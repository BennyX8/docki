/*
* File : json_checker
* Version : 1.0.0
* */

import 'dart:convert';

abstract class JsonChecker {
  Future<bool> isJson(String response);
}

class JsonCheckerImpl implements JsonChecker {
  final JsonCodec jsonCodec;

  JsonCheckerImpl(this.jsonCodec);

  @override
  Future<bool> isJson(String response) async {
    try {
      jsonCodec.decode(response);
      return true;
    } on FormatException {
      return Future.value(false);
    }
  }
}
