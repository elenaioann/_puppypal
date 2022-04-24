//In this page the calendar gets created and is displayed on the screen

//importing flutter libraries and other project pages
import 'package:flutter/material.dart'; //standard flutter package
import 'package:puppy_pal/pages/calendar/event_page.dart'; //the connected events page
import 'package:table_calendar/table_calendar.dart'; //flutter table calendar library
import '../../../Widgets/nav_bar.dart'; //imports the navigation bar
import '../../../Widgets/colors.dart'
    as color; //imports the custom color widget

//creating the class as a stateful widget
class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late Map<DateTime, List<EventPage>>
      selectedEvents; //collection of key/value pair that returns the day-time and a list
  CalendarFormat format = CalendarFormat.month; //calendar displayed format
  DateTime selectedDay = DateTime.now(); //the day the user selects
  DateTime focusedDay =
      DateTime.now(); //the automatically focused day, the current day

  final TextEditingController _eventController =
      TextEditingController(); //editable text field

  //when we want to remove an element
  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  //this method class initialises data
  @override
  void initState() {
    selectedEvents =
        {}; //initialising the variable that holds the selected events
    super.initState();
  }

  //creates a collection which returns the
  List<EventPage> _getEvents(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  //building the visual part of the calendar page
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const NavBar(), //navigation bar
        appBar: AppBar(
          //app bar displayed on the top
          title: const Text('Calendar'), //text title of the app bar
          centerTitle: true, //centralise the title
          backgroundColor: color.AppColor
              .navbarColour, // applies the background colour from the color widget
        ),
        body: Container(
          //body of the app
          padding: const EdgeInsets.only(
            //padding insets
            right: 5,
            left: 5,
          ),
          decoration: BoxDecoration(
            //creates a box we can decorate
            gradient: LinearGradient(
              //linear gradient background
              begin: FractionalOffset
                  .topLeft, //linear gradient starts on the top left of the box
              end: FractionalOffset.bottomRight, //and ends on the bottom right
              colors: [
                //two different colors were used
                color.AppColor.gradientFirst,
                color.AppColor.gradientSecond
              ],
            ),
          ),
          //calendar
          child: Column(
            children: [
              TableCalendar(
                //displaying the calendar
                focusedDay: focusedDay, //the selected day on the calendar
                firstDay: DateTime(1997), //first year of this calendar is 1997
                lastDay: DateTime(2060), //last year is 2060
                calendarFormat: format,
                onFormatChanged: (CalendarFormat _format) {
                  //the format that the calendar is displayed
                  setState(
                    //notifies the framework that the state has changed
                    () {
                      format = _format;
                    },
                  );
                },
                selectedDayPredicate: (DateTime date) {
                  //a TableCalendar function
                  return isSameDay(selectedDay,
                      date); //check if two days are the same day and if either of them is null, it returns false
                },
                startingDayOfWeek: StartingDayOfWeek
                    .monday, //choosing which day the calendar starts with
                daysOfWeekVisible:
                    true, //boolean showing the days of week when true
                onDaySelected: (DateTime selectDay, DateTime focusDay) {
                  setState(() {
                    selectedDay = selectDay; //the day the user chose
                    focusedDay = focusDay; //the current day
                  });
                },

                //Event handling
                eventLoader: _getEvents,

                //calendar styling
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true, //highlights the current day
                  selectedDecoration: BoxDecoration(
                    //creates a decorated box
                    color: color.AppColor.menuText
                        .withOpacity(0.7), //color from color widget
                    shape: BoxShape.circle, //the shape of the highlight
                    boxShadow: [
                      //creates a background shadow effect
                      BoxShadow(
                        //changing the initial solid black shadow
                        offset: const Offset(5,
                            5), //changing the horizontal and vertical values for the shadow
                        blurRadius: 10, //bluring effect
                        color: color.AppColor.boxColor1.withOpacity(0.6),
                      ),
                    ],
                  ),
                  selectedTextStyle:
                      const TextStyle(color: Colors.white), //text color
                  todayDecoration: BoxDecoration(
                    //decoration of current day
                    color: color.AppColor.navbarColour,
                    shape: BoxShape.circle,
                  ),
                  defaultDecoration: const BoxDecoration(
                    shape: BoxShape.circle, //shape of selected day
                  ),
                  weekendDecoration: BoxDecoration(
                    //changing the style of the weekend days
                    color: color.AppColor.navbarColour.withOpacity(0.13),
                    shape: BoxShape
                        .rectangle, //constant rectangle background for distinction of weekend days from weekdays
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible:
                      false, //when true it displays on the calendar a button which allows you to choose the calendar format (weekly/mothly/2-week)
                  titleCentered: true, //centers title
                ),
              ),
              ..._getEvents(selectedDay).map(
                //extends the elements of the collection
                (EventPage e) => ListTile(
                  //creates a list tile for the day's events
                  title: Text(e.title), //the text inputed in the event
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          //action bottom button to add the event
          backgroundColor: color.AppColor.navbarColour, //general background
          onPressed: () => showDialog(
            //when pressed opens a dialog
            context:
                context, //link to the location of the widget in the tree structre
            builder: (context) => AlertDialog(
              //creates widget's child which is used to take confirmation before performing an action
              title: Text(
                "Add Event",
                style: TextStyle(color: color.AppColor.boxColor1, fontSize: 20),
              ),
              backgroundColor: color.AppColor.menuBackground,
              content: TextFormField(
                  controller:
                      _eventController), //the field where user can add their events
              actions: [
                TextButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: color.AppColor.boxColor1,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () => Navigator.pop(
                      context), //opens the previous widget of the stack
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
                    //checks the user input when the button is pressed
                    if (_eventController.text.isEmpty) {
                    } else {
                      if (selectedEvents[selectedDay] != null) {
                        //if input is not empty its added to the calendar
                        selectedEvents[selectedDay]?.add(
                          EventPage(title: _eventController.text),
                        );
                      } else {
                        selectedEvents[selectedDay] = [
                          EventPage(title: _eventController.text)
                        ];
                      }
                    }
                    Navigator.pop(context); //returns to previous stacked widget
                    _eventController.clear(); //sets the value to empty
                    setState(() {});
                    return;
                  },
                ),
              ],
            ),
          ),
          //"Add Event"  window buttons, styling
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
