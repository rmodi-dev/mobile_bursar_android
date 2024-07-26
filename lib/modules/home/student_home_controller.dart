import 'package:get/get.dart';
import 'package:mobile_bursar_android/api/api.dart';
import 'package:mobile_bursar_android/models/response/users_response.dart';
import 'package:mobile_bursar_android/services/student_service.dart';

class StudentHomeController extends GetxController {
  final StudentService studentService = StudentService();
  final ApiRepository apiRepository;
  StudentHomeController({required this.apiRepository});

  var isLoading = true.obs;
  var students = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
  }

  Future<UsersResponse?> fetchStudents() async {
    isLoading(true);
    try {
      var students = await apiRepository.getStudents();
      return students;
      // var fetchedStudents = await apiRepository.getStudents();
      // students.assignAll(fetchedStudents as Iterable);
    } finally {
      isLoading(false);
    }
  }
}
