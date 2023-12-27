import 'package:flutter/cupertino.dart';

enum DeviceScreenType {
  desktop,
  tablet,
  cellphone,
}

DeviceScreenType getDeviceScreenType(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;
  final size = MediaQuery.of(context).size;

  if (Orientation.portrait == orientation) {
    if (size.width >= 900) {
      return DeviceScreenType.desktop;
    } else if (size.width >= 600) {
      return DeviceScreenType.tablet;
    } else {
      return DeviceScreenType.cellphone;
    }
  } else {
    if (size.height >= 900) {
      return DeviceScreenType.desktop;
    } else if (size.height >= 600) {
      return DeviceScreenType.tablet;
    } else {
      return DeviceScreenType.cellphone;
    }
  }
}
