import 'package:flutter/material.dart';
import 'package:project_x/providers/setting_provider.dart';

Future pickTime1(SettingProvider settingProvider, BuildContext context, TimeOfDay timeFish) async {
  final initialTime = timeFish;
  final newTime = await showTimePicker(
    context: context,
    initialTime: initialTime,
  );

  if (newTime == null) return;
  // ທຸກຄັ້ງທີເລືອກເວລາຈະ update data ຢູ່ provider
  settingProvider.setTimeFish1(newTime);
}

Future pickTime2(SettingProvider settingProvider, BuildContext context, TimeOfDay timeFish) async {
  final initialTime = timeFish;
  final newTime = await showTimePicker(
    context: context,
    initialTime: initialTime,
  );

  if (newTime == null) return;
  // ທຸກຄັ້ງທີເລືອກເວລາຈະ update data ຢູ່ provider
  settingProvider.setTimeFish2(newTime);
}
