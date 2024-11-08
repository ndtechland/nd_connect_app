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

import '../models/event_model2.dart';
import '../models/events_model.dart';
import '../models/task_model.dart';
import '../services_apis/api_servicesss.dart';


class EventsController extends GetxController {
  final isLoading = false.obs;
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = Rxn<DateTime>(null);
  final Rx<DateTime> focusedEventDay = DateTime.now().obs;
  final Rx<DateTime?> selectedEventDay = Rxn<DateTime>(null);
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;

  // Events map to store events based on dates
  final RxMap<DateTime, List<EventModel>> events =
      <DateTime, List<EventModel>>{}.obs;
  final RxMap<DateTime, List<MeetEventsDto>> eventsHoliday =
      <DateTime, List<MeetEventsDto>>{}.obs;

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
  // Future<void> EventsHolidayApi() async {
  //   isLoading.value = true;
  //   try {
  //     EventModel2? apiResponse = await ApiProvider.GetofficeEventsHoliApi();
  //     if (apiResponse != null && apiResponse.succeeded == true) {
  //       // Ensure data is of type EventData2 and pass it to _updateEventsHoliday
  //       _updateEventsHoliday(apiResponse.data as EventData2? ?? EventData2());
  //     } else {
  //       print('Error: ${apiResponse?.message}');
  //     }
  //   } catch (e) {
  //     print('Error fetching events: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }


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
   _autoSelectDatesWithEvents();
  }
  void _updateEventsHoliday(EventData2 apiData) {
    events.clear();

    // Add Office Events
    for (var officeEvent in apiData.officeEventsDtos ?? []) {
      if (officeEvent.date != null) {
        final eventDate = DateTime(officeEvent.date!.year, officeEvent.date!.month, officeEvent.date!.day);
        final eventModel = EventModel(
          date: officeEvent.date!,
          tittle: officeEvent.tittle ?? 'No Title',
          subtittle: officeEvent.subtittle ?? 'No Subtitle',
        );

        if (events.containsKey(eventDate)) {
          events[eventDate]?.add(eventModel);
        } else {
          events[eventDate] = [eventModel];
        }
      }
    }

    // Add Meet Events
    for (var meetEvent in apiData.meetEventsDtos ?? []) {
      if (meetEvent.eventdate != null) {
        final eventDate = DateTime(meetEvent.eventdate!.year, meetEvent.eventdate!.month, meetEvent.eventdate!.day);
        final eventModel = EventModel(
          date: meetEvent.eventdate!,
          tittle: meetEvent.eventTittle ?? 'No Title',
          subtittle: meetEvent.eventDescription ?? 'No Description',
        );

        if (events.containsKey(eventDate)) {
          events[eventDate]?.add(eventModel);
        } else {
          events[eventDate] = [eventModel];
        }
      }
    }

    _autoSelectDatesWithEvents();
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
      // selectedDay.value = datesWithEvents.first;
      // focusedDay.value = datesWithEvents.first;
      selectedDay.value = DateTime.now();
      selectedEventDay.value = DateTime.now();
      focusedDay.value = DateTime.now();
      focusedEventDay.value = DateTime.now();
    }
  }

  // Calendar event handling methods
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
    this.selectedEventDay.value = selectedDay;
    this.focusedEventDay.value = focusedDay;
  }

  void onFormatChanged(CalendarFormat format) {
    calendarFormat.value = format;
  }

  void onPageChanged(DateTime focusedDay) {
    this.focusedDay.value = focusedDay;
    this.focusedEventDay.value = focusedDay;
  }

  // Fetch events for a specific day
  List<EventModel> getEventsForDay(DateTime day) {
    final eventDate = DateTime(day.year, day.month, day.day);
    return events[eventDate] ?? [];
  }

  // List<MeetEventsDto> getEventsHolidayForDay(DateTime day) {
  //   final eventDate = DateTime(day.year, day.month, day.day);
  //   print("Events holiday : $eventDate");
  //   return eventsHoliday[eventDate] ?? [];
  // }

  // Check if a day has events
  bool hasEvents(DateTime day) {
    final eventDate = DateTime(day.year, day.month, day.day);
    return events.containsKey(eventDate);
  }
}
