import 'package:dartz/dartz.dart';
import 'package:food/core/data/models/apis/meal_model.dart';
import 'package:food/core/data/models/common_respons.dart';
import 'package:food/core/data/network/endpoints/meal_endpoints.dart';
import 'package:food/core/data/network/network_config.dart';
import 'package:food/core/enum/request_type.dart';
import 'package:food/core/utilis/network_util.dart';

class MealRepository {
  Future<Either<String, List<MealModel>>> getAll() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: MealEndPoints.getall,
        headers: NetworkConfig.getHeaders(needAuth: false),
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<MealModel> result = [];
          commonResponse.data!.forEach(
            (element) {
              result.add(MealModel.fromJson(element));
            },
          );
          return Right(result);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
