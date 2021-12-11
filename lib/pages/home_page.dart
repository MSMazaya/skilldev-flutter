import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:iot_skill_dev/widgets/shared/app_large_text.dart';
import 'package:iot_skill_dev/widgets/shared/app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _timeString;
  int _selectedIndex = 0; //New

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/static/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: GlassContainer(
        blur: 10,
        shadowStrength: 10,
        opacity: 0.2,
        border: const Border.fromBorderSide(BorderSide.none),
        borderRadius: BorderRadius.circular(10),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),
          drawer: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: const GlassContainer(
              opacity: 0.5,
              child: Drawer(
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    AppText(
                      color: Colors.white70,
                      text: "Welcome ",
                    ),
                    AppLargeText(
                      text: "Mazaya",
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                AppText(
                  color: Colors.white70,
                  text: _timeString!,
                ),
                const SizedBox(height: 25),
                AppText(
                  color: Colors.white70,
                  text: "Check your desired condition",
                  size: 20,
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 200,
                  width: double.maxFinite,
                  child: ListView.builder(
                    itemCount: 2,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: GlassContainer(
                        width: 200,
                        height: 200,
                        opacity: 0.5,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: GlassContainer(
            opacity: 0.6,
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: Colors.transparent,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.call),
                  label: 'Calls',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.camera),
                  label: 'Camera',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Chats',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
