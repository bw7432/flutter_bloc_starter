import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:flutter_starter/app/interceptors/api_interceptor.dart';
import 'dart:convert';
import 'package:flutter_starter/app/networking/api_exceptions.dart';
import 'package:flutter_starter/app/services/navigator_service.dart';
import 'package:flutter_starter/locator.dart';
import 'dart:async';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiBaseHelper {
  final String _baseUrl = "http://127.0.0.1:3000/api/v2/";

  final NavigatorService _navigatorService = locator<NavigatorService>();
  http.Client client = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await client.get(Uri.parse(_baseUrl + url));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on UnauthenticatedException {
      _navigatorService.navigateToAndRemove('/login');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    var responseJson;
    try {
      final response = await client.post(Uri.parse(_baseUrl + url), body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on UnauthenticatedException {
      _navigatorService.navigateToAndRemove('/login');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    var responseJson;
    try {
      final response = await client.put(Uri.parse(_baseUrl + url), body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on UnauthenticatedException {
      _navigatorService.navigateToAndRemove('/login');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    print('Api delete, url $url');
    var apiResponse;
    try {
      final response = await client.delete(Uri.parse(_baseUrl + url));
      apiResponse = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on UnauthenticatedException {
      _navigatorService.navigateToAndRemove('/login');
    }
    return apiResponse;
  }

  Future<dynamic> signIn(String url, dynamic body) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(_baseUrl + url), body: body);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (response.statusCode == 200) {
        await prefs.setString(
            'accessToken', response.headers['access-token'] ?? "");
        await prefs.setString('client', response.headers['client'] ?? "");
        await prefs.setString(
            'uid', json.decode(response.body)['data']['uid'] ?? "");
        await prefs.setString(
            'email', json.decode(response.body)['data']['email'] ?? "");
        await prefs.setInt(
            'userId', json.decode(response.body)['data']['id'] ?? 0);

        String deviceId = await PlatformDeviceId.getDeviceId ?? "";
        await prefs.setString('deviceId', deviceId);
      }
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on UnauthenticatedException {
      return Future.error('Unexpected error 😢');
    }
    return responseJson;
  }

  Future<dynamic> signUp(String url, dynamic body) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(_baseUrl + url),
          headers: {"Content-Type": "application/json"}, body: body);

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'accessToken', response.headers['access-token'] ?? "");
        await prefs.setString('client', response.headers['client'] ?? "");
        await prefs.setString(
            'uid', json.decode(response.body)['data']['uid'] ?? "");
        await prefs.setString(
            'email', json.decode(response.body)['data']['email'] ?? "");
        await prefs.setInt(
            'userId', json.decode(response.body)['data']['id'] ?? 0);
        String deviceId = await PlatformDeviceId.getDeviceId ?? "";
        await prefs.setString('deviceId', deviceId);
      }
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on UnauthenticatedException {
      return Future.error('Unexpected error 😢');
    }
    return responseJson;
  }

  Future<dynamic> signOut(String url) async {
    var responseJson;
    try {
      final response = await client.delete(Uri.parse(_baseUrl + url));

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('accessToken');
        await prefs.remove('client');
        await prefs.remove('uid');
        await prefs.remove('userId');
        await prefs.remove('email');
        await prefs.remove('deviceId');
      }

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on UnauthenticatedException {
      return Future.error('Unexpected error 😢');
    }
    return responseJson;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
      throw UnauthenticatedException(response.body.toString());
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
