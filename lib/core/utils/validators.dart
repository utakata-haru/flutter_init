import 'constants.dart';

/// Validation utilities
class Validators {
  /// Validate spot title
  static String? validateSpotTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Spot title is required';
    }
    if (value.length < AppConstants.minSpotTitleLength) {
      return 'Spot title must be at least ${AppConstants.minSpotTitleLength} character';
    }
    if (value.length > AppConstants.maxSpotTitleLength) {
      return 'Spot title must be at most ${AppConstants.maxSpotTitleLength} characters';
    }
    return null;
  }

  /// Validate address
  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    if (value.length < AppConstants.minAddressLength) {
      return 'Address must be at least ${AppConstants.minAddressLength} character';
    }
    if (value.length > AppConstants.maxAddressLength) {
      return 'Address must be at most ${AppConstants.maxAddressLength} characters';
    }
    return null;
  }

  /// Validate persona name
  static String? validatePersonaName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Persona name is required';
    }
    if (value.length < AppConstants.minPersonaNameLength) {
      return 'Persona name must be at least ${AppConstants.minPersonaNameLength} character';
    }
    if (value.length > AppConstants.maxPersonaNameLength) {
      return 'Persona name must be at most ${AppConstants.maxPersonaNameLength} characters';
    }
    return null;
  }

  /// Validate prompt text
  static String? validatePromptText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Prompt text is required';
    }
    if (value.length < AppConstants.minPromptTextLength) {
      return 'Prompt text must be at least ${AppConstants.minPromptTextLength} character';
    }
    if (value.length > AppConstants.maxPromptTextLength) {
      return 'Prompt text must be at most ${AppConstants.maxPromptTextLength} characters';
    }
    return null;
  }

  /// Validate latitude
  static String? validateLatitude(double? value) {
    if (value == null) {
      return 'Latitude is required';
    }
    if (value < -90.0 || value > 90.0) {
      return 'Latitude must be between -90 and 90';
    }
    return null;
  }

  /// Validate longitude
  static String? validateLongitude(double? value) {
    if (value == null) {
      return 'Longitude is required';
    }
    if (value < -180.0 || value > 180.0) {
      return 'Longitude must be between -180 and 180';
    }
    return null;
  }

  /// Validate photo count
  static String? validatePhotoCount(int count) {
    if (count > AppConstants.maxPhotosPerSpot) {
      return 'Maximum ${AppConstants.maxPhotosPerSpot} photos allowed';
    }
    return null;
  }

  /// Validate total photo size
  static String? validateTotalPhotoSize(int totalBytes) {
    if (totalBytes > AppConstants.maxTotalPhotoSizeBytes) {
      final maxMB = AppConstants.maxTotalPhotoSizeBytes / (1024 * 1024);
      return 'Total photo size must be under ${maxMB}MB';
    }
    return null;
  }
}
