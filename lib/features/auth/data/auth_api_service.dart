import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:samriddhi_algo_trade_app/core/constants/api_constants.dart';
import 'package:samriddhi_algo_trade_app/core/models/auth_response_model.dart';
import '../../../core/exceptions/auth_exception.dart';

class AuthApiService {
  final http.Client _client;

  AuthApiService({required http.Client client}) : _client = client;

  static const _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<AuthResponseModel> sendOtp(String mobileNo) async {
    final url = '${ApiConstants.baseUrl}${ApiConstants.sendOtp}';
    final uri = Uri.parse(url);
    try {
      final response = await _client.post(
        uri,
        headers: _headers,
        body: jsonEncode({'mobile': mobileNo}),
      );

      final body = jsonDecode(response.body);
      final message = body is Map ? body['message'] : body.toString();
      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(body);
      }
      throw AuthException.fromResponse(
        statusCode: response.statusCode,
        message: message,
      );
    } on AuthException {
      rethrow;
    } on SocketException {
      throw AuthException.network();
    } catch (e) {
      throw AuthException.serverError();
    }
  }

  Future<AuthResponseModel> registerUser({
    required String name,
    required String email,
    required String mobile,
  }) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.register}');
    try {
      final response = await _client.post(
        uri,
        headers: _headers,
        body: jsonEncode({'Name': name, 'Email': email, 'Mobile': mobile}),
      );
      final body = jsonDecode(response.body);
      final message = body is Map ? body['message'] : body.toString();

      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(body);
      }
      throw AuthException.fromResponse(
        statusCode: response.statusCode,
        message: message,
      );
    } on AuthException {
      rethrow;
    } on SocketException {
      throw AuthException.network();
    } catch (e) {
      throw AuthException.serverError();
    }
  }
}
