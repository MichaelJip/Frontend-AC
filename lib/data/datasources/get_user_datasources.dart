import 'package:astro_front/core/constants/variables.dart';
import 'package:astro_front/data/datasources/auth_local_datasources.dart';
import 'package:astro_front/data/models/all_user_response_model.dart';
import 'package:astro_front/data/models/me_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class GetUserDataSources {
  final http.Client client;
  final AuthLocalDatasource authLocalDatasource;

  GetUserDataSources(this.client, this.authLocalDatasource);

  // Get Authenticated User (Me)
  Future<Either<String, MeResponseModel>> getMe() async {
    final url = Uri.parse('${Variables.baseUrl}/auth/me');
    try {
      final token = await authLocalDatasource.getAuthToken();
      if (token == null) {
        return Left("No authentication token found");
      }

      final response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return Right(MeResponseModel.fromJson(response.body));
      } else {
        return Left("Failed to fetch user data");
      }
    } catch (e) {
      return Left("Something went wrong: $e");
    }
  }

  // Get All Users
  Future<Either<String, AllUserResponseModel>> getAllUsers({
    required int page,
    String? search,
  }) async {
    final queryParams = {'page': '$page'};
    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search; // Add search query if present
    }

    final uri = Uri.parse(
      '${Variables.baseUrl}/auth',
    ).replace(queryParameters: queryParams);
    try {
      final token = await authLocalDatasource.getAuthToken();
      if (token == null) {
        return Left("No authentication token found");
      }

      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return Right(AllUserResponseModel.fromJson(response.body));
      } else {
        return Left("Failed to fetch users");
      }
    } catch (e) {
      return Left("Something went wrong: $e");
    }
  }
}
