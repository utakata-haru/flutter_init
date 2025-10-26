/// App routing paths
class AppPaths {
  // Onboarding
  static const String splash = '/';
  static const String permission = '/permission';
  static const String apiKeySetup = '/api-key-setup';
  static const String tutorial = '/tutorial';

  // Main
  static const String home = '/home';

  // Spot
  static const String spotDetail = '/spot/:id';
  static const String spotEdit = '/spot/:id/edit';

  // Post
  static const String postCreate = '/post/create';
  static const String postDraft = '/post/draft/:id';

  // Persona
  static const String personaList = '/persona';
  static const String personaCreate = '/persona/create';
  static const String personaEdit = '/persona/:id/edit';
  static const String personaDetail = '/persona/:id';

  // Share
  static const String guestView = '/share/:token';

  // Settings
  static const String settings = '/settings';
  static const String apiKeySettings = '/settings/api-key';
  static const String languageSettings = '/settings/language';
}
