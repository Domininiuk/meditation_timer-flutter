 import 'package:flutter/cupertino.dart';

class TimeLeft
 {
   TimeLeft(int secs)
   {
     // Format the model
     secondsLeft = secs;
     _seconds = secs;
     _minutes = _seconds ~/60;
     _seconds -= _minutes * 60;

     _hours = _minutes ~/60;
     _minutes -= _hours * 60;
   }



   int secondsLeft = 0;
   int _seconds = 0;
   int _minutes = 0;
   int _hours = 0;


   void decrement()
   {
     secondsLeft--;
     _convert();
     // If seconds 0
     // decrement  minutes
     //   seconds = 60

   }
   void _convert()
   {
     _seconds = secondsLeft;
     _minutes = _seconds ~/60;
     _seconds -= _minutes * 60;

     _hours = _minutes ~/60;
     _minutes -= _hours * 60;
   }
   @override
  String toString()
   {
     String result = "";
    if(_hours > 0)
       {
         result += "$_hours";
         result += ":";
       }


       result += "$_minutes";
    result += ":";

     if(_seconds < 10)
     {
       result += "0$_seconds";
     }
     else
     {
       result += "$_seconds";
     }

     return result;
   }
 }
