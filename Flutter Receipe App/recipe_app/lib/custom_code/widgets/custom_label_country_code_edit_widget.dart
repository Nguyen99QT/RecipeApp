// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/services.dart';

class CustomLabelCountryCodeEditWidget extends StatefulWidget {
  const CustomLabelCountryCodeEditWidget({
    super.key,
    this.width,
    this.height,
    this.initialValue,
    this.code,
  });

  final double? width;
  final double? height;
  final String? initialValue;
  final String? code;

  @override
  State<CustomLabelCountryCodeEditWidget> createState() =>
      _CustomLabelCountryCodeEditWidgetState();
}

class _CustomLabelCountryCodeEditWidgetState
    extends State<CustomLabelCountryCodeEditWidget> {
  
  String _getCleanCountryCode() {
    // Clean and extract country code from the provided code
    if (widget.code != null && widget.code!.isNotEmpty) {
      String cleanCode = widget.code!.trim();
      
      // Extract country code - handle formats like "+84", "84", "+84 123456789"
      if (cleanCode.contains(' ')) {
        cleanCode = cleanCode.split(' ')[0]; // Get the part before space
      }
      
      // Remove + if present and validate
      cleanCode = cleanCode.replaceAll('+', '');
      
      // Check if it's a valid country code (2-4 digits)
      if (RegExp(r'^\d{1,4}$').hasMatch(cleanCode)) {
        return cleanCode;
      }
    }
    
    // Default to Vietnam if no valid code provided
    return '84';
  }
  
  String _getCountryISOCode() {
    // Map phone country codes to ISO codes for IntlPhoneField
    Map<String, String> phoneToISO = {
      '84': 'VN', // Vietnam
      '1': 'US',   // United States
      '44': 'GB',  // United Kingdom
      '86': 'CN',  // China
      '91': 'IN',  // India
      '81': 'JP',  // Japan
      '82': 'KR',  // South Korea
      '66': 'TH',  // Thailand
      '60': 'MY',  // Malaysia
      '65': 'SG',  // Singapore
      '62': 'ID',  // Indonesia
      '63': 'PH',  // Philippines
    };
    
    String phoneCode = _getCleanCountryCode();
    String isoCode = phoneToISO[phoneCode] ?? 'VN'; // Default to Vietnam
    
    print('[DEBUG] Phone code: $phoneCode -> ISO code: $isoCode');
    return isoCode;
  }
  
  @override
  Widget build(BuildContext context) {
    // Get clean country code and ISO code
    String countryCode = _getCleanCountryCode();
    String isoCode = _getCountryISOCode();
    
    // Prepare initial phone value (remove country code if present)
    String? initialPhone = widget.initialValue;
    if (initialPhone != null && initialPhone.isNotEmpty) {
      // Remove country code from initial value if it's prefixed
      if (initialPhone.startsWith(countryCode)) {
        initialPhone = initialPhone.substring(countryCode.length);
      }
      // Remove any + signs
      initialPhone = initialPhone.replaceAll('+', '');
    }
    
    print('[DEBUG] CustomLabelCountryCodeEditWidget:');
    print('[DEBUG] Original code: ${widget.code}');
    print('[DEBUG] Clean country code: $countryCode');
    print('[DEBUG] ISO code: $isoCode');
    print('[DEBUG] Original initial value: ${widget.initialValue}');
    print('[DEBUG] Clean initial phone: $initialPhone');
    
    return IntlPhoneField(
      showCountryFlag: false,
      autofocus: false,
      dropdownIcon: Icon(
        Icons.keyboard_arrow_down,
        size: 12,
        color: FlutterFlowTheme.of(context).primaryText,
      ),
      style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'SF Pro Display',
            fontSize: 16,
            letterSpacing: 0.0,
            useGoogleFonts: false,
            lineHeight: 1.2,
          ),
      dropdownIconPosition: IconPosition.trailing,
      dropdownTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'SF Pro Display',
            color: FlutterFlowTheme.of(context).primaryTextColor,
            fontSize: 17.0,
            letterSpacing: 0.0,
            useGoogleFonts: false,
          ),
      dropdownDecoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10)),
      initialValue: initialPhone,
      flagsButtonMargin: EdgeInsets.only(left: 16),
      keyboardType: TextInputType.phone,
      cursorColor: FlutterFlowTheme.of(context).primaryText,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
      decoration: InputDecoration(
        hintText: 'Enter your phone number',
        hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
              fontFamily: 'SF Pro Display',
              color: FlutterFlowTheme.of(context).black40,
              fontSize: 17.0,
              letterSpacing: 0.0,
              useGoogleFonts: false,
            ),
        counterText: '',
        errorStyle: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'SF Pro Display',
              color: FlutterFlowTheme.of(context).errorColor,
              fontSize: 17.0,
              letterSpacing: 0.0,
              useGoogleFonts: false,
            ),
        contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 15.0, 16.0, 15.0),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).errorColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).primaryTheme,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).black20, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).error, width: 1)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).black20,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).black20, width: 1)),
      ),
      initialCountryCode: isoCode, // Use ISO code instead of phone code
      validator: (num) {
        if (num == null || num.number.isEmpty) {
          return "Please enter phone number";
        }
        if (num.number.length < 8) {
          return "Phone number too short";
        }
        return null;
      },
      invalidNumberMessage: "Please enter valid phone number",
      onChanged: (value) {
        print('[DEBUG] Phone changed: ${value.completeNumber}');
        print('[DEBUG] Country code: ${value.countryCode}');
        print('[DEBUG] Phone number: ${value.number}');
        
        FFAppState().update(() {
          FFAppState().phone = value.number;
          FFAppState().countryCodeEdit = value.countryCode;
        });
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onCountryChanged: (value) {
        print('[DEBUG] Country changed: ${value.dialCode}');
        
        FFAppState().update(() {
          FFAppState().countryCodeEdit = value.dialCode.toString();
        });
      },
    );
  }
}
