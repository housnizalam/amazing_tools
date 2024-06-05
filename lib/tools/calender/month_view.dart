// ignore_for_file: prefer_const_constructors

import 'package:amazing_tools/tools/calender/widgets/calendar_head_row.dart';
import 'package:amazing_tools/tools/calender/widgets/calendar_view.dart';
import 'package:amazing_tools/tools/calender/widgets/controll_bar.dart';
import 'package:amazing_tools/tools/calender/widgets/date_picker.dart';
import 'package:amazing_tools/tools/calender/widgets/hidden.widget.dart';
import 'package:amazing_tools/tools/swipp_button.dart';
import 'package:flutter/material.dart';

class MonthView extends StatefulWidget {
  const MonthView({required this.selectedMonth, super.key});
  final DateTime selectedMonth;
  @override
  State<MonthView> createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView> {
  @override
  Widget build(BuildContext context) {
    // CalendarState.getInstance();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: DatePicker(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SwipeButton(
            child: Column(
              children: [
                HiddenView(),
                ControllBar(),
                CalenderHeadRow(),
                CalendarView(
                  selectedMonth: widget.selectedMonth,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
