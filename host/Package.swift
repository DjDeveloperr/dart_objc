// swift-tools-version: 6.2
import Foundation
import PackageDescription

let env = ProcessInfo.processInfo.environment
let includeCandidates: [String] = [
    env["DART_SDK_INCLUDE"],
    "/opt/homebrew/opt/dart-sdk/libexec/include",
    "/usr/local/opt/dart-sdk/libexec/include",
].compactMap { $0 }

let dartIncludeDir =
    includeCandidates.first(where: { FileManager.default.fileExists(atPath: $0) })
    ?? "/opt/homebrew/opt/dart-sdk/libexec/include"

let package = Package(
    name: "ObjcTestHost",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        .executable(name: "ObjcTestHost", targets: ["ObjcTestHost"]),
    ],
    targets: [
        .target(
            name: "DartHostEmbedder",
            path: "Sources/DartHostEmbedder",
            publicHeadersPath: "include",
            cSettings: [
                .unsafeFlags(["-I\(dartIncludeDir)"]),
            ]
        ),
        .executableTarget(
            name: "ObjcTestHost",
            dependencies: ["DartHostEmbedder"],
            path: "Sources/ObjcTestHost"
        )
    ]
)
