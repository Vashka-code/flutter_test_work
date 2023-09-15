import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_work/features/main/main_page_bloc.dart';
import 'package:flutter_test_work/features/main/main_event.dart';
import 'package:flutter_test_work/features/main/main_state.dart';
import 'package:flutter_test_work/pages/content/calendar_page_content.dart';
import 'package:flutter_test_work/pages/content/drivers_page_content.dart';
import 'package:flutter_test_work/pages/content/home_page_content.dart';
import 'package:flutter_test_work/pages/content/vehicles_page_content.dart';
import 'package:remixicon/remixicon.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainPageBloc, MainPageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.tabIndex,
              elevation: 24,
              selectedItemColor: Colors.lightBlue,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today), label: 'Calendar'),
                BottomNavigationBarItem(
                    icon: Icon(Remix.steering_line), label: 'Drivers'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.directions_car), label: 'Vehicles')
              ],
              onTap: (index) {
                context.read<MainPageBloc>().add(TabChange(tabIndex: index));
              },
            ),
            body: bottomNavScreen.elementAt(state.tabIndex),
          );
        });
  }
}

const List<Widget> bottomNavScreen = <Widget>[
  HomePageContent(),
  CalendarPageContent(),
  DriversPageContent(),
  VehiclesPageContent(),
];
