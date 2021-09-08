import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../form_builder_vat_field.dart';
import 'vat_utils.dart';

/// Field for European VAT number input.
class FormBuilderVatField extends FormBuilderField<String> {
  final TextInputType keyboardType;
  final bool obscureText;
  final TextStyle? style;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final bool autofocus;
  final bool autocorrect;
  final MaxLengthEnforcement maxLengthEnforcement;
  final int? maxLength;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final double cursorWidth;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final InputCounterWidgetBuilder? buildCounter;
  final bool expands;
  final int? minLines;
  final bool? showCursor;
  final VoidCallback? onTap;

  // For country dialog
  final String? searchText;
  final EdgeInsets? titlePadding;
  final bool? isSearchable;
  final Text? dialogTitle;
  final String? defaultSelectedCountryIsoCode;
  final List<String>? priorityListByIsoCode;
  final TextStyle? dialogTextStyle;
  final bool isCupertinoPicker;
  final double? cupertinoPickerSheetHeight;
  final TextAlignVertical? textAlignVertical;

  /// Creates field for European VAT number input.
  FormBuilderVatField({
    Key? key,
    //From Super
    required String name,
    FormFieldValidator<String>? validator,
    String? initialValue,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<String?>? onChanged,
    ValueTransformer<String>? valueTransformer,
    bool enabled = true,
    FormFieldSetter<String>? onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback? onReset,
    FocusNode? focusNode,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.characters,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.maxLengthEnforcement = MaxLengthEnforcement.enforced,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.autocorrect = true,
    this.cursorWidth = 2.0,
    this.keyboardType = TextInputType.text,
    this.style,
    this.controller,
    this.textInputAction,
    this.strutStyle,
    this.textDirection,
    this.maxLength,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.buildCounter,
    this.expands = false,
    this.minLines,
    this.showCursor,
    this.onTap,
    this.searchText,
    this.titlePadding,
    this.dialogTitle,
    this.isSearchable,
    this.defaultSelectedCountryIsoCode = 'BE',
    this.priorityListByIsoCode,
    this.dialogTextStyle,
    this.isCupertinoPicker = false,
    this.cupertinoPickerSheetHeight,
    this.textAlignVertical,
  })  : assert(initialValue == null ||
            controller == null ||
            defaultSelectedCountryIsoCode != null),
        super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
          builder: (FormFieldState<String?> field) {
            final state = field as _FormBuilderVatFieldState;

            return InputDecorator(
              decoration: state.decoration,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: state.enabled
                        ? () {
                            state.requestFocus();
                            if (isCupertinoPicker) {
                              state._openCupertinoCountryPicker();
                            } else {
                              state._openCountryPickerDialog();
                            }
                          }
                        : null,
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.arrow_drop_down),
                        const SizedBox(width: 10),
                        CountryPickerUtils.getDefaultFlagImage(
                          state._selectedDialogCountry,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          state._selectedDialogCountry.iso3Code == 'CHE'
                              ? 'CHE '
                              : '${state._selectedDialogCountry.isoCode} ',
                          style: Theme.of(state.context)
                              .textTheme
                              .subtitle1!
                              .merge(style),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      enabled: state.enabled,
                      style: style,
                      focusNode: state.effectiveFocusNode,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        hintText: decoration.hintText,
                        hintStyle: decoration.hintStyle,
                      ),
                      onChanged: (val) {
                        state.invokeChange();
                      },
                      maxLines: 1,
                      keyboardType: keyboardType,
                      obscureText: obscureText,
                      onEditingComplete: onEditingComplete,
                      controller: state._effectiveController,
                      autocorrect: autocorrect,
                      autofocus: autofocus,
                      buildCounter: buildCounter,
                      cursorColor: cursorColor,
                      cursorRadius: cursorRadius,
                      cursorWidth: cursorWidth,
                      enableInteractiveSelection: enableInteractiveSelection,
                      maxLength: maxLength,
                      inputFormatters: inputFormatters,
                      keyboardAppearance: keyboardAppearance,
                      maxLengthEnforcement: maxLengthEnforcement,
                      scrollPadding: scrollPadding,
                      textAlign: textAlign,
                      textCapitalization: textCapitalization,
                      textDirection: textDirection,
                      textInputAction: textInputAction,
                      strutStyle: strutStyle,
                      //readOnly: state.readOnly, -- Does this need to be exposed?
                      expands: expands,
                      minLines: minLines,
                      showCursor: showCursor,
                      onTap: onTap,
                      textAlignVertical: textAlignVertical,
                    ),
                  ),
                ],
              ),
            );
          },
        );

  @override
  _FormBuilderVatFieldState createState() => _FormBuilderVatFieldState();
}

