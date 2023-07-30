import '../network_config.dart';

class UserEndpoints{
  static String login=NetworkConfig.getFullApiUrl('user/login');
  static String register = NetworkConfig.getFullApiUrl('User/Register');
  static String ForgotPassword = NetworkConfig.getFullApiUrl('User/ForgotPassword');


}