/// App-wide constants
class AppConstants {
  // App Info
  static const String appName = 'AI Travel Persona Map';
  static const String appVersion = '1.0.0';

  // Photo Constraints
  static const int maxPhotosPerSpot = 5;
  static const int maxTotalPhotoSizeBytes = 50 * 1024 * 1024; // 50MB
  static const int maxImageDimension = 1920;
  static const int jpegQuality = 85;
  static const int thumbnailSize = 300;

  // Validation Constraints
  static const int minSpotTitleLength = 1;
  static const int maxSpotTitleLength = 100;
  static const int minAddressLength = 1;
  static const int maxAddressLength = 500;
  static const int minPersonaNameLength = 1;
  static const int maxPersonaNameLength = 50;
  static const int minPromptTextLength = 1;
  static const int maxPromptTextLength = 10000;

  // API Timeouts
  static const Duration mapsApiTimeout = Duration(seconds: 10);
  static const Duration aiApiTimeout = Duration(seconds: 10);
  static const Duration networkTimeout = Duration(seconds: 30);

  // Retry Strategy
  static const int mapsApiMaxRetries = 3;
  static const int aiApiMaxRetries = 2;
  static const Duration retryDelay = Duration(seconds: 3);

  // Cache
  static const Duration mapTileCacheDuration = Duration(days: 30);
  static const int maxPhotoCache = 50;
  static const int lowStorageWarningMB = 500;

  // Pagination
  static const int initialSpotLoadCount = 50;
  static const int spotLoadBatchSize = 20;

  // Share Token
  static const int shareTokenBits = 128;

  // Log
  static const int maxLogSizeBytes = 5 * 1024 * 1024; // 5MB
}
