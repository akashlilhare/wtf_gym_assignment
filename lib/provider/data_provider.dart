import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:wtf_gym_assignment/core/constant.dart';
import 'package:wtf_gym_assignment/core/enum/filter_type.dart';
import 'package:wtf_gym_assignment/core/enum/gym_type.dart';
import 'package:wtf_gym_assignment/model/city_model.dart';
import 'package:wtf_gym_assignment/model/gym_model.dart';

import '../core/enum/app_connection_status.dart';

class DataProvider with ChangeNotifier {
  AppConnectionStatus appConnectionStatus = AppConnectionStatus.none;
  final Constant _constant = Constant();
   GymModel? gymModel;
  late CityModel cityModel;

  GymType selectedGymType = GymType.all;
  FilterType filterType = FilterType.tag;

  String selectedArea = "";
  Position? userPosition;


  int initialPage = 1;
  int totalPageCount = 1;

  getNearestGym({ int? pageIndex, double? lat, double? long}) async {
    String url =
        "https://devapi.wtfup.me/gym/nearestgym/new?page=${pageIndex??1}&limit=10&lat=${lat??28.572432}&long=${long??77.329105}";
    print(url);

    try {
      appConnectionStatus = AppConnectionStatus.active;
      notifyListeners();
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        gymModel = GymModel.fromJson(jsonDecode(response.body));
        totalPageCount = gymModel!.pagination[0].pages;
        initialPage = pageIndex??1 ;
      } else {
        appConnectionStatus = AppConnectionStatus.done;
        notifyListeners();
      }
    } catch (e) {
      _constant.getToast(title: "Something went wrong");
      appConnectionStatus = AppConnectionStatus.error;
    } finally {
      appConnectionStatus = AppConnectionStatus.none;
      notifyListeners();
    }
  }

  switchGymType({required GymType gymType}) {
    selectedGymType = gymType;
    notifyListeners();
  }

  switchFilterType({required FilterType selectedFilter}) {
    filterType = selectedFilter;
    notifyListeners();
  }

  switchSelectedArea({required String area}) {
    selectedArea = area;
    notifyListeners();
  }

  selectFromLocation({required BuildContext context}) async {
    print("here");
    await determinePosition();
    if (userPosition == null) {
      _constant.getToast(title: "Something went wrong");
    } else {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          userPosition!.latitude, userPosition!.longitude);
      selectedArea = " ${placemarks[0].locality} ${placemarks[0].postalCode} ";
      Navigator.of(context).pop();
      getNearestGym(

          lat: userPosition!.latitude,
          long: userPosition!.longitude);
    }
    notifyListeners();
  }

  determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userPosition = await Geolocator.getCurrentPosition();
    notifyListeners();
  }

  resetFilter() {
    selectedGymType = GymType.all;
    filterType = FilterType.tag;
    userPosition = null;
    notifyListeners();
  }

  getCities() async {
    String url = "https://devapi.wtfup.me/gym/cities";

    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI0cTYwTWs3R0poeXg5IiwibmFtZSI6Ik5hcmVzaCIsImlhdCI6MTY2Mzc1MjEzNCwiZXhwIjoxNjY2MzQ0MTM0fQ.CtfnZC3Y58YcoLCD29v8Fjz24kQUeUfViDx6ukGJPFw";

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      appConnectionStatus = AppConnectionStatus.active;
      notifyListeners();
      http.Response response =
          await http.get(Uri.parse(url), headers: requestHeaders);
      print("response body");
      print(
        response.body,
      );
      if (response.statusCode == 200) {
        cityModel = CityModel.fromJson(jsonDecode(response.body));
      } else {
        appConnectionStatus = AppConnectionStatus.done;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      _constant.getToast(title: "Something went wrong");
      appConnectionStatus = AppConnectionStatus.error;
    } finally {
      appConnectionStatus = AppConnectionStatus.none;
      notifyListeners();
    }
  }
}
