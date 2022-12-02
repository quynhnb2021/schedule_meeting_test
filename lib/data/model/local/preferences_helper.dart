abstract class PreferencesHelper {
  // Future<String> getToken();

  // Future<void> saveUserInfo(LoginResponse value, bool rememberLogin);

  // Future<LoginResponse?> getUserInfo();

  Future<void> clearUserInfo();
  Future<void> clearAllInfor();

  Future<void> saveTheme(bool value);
  Future<void> getTheme();

  Future<void> saveMail(String value);
  Future<void> getMail();
  Future<void> saveNameUser(String value);
  Future<void> getNameUser();
}
