/// Global configuration for the app
///
/// This class contains flags that control the app's behavior
/// for development and testing purposes.
///
/// DEVELOPER NOTE: Modify these values to quickly switch between different app states
class AppConfig {
  /// Whether the user has completed their profile
  ///
  /// Set to true to show the app as if the user has a complete profile
  /// Set to false to show the "Create profile now" prompt
  static bool hasCompletedProfile = true;

  /// Whether the user is new and needs onboarding
  ///
  /// Set to true to show onboarding screens
  /// Set to false to skip onboarding and go directly to the main app
  static bool isNewUser = false;

  /// Whether to show debug information in the app
  static bool showDebugInfo = false;

  /// Print the current configuration values
  static void printConfig() {
    print(
        'AppConfig: hasCompletedProfile=$hasCompletedProfile, isNewUser=$isNewUser');
  }
}
