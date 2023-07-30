import 'package:food/core/enum/connectivity_status.dart';
import 'package:food/core/services/connectivity_service.dart';
import 'package:food/ui/shared/custom_widget/custom_toast.dart';
import 'package:get/get.dart';

import '../../../../core/data/models/apis/category_model.dart';
import '../../../../core/data/models/apis/meal_model.dart';
import '../../../../core/data/repositories/category_repository.dart';
import '../../../../core/data/repositories/meal_repository.dart';
import '../../../../core/enum/message_type.dart';
import '../../../../core/enum/operation_type.dart';
import '../../../../core/enum/request_status.dart';
import '../../../../core/services/base_controller.dart';
import '../../../shared/utils.dart';


class HomePageController extends BaseController {

  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<MealModel> mealList = <MealModel>[].obs;

  bool get isCategoryLoading =>
      requestStatus.value == RequestStatus.LOADING &&
        operationType.contains(OperationType.CATEGORY);

  bool get isMealLoading =>
      requestStatus.value == RequestStatus.LOADING &&
          operationType.contains(OperationType.MEAL);


  @override
  void onInit() {
    getAllCategory();
    getAllMeal();
    super.onInit();
  }
  // void isOnline(ConnectivityStatus status,ConnectivityService s){


  // }

  void getAllCategory() {
    runLoadingFutureFunction(
        type: OperationType.CATEGORY,
        function: CategoryRepository().getAll().then((value) {
          value.fold((l) {
            CustomToast.showMessage(
                meassage: l, messageType: MessageType.REJECTED);
          }, (r) {
            categoryList.addAll(r);
          });
        }));
  }
  void getAllMeal() {
    runLoadingFutureFunction(
        type: OperationType.MEAL,
        function: MealRepository().getAll().then((value) {
          value.fold((l) {
            CustomToast.showMessage(
                meassage: l, messageType: MessageType.REJECTED);
          }, (r) {
            mealList.addAll(r);
          });
        }));
  }

  void addToCart(MealModel model) {
    cartService.addToCart(
        model: model,
        count: 1,
        afterAdd: () {
          CustomToast.showMessage(
              meassage: 'Added', messageType: MessageType.SUCCESS);
        });
  }

}