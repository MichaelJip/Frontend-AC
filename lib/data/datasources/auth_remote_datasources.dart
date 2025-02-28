import 'dart:convert';

import 'package:astro_front/core/constants/variables.dart';
import 'package:astro_front/data/datasources/auth_local_datasources.dart';
import 'package:astro_front/data/models/delete_user_response_model.dart';
import 'package:astro_front/data/models/forget_password_response_model.dart';
import 'package:astro_front/data/models/login_response_model.dart';
import 'package:astro_front/data/models/register_response_model.dart';
import 'package:astro_front/data/models/update_profile_response_model.dart';
import 'package:astro_front/data/models/verify_otp_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSources {
  final AuthLocalDatasource authLocalDatasource;
  final http.Client client;

  AuthRemoteDataSources(this.client, this.authLocalDatasource);
  //Register
  Future<Either<String, RegisterResponseModel>> register(
    String username,
    String email,
    String password,
    String confirmPassword,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/auth/register');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Ensure JSON format
        },
        body: jsonEncode({
          'email': email,
          'username': username,
          'password': password,
          'confirmPassword': confirmPassword,
        }),
      );

      if (response.statusCode == 200) {
        return Right(RegisterResponseModel.fromJson(response.body));
      } else {
        return left("Failed to register");
      }
    } catch (e) {
      return Left("Something went wrong: $e");
    }
  }

  //Login
  Future<Either<String, LoginResponseModel>> login(
    String identifier,
    String password,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/auth/login');
    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Ensure JSON format
        },
        body: jsonEncode({'identifier': identifier, 'password': password}),
      );

      if (response.statusCode == 200) {
        final parsedData = LoginResponseModel.fromJson(response.body);
        return Right(parsedData);
      } else {
        return Left("Failed to login");
      }
    } catch (e) {
      return Left("Something went wrong: $e");
    }
  }

  //Update User
  Future<Either<String, UpdateProfileResponseModel>> update(
    String id,
    String username,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/auth/$id');
    print("API Request URL: $url");
    print("Request Body: ${jsonEncode({'username': username})}");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username}),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return Right(
          UpdateProfileResponseModel.fromJson(jsonDecode(response.body)),
        );
      } else {
        return Left("Failed to update user: ${response.body}");
      }
    } catch (e) {
      print("API Error: $e");
      return Left("Something went wrong: $e");
    }
  }

  //Delete User
  Future<Either<String, DeleteProfileResponseModel>> delete(String id) async {
    final url = Uri.parse('${Variables.baseUrl}/auth/$id');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Ensure JSON format
        },
      );

      if (response.statusCode == 200) {
        return Right(DeleteProfileResponseModel.fromJson(response.body));
      } else {
        return left("Failed to register");
      }
    } catch (e) {
      return Left("Something went wrong: $e");
    }
  }

  //Forget Password
  Future<Either<String, ForgetPasswordResponseModel>> forgetPassword(
    String email,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/auth/forget-password');
    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Ensure JSON format
        },
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        final parsedData = ForgetPasswordResponseModel.fromJson(response.body);
        return Right(parsedData);
      } else {
        return Left("Failed to send OTP");
      }
    } catch (e) {
      return Left("Something went wrong: $e");
    }
  }

  //Verify OTP
  Future<Either<String, VerifyOtpResponseModel>> verify(
    String email,
    String otp,
    String newPassword,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/auth/verify');
    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Ensure JSON format
        },
        body: jsonEncode({
          'email': email,
          'otp': otp,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        final parsedData = VerifyOtpResponseModel.fromJson(response.body);
        return Right(parsedData);
      } else {
        return Left("Failed to restart password");
      }
    } catch (e) {
      return Left("Something went wrong: $e");
    }
  }
}
