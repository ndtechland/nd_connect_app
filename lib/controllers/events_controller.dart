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
import '../models/task_model.dart';
import '../services_apis/api_servicesss.dart';


class EventsController extends GetxController {
  final isLoading = false.obs;
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = Rxn<DateTime>(null);
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;

  // Events map to store events based on dates
  final RxMap<DateTime, List<EventModel>> events =
      <DateTime, List<EventModel>>{}.obs;

  EventsController() {
   // _initializeEvents();
  }

  // Fetch events from API
  Future<void> EventsApi() async {
    isLoading.value = true;
    try {
      EventsModell? apiResponse = await ApiProvider.GetofficeEventsApi();
      if (apiResponse != null && apiResponse.succeeded == true) {
        // Update events map with API data
        _updateEvents(apiResponse.data ?? []);
      } else {
        print('Error: ${apiResponse?.message}');
      }
    } catch (e) {
      print('Error fetching events: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Update events map with data from API
  void _updateEvents(List<EventModel> apiData) {
    // Clear current events
    events.clear();

    for (var datum in apiData) {
      if (datum.date != null) {
        // Use the date directly as it's already parsed as DateTime
        final eventDate = datum.date!;
        final eventModel = EventModel(
          date: eventDate,
          tittle: datum.tittle ?? 'No Title',
          subtittle: datum.subtittle ?? 'No Subtitle',
        );

        print("eventDate: $eventDate");

        // Creating the key with just the date (year, month, day)
        final eventKey = DateTime(eventDate.year, eventDate.month, eventDate.day);

        if (events.containsKey(eventKey)) {
          events[eventKey]?.add(eventModel);
        } else {
          events[eventKey] = [eventModel];
        }
      }
    }

    // Automatically select the first date with events
   // _autoSelectDatesWithEvents();
  }


  // void _initializeEvents() {
  //   // Fetch static event data (optional, you may remove this if you only want API data)
  //   final eventsList = StaticEventData.getEvents();
  //
  //   for (var event in eventsList) {
  //     final eventDate =
  //     DateTime(event.date.year, event.date.month, event.date.day);
  //     if (events.containsKey(eventDate)) {
  //       events[eventDate]?.add(event);
  //     } else {
  //       events[eventDate] = [event];
  //     }
  //   }
  //
  //   // Automatically select the first date with events
  //   _autoSelectDatesWithEvents();
  // }

  void _autoSelectDatesWithEvents() {
    final datesWithEvents = events.keys.toList();
    if (datesWithEvents.isNotEmpty) {
      selectedDay.value = datesWithEvents.first;
      focusedDay.value = datesWithEvents.first;
    }
  }

  // Calendar event handling methods
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

  // Fetch events for a specific day
  List<EventModel> getEventsForDay(DateTime day) {
    final eventDate = DateTime(day.year, day.month, day.day);
    return events[eventDate] ?? [];
  }

  // Check if a day has events
  bool hasEvents(DateTime day) {
    final eventDate = DateTime(day.year, day.month, day.day);
    return events.containsKey(eventDate);
  }
}
