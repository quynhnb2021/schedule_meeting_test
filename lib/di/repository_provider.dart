import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/data/model/local/app_preferences_helper.dart';
import 'package:schedule_meeting/data/repository/firebase_manage.dart';

final firebaseManageProvider = Provider((ref) => FirebaseManager(ref.read));

final sharedPrefProvider = Provider((_) => AppPreferencesHelper());
