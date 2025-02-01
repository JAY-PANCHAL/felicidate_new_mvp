import 'package:flutter/material.dart';

enum BookingKey
{
  start,
  stop,
  cancel,
  client_cancel,
  extra
}

extension ExtraFunctionality on BookingKey
{
  String get string
  {
    switch (this)
    {
      case BookingKey.start:
        return "start";
      case BookingKey.stop:
        return "stop";
      case BookingKey.cancel:
        return "cancel";
      case BookingKey.extra:
        return "extra";
      case BookingKey.client_cancel:
        return "client_cancel";
    }
  }
  int get id
  {
    switch (this)
    {
      case BookingKey.start:
        return 1;
      case BookingKey.stop:
        return 2;
      case BookingKey.cancel:
        return 4;
      case BookingKey.extra:
        return 3;
      case BookingKey.client_cancel:
        return 5;
    }
  }

}