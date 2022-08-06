import 'dart:async';

// import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/app_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:swiftlists_flutter/app/models/user.dart';
// import 'package:swiftlists_flutter/app/services/category_service.dart';
// import 'package:swiftlists_flutter/app/services/group_service.dart';
// import 'package:swiftlists_flutter/app/services/process_queue.dart';
// import 'package:swiftlists_flutter/app/services/user_service.dart';
// import 'package:swiftlists_flutter/app_state.dart';
// import 'package:swiftlists_flutter/locator.dart';

// import 'app/services/firebase_analytics_service.dart';

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  const StatefulWrapper({required this.onInit, required this.child});
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class App extends StatelessWidget {
  void _onItemTap(context, int index) {
    Provider.of<AppState>(context, listen: false).setSelectedIndex(index);
  }

  _getThingsStarted() async {
    _loadUserInfo();
    // locator<FirebaseAnalyticsService>().logScreens(name: 'HomePage');
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _userId = prefs.getInt('userId') ?? 0;
    // User? user = await UserService().getUser();
    // if (_userId != 0) {
    //   // set userId, userProps for firebase
    //   locator<FirebaseAnalyticsService>().setUserProps(
    //       name: 'is_premium', value: user?.isPremium.toString() ?? false);
    //   locator<FirebaseAnalyticsService>().setUserId(id: '$_userId');
    //   CategoryService().getCategories();
    //   GroupService().getGroups();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
        onInit: () {
          _getThingsStarted().then((value) {
            print('Async done');
          });
        },
        child: ChangeNotifierProvider<AppState>(
            create: (BuildContext context) => AppState(),
            child: Consumer<AppState>(builder: (context, viewModel, child) {
              return Scaffold(
                // appBar: AppBar(
                //   title: Text('Bottom Navigation Bar'),
                // ),
                body: IndexedStack(
                  index: viewModel.selectedIndex,
                  children: viewModel.widgetOptions,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.blue,
                  // ignore: prefer_const_literals_to_create_immutables
                  items: [
                    const BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home,
                        ),
                        label: 'Home'),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'Settings'),
                    // const BottomNavigationBarItem(
                    //     icon: Icon(Icons.settings), label: 'Premium')
                  ],
                  currentIndex: viewModel.selectedIndex,
                  onTap: (index) => _onItemTap(context, index),
                ),
              );
            })));
  }
}
