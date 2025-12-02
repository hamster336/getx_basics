import 'package:get/get.dart';

class SelectController extends GetxController {
  var selectedIndex = <int>{}.obs; // indexes of the selected notes
  var selectionMode =
      false.obs; // if notes are in selection mode or normal mode
  var selectAll = false.obs;
}
