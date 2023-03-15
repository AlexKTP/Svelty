import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/intl.dart';
import 'package:svelty/MeasureScreen.dart';
import 'package:svelty/MyAppBar.dart';
import 'package:svelty/data/DatabaseHelper.dart';
import 'package:svelty/data/TrackRepository.dart';

void main() {
  if(Platform.isAndroid || Platform.isIOS){
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Svelty'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  DateTime currentDate = DateTime.now();
  String currentDateFormated = "";
  bool _isThereNonSynchroData = false;

  void initialization() async {
    Timer(const Duration(seconds: 2), () {FlutterNativeSplash.remove();});
  }

  @override
  void initState() {
    if(Platform.isIOS || Platform.isAndroid){
      initialization();
    }
    currentDateFormated = DateFormat('EEE d MMM yyyy').format(currentDate);
    TrackRepository trackRepository = TrackRepository(DatabaseHelper());
    trackRepository.rowCount().then((value) => _counter = value??=0);
    trackRepository.isThereNonSynchroData().then((value) => _isThereNonSynchroData = value??=false);
    super.initState();
  }

  void _buildTrack() {
     Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MeasureScreen(),
        ),
     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentDateFormated),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                'Nombre de prises de poids: $_counter',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(_isThereNonSynchroData) Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const Text('Données à synchroniser',
                      style: TextStyle(
                          color:  Colors.greenAccent,
                         fontWeight: FontWeight.w100,
                          fontStyle: FontStyle.normal,
                          fontSize: 10),),
                    IconButton(onPressed: _synchronize, icon: const Icon(Icons.sync, color: Colors.greenAccent,))
                  ],)
                ],
              )
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _buildTrack,
        tooltip: 'Build new Track',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _synchronize() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Synchronisation lancée", style: TextStyle(color: Colors.black),), backgroundColor: Colors.cyanAccent,));
  }
}
