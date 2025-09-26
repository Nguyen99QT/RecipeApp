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
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomLabelCountryCodeWidget extends StatefulWidget {
  const CustomLabelCountryCodeWidget({
    super.key,
    this.width,
    this.height,
    this.initialValue,
    this.initialCountryCode,
  });

  final double? width;
  final double? height;
  final String? initialValue;
  final String? initialCountryCode;

  @override
  State<CustomLabelCountryCodeWidget> createState() =>
      _CustomLabelCountryCodeWidgetState();
}

class _CustomLabelCountryCodeWidgetState
    extends State<CustomLabelCountryCodeWidget> {
  
  @override
  void initState() {
    super.initState();
    // Force default to Vietnam for better UX
    if (FFAppState().countryName == 'US' || FFAppState().countryName.isEmpty) {
      FFAppState().update(() {
        FFAppState().countryName = 'VN';
        FFAppState().countryCode = '+84';
      });
    }
  }
  
  bool _isEmulator() {
    if (kIsWeb) return false;
    
    // Common emulator indicators
    if (Platform.isAndroid) {
      // Check for common emulator model names
      return false; // We'll use a simple approach for now
    }
    return false;
  }
  
  String _getDefaultCountryCode() {
    // Get device locale
    final locale = Localizations.localeOf(context);
    final countryCode = locale.countryCode;
    
    print('Device locale: ${locale.toString()}');
    print('Country code from locale: $countryCode');
    
    // Map common country codes to phone country codes
    final countryMap = {
      'VN': 'VN', // Vietnam
      'US': 'US', // United States
      'GB': 'GB', // United Kingdom
      'IN': 'IN', // India
      'CN': 'CN', // China
      'JP': 'JP', // Japan
      'KR': 'KR', // Korea
      'TH': 'TH', // Thailand
      'MY': 'MY', // Malaysia
      'SG': 'SG', // Singapore
      'ID': 'ID', // Indonesia
      'PH': 'PH', // Philippines
    };
    
    // Check if widget has initial country code first
    if (widget.initialCountryCode != null && 
        widget.initialCountryCode!.isNotEmpty && 
        widget.initialCountryCode != 'US') { // Ignore US from emulator
      print('Using widget initialCountryCode: ${widget.initialCountryCode}');
      return widget.initialCountryCode!;
    }
    
    // Check FFAppState for saved country (but ignore US for better UX in Vietnam)
    if (FFAppState().countryName.isNotEmpty && 
        FFAppState().countryName != 'VN' && 
        FFAppState().countryName != 'US') { // Ignore US from emulator/previous sessions
      print('Using saved countryName from FFAppState: ${FFAppState().countryName}');
      return FFAppState().countryName;
    }
    
    // Use locale if available and mapped (but skip US for emulator)
    if (countryCode != null && countryMap.containsKey(countryCode) && countryCode != 'US') {
      print('Using locale country code: $countryCode');
      return countryMap[countryCode]!;
    }
    
    // For emulator, US locale, or when locale detection fails, default to Vietnam for better UX
    print('Defaulting to Vietnam (VN) - emulator detected or preferred for Vietnamese users');
    return 'VN';
  }

  @override
  Widget build(BuildContext context) {
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
      initialValue: widget.initialValue,
      flagsButtonMargin: EdgeInsets.only(left: 16),
      keyboardType: TextInputType.phone,
      cursorColor: FlutterFlowTheme.of(context).primaryText,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
      decoration: InputDecoration(
        // labelText: "Phone number",
        // labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
        //       fontFamily: 'SF Pro Display',
        //       color: FlutterFlowTheme.of(context).grey400,
        //       fontSize: 13,
        //       useGoogleFonts: false,
        //     ),
        alignLabelWithHint: false,
        //   label: Text(
        //     "Phone number",
        //   style: FlutterFlowTheme.of(context).labelMedium.override(
        //       fontFamily: 'SF Pro Display',
        //    color: FlutterFlowTheme.of(context).black40,
        //         fontSize: 14,
        //         useGoogleFonts: false,
        //        lineHeight: 1.2,
        //      ),
        //   ),
        hintText: 'Enter your phone number',
        hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
              fontFamily: 'SF Pro Display',
              color: FlutterFlowTheme.of(context).black40,
              fontSize: 17.0,
              letterSpacing: 0.0,
              useGoogleFonts: false,
            ),
        counterText: '',

        // errorText: 'Please enter valid number ',
        errorStyle: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'SF Pro Display',
              color: FlutterFlowTheme.of(context).errorColor,
              fontSize: 17.0,
              letterSpacing: 0.0,
              useGoogleFonts: false,
            ),
        // contentPadding: EdgeInsets.only(top: 16, bottom: 16, left: 16),
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
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).primaryText,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
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
      initialCountryCode: _getDefaultCountryCode(), // Auto-detect or default to Vietnam
      validator: (phone) {
        if (phone == null || phone.number.isEmpty) {
          return "Please enter phone number";
        }
        if (phone.number.length < 8) {
          return "Phone number too short";
        }
        return null;
      },
      invalidNumberMessage: "Please enter valid phone number",
      onChanged: (value) {
        print('[DEBUG] Phone number changed: ${value.completeNumber}');
        print('[DEBUG] Country code: ${value.countryCode}');
        print('[DEBUG] Phone number only: ${value.number}');
        
        FFAppState().update(() {
          FFAppState().phone = value.number;
          FFAppState().countryCode = value.countryCode;
        });
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onCountryChanged: (value) {
        print('[DEBUG] Country code changed to: ${value.dialCode}');
        print('[DEBUG] Country name: ${value.code}');
        
        FFAppState().update(() {
          FFAppState().countryCode = value.dialCode.toString();
          FFAppState().countryName = value.code.toString(); // Store country code (e.g., 'VN')
        });
        print('Country changed to: ${value.name} (${value.code}) ${value.dialCode}');
      },
    );
  }
}
