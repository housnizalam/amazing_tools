import 'package:amazing_tools/tools/calender/models/calendar_slider.dart';
import 'package:amazing_tools/tools/calender/models/calendar_state_classe.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final calendarState = CalendarState.getInstance();
    DateTime? selectedDate;
    double width = MediaQuery.of(context).size.width;
    double fontsize = width * 0.06 < 30 ? width * 0.06 : 30;
    return Material(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () {
                CalenderSlider.scale();
              },
              child: const Icon(Icons.home),
            ),
          ),
          const Expanded(flex: 4, child: SizedBox()),
          Expanded(
            flex: 11,
            child: InkWell(
              child: Center(
                child: Text(
                  // titel
                  calendarState.stringSelectedMonth,
                  style: TextStyle(fontSize: fontsize, fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: calendarState.selectedMonth,
                        firstDate: DateTime(DateTime.now().year - 10),
                        lastDate: DateTime(DateTime.now().year + 10))
                    .then((value) {
                  selectedDate = value;
                });
              },
            ),
          ),
          const Expanded(flex: 4, child: SizedBox()),
        ],
      ),
    );
  }
}
