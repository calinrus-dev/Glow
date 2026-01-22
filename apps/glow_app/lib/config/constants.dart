/// Application constants.
class AppConstants {
  const AppConstants._();

  // API
  static const apiTimeout = Duration(seconds: 30);
  static const apiConnectTimeout = Duration(seconds: 15);

  // Cache
  static const cacheDuration = Duration(hours: 1);
  static const maxCacheSize = 100 * 1024 * 1024; // 100 MB

  // Pagination
  static const defaultPageSize = 20;
  static const maxPageSize = 100;

  // Realtime
  static const realtimeHeartbeatInterval = Duration(seconds: 30);
  static const realtimeReconnectDelay = Duration(seconds: 5);

  // Media
  static const maxImageSize = 10 * 1024 * 1024; // 10 MB
  static const maxVideoSize = 100 * 1024 * 1024; // 100 MB
  static const imageQuality = 85;

  // Storage keys
  static const authTokenKey = 'auth_token';
  static const refreshTokenKey = 'refresh_token';
  static const userPrefsKey = 'user_preferences';
  static const themeKey = 'theme_mode';
}
