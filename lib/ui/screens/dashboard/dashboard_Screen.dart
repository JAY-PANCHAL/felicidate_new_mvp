import 'package:felicidade/ui/screens/dashboard/profile/profile_screen.dart';
import 'package:felicidade/ui/screens/dashboard/talk/talk_screen.dart';
import 'package:felicidade/ui/screens/dashboard/trip/trip_screen.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:felicidade/common/utils/image_paths.dart';

import '../../../common/utils/strings.dart';
import '../../widget/image_view.dart';
import 'dashboard_controller.dart';
import 'expert/expert_screen.dart';
import 'home/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PersistentTabController _controller;

  final DashboardController dashboardController = Get.put(DashboardController());


  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<PersistentTabConfig> _tabs() {
    return [
      PersistentTabConfig(
        screen: HomeScreen(),
        item: ItemConfig(
          inactiveIcon: ImageView(
            width: 33.sp,
            height: 33.sp,
            boxFit: BoxFit.contain,
            image: AppSvgIcons.home,
            color: GREY_COLOR,
            imageType: ImageType.svg,
          ),
          icon: ImageView(
            width: 33.sp,
            height: 33.sp,
            boxFit: BoxFit.contain,
            image: AppSvgIcons.home,
            color: PINK,
            imageType: ImageType.svg,
          ),
          title: Strings.home,
        ),
      ),
      PersistentTabConfig(
        screen: TalkScreen(),
        item: ItemConfig(
          inactiveIcon: ImageView(
            width: 33.sp,
            height: 33.sp,
            boxFit: BoxFit.contain,
            image: AppSvgIcons.talk,
            color: GREY_COLOR,
            imageType: ImageType.svg,
          ),
          icon: ImageView(
            width: 33.sp,
            height: 33.sp,
            boxFit: BoxFit.contain,
            image: AppSvgIcons.talk,
            color: DETAILS_COLOR,
            // color: PINK,
            imageType: ImageType.svg,
          ),

          title:Strings.talk,
        ),
      ),
      PersistentTabConfig(
        screen: ExpertScreen(),
        item: ItemConfig(
          inactiveIcon: ImageView(
            width: 33.sp,
            height: 33.sp,
            boxFit: BoxFit.contain,
            image: AppSvgIcons.expert,
            color: GREY_COLOR,
            imageType: ImageType.svg,
          ),
          icon: ImageView(
            width: 33.sp,
            height: 33.sp,
            boxFit: BoxFit.contain,
            image: AppSvgIcons.expert,
            color: BLUE_COLOR2,
            // color: PINK,
            imageType: ImageType.svg,
          ),
          title: Strings.expert
        ),
      ),
      PersistentTabConfig(
        screen: TripScreen(),
        item: ItemConfig(
          inactiveIcon: ImageView(
            width: 33.sp,
            height: 33.sp,
            boxFit: BoxFit.contain,
            image: AppSvgIcons.trip,
            color: GREY_COLOR,
            imageType: ImageType.svg,
          ),
          icon: ImageView(
            width: 33.sp,
            height: 33.sp,
            boxFit: BoxFit.contain,
            image: AppSvgIcons.trip,
            color: YELLOW_COLOR,
            // color: PINK,
            imageType: ImageType.svg,
          ),
          title: Strings.trip,
        ),
      ),
      PersistentTabConfig(
        screen: ProfileScreen(),
        item: ItemConfig(
          inactiveIcon: ImageView(
            width: 33.sp,
            height: 33.sp,
            boxFit: BoxFit.contain,
            image: AppSvgIcons.profile,
            color: GREY_COLOR,
            imageType: ImageType.svg,
          ),
          icon: ImageView(
            width: 33.sp,
            height: 33.sp,
            boxFit: BoxFit.contain,
            image: AppSvgIcons.profile,
            color: BUTTON_COLOR,
            // color: PINK,
            imageType: ImageType.svg,
          ),
          title: Strings.profile,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      tabs: _tabs(),
      navBarBuilder: (navBarConfig) => CustomBottomNavBar(
        controller: _controller,
        items: _tabs().map((tab) => tab.item).toList(),
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final PersistentTabController controller;
  final List<ItemConfig> items;

  CustomBottomNavBar({required this.controller, required this.items});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: controller.index,
      onTap: (index) => controller.jumpToTab(index),      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
      items: items.map((item) {
        return BottomNavigationBarItem(
          icon: item.inactiveIcon,
          activeIcon: item.icon,
          label: item.title,
        );
      }).toList(),
    );
  }
}








