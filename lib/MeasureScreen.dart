import 'package:flutter/material.dart';
import 'package:svelty/MyAppBar.dart';
import 'package:svelty/Track.dart';
import 'package:svelty/WeightPicker.dart';
import 'package:svelty/data/DatabaseHelper.dart';
import 'package:svelty/data/TrackRepository.dart';

class MeasureScreen extends StatelessWidget {
   MeasureScreen({super.key});
   late TrackRepository trackRepository;
   late WeightPicker weightPicker;
   late BuildContext buildContext;

  @override
  Widget build(BuildContext context) {
    trackRepository = TrackRepository(DatabaseHelper());
    weightPicker = WeightPicker();
    buildContext = context;
    return Scaffold(
      appBar: MyAppBar(true),
      body: Column(
        children: [weightPicker],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveTrack,
        tooltip: 'save new Track',
        child: const Icon(Icons.save),
      ),
    );
  }

  void saveTrack() async {
    TrackBuilder trackBuilder = TrackBuilder();
    trackBuilder.weight = weightPicker.getWeight();
    int id = await trackRepository.create(Track(trackBuilder));
    if(id>-1) {
      ScaffoldMessenger.of(buildContext).showSnackBar(const SnackBar(
        content: Text("Le poids est bien enregistrée", style: TextStyle(color: Colors.black),), backgroundColor: Colors.cyanAccent,));
    } else {
      ScaffoldMessenger.of(buildContext).showSnackBar(const SnackBar(
        content: Text("Une erreur s'est produite lors de la prise de poids", style: TextStyle(color: Colors.black),), backgroundColor: Colors.red,));
    }
    Future.delayed(const Duration(milliseconds: 200), () {
        Navigator.pop(buildContext);
    });

  }
}
