import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_bursar_android/modules/home/student_home_controller.dart';
import 'package:mobile_bursar_android/shared/shared.dart';

class StudentHomeScreen extends GetView<StudentHomeController> {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Students Home')),
      body: Obx(() {
        return _buildContent(context);
      }),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _buildNavigationBarItem(
            "Payments",
            "icon_resource.svg",
          ),
          _buildNavigationBarItem(
            "Finance",
            "icon_finance.svg",
          ),
          _buildNavigationBarItem(
            "Profile",
            "icon_me.svg",
            // MainTabs.me == controller.students[index]
            //     ? "icon_me_activated.svg"
            //     : "icon_me.svg",
          ),
          _buildNavigationBarItem(
            "Logout",
            "icon_sign_out.svg",
          )
        ],
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: ColorConstants.black,
        // currentIndex: controller.getCurrentIndex(controller.students[index]),
        selectedItemColor: ColorConstants.black,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        onTap: (index) {
          if (index == 3) {
            _logout();
          }
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    } else if (controller.students.isEmpty) {
      return const Center(child: Text('No students returned'));
    } else {
      return ListView.builder(
          itemCount: controller.students.length,
          itemBuilder: (context, index) {
            final student = controller.students[index];
            return Card(
              // color: Colors.white,
              color: const Color(0xFF8C9EFF),
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('${student.firstName} ${student.lastName}'),
                subtitle: Text('Class: ${student.currentClass}'),
              ),
            );
          });
    }
  }

  BottomNavigationBarItem _buildNavigationBarItem(String label, String svg) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/svgs/$svg'),
      label: label,
    );
  }

  void _logout() {
    Get.offAllNamed('/login');
  }
}
