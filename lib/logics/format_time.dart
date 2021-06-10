import 'package:flutter/material.dart';

class FormatTime{
  static List<String> displayTime(List<TimeOfDay> time){
    final hours1 = time[0].hour.toString().padLeft(2, '0');
    final minutes1 = time[0].minute.toString().padLeft(2, '0');
    final displayTime1 = '$hours1:$minutes1';
    final hours2 = time[1].hour.toString().padLeft(2, '0');
    final minutes2 = time[1].minute.toString().padLeft(2, '0');
    final displayTime2 = '$hours2:$minutes2';
    return [displayTime1, displayTime2];
  }
}