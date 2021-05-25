# form_builder_vat_field

VAT number input field for [flutter_form_builder](https://pub.dev/packages/flutter_form_builder) package

# Usage
```dart
FormBuilderVatField(
  name: 'vat_number',
  decoration: const InputDecoration(
    labelText: 'VAT Number',
    hintText: 'VAT number',
  ),
  priorityListByIsoCode: ['BE'],
  validator: FormBuilderValidators.compose([
    FormBuilderValidators.required(context),
    VatFormBuilderValidators.vatNumber(
      context,
      errorText: 'This is not a valid VAT number',
    ),
  ]),
  initialValue: 'FI 99999999',
),
```
