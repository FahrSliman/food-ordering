import 'package:dartz/dartz.dart';
import 'package:food/core/data/models/apis/token_info.dart';
import 'package:food/core/data/models/common_respons.dart';
import 'package:food/core/data/network/endpoints/user_endpoints.dart';
import 'package:food/core/data/network/network_config.dart';
import 'package:food/core/enum/request_type.dart';
import 'package:food/core/utilis/network_util.dart';

class UserRepository {
  Future<Either<String, TokenInfo>> login({
    required String email,
    required String password,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: UserEndpoints.login,
        body: {
          'userName': email,
          'password': password,
        },
        headers: NetworkConfig.getHeaders(
          needAuth: false, //set the extra headers here
        ),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(TokenInfo.fromJson(commonResponse.data ?? {}));
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  } //async

  Future<Either<String, bool>> register({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required int age,
    required String photoPath,
  }) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        type: RequestType.POST,
        url: UserEndpoints.register,
        fields: {
          'Email': email,
          'FirstName': firstname,
          'LastName': lastname,
          'Password': password,
          'Age': age.toString(),
        },
        files: {"Photo": photoPath},
        headers: NetworkConfig.getHeaders(needAuth: false),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(commonResponse.getStatus);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  } //async


  
   Future<Either<String, String>> ForgotPassword({
    required String email1,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: UserEndpoints.ForgotPassword,
        params:{"email1": "$email1"},
        headers: NetworkConfig.getHeaders(
          needAuth: false, //set the extra headers here
        ),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(response.toString());
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  } //async
}
