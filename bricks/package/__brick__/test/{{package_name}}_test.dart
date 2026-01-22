{{#is_flutter}}import 'package:flutter_test/flutter_test.dart';{{/is_flutter}}{{^is_flutter}}import 'package:test/test.dart';{{/is_flutter}}
import 'package:{{package_name}}/{{package_name}}.dart';

void main() {
  group('{{package_name.pascalCase()}}', () {
    test('initial test', () {
      expect(true, isTrue);
    });
  });
}
