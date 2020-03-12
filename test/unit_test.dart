import 'package:flutter_test/flutter_test.dart';
import 'package:weathernow/services/weather.dart';

void main(){
  WeatherModel weatherModel;

  setUp(() {
    weatherModel = new WeatherModel();
  });
  
  group("city data", (){
    test('check searched city data', (){
       var results = weatherModel.getCityWeather('london');
       expect(results, isNot(null));
    });

  });
  
}