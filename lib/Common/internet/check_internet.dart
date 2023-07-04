import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {
  InternetController get instance => Get.find();

  //
  Future<bool> checkInternetConnectivity() async {
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  //
  Future<void> retryInternetConnectivity() async {
  await checkInternetConnectivity();
}
}