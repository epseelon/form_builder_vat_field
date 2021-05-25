import 'package:flutter/widgets.dart';

import 'vat_utils.dart';

class VatFormBuilderValidators {
  /// [FormFieldValidator] that requires the field to have a valid VAT number value
  static FormFieldValidator<T> vatNumber<T>(
    BuildContext context, {
    required String errorText,
  }) {
    return (T? valueCandidate) {
      if (valueCandidate == null ||
          (valueCandidate is String &&
              VatUtils.parse(valueCandidate) == null)) {
        return errorText;
      }
      return null;
    };
  }
}
