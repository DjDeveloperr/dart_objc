import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:objective_c/objective_c.dart';

CGRect cgRect(double x, double y, double width, double height) {
  final bytes = Uint8List(ffi.sizeOf<CGRect>());
  final rect = ffi.Struct.create<CGRect>(bytes);
  rect.origin.x = x;
  rect.origin.y = y;
  rect.size.width = width;
  rect.size.height = height;
  return rect;
}
