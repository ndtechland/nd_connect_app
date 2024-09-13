// import 'package:get/get.dart';
//
// import '../models/events_model.dart';
//
// class EventController extends GetxController {
//   var events = <DateTime, List<Event>>{}.obs;
//   var selectedDay = DateTime.now().obs;
//   var selectedEvents = <Event>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadEvents();
//   }
//
//   void loadEvents() {
//     // Get the dummy events
//     List<Event> dummyEvents = Event.getDummyEvents();
//
//     // Group events by their date
//     Map<DateTime, List<Event>> groupedEvents = {};
//     for (var event in dummyEvents) {
//       DateTime eventDate =
//       DateTime(event.date.year, event.date.month, event.date.day);
//       if (groupedEvents[eventDate] != null) {
//         groupedEvents[eventDate]!.add(event);
//       } else {
//         groupedEvents[eventDate] = [event];
//       }
//     }
//
//     // Update the observable events map
//     events.value = groupedEvents;
//
//     // Set selected day events
//     selectedEvents.value = getEventsForDay(selectedDay.value);
//   }
//
//   List<Event> getEventsForDay(DateTime day) {
//     return events[DateTime(day.year, day.month, day.day)] ?? [];
//   }
//
//   void onDaySelected(DateTime day) {
//     selectedDay.value = day;
//     selectedEvents.value = getEventsForDay(day);
//   }
// }
// lib/controllers/events_controller.dart
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/events_model.dart';


class EventsController extends GetxController {
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = Rxn<DateTime>(null);
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;

  // Static event data
  final RxMap<DateTime, List<EventModel>> events =
      <DateTime, List<EventModel>>{}.obs;

  EventsController() {
    _initializeEvents();
  }

  void _initializeEvents() {
    final eventsList = StaticEventData.getEvents();

    for (var event in eventsList) {
      final eventDate =
      DateTime(event.date.year, event.date.month, event.date.day);
      if (events.containsKey(eventDate)) {
        events[eventDate]?.add(event);
      } else {
        events[eventDate] = [event];
      }
    }

    // Automatically select the first date with events
    _autoSelectDatesWithEvents();
  }

  void _autoSelectDatesWithEvents() {
    final datesWithEvents = events.keys.toList();
    if (datesWithEvents.isNotEmpty) {
      selectedDay.value = datesWithEvents.first;
      focusedDay.value = datesWithEvents.first;
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
  }

  void onFormatChanged(CalendarFormat format) {
    calendarFormat.value = format;
  }

  void onPageChanged(DateTime focusedDay) {
    this.focusedDay.value = focusedDay;
  }

  List<EventModel> getEventsForDay(DateTime day) {
    final eventDate = DateTime(day.year, day.month, day.day);
    return events[eventDate] ?? [];
  }

  bool hasEvents(DateTime day) {
    final eventDate = DateTime(day.year, day.month, day.day);
    return events.containsKey(eventDate);
  }
}