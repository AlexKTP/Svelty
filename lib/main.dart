import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:svelty/MeasureScreen.dart';
import 'package:svelty/MyAppBar.dart';
import 'package:svelty/data/DatabaseHelper.dart';
import 'package:svelty/data/TrackRepository.dart';

void main() {
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

  @override
  void initState() {
    currentDateFormated = DateFormat('EEE d MMM yyyy').format(currentDate);
    TrackRepository trackRepository = TrackRepository(DatabaseHelper());
    trackRepository.rowCount().then((value) => _counter = value??=0);
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
}
