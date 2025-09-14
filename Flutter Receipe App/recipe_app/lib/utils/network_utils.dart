import 'dart:io';
import 'package:flutter/foundation.dart';

class NetworkUtils {
  static String? _cachedIpAddress;
  
  /// Get the local IP address automatically
  static Future<String> getLocalIpAddress() async {
    // Return cached IP if available
    if (_cachedIpAddress != null) {
      return _cachedIpAddress!;
    }

    try {
      // For Android emulator, always use 10.0.2.2
      if (kDebugMode && Platform.isAndroid) {
        final interfaces = await NetworkInterface.list();
        bool isEmulator = false;
        
        // Check if running on emulator by looking for specific network interfaces
        for (var interface in interfaces) {
          if (interface.name.contains('eth0') || 
              interface.addresses.any((addr) => addr.address.startsWith('10.0.2.'))) {
            isEmulator = true;
            break;
          }
        }
        
        if (isEmulator) {
          _cachedIpAddress = '10.0.2.2';
          print('[DEBUG] Detected Android emulator, using: $_cachedIpAddress');
          return _cachedIpAddress!;
        }
      }

      // For real devices or iOS, get actual IP address
      final interfaces = await NetworkInterface.list(type: InternetAddressType.IPv4);
      
      // Prefer WiFi interfaces first
      for (var interface in interfaces) {
        if (interface.name.toLowerCase().contains('wlan') || 
            interface.name.toLowerCase().contains('wifi') ||
            interface.name.toLowerCase().contains('en0') ||
            interface.name.toLowerCase().contains('ethernet')) {
          
          for (var address in interface.addresses) {
            // Skip loopback and link-local addresses
            if (!address.isLoopback && 
                !address.address.startsWith('169.254') &&
                !address.address.startsWith('127.') &&
                address.type == InternetAddressType.IPv4) {
              
              _cachedIpAddress = address.address;
              print('[DEBUG] Found WiFi/Ethernet IP: $_cachedIpAddress');
              return _cachedIpAddress!;
            }
          }
        }
      }

      // If no WiFi found, use any valid IP
      for (var interface in interfaces) {
        for (var address in interface.addresses) {
          if (!address.isLoopback && 
              !address.address.startsWith('169.254') &&
              !address.address.startsWith('127.') &&
              address.type == InternetAddressType.IPv4) {
            
            _cachedIpAddress = address.address;
            print('[DEBUG] Found IP address: $_cachedIpAddress');
            return _cachedIpAddress!;
          }
        }
      }

      // Fallback to localhost if nothing found
      _cachedIpAddress = '127.0.0.1';
      print('[DEBUG] No network interface found, using localhost: $_cachedIpAddress');
      return _cachedIpAddress!;
      
    } catch (e) {
      print('[ERROR] Failed to get IP address: $e');
      // Fallback to emulator IP or localhost
      _cachedIpAddress = kDebugMode && Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
      return _cachedIpAddress!;
    }
  }

  /// Get the base URL for API calls
  static Future<String> getApiBaseUrl({int port = 8190}) async {
    final ip = await getLocalIpAddress();
    final baseUrl = 'http://$ip:$port/api';
    print('[DEBUG] API Base URL: $baseUrl');
    return baseUrl;
  }

  /// Clear cached IP address (call this when network changes)
  static void clearCache() {
    _cachedIpAddress = null;
    print('[DEBUG] Network cache cleared');
  }

  /// Set IP address manually for debugging
  static void setManualIp(String ipAddress) {
    _cachedIpAddress = ipAddress;
    print('[DEBUG] Manual IP set to: $_cachedIpAddress');
  }

  /// Get cached IP address without async call
  static String? getCachedIp() {
    return _cachedIpAddress;
  }

  /// Check if the current IP is for emulator
  static Future<bool> isEmulator() async {
    final ip = await getLocalIpAddress();
    return ip == '10.0.2.2';
  }

  /// Get computer's IP for server logs
  static Future<String> getComputerIpForServer() async {
    try {
      final interfaces = await NetworkInterface.list(type: InternetAddressType.IPv4);
      
      // Look for WiFi or Ethernet interface
      for (var interface in interfaces) {
        if (interface.name.toLowerCase().contains('ethernet') ||
            interface.name.toLowerCase().contains('wifi') ||
            interface.name.toLowerCase().contains('wlan')) {
          
          for (var address in interface.addresses) {
            if (!address.isLoopback && 
                address.type == InternetAddressType.IPv4 &&
                !address.address.startsWith('169.254')) {
              
              print('[DEBUG] Computer IP for server: ${address.address}');
              return address.address;
            }
          }
        }
      }
      
      // Fallback to any valid IP
      for (var interface in interfaces) {
        for (var address in interface.addresses) {
          if (!address.isLoopback && 
              address.type == InternetAddressType.IPv4 &&
              !address.address.startsWith('169.254')) {
            
            print('[DEBUG] Computer IP (fallback): ${address.address}');
            return address.address;
          }
        }
      }
      
      return '127.0.0.1';
    } catch (e) {
      print('[ERROR] Failed to get computer IP: $e');
      return '127.0.0.1';
    }
  }
}