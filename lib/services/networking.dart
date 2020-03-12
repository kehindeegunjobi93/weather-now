import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  final String url;

  WeatherService(this.url);

  Future getData() async {
    http.Response response = await
    http.get(url);
    if(response.statusCode == 200){
      String data = response.body;
      var decoded = jsonDecode(data);
      return decoded;

    } else {
      print('error');
    }
}

}