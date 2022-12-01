import 'package:schedule_meeting/data/model/remote/response/schedule_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:schedule_meeting/ui/base/base_view_model.dart';

class HomeScheduleViewModel extends BaseViewModel {
  HomeScheduleViewModel(Reader reader) : super(reader);
  List<ScheduleResponse>? dataSchedules;
  String type = '';
  Stream<QuerySnapshot>? schedulesStream;
  getBlogs(String? type, String? mail) async {
    setBusy(true);
    await appApiHelper.getSchedule('schedules', type, mail, (data) {
      print(data);
      schedulesStream = data;
      setBusy(false);
    });
    setBusy(false);
  }

  // choseType(int i) async {
  //   switch (i) {
  //     case 0:
  //       type = 'Sports';
  //       await getBlogs(type, null);
  //       notifyListeners();
  //       break;
  //     case 1:
  //       type = 'Movies';
  //       await getBlogs(type, null);
  //       notifyListeners();
  //       break;
  //     default:
  //       type = '';
  //       await getBlogs(null, null);
  //       notifyListeners();
  //       break;
  //   }
  // }
}
