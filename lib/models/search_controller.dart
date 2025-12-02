import 'package:get/get.dart';
import 'package:getx_basics/models/notes.dart';

class SearchController extends GetxController {
  var searchEmpty = true.obs;
  var match = <Notes>[].obs;
}
