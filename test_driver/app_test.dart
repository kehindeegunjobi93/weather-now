import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('City Search', (){
    final textFieldFinder = find.byValueKey('citySearch');
    final buttonFinder = find.byValueKey('searchButton');
    
    FlutterDriver driver;
    
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    
    tearDownAll(() async {
      if(driver != null){
        driver.close();
      }
    });

    test('check flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });
    
    test('receive city name', () async {
      await driver.tap(textFieldFinder);
      
      await driver.enterText("london");
      
      await driver.tap(buttonFinder);
      
      expect(await driver.getText(textFieldFinder), "london");
    });
  });
}