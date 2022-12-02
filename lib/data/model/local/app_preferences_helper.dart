import 'package:schedule_meeting/data/model/local/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefToken = 'prefToken';
const String prefUsername = 'prefUsername';
const String prefPassword = 'prefPassword';
const String preUserInfo = 'preUserInfo';
const String prefFistLogin = 'prefFistLogin';
const String prefRememeberLogin = 'prefRememeberLogin';
const String prefThemeDark = 'prefThemeDark';
const String prefThemeAuto = 'prefThemeAuto';
const String prefLanguage = 'prefLanguage';
const String prefMail = 'prefMail';
const String prefName = 'prefName';

class AppPreferencesHelper implements PreferencesHelper {
  // @override
  // Future<String> getToken() async {
  //   LoginResponse? response = await getUserInfo();
  //   return response?.headerToken ?? '';
  // }

  // @override
  // Future<void> saveUserInfo(LoginResponse value, bool rememberLogin) async {
  //   final Map<String, dynamic> userInfo = {
  //     'User_ID': value.userID,
  //     'Company_ID': value.companyID,
  //     'owner_id': value.ownerId,
  //     'super_admin': value.superAdmin,
  //     'level_2_admin': value.level2Admin,
  //     'User_first_name': value.userFirstName,
  //     'User_last_name': value.userLastName,
  //     "Header_Token": value.headerToken,
  //     'User_email_address': value.userEmailAddress,
  //     'First_Login': value.firstLogin,
  //     "remember_login": rememberLogin,
  //   };
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(preUserInfo, jsonEncode(userInfo));
  // }

  // @override
  // Future<LoginResponse?> getUserInfo() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? userInfo = prefs.getString(preUserInfo);
  //   if (userInfo == null) return null;
  //   return LoginResponse.fromJson(jsonDecode(userInfo));
  // }

  @override
  Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(preUserInfo);
  }

  @override
  Future<void> clearAllInfor() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(prefToken);
    await prefs.remove(preUserInfo);
    await prefs.remove(prefUsername);
    await prefs.remove(prefPassword);
    await prefs.remove(preUserInfo);
    await prefs.remove(prefFistLogin);
    await prefs.remove(prefRememeberLogin);
    await prefs.remove(prefLanguage);
    await prefs.remove(prefMail);
  }

  @override
  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool(prefThemeDark) ?? false;
    return isDarkMode;
  }

  @override
  Future<void> saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(prefThemeDark, value);
  }

  @override
  Future<void> saveThemeAuto(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(prefThemeAuto, value);
  }

  @override
  Future<bool> getThemeAuto() async {
    final prefs = await SharedPreferences.getInstance();
    bool isAuto = prefs.getBool(prefThemeAuto) ?? false;
    return isAuto;
  }

  @override
  Future<void> saveLanguage(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefLanguage, value);
  }

  @override
  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String isLanguage = prefs.getString(prefLanguage) ?? '';
    return isLanguage;
  }

  @override
  Future<String> getMail() async {
    final prefs = await SharedPreferences.getInstance();
    String isMail = prefs.getString(prefMail) ?? '';
    return isMail;
  }

  @override
  Future<void> saveMail(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefMail, value);
  }

  @override
  Future<String> getNameUser() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString(prefName) ?? '';
    return name;
  }

  @override
  Future<void> saveNameUser(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefName, value);
  }
}
