import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_bursar_android/shared/shared.dart';

import '../../api/api_provider.dart';
import '../../api/api_repository.dart';
import '../home/student_home_controller.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  StudentHomeScreenState createState() => StudentHomeScreenState();
}

class StudentHomeScreenState extends State<StudentHomeScreen> {
  late final ApiRepository apiRepository;
  late final ApiProvider apiProvider;
  late StudentHomeController controller;

  @override
  void initState() {
    super.initState();
    apiProvider = ApiProvider();
    apiRepository = ApiRepository(apiProvider: apiProvider);
    controller =
        Get.arguments ?? StudentHomeController(apiRepository: apiRepository);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Obx(() => _buildWidget()),
    );
  }

  Widget _buildWidget() {
    return Scaffold(
      appBar: AppBar(title: const Text('Students Home')),
      body: Center(
        child: _buildContent(context),
      ),
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
        onTap: (index) {},
        // onTap: (index) => controller.switchTab(index),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    } else if (controller.students.isEmpty) {
      return const Center(child: Text('No students found'));
    } else {
      return ListView.builder(
          itemCount: controller.students.length,
          itemBuilder: (context, index) {
            final student = controller.students[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(student['firstName'] + ' ' + student['lastName']),
                subtitle: Text('Class: ${student['currentClass']}'),
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
}
