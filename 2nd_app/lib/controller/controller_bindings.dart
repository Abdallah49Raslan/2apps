import 'package:application_1/controller/controller.dart';
import 'package:get/get.dart';

class controllerBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<controller>(controller());
  }
}