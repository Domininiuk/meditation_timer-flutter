import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forfun/widgets/countdown_timer.dart';

import 'models/time_left.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meditation Timer',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
        backgroundColor: Colors.grey,

      ),
      home: const MyHomePage(title: 'Meditation timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer _timer;

  // update the ui and secondsLeft with each tick using setstaet

  TimeLeft _timeLeft = TimeLeft(5*60);
  bool _timerRunning = false;
  final List<int> _timerValues = [5, 10 ,15, 30, 45, 60, 90];
  String _menuItem = "5";
  IconData _currentFabIcon = Icons.alarm_add;


  ///
  /// This method formats _secondsLeft into a HH:MM::SS format for the text
  ///
  String formatSecondsLeft()
  {
    String result ="";



    return result;
  }
  void _fabPressed(){
    /// If the timer isnt running
    /// Start it and change the fab icon to pause
    /// If it is running, cancel the timer,
    /// and change the icon to start

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CountDownTimer(UniqueKey(),
          _timeLeft.secondsLeft))
    );
    if(!_timerRunning){
      startTimer();
    }
    else if(_timerRunning){
     stopTimer();
    }
}
void stopTimer(){
    setState((){
      _timer.cancel();
      _timerRunning = false;
    });
}

  void startTimer()
  {
    //setState()
    _timerRunning = true;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
        (Timer timer){
        if(_timeLeft.secondsLeft == 0){
          setState((){
           stopTimer();
           SystemSound.play(SystemSoundType.alert);
            // add a cancel timer method
          });
        }
        else{
          setState((){
            _timeLeft.decrement();
          });
        }
        },
    );
  }


  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  void _onTimeListChanged(String? s)
  {
    setState(() {
      // Times sixty because a minute has 60 seconds
      _timeLeft = TimeLeft(int.parse(s!) * 60);
      _menuItem = s;
    }
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
             Visibility(
               child: Text(
            "How many minutes would you like to meditate for:"
            ,
              // style: Theme.of(context).textTheme.headline6
               ),
               visible: !_timerRunning,
             )
            ,
            Visibility(
            child: DropdownButton<String>(
              icon: const Icon(Icons.arrow_downward),
              focusColor:Colors.white,
              elevation: 16,
              onChanged: _onTimeListChanged,
              value: _menuItem,
              items:( _timerValues.map((int value){
                return DropdownMenuItem<String>(
                  value: value.toString(),
                  child: Text(value.toString(), //style: Theme.of(context).textTheme.headline4
                 ),
                );
              }).toList()
              ),
            ),
            visible: !_timerRunning,
          ),
            Text(_timeLeft.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
        // ADD A DROPDOWN BUTTOn
      ),
      bottomNavigationBar:  BottomAppBar(
        notchMargin: 5,
        shape: CircularNotchedRectangle(),

        color: Colors.grey,
        child: Row(
          children: [
           IconButton(onPressed: () {  },
              icon: Icon(Icons.menu),
            )
          ],

        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: _fabPressed,
          tooltip: 'Increment',
          child: Icon(_timerRunning
              ? Icons.stop
              : Icons.alarm_add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



/*

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CountDownTimer(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        accentColor: Colors.red,
      ),
    );
  }

 */

}
