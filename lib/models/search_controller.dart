import 'package:get/get.dart';
import 'package:getx_basics/models/notes.dart';

class SearchNoteController extends GetxController {
  // SearchController is a name of some existing class
  var searchEmpty = true.obs;
  var match = <Notes>[].obs;
}
