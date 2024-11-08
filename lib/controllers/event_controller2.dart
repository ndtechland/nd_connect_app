import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/event_model2.dart';
import '../services_apis/api_servicesss.dart';

class EventController2 extends GetxController{
  final isLoading = false.obs;
  final Rx<DateTime> focusedEventDay = DateTime.now().obs;
  final Rx<DateTime?> selectedEventDay = Rxn<DateTime>(null);
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;
  final RxMap<DateTime, List<MeetEventsDto>> events =
      <DateTime, List<MeetEventsDto>>{}.obs;
  final RxMap<DateTime, List<OfficeEventsDto>> eventsHoliday =
      <DateTime, List<OfficeEventsDto>>{}.obs;

  Future<void> EventsHolidayApi() async {
    isLoading.value = true;
    try {
      EventModel2? apiResponse = await ApiProvider.GetofficeEventsHoliApi();
      if (apiResponse != null && apiResponse.succeeded == true) {
        // Ensure data is of type EventData2 and pass it to _updateEventsHoliday
        _updateEventsHoliday(apiResponse.data ?? EventData2());
      } else {
        print('Error: ${apiResponse?.message}');
      }
    } catch (e) {
      print('Error fetching events: $e');
    } finally {
      isLoading.value = false;
    }
  }
  void _updateEventsHoliday(EventData2 apiData) {
    eventsHoliday.clear();
    events.clear();
    // Add Office Events
    for (var officeEvent in apiData.officeEventsDtos ?? []) {
      if (officeEvent.date != null) {
        final eventDate = DateTime(officeEvent.date!.year, officeEvent.date!.month, officeEvent.date!.day);
        final eventModel = OfficeEventsDto(
          date: officeEvent.date!,
          tittle: officeEvent.tittle ?? 'No Title',
          subtittle: officeEvent.subtittle ?? 'No Subtitle',
        );

        if (eventsHoliday.containsKey(eventDate)) {
          eventsHoliday[eventDate]?.add(eventModel);
        } else {
          eventsHoliday[eventDate] = [eventModel];
        }
      }
    }

    // Add Meet Events
    for (var meetEvent in apiData.meetEventsDtos ?? []) {
      if (meetEvent.eventdate != null) {
        final eventDate = DateTime(meetEvent.eventdate!.year, meetEvent.eventdate!.month, meetEvent.eventdate!.day);
        final eventModel = MeetEventsDto(
          eventdate: meetEvent.eventdate!,
          eventTime: meetEvent.eventTime ?? " No Time",
          eventTittle: meetEvent.eventTittle ?? 'No Title',
          eventDescription: meetEvent.eventDescription ?? 'No Description',
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
  void _autoSelectDatesWithEvents() {
    final datesWithEvents = events.keys.toList();
    if (datesWithEvents.isNotEmpty) {
      // selectedDay.value = datesWithEvents.first;
      // focusedDay.value = datesWithEvents.first;
      selectedEventDay.value = DateTime.now();
      focusedEventDay.value = DateTime.now();
    }
  }

  // Calendar event handling methods
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedEventDay.value = selectedDay;
    this.focusedEventDay.value = focusedDay;
  }

  void onFormatChanged(CalendarFormat format) {
    calendarFormat.value = format;
  }

  void onPageChanged(DateTime focusedDay) {
    this.focusedEventDay.value = focusedDay;
  }

  // Fetch events for a specific day
  List<MeetEventsDto> getEventsHolidayForDay(DateTime day) {
    final eventDate = DateTime(day.year, day.month, day.day);
    print("Events holiday : $eventDate");
    return events[eventDate] ?? [];
  }

  // Check if a day has events
  bool hasEvents(DateTime day) {
    final eventDate = DateTime(day.year, day.month, day.day);
    return events.containsKey(eventDate);
  }
}