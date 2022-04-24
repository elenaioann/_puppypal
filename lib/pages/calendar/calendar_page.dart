import 'package:flutter/material.dart';
import 'package:puppy_pal/pages/calendar/event_page.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../Widgets/nav_bar.dart';
import '../../../Widgets/colors.dart' as color;

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late Map<DateTime, List<EventPage>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  final TextEditingController _eventController = TextEditingController();

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<EventPage> _getEvents(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('Calendar'),
          centerTitle: true,
          backgroundColor: color.AppColor.navbarColour,
        ),
        body: Container(
          padding: const EdgeInsets.only(
            right: 5,
            left: 5,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: [
                color.AppColor.gradientFirst,
                color.AppColor.gradientSecond
              ],
            ),
          ),
          //calendar
          child: Column(
            children: [
              TableCalendar(
                focusedDay: focusedDay,
                firstDay: DateTime(1997),
                lastDay: DateTime(2060),
                calendarFormat: format,
                onFormatChanged: (CalendarFormat _format) {
                  setState(
                    () {
                      format = _format;
                    },
                  );
                },
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(selectedDay, date);
                },
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekVisible: true,
                onDaySelected: (DateTime selectDay, DateTime focusDay) {
                  setState(() {
                    selectedDay = selectDay;
                    focusedDay = focusDay;
                  });
                },

                //Event handling
                eventLoader: _getEvents,

                //calendar styling
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  selectedDecoration: BoxDecoration(
                    color: color.AppColor.menuText.withOpacity(0.7),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(5, 5),
                        blurRadius: 10,
                        color: color.AppColor.boxColor1.withOpacity(0.6),
                      ),
                    ],
                  ),
                  selectedTextStyle: const TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    color: color.AppColor.navbarColour,
                    shape: BoxShape.circle,
                  ),
                  defaultDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  weekendDecoration: BoxDecoration(
                    color: color.AppColor.navbarColour.withOpacity(0.13),
                    shape: BoxShape.rectangle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
              ..._getEvents(selectedDay).map(
                (EventPage e) => ListTile(
                  title: Text(e.title),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: color.AppColor.navbarColour,
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "Add Event",
                style: TextStyle(color: color.AppColor.boxColor1, fontSize: 20),
              ),
              backgroundColor: color.AppColor.menuBackground,
              content: TextFormField(controller: _eventController),
              actions: [
                TextButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: color.AppColor.boxColor1,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: Text(
                    "Add",
                    style: TextStyle(
                      color: color.AppColor.boxColor1,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    if (_eventController.text.isEmpty) {
                    } else {
                      if (selectedEvents[selectedDay] != null) {
                        selectedEvents[selectedDay]?.add(
                          EventPage(title: _eventController.text),
                        );
                      } else {
                        selectedEvents[selectedDay] = [
                          EventPage(title: _eventController.text)
                        ];
                      }
                    }
                    Navigator.pop(context);
                    _eventController.clear();
                    setState(() {});
                    return;
                  },
                ),
              ],
            ),
          ),
          label: Text(
            "Add Event",
            style: TextStyle(
              color: color.AppColor.plainText2,
              fontSize: 20,
            ),
          ),
          icon: const Icon(Icons.add),
        ),
      );
}
