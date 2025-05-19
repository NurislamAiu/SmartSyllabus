import 'dart:developer' as developer;

class AppLog {
  static void info(String message, {String tag = 'INFO'}) {
    developer.log('[INFO][$tag] $message');
  }

  static void error(String message, {String tag = 'ERROR', Object? error, StackTrace? stackTrace}) {
    developer.log('[ERROR][$tag] $message', error: error, stackTrace: stackTrace);
  }

  static void debug(String message, {String tag = 'DEBUG'}) {
    assert(() {
      developer.log('[DEBUG][$tag] $message');
      return true;
    }());
  }
}