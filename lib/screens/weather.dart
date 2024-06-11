import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:weatherflutterproject/model/model.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWD, this.parseAir}); //필요 데이터 파싱해오기
  final parseWD;
  final parseAir;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model=Model();
  String? cityName;
  int? temp;
  Widget? icon;
  var date = DateTime.now();
  String? des;
  Widget? airIcon;
  Widget? airState;
  double? dust1;
  double? dust2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWD, widget.parseAir);
  }

  void updateData(dynamic weatherData, dynamic airData) {
    double temp2 = weatherData['main']['temp'];
    int condition =weatherData['weather'][0]['id'];
    temp = temp2.toInt();
    cityName = weatherData['name'];
    icon=model.getWeatherIcon(condition);
    des=weatherData['weather'][0]['description'];
    int index=airData['list'][0]['main']['aqi'];
    airIcon=model.getAirIcon(index);
    airState=model.getAirCondition(index);
    dust1=airData['list'][0]['components']['pm10'];
    dust2=airData['list'][0]['components']['pm2_5'];

    print(temp);
    print(cityName);
  }

  String getSystemTime() {
    var now = DateTime.now(); //현재 시간 받아오기
    return DateFormat("h:mm a").format(now); //시간 포맷 형태
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, //바디를 앱바 위치까지 올리기
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        //앱바 색상 투명하게
        elevation: 0.0,
        //높이 없애기
        leading: IconButton(
          //앱바 좌측에 넣기
          icon: Icon(Icons.near_me),
          onPressed: () {},
          iconSize: 30.0,
        ),
        actions: [
          //앱바 우측에 넣기
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.location_searching),
            iconSize: 30.0,
          )
        ],
      ),
      body: Container(
        child: Stack(
          //위젯 쌓기
          children: [
            Image.asset(
              'image/background.jpg',
              fit: BoxFit.cover, //배경 이미지로 가져 온 걸 화면에 꽉 차게 함.
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150.0,
                            ),
                            Text(
                              '$cityName',
                              style: GoogleFonts.lato(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Row(
                              children: [
                                TimerBuilder.periodic(
                                  //시간 가져오기/갱신하기
                                  (Duration(minutes: 1)),
                                  builder: (context) {
                                    print('${getSystemTime()}');
                                    return Text(
                                      '${getSystemTime()}',
                                      style: GoogleFonts.lato(
                                          fontSize: 16.0, color: Colors.white),
                                    );
                                  },
                                ),
                                Text(
                                  DateFormat(' - EEEE, ').format(date),
                                  style: GoogleFonts.lato(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                                Text(
                                  DateFormat('d MMM, yyy').format(date),
                                  style: GoogleFonts.lato(
                                      fontSize: 16.0, color: Colors.white),
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$temp\u2103',
                              style: GoogleFonts.lato(
                                  fontSize: 85.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                            Row(
                              children: [
                                icon!,
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('$des',
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0, color: Colors.white))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 15.0,
                        thickness: 2.0,
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'AQI(대기질 지수)',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0, color: Colors.white
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              airIcon!,
                              SizedBox(
                                height: 10.0,
                              ),
                              airState!
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '미세먼지',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0, color: Colors.white
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '$dust1',
                                style: GoogleFonts.lato(
                                    fontSize: 24.0, color: Colors.white
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '㎍/㎥',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0, color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '초미세먼지',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    color: Colors.white
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '$dust2',
                                style: GoogleFonts.lato(
                                    fontSize: 24.0,
                                    color: Colors.white
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '㎍/㎥',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0, color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
