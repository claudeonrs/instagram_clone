import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0; // default page taken to be home page
  late PageController pageController; // initialized later

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  /*
  Handles navigating to pages represented by icons
  */
  void navigationTap(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context)
    //     .getUser; // avoid same class name clash with firebase User
    return Scaffold(
      body: PageView(
        children: [
          Text('feed'),
          Text('search'),
          Text('add post'),
          Text('notifications'),
          Text('profile'),
        ],
        physics:
            const NeverScrollableScrollPhysics(), // prevents scrolling between different tabs
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _page == 0 ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,
                color: _page == 1 ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,
                color: _page == 2 ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,
                color: _page == 3 ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _page == 4 ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTap,
      ),
    );
  }
}
