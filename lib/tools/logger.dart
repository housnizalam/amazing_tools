import 'dart:developer';

import 'package:flutter/foundation.dart';


/// This custom logger helps us to ensure a consistent and configurable logging
/// standard in the whole app.
///
/// Usage:
/// - Initialize a logger for every method.
/// - Call the logger for every logable line.
/// ```dart
/// final logger = Logger('SomeClass', 'someMethod');
/// logger('This is a log message', 2);
/// ```
///
/// The behavior of the logger can be regulated with initialization and
/// for each call.
///
/// On initialization logging can be turned on or off. This means you can
/// develop a method with logging turned on, using many logger calls. Then
/// you just turn off the logging, not removing all the logger calls. When
/// you encounter a problem, simply turn back on the logging for this method.
///
/// Every function call is configurable by settings its logging level. A logging
/// level of 0 turns effectively off this logger call. You can leave the logger
/// call in the code but not use it anymore this way. A logging level of 1 or
/// 2 will only be logged when the logger was turned on in initialization. They
/// will just show up in different colors. A logging level 3, however, will
/// even be logged if the logger was set to "no logging".
class Logger {
  /// This custom logger helps us to ensure a consistent and configurable logging
  /// standard in the whole app.
  ///
  /// Usage:
  /// - Initialize a logger for every method.
  /// - Call the logger for every logable line.
  /// ```dart
  /// final logger = Logger('SomeClass', 'someMethod');
  /// logger('This is a log message', 2);
  /// ```
  ///
  /// The behavior of the logger can be regulated with initialization and
  /// for each call.
  ///
  /// On initialization logging can be turned on or off. This means you can
  /// develop a method with logging turned on, using many logger calls. Then
  /// you just turn off the logging, not removing all the logger calls. When
  /// you encounter a problem, simply turn back on the logging for this method.
  ///
  /// Every function call is configurable by settings its logging level. A logging
  /// level of 0 turns effectively off this logger call. You can leave the logger
  /// call in the code but not use it anymore this way. A logging level of 1 or
  /// 2 will only be logged when the logger was turned on in initialization. They
  /// will just show up in different colors. A logging level 3, however, will
  /// even be logged if the logger was set to "no logging".
  Logger(
    Type objectType,
    String method, [
    bool active = true,
  ])  : _objectType = objectType,
        _method = method,
        _active = active;
  final Type _objectType;
  final String _method;
  final bool _active;

  // Level 1
  void _printMessage(String text) {
    final message = '\x1B[37m$text\x1B[0m';
    if (kIsWeb) {
      // ignore: avoid_print
      print(message);
    } else {
      log(message); // White
    }
  }

  // Level 2
  void _printWarning(String text) {
    final message = '\x1B[33m$text\x1B[0m';
    if (kIsWeb) {
      // ignore: avoid_print
      print(message);
    } else {
      log(message); // Yellow
    }
  }

  // Level 3
  void _printError(String text) {
    final message = '\x1B[31m$text\x1B[0m';
    if (kIsWeb) {
      // ignore: avoid_print
      print(message);
    } else {
      log(message); // Red
    }
  }

  /// Every function call is configurable by settings its logging level. A logging
  /// level of 0 turns effectively off this logger call. You can leave the logger
  /// call in the code but not use it anymore this way. A logging level of 1 or
  /// 2 will only be logged when the logger was turned on in initialization. They
  /// will just show up in different colors. A logging level 3, however, will
  /// even be logged if the logger was set to "no logging".
  /// - message: The logging message
  /// - level: The level of the log message.
  ///   - 0: The message will not be logged
  ///   - 1: The message will be logged (in white color) if logging was turned on
  ///        on logger initialization
  ///   - 2: The message will be logged (in yellow color) if logging was turned
  ///        on on logger initialization
  ///   - 3: The message will always be logged (in red color)
  void call(String message, [int level = 1]) {
    assert(message.isNotEmpty && level >= 0 && level <= 3, 'Invalid logger call.');
    if ((!_active && level <= 2) || level < 1) {
      return;
    }
    final now = DateTime.now();
    final hour = '${now.hour < 10 ? '0' : ''}${now.hour}';
    final minute = '${now.minute < 10 ? '0' : ''}${now.minute}';
    final second = '${now.second < 10 ? '0' : ''}${now.second}';
    final millisecond =
        '${now.millisecond < 1000 ? '0' : ''}${now.millisecond < 100 ? '0' : ''}${now.millisecond < 10 ? '0' : ''}${now.millisecond}';
    final logMessage = '[$_objectType.$_method] $hour:$minute:$second.$millisecond: $message';

    if (level == 1) {
      _printMessage(logMessage);
    } else if (level == 2) {
      _printWarning(logMessage);
    } else {
      _printError(logMessage);
    }
  }
}
