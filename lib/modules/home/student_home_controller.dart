import 'package:get/get.dart';
import 'package:mobile_bursar_android/api/api.dart';
import 'package:mobile_bursar_android/services/student_service.dart';

class StudentHomeController extends GetxController {
  final StudentService studentService = StudentService();
  final ApiRepository apiRepository;
  StudentHomeController({required this.apiRepository});

  var students = <dynamic>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() async {
    fetchStudents();
    super.onInit();
  }

  void fetchStudents() async {
    try {
      isLoading(true);
      var studentList = await studentService.getStudents();
      students.assignAll(studentList);
    } finally {
      isLoading(false);
    }
  }
}
