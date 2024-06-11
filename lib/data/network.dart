import 'package:http/http.dart' as http;
import 'dart:convert';

class Network{
  final String url;
  final String url2;
  Network(this.url, this.url2);

  Future<dynamic> getJsonData() async {
    //날씨 관련 더미 데이터를 받아온다. 이때, 다 받아온 다음에 실행하게 하기 위해 async이용
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
    else{
      String jsonData = response.body;
      print(jsonData);
    }
  }

  Future<dynamic> getAirData() async {
    //공기질 관련 더미 데이터를 받아온다. 이때, 다 받아온 다음에 실행하게 하기 위해 async이용
    http.Response response = await http.get(Uri.parse(url2));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
    else{
      String jsonData = response.body;
      print(jsonData);
    }
  }
}