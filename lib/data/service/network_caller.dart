import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);

      Response response = await get(
        uri,
        headers: {'token': AuthController.accessToken ?? ''},
      );
      _logResponse(url, response);

      final decodedData = await jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          responseCode: response.statusCode,
          body: decodedData,
        );
      }  else if (response.statusCode == 401) {
        _onUnAuthorized();
        return NetworkResponse(
          isSuccess: false,
          responseCode: response.statusCode,
          errorMessage: 'Un-Authorized',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          responseCode: response.statusCode,
          errorMessage:
              decodedData['data']?.toString() ?? 'Something went wrong!',
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        responseCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, body: body);

      Response response = await post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'token': AuthController.accessToken ?? '',
        },
        body: jsonEncode(body),
      );
      _logResponse(url, response);

      final decodedData = await jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          responseCode: response.statusCode,
          body: decodedData,
        );
      } else if (response.statusCode == 401) {
        _onUnAuthorized();
        return NetworkResponse(
          isSuccess: false,
          responseCode: response.statusCode,
          errorMessage: 'Un-Authorized',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          responseCode: response.statusCode,
          errorMessage:
              (decodedData['data']?.toString() ??
              decodedData['status']?.toString() ??
              'Something went wrong! Please try again later...'),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      return NetworkResponse(
        isSuccess: false,
        responseCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> patchRequest(
      String url, {
        Map<String, dynamic>? body,
      }) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, body: body);

      Response response = await patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'token': AuthController.accessToken ?? '',
        },
        body: body != null ? jsonEncode(body) : null,
      );
      _logResponse(url, response);

      final decodedData = await jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          responseCode: response.statusCode,
          body: decodedData,
        );
      } else if (response.statusCode == 401) {
        _onUnAuthorized();
        return NetworkResponse(
          isSuccess: false,
          responseCode: response.statusCode,
          errorMessage: 'Un-Authorized',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          responseCode: response.statusCode,
          errorMessage:decodedData['data']);
      }
    } catch (e) {
      debugPrint(e.toString());
      return NetworkResponse(
        isSuccess: false,
        responseCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> deleteRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);

      Response response = await delete(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'token': AuthController.accessToken ?? '',
        },
      );
      _logResponse(url, response);

      final decodedData = await jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          responseCode: response.statusCode,
          body: decodedData,
        );
      } else if (response.statusCode == 401) {
        _onUnAuthorized();
        return NetworkResponse(
          isSuccess: false,
          responseCode: response.statusCode,
          errorMessage: 'Un-Authorized',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          responseCode: response.statusCode,
          errorMessage: decodedData['data']?.toString() ?? 'Delete failed!',
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      return NetworkResponse(
        isSuccess: false,
        responseCode: -1,
        errorMessage: e.toString(),
      );
    }
  }


  static void _onUnAuthorized() async {
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(
      TaskManagerApp.navigatorKey.currentContext!,
      SignInScreen.routeName,
      (route) => false,
    );
  }

  static void _logRequest(String url, {Map<String, dynamic>? body}) {
    debugPrint(
      'Request: $url\n'
      'Body: ${body != null ? jsonEncode(body) : 'No body'}',
    );
  }

  static void _logResponse(String url, Response response) {
    debugPrint(
      'Request: $url\n'
      'Status Code: ${response.statusCode}\n'
      'Response: ${response.body}',
    );
  }
}

class NetworkResponse {
  final bool isSuccess;
  final int responseCode;
  final dynamic body;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.responseCode,
    this.body,
    this.errorMessage = 'Something went wrong! Please try again later...',
  });
}
