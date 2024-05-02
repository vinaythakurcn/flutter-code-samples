import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:appointment_app/screens/home/app_drawer_screen.dart';
import 'package:appointment_app/constants/colorpalette.dart';
import 'package:appointment_app/controller/calendar/calendar_controller.dart';
import 'package:appointment_app/localization/app_messages_key.dart';
import 'package:appointment_app/model/calendar/calendar_job_model.dart';
import 'package:appointment_app/routes/route_paths.dart';
import 'package:appointment_app/widgets/loading.dart';
import 'package:appointment_app/widgets/space_vertical.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController calendarController = Get.put(CalendarController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      calendarController.getCalendarJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPalette.backgroundColor,
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: Text(AppMessagesKey.calendar.tr),
        ),
        body: Obx(
          () {
            return /* calendarController.isLoading
                ? const Center(
                    child: Loading(
                      color: ColorPalette.blue,
                    ),
                  )
                :  */
                Column(
              children: [
                ColoredBox(
                  color: ColorPalette.backgroundColor,
                  child: TableCalendar<CalendarJobModel>(
                    firstDay: DateTime(1900),
                    lastDay: DateTime(9999),
                    focusedDay: calendarController.focusDate,
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                      CalendarFormat.week: 'Week'
                    },
                    calendarFormat: calendarController.calendarFormat,
                    onFormatChanged: (format) =>
                        calendarController.calendarFormat = format,
                    headerStyle: HeaderStyle(
                      leftChevronIcon: const Icon(
                        Icons.chevron_left,
                        color: ColorPalette.blue,
                        size: 30,
                      ),
                      formatButtonTextStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: ColorPalette.blueText,
                              ),
                      formatButtonDecoration: BoxDecoration(
                          border: Border.all(
                            color: ColorPalette.blackText,
                          ),
                          borderRadius: BorderRadius.circular(4)),
                      titleTextStyle: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: ColorPalette.blackText),
                      rightChevronIcon: const Icon(
                        Icons.chevron_right,
                        color: ColorPalette.blue,
                        size: 30,
                      ),
                    ),
                    selectedDayPredicate: (day) =>
                        isSameDay(calendarController.selectedDate, day),
                    eventLoader: calendarController.getJobsForDay,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,
                      selectedDecoration: const BoxDecoration(
                        color: ColorPalette.blue,
                        shape: BoxShape.circle,
                      ),
                      markerSize: 7,
                      markersMaxCount: 10,
                      defaultTextStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: ColorPalette.blackText,
                              ),
                      weekendTextStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: ColorPalette.blackText,
                              ),
                      markerDecoration: const BoxDecoration(
                        color: ColorPalette.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    onDaySelected: calendarController.onDaySelected,
                    calendarBuilders: CalendarBuilders(
                      todayBuilder: (context, day, focusedDay) => SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Center(
                          child: Text(
                            day.day.toString(),
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: ColorPalette.blackText,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    onPageChanged: (date) async {
                      if (date.month != calendarController.selectedDate.month) {
                        calendarController.selectedDate = date;
                        await calendarController.getCalendarJobs();
                        calendarController.focusDate = date;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                calendarController.isLoading
                    ? const Center(
                        child: Loading(
                          color: ColorPalette.blue,
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(
                              top: 12, left: 12, right: 12),
                          itemCount: calendarController.selectedDayJobs.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.toNamed(
                                  RoutePaths.jobDetails,
                                  arguments: {
                                    "jobId": calendarController
                                        .selectedDayJobs[index].id,
                                    "jobName": calendarController
                                            .selectedDayJobs[index].title ??
                                        "",
                                  },
                                );
                              },
                              child: Ink(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: calendarController
                                              .selectedDayJobs[index]
                                              .linkColor ==
                                          null
                                      ? ColorPalette.blue
                                      : Color(int.parse(
                                          "0xff${calendarController.selectedDayJobs[index].linkColor}")),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Text(
                                  calendarController
                                          .selectedDayJobs[index].title ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: ColorPalette.white,
                                      ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SpaceVertical(8.0),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
