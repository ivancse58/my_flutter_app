import 'package:intl/intl.dart' show DateFormat;
import 'package:logging/logging.dart';

// https://dart.academy/creational-design-patterns-for-dart-and-flutter-singleton/
class DebugLogger {
  static DebugLogger? _instance;
  static Logger? _logger;
  static final _dateFormatter = DateFormat('yyyy-MM-dd H:m:s.S');
  static const appName = 'my_flutter_app';

  DebugLogger._internal() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen(_recordHandler);

    _logger = Logger(appName);

    _instance = this;
  }

  factory DebugLogger() => _instance ?? DebugLogger._internal();

  void _recordHandler(LogRecord rec) {
    print('${_dateFormatter.format(rec.time)}: ${rec.message}');
  }

  void log(message, [Object? error, StackTrace? stackTrace]) =>
      _logger?.info(message, error, stackTrace);
}
