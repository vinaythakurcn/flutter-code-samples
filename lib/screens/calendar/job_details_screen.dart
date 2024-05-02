import 'package:appointment_app/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:appointment_app/constants/colorpalette.dart';
import 'package:appointment_app/controller/home/home_controller.dart';
import 'package:appointment_app/controller/calendar/calendar_controller.dart';
import 'package:appointment_app/localization/app_messages_key.dart';
import 'package:appointment_app/routes/route_paths.dart';
import 'package:appointment_app/widgets/job_call_item.dart';
import 'package:appointment_app/widgets/loading.dart';
import 'package:appointment_app/widgets/space_horizontal.dart';
import 'package:appointment_app/widgets/space_vertical.dart';

class JobDetailsScreen extends StatefulWidget {
  final String jobId;
  final String jobName;
  const JobDetailsScreen({
    super.key,
    required this.jobId,
    required this.jobName,
  });

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  CalendarController calendarController = Get.find<CalendarController>();
  HomeControlller homeControlller = Get.find<HomeControlller>();

  @override
  void initState() {
    super.initState();
    calendarController.getWishlistStatusAndJobDetails(widget.jobId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppMessagesKey.jobDetails.tr),
        ),
        body: Obx(
          () => calendarController.jobDetailIsLoading
              ? const Center(
                  child: Loading(
                    color: ColorPalette.blue,
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.jobName,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Divider(),
                        // if (calendarController.wishStatusModel.result != null)
                        Row(
                          children: [
                            Visibility(
                              visible: homeControlller
                                          .clientDetails.wishlistLock !=
                                      null &&
                                  homeControlller.clientDetails.wishlistLock ==
                                      1,
                              child: SizedBox(
                                width: 120,
                                child: RadioListTile(
                                  value: "W",
                                  groupValue: calendarController
                                              .wishStatusModel.result ==
                                          null
                                      ? ""
                                      : calendarController.wishStatusModel
                                          .result!.listType!.value,
                                  onChanged: (value) {
                                    calendarController.onRadioButtonPress(
                                        calendarController
                                                    .wishStatusModel.result ==
                                                null
                                            ? null
                                            : calendarController
                                                .wishStatusModel.result!.id,
                                        calendarController.jobDetailsModel.id!,
                                        true);
                                  },
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  title: Text(
                                    AppMessagesKey.wished.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: ColorPalette.blackText,
                                        ),
                                  ),
                                  activeColor: const Color(0xff3CA7CE),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: homeControlller
                                          .clientDetails.ignorelistLock !=
                                      null &&
                                  homeControlller
                                          .clientDetails.ignorelistLock ==
                                      1,
                              child: SizedBox(
                                width: 120,
                                child: RadioListTile(
                                  value: "I",
                                  groupValue: calendarController
                                              .wishStatusModel.result ==
                                          null
                                      ? ""
                                      : calendarController.wishStatusModel
                                          .result!.listType!.value,
                                  onChanged: (value) {
                                    calendarController.onRadioButtonPress(
                                        calendarController
                                                    .wishStatusModel.result ==
                                                null
                                            ? null
                                            : calendarController
                                                .wishStatusModel.result!.id,
                                        calendarController.jobDetailsModel.id!,
                                        false);
                                  },
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                  title: Text(
                                    AppMessagesKey.ignored.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: ColorPalette.blackText,
                                        ),
                                  ),
                                  activeColor: const Color(0xff3CA7CE),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: JobCallItem(
                                  title: AppMessagesKey.jobID.tr,
                                  value:
                                      "#${calendarController.jobDetailsModel.jobNumber ?? ""}",
                                ),
                              ),
                              Expanded(
                                child: JobCallItem(
                                  title: AppMessagesKey.dispatchedBy.tr,
                                  value: calendarController
                                              .jobDetailsModel.dispatchedBy ==
                                          null
                                      ? ""
                                      : "${calendarController.jobDetailsModel.dispatchedBy!.firstName ?? ""} ${calendarController.jobDetailsModel.dispatchedBy!.lastName ?? ""}",
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: JobCallItem(
                                  title: AppMessagesKey.startDate.tr,
                                  value: DateFormat(Utilities.getDateFormat(
                                          homeControlller.employeeDetailModel
                                              .result!.dateFormat!))
                                      .format(
                                    DateTime.parse(calendarController
                                        .jobDetailsModel.start!),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: JobCallItem(
                                  title: AppMessagesKey.endDate.tr,
                                  value: DateFormat(Utilities.getDateFormat(
                                          homeControlller.employeeDetailModel
                                              .result!.dateFormat!))
                                      .format(
                                    DateTime.parse(calendarController
                                        .jobDetailsModel.end!),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: JobCallItem(
                                  title: AppMessagesKey.employer.tr,
                                  value: calendarController
                                          .jobDetailsModel.employer?.name ??
                                      "",
                                ),
                              ),
                              Expanded(
                                child: JobCallItem(
                                    title: AppMessagesKey.employerContact.tr,
                                    value: calendarController
                                                    .jobDetailsModel.employer !=
                                                null ||
                                            calendarController.jobDetailsModel
                                                    .employer!.employerUsers !=
                                                null ||
                                            calendarController
                                                .jobDetailsModel
                                                .employer!
                                                .employerUsers!
                                                .isNotEmpty ||
                                            calendarController
                                                    .jobDetailsModel
                                                    .employer!
                                                    .employerUsers!
                                                    .first
                                                    .user !=
                                                null
                                        ? calendarController
                                                .jobDetailsModel
                                                .employer!
                                                .employerUsers!
                                                .first
                                                .user!
                                                .firstName ??
                                            ""
                                        : ""),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: JobCallItem(
                                  title: AppMessagesKey.payroll.tr,
                                  value:
                                      "${calendarController.jobDetailsModel.payroll ?? "----"}",
                                ),
                              ),
                              Expanded(
                                child: JobCallItem(
                                  title: AppMessagesKey.jobSteward.tr,
                                  value:
                                      "${calendarController.jobDetailsModel.firstName} ${calendarController.jobDetailsModel.lastName}",
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: JobCallItem(
                            title: AppMessagesKey.jobVenue.tr,
                            value:
                                calendarController.jobDetailsModel.venue != null
                                    ? calendarController
                                            .jobDetailsModel.venue!.name ??
                                        ""
                                    : "",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: JobCallItem(
                            title: AppMessagesKey.comments.tr,
                            value: calendarController.jobDetailsModel.comment ??
                                "",
                            isHtmlText: true,
                          ),
                        ),
                        Visibility(
                          visible: calendarController.jobDetailsModel
                                      .employerRequestsPrivate !=
                                  null &&
                              calendarController.jobDetailsModel
                                      .employerRequestsPrivate ==
                                  0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: JobCallItem(
                              title: AppMessagesKey.employerRequests.tr,
                              value: calendarController
                                      .jobDetailsModel.employerRequests ??
                                  "",
                              isHtmlText: true,
                            ),
                          ),
                        ),
                        const SpaceVertical(30),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    RoutePaths.jobCalls,
                                    arguments: {
                                      "callId": widget.jobId,
                                      "createdAt":
                                          DateFormat('yyyy-MM-dd HH:mm:ss')
                                              .format(DateTime.now()),
                                    },
                                  );
                                },
                                child: Ink(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffBACCDD)),
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorPalette.white,
                                  ),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SpaceHorizontal(10),
                                      const Icon(
                                        FontAwesomeIcons.eye,
                                        size: 14,
                                        color: Color(0xff57BCEA),
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppMessagesKey.viewCall.tr,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SpaceHorizontal(20),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(RoutePaths.location,
                                      arguments:
                                          " ${calendarController.jobDetailsModel.venue!.name ?? ''}, ${calendarController.jobDetailsModel.venue!.addresses?.first.address ?? ""}, ${calendarController.jobDetailsModel.venue!.addresses!.first.stateProvince ?? ""}, ${calendarController.jobDetailsModel.venue!.addresses!.first.country ?? ""}");
                                },
                                child: Ink(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffBACCDD)),
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorPalette.white,
                                  ),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SpaceHorizontal(10),
                                      const Icon(
                                        FontAwesomeIcons.locationDot,
                                        size: 14,
                                        color: Color.fromRGBO(175, 81, 81, 1),
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppMessagesKey.location.tr,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
