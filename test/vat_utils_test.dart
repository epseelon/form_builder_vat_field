import 'package:test/test.dart';
import 'package:form_builder_vat_field/form_builder_vat_field.dart';
import 'dart:io';
import 'dart:convert';

Future<List<String>> readLinesFromFile(String filename) async {
  List<String> result = [];
  await File('test/$filename')
      .openRead()
      .map(utf8.decode)
      .transform(LineSplitter())
      .forEach((l) => result.add(l));
  return result;
}

void main() {
  test('Valid VAT numbers should be parsed correctly', () async {
    final validVatNumbers = await readLinesFromFile('valid.txt');

    for (final vatNumber in validVatNumbers) {
      expect(VatUtils.parse(vatNumber) != null, true,
          reason: '$vatNumber is not parsed as valid');
    }
  });

  test('Invalid VAT numbers should not be parsed correctly', () async {
    final invalidVatNumbers = await readLinesFromFile('invalid.txt');

    for (final vatNumber in invalidVatNumbers) {
      expect(VatUtils.parse(vatNumber) == null, true,
          reason: '$vatNumber is parsed as valid');
    }
  });
}