class _FormBuilderVatFieldState
    extends FormBuilderFieldState<FormBuilderVatField, String> {
  late TextEditingController _effectiveController;
  late Country _selectedDialogCountry;

  String get fullNumber {
    // When there is no VAT number text, the field is empty -- the country
    // prefix is only prepended when a VAT number is specified.
    final vatText = _effectiveController.text
        .trim()
        .replaceAll(' ', '')
        .replaceAll('.', '')
        .replaceAll('-', '');
    return vatText.isNotEmpty
        ? '${_selectedDialogCountry.iso3Code == 'CHE' ? 'CHE' : _selectedDialogCountry.isoCode}$vatText'
        : vatText;
  }

  @override
  void initState() {
    super.initState();
    _effectiveController = widget.controller ?? TextEditingController();
    _selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode(
        widget.defaultSelectedCountryIsoCode!);
    _parseVat();
  }

  @override
  void dispose() {
    // Dispose the _effectiveController when initState created it
    if (null == widget.controller) {
      _effectiveController.dispose();
    }
    super.dispose();
  }

  /// cf. for reference: https://www.avalara.com/vatlive/en/eu-vat-rules/eu-vat-number-registration/eu-vat-number-formats.html
  Future<void> _parseVat() async {
    // print('initialValue: $initialValue');
    if (initialValue != null && initialValue!.isNotEmpty) {
      try {
        final parseResult = VatUtils.parse(initialValue!);
        if (parseResult != null) {
          setState(() {
            _selectedDialogCountry =
                CountryPickerUtils.getCountryByIsoCode(parseResult.countryCode);
          });
          _effectiveController.text = parseResult.nationalNumber;
        }
      } catch (error) {
        _effectiveController.text = initialValue!.replaceFirst('+', '');
      }
    }
  }

  void invokeChange() {
    didChange(fullNumber);
    widget.onChanged?.call(fullNumber);
  }

  void _openCupertinoCountryPicker() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          pickerSheetHeight: widget.cupertinoPickerSheetHeight ?? 300.0,
          onValuePicked: (Country country) {
            effectiveFocusNode!.requestFocus();
            setState(() => _selectedDialogCountry = country);
            didChange(fullNumber);
          },
          itemFilter: (c) => VatUtils.vatCountryCodes.contains(c.isoCode),
          priorityList: widget.priorityListByIsoCode != null
              ? List.generate(
                  widget.priorityListByIsoCode!.length,
                  (index) {
                    return CountryPickerUtils.getCountryByIsoCode(
                      widget.priorityListByIsoCode![index],
                    );
                  },
                )
              : null,
        );
      },
    );
  }

  void _openCountryPickerDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return Theme(
          data: Theme.of(context).copyWith(
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: widget.cursorColor,
            ),
            primaryColor: widget.cursorColor ?? Theme.of(context).primaryColor,
          ),
          child: CountryPickerDialog(
            titlePadding: widget.titlePadding ?? const EdgeInsets.all(8.0),
            searchCursorColor:
                widget.cursorColor ?? Theme.of(context).primaryColor,
            searchInputDecoration:
                InputDecoration(hintText: widget.searchText ?? 'Search...'),
            isSearchable: widget.isSearchable ?? true,
            title: widget.dialogTitle ??
                Text(
                  'Select Your Country Code',
                  style: widget.dialogTextStyle ?? widget.style,
                ),
            onValuePicked: (Country country) {
              setState(() => _selectedDialogCountry = country);
              invokeChange();
            },
            itemFilter: (c) => VatUtils.vatCountryCodes.contains(c.isoCode),
            priorityList: widget.priorityListByIsoCode != null
                ? List.generate(
                    widget.priorityListByIsoCode!.length,
                    (index) {
                      return CountryPickerUtils.getCountryByIsoCode(
                          widget.priorityListByIsoCode![index]);
                    },
                  )
                : null,
            itemBuilder: _buildDialogItem,
          ),
        );
      },
    );
  }

  Widget _buildDialogItem(Country country) {
    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CountryPickerUtils.getDefaultFlagImage(country),
        title: Text(country.name),
        trailing:
            Text(country.iso3Code == 'CHE' ? 'CHE' : '${country.isoCode}'),
      ),
    );
  }
}
