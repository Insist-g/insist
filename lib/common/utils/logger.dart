import 'package:logger/logger.dart';

class Log {
  static Log _instance = Log._internal();

  factory Log() => _instance;

  static late Logger logger;
  static late Logger loggerNoStack;

  Log._internal() {
    logger = Logger(printer: PrettyPrinter());
    loggerNoStack = Logger(printer: PrettyPrinter(methodCount: 0));
  }

  d(String? str, {String? tag, bool noStack = false}) {
    if (str == null) return;
    noStack ? loggerNoStack.d(str) : logger.d((tag == null ? '' : tag+'=>' )+ str);
  }
}

// Sample of abstract logging function
write(String text, {bool isError = false}) =>
    Future.microtask(() => print('** $text. isError: [$isError]'));
