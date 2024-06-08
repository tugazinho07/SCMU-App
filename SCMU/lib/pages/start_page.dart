import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scmu/components/notification.dart';

class StartingPage extends StatefulWidget {

  const StartingPage({Key? key}) : super(key: key);

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  bool doorOpen = false;
  String realTimeCode = "";
  String realTimeTemp = "-1";
  String realTimePeople = "99";

  void _toggleDoor() {

    NotificationService.showNotification(
        title: 'Código de Acesso',
        body: "Insira o seguinto código:" + realTimeCode,
    );

    /*
    final doorStatusRef = FirebaseDatabase.instance.reference().child('door').child('status');

    // Alternar o estado da porta no Firebase Realtime Database
    doorStatusRef.set(!doorOpen).then((_) {
      setState(() {
        doorOpen = !doorOpen; // Atualizar o estado local da porta
        print('Door status changed to: ${doorOpen ? 'Open' : 'Closed'}');
      });
    }).catchError((error) {
      print('Failed to toggle door status: $error');
    });
    */
  }
  void _openDoor() {
    // Add your implementation here
    print('Door opened');
  }

  void _toggleLight() {
    final adminDoorRef = FirebaseDatabase.instance.ref().child('data').child('adminDoor');
    adminDoorRef.set(true).then((_) {
      setState(() {
        print('adminDoor set to true');
      });
    }).catchError((error) {
      print('Failed to update adminDoor: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference _DoorRef = FirebaseDatabase.instance.ref().child('doorCode');
    _DoorRef.onValue.listen(
            (event) {
              setState(() {
                realTimeCode = event.snapshot.value.toString();
              });
            });
    DatabaseReference _TempRef = FirebaseDatabase.instance.ref().child('data').child('temp');
    _TempRef.onValue.listen(
            (event) {
          setState(() {
            realTimeTemp = event.snapshot.value.toString();
          });
        });
    DatabaseReference _PeopleRef = FirebaseDatabase.instance.ref().child('data').child('people');
    _PeopleRef.onValue.listen(
            (event) {
          setState(() {
            realTimePeople = event.snapshot.value.toString();
          });
        });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Temperature:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          realTimeTemp + "ºC",
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'People:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          realTimePeople,
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleDoor,
                child: Text(doorOpen ? 'Close Door' : 'Ask Code'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleLight,
                child: Text('Toggle Door'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
