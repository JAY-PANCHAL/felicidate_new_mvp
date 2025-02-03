import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:felicidade/common/utils/image_paths.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late PersistentTabController _controller;

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
          inactiveIcon: SvgPicture.asset(AppSvgIcons.home, color: Colors.grey),
          icon: SvgPicture.asset(AppSvgIcons.home, color: Colors.pink),
          title: "Home",
        ),
      ),
      PersistentTabConfig(
        screen: TalkScreen(),
        item: ItemConfig(
          inactiveIcon: SvgPicture.asset(AppSvgIcons.talk, color: Colors.grey),
          icon: SvgPicture.asset(AppSvgIcons.talk, color: Colors.pink),
          title: "Talk",
        ),
      ),
      PersistentTabConfig(
        screen: ExpertScreen(),
        item: ItemConfig(
          inactiveIcon: SvgPicture.asset(AppSvgIcons.expert, color: Colors.grey),
          icon: SvgPicture.asset(AppSvgIcons.expert, color: Colors.pink),
          title: "Expert",
        ),
      ),
      PersistentTabConfig(
        screen: TripScreen(),
        item: ItemConfig(
          inactiveIcon: SvgPicture.asset(AppSvgIcons.trip, color: Colors.grey),
          icon: SvgPicture.asset(AppSvgIcons.trip, color: Colors.pink),
          title: "Trip",
        ),
      ),
      PersistentTabConfig(
        screen: ProfileScreen(),
        item: ItemConfig(
          inactiveIcon: SvgPicture.asset(AppSvgIcons.profile, color: Colors.grey),
          icon: SvgPicture.asset(AppSvgIcons.profile, color: Colors.pink),
          title: "Profile",
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistent Bottom Navigation Bar Demo',
      debugShowCheckedModeBanner: false,
      home: PersistentTabView(
        controller: _controller,
        tabs: _tabs(),
        navBarBuilder: (navBarConfig) => CustomBottomNavBar(
          controller: _controller,
          items: _tabs().map((tab) => tab.item).toList(),
        ),
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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Home Screen")),
    );
  }
}

class TalkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Talk Screen")),
    );
  }
}

class ExpertScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Expert Screen")),
    );
  }
}

class TripScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Trip Screen")),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Profile Screen")),
    );
  }
}
