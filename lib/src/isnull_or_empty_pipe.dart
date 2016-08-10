import 'package:angular2/angular2.dart';

/*
 * Заменяет значение
 * Takes an exponent argument that defaults to 1.
 * Usage:
 *   value | exponentialStrength:exponent
 * Example:
 *   {{ 2 |  exponentialStrength:10}}
 *   formats to: 1024
 */
@Pipe(name: 'isNullOrEmpty')
class IsNullOrEmptyPipe extends PipeTransform {
  String transform(String value, [String placeholder]) => value == null || value.toString().trim().isEmpty ? (placeholder ?? '[нет данных]') : value;
}