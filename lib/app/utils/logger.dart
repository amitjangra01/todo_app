import 'package:logger/logger.dart';

var loggerLevel = Level.verbose;
Logger logger = Logger(
  printer: PrettyPrinter(
    errorMethodCount: 5,
    lineLength: 90,
    printEmojis: true,
    colors: false,
  ),
  level: loggerLevel,
);
