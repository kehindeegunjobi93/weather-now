import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weathernow/screens/city_screen.dart';
import 'package:weathernow/services/weather.dart';
import 'package:weathernow/utilities/constants.dart';
import 'package:weathernow/utilities/helper.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  var date;
  var country;
  var desc;
  var speed;
  var humidity;
  var pressure;
  var iconBg;

  Color _iconColor = Colors.white;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
    print(widget.locationWeather);
  }

  void updateUI(dynamic weatherData){
    setState(() {
      if (weatherData == null){
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      date = Helper.getFormattedDate(new DateTime.fromMillisecondsSinceEpoch(weatherData['dt'] * 1000));
      country = weatherData['sys']['country'];
      desc = weatherData['weather'][0]['description'];
      speed = weatherData['wind']['speed'].toStringAsFixed(1);
      humidity = weatherData['main']['humidity'].toStringAsFixed(0);
      pressure = weatherData['main']['pressure'];
      var icon = weatherData['weather'][0]['icon'];
      iconBg = weather.getBackground(icon);

    });

  }

  _showSnackBar(){
    final snackBar = new SnackBar(
      content: Text("$cityName is added to Favorites",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20
      ),),
      backgroundColor: Colors.redAccent.withOpacity(0.8),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/$iconBg.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        var weatherData =  await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    //print(typedName);
                    },
                    child: Icon(
                      Icons.search,
                      size: 50.0,
                    ),
                  ),


                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.my_location,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            '$date',
                            style: dateTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                              '$temperature°',
                              style: kTempTextStyle,
                            ),
                            Text(
                              weatherIcon,
                              style: kConditionTextStyle,
                            ),
                      ]
                          ),
                          Text('$desc', style: dateTextStyle,),
                          Text('in $cityName, $country', style: kButtonTextStyle,),
                        ],
                      ),
                    ),

                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:8, horizontal:8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("$speed mi/h", style: dateTextStyle,),
                            Icon(Icons.arrow_forward, size: 30, color: Colors.lightGreenAccent)
                          ],
                        ),
                      ),

                    Row(
                      children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("$humidity %", style: dateTextStyle),
                          Icon(Icons.hot_tub, size: 30, color: Colors.yellowAccent)
                        ],
                      ),
                    ),
                ],
                    ),

                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("${pressure} hPa", style: dateTextStyle),
                              Icon(Icons.cloud, size: 30, color: Colors.blueAccent)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
