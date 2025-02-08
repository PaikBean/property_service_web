import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../common/LoginData.dart';
import 'package:logger/logger.dart';

const TIME_OUT_DURATION = Duration(seconds: 30);
const String BASE_URL = 'localhost:8080';

enum HttpType {
  GET,
  POST,
  POST_NO_TOKEN,
  PUT,
  DELETE,
}

Logger logger = Logger();

class ApiCallUtils {
  static Future<String> apiRequest({
    required BuildContext context,
    required String url,
    required HttpType type,
    Map<String, dynamic>? queryParam,
    dynamic body,
  }) async {
    logger.i("Call API\t${type.name} $url\n\n"
        "Query Params: ${queryParam != null ? jsonEncode(queryParam) : "None"}\n"
        "Body: ${body != null ? jsonEncode(body) : "None"}");

    http.Response response;

    switch (type) {
      case HttpType.GET:
        response = await _httpGet(context, url, queryParam);
        break;
      case HttpType.POST:
        response = await _httpPost(context, url, queryParam, body);
        break;
      case HttpType.POST_NO_TOKEN:
        response = await _httpPostNoToken(context, url, queryParam, body);
        break;
      case HttpType.PUT:
        response = await _httpPut(context, url, queryParam, body);
        break;
      case HttpType.DELETE:
        response = await _httpDelete(context, url, queryParam, body);
        break;
      default:
        throw 'Unsupported HTTP method';
    }

    return _handleApiResponse(response);
  }

  // GET
  static Future<http.Response> _httpGet(BuildContext context, String url,
      Map<String, dynamic>? queryParam) async =>
      await http
          .get(
        Uri.http(
          BASE_URL,
          url,
          queryParam ?? {},
        ),
        headers: HeaderDto(
            accessToken: Provider.of<LoginData>(context, listen: false)
                .getSession()!
                .jwt
                .accessToken)
            .toHeader(),
      )
          .timeout(TIME_OUT_DURATION);

  static Future<http.Response> _httpPost(BuildContext context, String url,
      Map<String, dynamic>? queryParam, dynamic body) async =>
      await http
          .post(
        Uri.http(
          BASE_URL,
          url,
          queryParam ?? {},
        ),
        headers: HeaderDto(
            accessToken: Provider.of<LoginData>(context, listen: false)
                .getSession()!
                .jwt
                .accessToken)
            .toHeader(),
        body: jsonEncode(body),
      )
          .timeout(TIME_OUT_DURATION);

  static Future<http.Response> _httpPostNoToken(BuildContext context, String url,
      Map<String, dynamic>? queryParam, dynamic body) async =>
      await http
          .post(
        Uri.http(
          BASE_URL,
          url,
          queryParam ?? {},
        ),
        headers: HeaderDto().toHeader(),
        body: jsonEncode(body),
      )
          .timeout(TIME_OUT_DURATION);

  // Put
  static Future<http.Response> _httpPut(BuildContext context, String url,
      Map<String, dynamic>? queryParam, dynamic body) async =>
      await http
          .put(
        Uri.http(
          BASE_URL,
          url,
          queryParam ?? {},
        ),
        headers: HeaderDto(
            accessToken: Provider.of<LoginData>(context, listen: false)
                .getSession()!
                .jwt
                .accessToken)
            .toHeader(),
        body: jsonEncode(body),
      )
          .timeout(TIME_OUT_DURATION);
  // Delete
  static Future<http.Response> _httpDelete(BuildContext context, String url,
      Map<String, dynamic>? queryParam, dynamic body) async =>
      await http
          .delete(
        Uri.http(
          BASE_URL,
          url,
          queryParam ?? {},
        ),
        headers: HeaderDto(
            accessToken: Provider.of<LoginData>(context, listen: false)
                .getSession()!
                .jwt
                .accessToken)
            .toHeader(),
        body: jsonEncode(body),
      )
          .timeout(TIME_OUT_DURATION);

  static String _handleApiResponse(http.Response response) {
    if (response.statusCode >= HttpStatus.ok &&
        response.statusCode < HttpStatus.multipleChoices) {
      ResponseDto responseDto =
      apiResponseDtoFromJson(jsonDecode(response.body));

      // 성공 여부 확인
      if (responseDto.result == 'SUCCESS') {
        String responseData = responseDto.data != null ? jsonEncode(responseDto.data) : '';
        logger.i("API Call Success. Response Data is\n"
            "$responseData");
        return responseData;
      } else {
        String responseMessage = jsonEncode(responseDto.message);
        logger.e("API Call Fail. Response Message is\n"
            "$responseMessage");
        throw Exception(responseMessage);
      }
    } else {
      String responseCode = jsonEncode(response.statusCode);
      logger.e("API Call Fail. Response Code is\n"
          "$responseCode");
      throw Exception("API Call Fail. Response Code is\n"
          "$responseCode");
    }
  }
}

class HeaderDto {
  String? accessToken;

  HeaderDto({this.accessToken});

  Map<String, String> toHeader() {
    return {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
}

class ResponseDto {
  final String? result;
  final dynamic data;
  final String? message;
  final String? code;
  final String? errors;

  ResponseDto({
    this.result,
    this.data,
    this.message,
    this.code,
    this.errors,
  });

  factory ResponseDto.fromJson(Map<String, dynamic> json) {
    return ResponseDto(
      result: json['result'] ?? '',
      data: json['data'],
      message: json['message'] ?? '',
      code: json['code'] ?? '',
      errors: json['errors'] ?? '',
    );
  }
}

ResponseDto apiResponseDtoFromJson(Map<String, dynamic> json) {
  return ResponseDto.fromJson(json);
}