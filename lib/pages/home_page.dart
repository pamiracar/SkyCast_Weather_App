import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skycast_web/models/weather_model.dart';
import 'package:skycast_web/pages/weather_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _emailController;
  String sehir = "";

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: sehir);
    _emailController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Center(
          child: const Text(
            "SkyCast",
            style: TextStyle(color: Color(0xFFB0BEC5)),
          ),
        ),
        backgroundColor: Theme.of(
          context,
        ).colorScheme.surfaceContainer.withAlpha(450),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //cloud icon
            Icon(
              Icons.cloud_queue,
              size: 120,
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainer.withAlpha(450),
            ),

            //where are you now?
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                style: TextStyle(color: Color(0xFFB0BEC5)),
                onChanged: (value) {
                  setState(() {
                    sehir = value;
                  });
                },
                decoration: InputDecoration(
                  hint: Text(
                    "Hangi şehrin hava durumunu öğrenmek istersin?",
                    style: TextStyle(color: Color(0xFFB0BEC5)),
                  ),
                  filled: true,
                  fillColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainer.withAlpha(100),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            //learn button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest.withAlpha(450),
                ),
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherPage(data: sehir,)),
                  );
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: const Text(
                      "Öğren",
                      style: TextStyle(color: Color(0xFFB0BEC5)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
