
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:task_managenent/app.dart';
import 'package:task_managenent/ui/Screen/login_screen.dart';
import 'package:task_managenent/ui/controllers/auth-controller.dart';

class apiCaller {
  static final Logger _logger = Logger();

  static Future<ApiResponse> getRequest ({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url);

      Response response = await get(uri, headers: {
        'token' : AuthController.accessToken ?? ''
      }) ;
      _logResponse(url, response);

      final int statusCode = response.statusCode;


      if(statusCode == 200) {
        // Success
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
            isSuccess: true,
            responseCode: statusCode,
            responseData: decodedData
        );
      } else if(statusCode == 401) {
          await _moveToLogin();
          return ApiResponse(
              isSuccess: false,
              responseCode: statusCode,
              errorMessage: "Un-Authorized",
              responseData: null,
          );
      } else {
        // Failed
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
            isSuccess: false,
            responseCode: statusCode,
            responseData: decodedData,
            errorMessage: decodedData['data']
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
          isSuccess: false,
          responseCode: -1,
          responseData: null,
          errorMessage: e.toString()

      );
    }
  }
  static Future<ApiResponse> postRequest ({required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      _logRequest(url, body: body);

      Response response = await post(uri,
      headers: {"content-type": "application/json",
        'token' : AuthController.accessToken ?? ''
      },
      body: jsonEncode(body)
      ) ;
      _logResponse(url, response);

      final int statusCode = response.statusCode;


      if(statusCode == 200 || statusCode == 201) {
        // Success
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
            isSuccess: true,
            responseCode: statusCode,
            responseData: decodedData,
        );
      } else if(statusCode == 401) {
        await _moveToLogin();
        return ApiResponse(
          isSuccess: false,
          responseCode: statusCode,
          errorMessage: "Un-Authorized",
          responseData: null,
        );
      } else {
        // Failed
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
            isSuccess: false,
            responseCode: statusCode,
            responseData: decodedData,
            errorMessage: decodedData['message'] ?? 'Something went wrong',
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
          isSuccess: false,
          responseCode: -1,
          responseData: null,
          errorMessage: e.toString()

      );
    }
  }

  static void _logRequest (String url, {Map<String, dynamic>? body}) {
    _logger.i("URL => $url\n"
    "Request Body: $body"
    );
  }

  static void _logResponse (String url, Response response ) {
    _logger.i("URL => $url\n"
    "Status Code: ${response.statusCode}\n"
        "Body: ${response.body}"
    );
  }

   static Future<void> _moveToLogin() async {
     await AuthController.clearUserData();
     Navigator.pushNamedAndRemoveUntil(TaskManager.navigator.currentContext!, LoginScreen.name, (predicate) => false);
   }
}

class ApiResponse {
  final bool isSuccess;
  final int responseCode;
  final dynamic responseData;
  final String? errorMessage;

  ApiResponse({
    required this.isSuccess,
    required this.responseCode,
    required this.responseData,
    this.errorMessage = "Something went wrong"
  });
}