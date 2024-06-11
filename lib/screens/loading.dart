import 'package:flutter/material.dart';
import 'package:weatherflutterproject/data/network.dart';
import 'package:weatherflutterproject/data/my_location.dart';
import 'package:weatherflutterproject/screens/weather.dart';
const apikey='내 API 키 ';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double? latitude3;
  double? longitude3;

@override
  void initState() {    //메서드 생성시 한번만 불려옴 (실행 됨)
    // TODO: implement initState
    super.initState();
    getLocation();
  }

void getLocation() async {
  MyLocation myLocation=MyLocation();
  await myLocation.getMyCurrentLocation();
  latitude3 = myLocation.latitude2;
  longitude3 = myLocation.longitude2;

  Network network=Network('https://api.openweathermap.org/data/2.5/'
      'weather?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric',
      'https://api.openweathermap.org/data/2.5/'
          'air_pollution?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric'
  );
  var weatherData= await network.getJsonData();
  print(weatherData);

  var airData = await network.getAirData();
  print(airData);
  
  Navigator.push(context, MaterialPageRoute(builder: (context){
    return WeatherScreen(   //화면 이동이랑 같이 데이터도 보냄
      parseWD: weatherData,
      parseAir: airData,);
  }));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue
          ),
            onPressed: null,
            child: const Text(
              '로딩 중...',
              style: TextStyle(
                color: Colors.white
              ),
            )
        ),
      ),
    );
  }
}
