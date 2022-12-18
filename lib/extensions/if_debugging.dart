import 'package:flutter/foundation.dart' show kDebugMode;

extension IfDebugging on String {
  String? get ifDebuggin => kDebugMode ? this : null;
}
