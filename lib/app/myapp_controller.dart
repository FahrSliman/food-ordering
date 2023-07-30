import '../core/enum/connectivity_status.dart';
import '../core/services/base_controller.dart';
import '../ui/shared/utils.dart';

class MyAppController extends BaseController {
  ConnectivityStatus connectionStatus = ConnectivityStatus.ONLINE;

  @override
  void onInit() {
    listenToConnectionStatus();
    super.onInit();
  }

  void listenToConnectionStatus() {
    connectivityService.connectivityStatusController.stream.listen((event) {
      connectionStatus = event;
    });
  }
}
