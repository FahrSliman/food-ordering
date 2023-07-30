import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import '../../ui/shared/utils.dart';
import '../data/repositories/user_repository.dart';
import '../enum/operation_type.dart';
import '../enum/request_status.dart';

class BaseController extends GetxController {
  UserRepository userRepository = Get.put(UserRepository());

  Rx<RequestStatus> requestStatus = RequestStatus.DEFAULT.obs;
  RxList<OperationType> operationType = <OperationType>[].obs;

  Future runFutureFunction({required Future function}) async {
    checkConnection(() async {
      await function;
    });
  }

  Future runLoadingFutureFunction(
      {required Future function,
      OperationType? type = OperationType.NONE}) async {
    checkConnection(() async {
      requestStatus.value = RequestStatus.LOADING;
      operationType.add(type!);
      await function;
      requestStatus.value = RequestStatus.DEFAULT;
      operationType.remove(type);
    });
  }

  Future runFullLoadingFunction({required Future function,}) async {
    checkConnection(() async {
      customLoader();
      await function;
      BotToast.closeAllLoading();
    });
  }
}
