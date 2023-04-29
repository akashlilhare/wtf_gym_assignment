import 'package:fluttertoast/fluttertoast.dart';
import 'package:wtf_gym_assignment/core/enum/gym_type.dart';

class Constant {
  getToast({required String title}) {
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0);
  }

  getGymTitle({required GymType gymType}) {
    if (gymType == GymType.all) {
      return "All";
    } else if (gymType == GymType.exclusive) {
      return "WTF Exclusive";
    } else if (gymType == GymType.coBranded) {
      return "WTF Co-branded";
    } else {
      return "WTF Powered";
    }
  }

  stringToGymType({required String gymType}) {
    if (gymType == "Powered") {
      return GymType.powered;
    } else if (gymType == "Exclusive") {
      return GymType.exclusive;
    } else {
      return GymType.coBranded;
    }
  }
}
