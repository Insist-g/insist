import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/values/values.dart';
import 'package:get/get.dart';
import 'index.dart';

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key});

  Widget buildBody() {
    return GetBuilder<ApplicationController>(builder: (logic) {
      return Obx(() {
        return IndexedStack(
          children: logic.tabTitles.map((e) {
            return e['page'] as Widget;
          }).toList(),
          index: logic.state.page,
        );
      });
    });
  }

  Widget buildBottomBar() {
    return GetBuilder<ApplicationController>(builder: (logic) {
      return Obx(() => BottomNavigationBar(
            currentIndex: logic.state.page,
            fixedColor: AppColors.primaryElement,
            type: BottomNavigationBarType.fixed,
            onTap: logic.handlePageChanged,
            items: logic.tabTitles
                .map((e) => BottomNavigationBarItem(
                      icon: Icon(
                        e['icon'],
                        color: AppColors.tabBarElement,
                      ),
                      activeIcon: Icon(
                        e['icon'],
                        color: AppColors.secondaryElementText,
                      ),
                      label: e['title'],
                      backgroundColor: AppColors.primaryBackground,
                    ))
                .toList(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ApplicationController());
    Widget scaffold = Scaffold(
      body: buildBody(),
      bottomNavigationBar: buildBottomBar(),
    );
    Widget willPopScope = WillPopScope(
      child: scaffold,
      onWillPop: () async {
        return false;
      },
    );
    return willPopScope;
  }
}
