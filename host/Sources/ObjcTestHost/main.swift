import AppKit
import DartHostEmbedder
import Darwin
import Foundation

private struct HostConfiguration {
    let dartVmPath: String
    let kernelPath: String
    let scriptURI: String
    let entrypoint: String
    let objectiveCDylibPath: String
    let foundationBindingsDylibPath: String
    let appKitBindingsDylibPath: String
    let metalBindingsDylibPath: String
    let metalKitBindingsDylibPath: String

    static func load(from env: [String: String]) -> HostConfiguration {
        let repoRoot = env["OBJC_TEST_REPO_ROOT"] ?? FileManager.default.currentDirectoryPath
        return HostConfiguration(
            dartVmPath: env["DART_VM_BIN"] ?? "/opt/homebrew/opt/dart-sdk/libexec/bin/dartvm",
            kernelPath: env["DART_KERNEL_PATH"] ?? "\(repoRoot)/host/build/objc_test.dill",
            scriptURI: env["DART_SCRIPT_URI"] ?? "file://\(repoRoot)/bin/objc_test.dart",
            entrypoint: env["DART_ENTRYPOINT_SYMBOL"] ?? "main",
            objectiveCDylibPath:
                env["OBJECTIVE_C_DYLIB"] ?? "\(repoRoot)/.dart_tool/lib/objective_c.dylib",
            foundationBindingsDylibPath:
                env["FOUNDATION_BINDINGS_DYLIB"]
                ?? "\(repoRoot)/host/build/objc_foundation_bindings.dylib",
            appKitBindingsDylibPath:
                env["APPKIT_BINDINGS_DYLIB"]
                ?? "\(repoRoot)/host/build/objc_appkit_bindings.dylib"
            ,
            metalBindingsDylibPath:
                env["METAL_BINDINGS_DYLIB"]
                ?? "\(repoRoot)/host/build/objc_metal_bindings.dylib",
            metalKitBindingsDylibPath:
                env["METALKIT_BINDINGS_DYLIB"]
                ?? "\(repoRoot)/host/build/objc_metalkit_bindings.dylib"
        )
    }
}

@inline(__always)
private func withEmbedderCStringArgs<T>(
    _ configuration: HostConfiguration,
    _ body: (
        UnsafePointer<CChar>,
        UnsafePointer<CChar>,
        UnsafePointer<CChar>,
        UnsafePointer<CChar>
    ) -> T
) -> T {
    configuration.dartVmPath.withCString { vmPtr in
        configuration.kernelPath.withCString { kernelPtr in
            configuration.scriptURI.withCString { scriptPtr in
                configuration.entrypoint.withCString { entryPtr in
                    body(vmPtr, kernelPtr, scriptPtr, entryPtr)
                }
            }
        }
    }
}

private func preloadObjectiveCDylib(at path: String) -> String? {
    guard FileManager.default.fileExists(atPath: path) else {
        return "File not found at \(path)"
    }
    let handle = dlopen(path, RTLD_NOW | RTLD_GLOBAL)
    if handle == nil {
        if let errorPtr = dlerror() {
            return String(cString: errorPtr)
        }
        return "dlopen failed with unknown error"
    }
    return nil
}

private func lastEmbedderError() -> String {
    guard let ptr = dart_host_embedder_last_error() else {
        return "Unknown error"
    }
    let text = String(cString: ptr)
    return text.isEmpty ? "Unknown error" : text
}

private func fatalHostError(_ prefix: String, _ detail: String) -> Never {
    let message = "[ObjcTestHost] \(prefix): \(detail)\n"
    if let data = message.data(using: .utf8) {
        FileHandle.standardError.write(data)
    } else {
        fputs(message, stderr)
    }
    exit(1)
}

private func startEmbeddedDartVM(using configuration: HostConfiguration) {
    if let preloadError = preloadObjectiveCDylib(at: configuration.objectiveCDylibPath) {
        fatalHostError("Failed to preload objective_c runtime", preloadError)
    }
    if let preloadError = preloadObjectiveCDylib(at: configuration.foundationBindingsDylibPath) {
        fatalHostError("Failed to preload Foundation bindings", preloadError)
    }
    if let preloadError = preloadObjectiveCDylib(at: configuration.appKitBindingsDylibPath) {
        fatalHostError("Failed to preload AppKit bindings", preloadError)
    }
    if let preloadError = preloadObjectiveCDylib(at: configuration.metalBindingsDylibPath) {
        fatalHostError("Failed to preload Metal bindings", preloadError)
    }
    if let preloadError = preloadObjectiveCDylib(at: configuration.metalKitBindingsDylibPath) {
        fatalHostError("Failed to preload MetalKit bindings", preloadError)
    }

    let launchStatus = withEmbedderCStringArgs(configuration) {
        dart_host_embedder_start($0, $1, $2, $3)
    }
    if launchStatus != 0 {
        fatalHostError("Failed to start embedded Dart VM", lastEmbedderError())
    }
}

private func stopEmbeddedDartVM() {
    let status = dart_host_embedder_stop()
    if status != 0 {
        fatalHostError("Failed to stop embedded Dart VM", lastEmbedderError())
    }
}

@MainActor
private func main() {
    let configuration = HostConfiguration.load(from: ProcessInfo.processInfo.environment)
    let app = NSApplication.shared

    startEmbeddedDartVM(using: configuration)
    app.run()
    stopEmbeddedDartVM()
}

main()
