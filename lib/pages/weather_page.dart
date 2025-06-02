import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skycast_web/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({super.key, required this.data});

  final String data;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Future<WeatherModel>? weatherFuture;

  String get seciliOlanSehir => widget.data;

  @override
  void initState() {
    // TODO: implement initState

    selectedCity(seciliOlanSehir);
  }

  void selectedCity(String sehir) {
    setState(() {
      sehir = seciliOlanSehir;
      weatherFuture = getWeather(sehir);
    });
  }

  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.openweathermap.org/data/2.5",
      queryParameters: {
        "appid": "9e8cc2a1b4f6e04b49bd486d322ebe01",
        "lang": "tr",
        "units": "metric",
      },
    ),
  );

  Future<WeatherModel> getWeather(String secilensehir) async {
    final response = await dio.get(
      "/weather",
      queryParameters: {"q": secilensehir},
    );
    var model = WeatherModel.fromJson(response.data);
    return model;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "SkyCast",
          style: TextStyle(color: Color(0xFFB0BEC5)),
        ),
        backgroundColor: Theme.of(
          context,
        ).colorScheme.surfaceContainer.withAlpha(450),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.data,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 55,
                color: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest.withAlpha(450),
              ),
            ),
            FutureBuilder(
              future: weatherFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.surface.withAlpha(450),
                  ));
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString(), textAlign: TextAlign.center,style: TextStyle(color: Colors.black),),
                  );
                }
                if (snapshot.hasData) {
                  final List<Map<String, dynamic>> infos = [
                    {
                      "title": "Sıcaklık",
                      "value": "${snapshot.data!.main!.temp} °C",
                      "icon": Icons.thermostat,
                    },
                    {
                      "title": "Hissedilen",
                      "value": "${snapshot.data!.main!.feelsLike} °C",
                      "icon": Icons.thermostat,
                    },
                    {
                      "title": "Nem",
                      "value": "${snapshot.data!.main!.humidity} %",
                      "icon": Icons.water_drop,
                    },
                    {
                      "title": "Rüzgar",
                      "value": "${snapshot.data!.wind!.speed} m/s",
                      "icon": Icons.wind_power,
                    },
                    {
                      "title": "Basınç",
                      "value": "${snapshot.data!.main!.pressure} hPa",
                      "icon": Icons.speed,
                    },
                  ];

                  return Container(
                    margin: EdgeInsets.all(25),
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainer.withAlpha(450),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${snapshot.data!.main!.temp.toString()} °C",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 40,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          SizedBox(height: 20),
                          //grid
                          GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                ),
                            itemCount: 4,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final item = infos[index+1];
                              return Card(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainer.withAlpha(500),
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        item['icon'],
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        size: 40,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        item['title'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      ),
                                      Text(
                                        item['value'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
