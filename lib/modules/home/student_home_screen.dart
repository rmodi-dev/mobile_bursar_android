import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_bursar_android/shared/shared.dart';

import '../home/student_home_controller.dart';

class StudentHomeScreen extends GetView<StudentHomeController> {
  const StudentHomeScreen({super.key});

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
        child: _buildContent(controller),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _buildNavigationBarItem(
            "Home",
            "icon_home.svg",
            // MainTabs.home == controller.isLoading.value
            //     ? "icon_home_activated.svg"
            //     : "icon_home.svg",
          ),
          _buildNavigationBarItem(
            "Discover",
            "icon_discover.svg",
            // MainTabs.discover == controller.students.isEmpty
            //     ? "icon_discover_activated.svg"
            //     : "icon_discover.svg",
          ),
          _buildNavigationBarItem(
            "Resource",
            "icon_resource.svg",
          ),
          _buildNavigationBarItem(
            "Inbox",
            "icon_inbox.svg",
            // MainTabs.inbox == controller.students.length
            //     ? "icon_inbox_activated.svg"
            //     : "icon_inbox.svg",
          ),
          _buildNavigationBarItem(
            "Profile",
            "icon_me.svg",
            // MainTabs.me == controller.students[index]
            //     ? "icon_me_activated.svg"
            //     : "icon_me.svg",
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

  Widget _buildContent(controller) {
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
