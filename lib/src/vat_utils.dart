import 'vat_number.dart';

class VatUtils {
  static Map<String, String> _vatFormats = {
    'CH': r'^(CHE)([0-9]{9}(MWST|TVA|IVA))$',
    'AT': r'^(AT)(U[0-9]{8})$',
    'BE': r'^(BE)(0?[0-9]{9})$',
    'BG': r'^(BG)([0-9]{9,10})$',
    'CY': r'^(CY)([0-9]{8}[A-Z])$',
    'CZ': r'^(CZ)([0-9]{8,10})$',
    'DE': r'^(DE)([0-9]{9})$',
    'DK': r'^(DK)([0-9]{8})$',
    'EE': r'^(EE)([0-9]{9})$',
    'GR': r'^(EL|GR)([0-9]{9})$',
    'ES': r'^(ES)([0-9A-Z][0-9]{7}[0-9A-Z])$',
    'FI': r'^(FI)([0-9]{8})$',
    'FR': r'^(FR)([0-9A-Z]{2}[0-9]{9})$',
    'GB': r'^(GB)(([0-9]{9}([0-9]{3})?)|([A-Z]{2}[0-9]{3}))$',
    'HU': r'^(HU)([0-9]{8})$',
    'IE': r'^(IE)([0-9A-Z]{8,9})$',
    'IT': r'^(IT)([0-9]{11})$',
    'LT': r'^(LT)([0-9]{9}|[0-9]{12})$',
    'LU': r'^(LU)([0-9]{8})$',
    'LV': r'^(LV)([0-9]{11})$',
    'MT': r'^(MT)([0-9]{8})$',
    'NL': r'^(NL)([0-9]{9}B[0-9]{2})$',
    'PL': r'^(PL)([0-9]{10})$',
    'PT': r'^(PT)([0-9]{9})$',
    'RO': r'^(RO)([0-9]{2,10})$',
    'SE': r'^(SE)([0-9]{12})$',
    'SI': r'^(SI)([0-9]{8})$',
    'SK': r'^(SK)([0-9]{10})$',
    'HR': r'^(HR)([0-9]{11})$',
  };

  static List<String> get vatCountryCodes => _vatFormats.keys.toList();

  static VatNumber? parse(String vatNumber) {
    vatNumber = vatNumber
        .trim()
        .replaceAll(' ', '')
        .replaceAll('.', '')
        .replaceAll('-', '');

    for (final countryCode in _vatFormats.keys) {
      final pattern = _vatFormats[countryCode]!;
      final regex = RegExp(pattern, caseSensitive: false);
      final match = regex.firstMatch(vatNumber);
      if (match != null) {
        final countryCode = match.group(1);
        final number = match.group(2);
        if (countryCode != null && number != null) {
          var actualCountryCode = countryCode;
          if (countryCode == 'EL') {
            actualCountryCode = 'GR';
          } else if (countryCode == 'CHE') {
            actualCountryCode = 'CH';
          }
          return VatNumber(
            countryCode: actualCountryCode.toUpperCase(),
            nationalNumber: number.toUpperCase(),
          );
        } else {
          return null;
        }
      }
    }
    return null;
  }
}
