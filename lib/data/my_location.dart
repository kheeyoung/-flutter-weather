import 'package:geolocator/geolocator.dart';
//위치 가져오기

class MyLocation {
  double? latitude2;
  double? longitude2;

  Future <void> getMyCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator
          .requestPermission(); //위치 정보 사용 허가
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude2 = position.latitude;
      longitude2 = position.longitude;
      print(latitude2);
      print(longitude2);
    }
    catch (e) {
      print('연결 실패');
    }
  }
}