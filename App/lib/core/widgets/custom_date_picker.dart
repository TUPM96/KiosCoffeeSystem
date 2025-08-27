import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/utils/conversion/conversion.dart';
import 'package:boilerplate/utils/conversion/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomDatePicker extends StatefulWidget {
  final List<DateTime>? selectedDates;
  final Function(DateTime)? onDaySelected;
  final DateTime startDate;
  final DateTime endDate;
  final Function(DateTime) onConfirmed;
  final Store store;

  const CustomDatePicker(
      {Key? key,
      this.selectedDates,
      this.onDaySelected,
      required this.onConfirmed,
      required this.startDate,
      required this.endDate,
      required this.store})
      : super(key: key);

  @override
  _CustomDatePickerState createState() {
    return _CustomDatePickerState();
  }
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late List<DateTime> selectedDates;
  late DateTime selectedSingleDate;
  late final dynamic store;
  late Function(DateTime) onConfirmed;

  @override
  void initState() {
    selectedDates = widget.selectedDates ?? List<DateTime>.empty();
    selectedSingleDate = DateTime.now();
    store = widget.store;
    onConfirmed = widget.onConfirmed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectedDates = widget.selectedDates ?? List<DateTime>.empty();
    return Wrap(
      children: [
        _buildMultiTableCalendar(),
        _buildConfirmButton(),
      ],
    );
  }

  _buildConfirmButton() {
    var theme = context.elevatedButtonTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          context.navigator.pop();
          onConfirmed.call(selectedSingleDate);
        },
        style: theme.style!.copyWith(
          minimumSize: MaterialStatePropertyAll(
            Size(double.infinity, 40),
          ),
        ),
        child: Text('Simpan'),
      ),
    );
  }

  _buildMultiTableCalendar() {
    var height = context.mediaQuery.size.height;
    return TableCalendar(
      currentDay: DateTime.now(),
      focusedDay: DateTime.now(),
      firstDay: DateTime(1990),
      lastDay: DateTime.now(),
      daysOfWeekHeight: 50.0,
      calendarFormat: CalendarFormat.month,
      dayHitTestBehavior: HitTestBehavior.translucent,
      rowHeight: 50,
      selectedDayPredicate: (day) {
        bool result = false;
        for (var element in selectedDates) {
          var dayFormatted = DateFormat('yyyy-MM-ddTHH:mm:ss').format(day);
          var selectedDayFormatted =
              DateFormat('yyyy-MM-ddTHH:mm:ss').format(element);
          if (dayFormatted == selectedDayFormatted) {
            result = true;
          }
        }
        return result;
      },
      enabledDayPredicate: (day) {
        return true;
      },
      onDaySelected: (selectedDay, focusedDay) {
        var dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');

        for (var element in selectedDates) {
          widget.onDaySelected!(selectedDay);
        }

        setState(() {
          selectedSingleDate = selectedDay;
        });
      },
      headerStyle: HeaderStyle(
          leftChevronVisible: true,
          rightChevronVisible: true,
          leftChevronIcon: Row(children: const [
            Icon(
              Icons.chevron_left,
              size: 30,
              color: Colors.black,
            ),
          ]),
          rightChevronIcon: Row(children: const [
            Icon(
              Icons.chevron_right,
              size: 30,
              color: Colors.black,
            )
          ]),
          formatButtonShowsNext: true,
          formatButtonVisible: false),
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: context.primary),
        ),
        todayDecoration: const BoxDecoration(
            color: Color(0xFF9FA8DA), shape: BoxShape.circle),
        rangeHighlightColor: Colors.transparent,
        withinRangeTextStyle: context.textTheme.bodyLarge!,
        selectedTextStyle:
            context.textTheme.bodyMedium!.copyWith(color: Colors.white),
        todayTextStyle:
            context.textTheme.displayMedium!.copyWith(color: Colors.white),
        withinRangeDecoration:
            BoxDecoration(color: hexToColor('#00A5B9'), shape: BoxShape.circle),
        rangeEndDecoration:
            BoxDecoration(color: hexToColor('#00A5B9'), shape: BoxShape.circle),
        rangeStartDecoration:
            BoxDecoration(color: hexToColor('#00A5B9'), shape: BoxShape.circle),
      ),
      calendarBuilders: CalendarBuilders(
        prioritizedBuilder: (context, day, focusedDay) {
          var prioritizedDate = day.extractToDateOnly();
          var selectedDate = selectedSingleDate.extractToDateOnly();
          var currentDate = DateTime.now().extractToDateOnly();

          // if (prioritizedDate == currentDate) {
          //   return LayoutBuilder(
          //     builder: (context, constraints) {
          //       var height = constraints.maxHeight;
          //       return Column(
          //         mainAxisSize: MainAxisSize.min,
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           Dimens.vSpaceTiny,
          //           Expanded(
          //             child: Container(
          //               constraints: BoxConstraints(maxHeight: height),
          //               margin: const EdgeInsets.symmetric(vertical: 0),
          //               padding: EdgeInsets.zero,
          //               alignment: Alignment.center,
          //               decoration: BoxDecoration(
          //                   shape: BoxShape.circle, color: Colors.transparent),
          //               child: Text(
          //                 '${day.day}',
          //                 style: context.textTheme.bodyMedium!
          //                     .copyWith(height: 1.6),
          //               ),
          //             ),
          //           ),
          //           Dimens.vSpaceTiny,
          //           Divider(
          //             height: 5,
          //             thickness: 1,
          //             color: AppColors.borderColor,
          //           ),
          //         ],
          //       );
          //     },
          //   );
          // } else
          if (prioritizedDate == selectedDate) {
            return LayoutBuilder(
              builder: (context, constraints) {
                var height = constraints.maxHeight;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Dimens.vSpaceTiny,
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(maxHeight: height),
                        margin: const EdgeInsets.symmetric(vertical: 0),
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: context.primary),
                        ),
                        child: Text(
                          '${day.day}',
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    Dimens.vSpaceTiny,
                    Divider(
                      height: 5,
                      thickness: 1,
                      color: AppColors.borderColor,
                    ),
                  ],
                );
              },
            );
          }
          return null;
        },
        selectedBuilder: (context, day, focusedDay) {
          return LayoutBuilder(
            builder: (context, constraints) {
              var height = constraints.maxHeight;
              return Column(
                children: [
                  Container(
                    constraints: BoxConstraints(maxHeight: height - 20),
                    margin: const EdgeInsets.symmetric(vertical: 0),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: context.primary),
                    ),
                    child: Text(
                      '${day.day}',
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: AppColors.borderColor,
                  ),
                ],
              );
            },
          );
          // if (day.month != focusedDay.month) {
          //   //outside builder
          //   return Container(
          //     alignment: Alignment.center,
          //     constraints: const BoxConstraints(maxHeight: 40),
          //     margin: const EdgeInsets.symmetric(vertical: 8.5),
          //     padding: const EdgeInsets.all(10),
          //     decoration: BoxDecoration(
          //       border: Border(
          //           bottom: BorderSide(
          //         width: 1,
          //         color: AppColors.borderColor,
          //       )),
          //     ),
          //     child: Text(
          //       '${day.day}',
          //       style: context.textTheme.bodySmall!
          //           .copyWith(fontSize: 12, color: Colors.grey),
          //     ),
          //   );
          // }

          // //dates which have shift inside
          // return Column(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       constraints: const BoxConstraints(maxHeight: 40),
          //       margin: const EdgeInsets.symmetric(vertical: 7.5),
          //       padding: const EdgeInsets.all(10),
          //       alignment: Alignment.center,
          //       decoration: const BoxDecoration(
          //           color: Color(
          //             0xFFDFF6F9,
          //           ),
          //           shape: BoxShape.circle),
          //       child: Text(
          //         '${day.day} ',
          //         textAlign: TextAlign.center,
          //         style: context.textTheme.bodyMedium!
          //             .copyWith(color: Colors.black),
          //       ),
          //     ),
          //     Divider(
          //       thickness: 1,
          //       color: AppColors.borderColor,
          //     ),
          //   ],
          // );
        },
        defaultBuilder: (context, day, focusedDay) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
                vertical: context.mediaQuery.size.height * 0.00245),
            padding: EdgeInsets.all(context.mediaQuery.size.height * 0.0035),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: AppColors.borderColor),
              ),
            ),
            child: Text('${day.day}'),
          );
        },
        markerBuilder: (context, date, list) {
          if (list.isEmpty) return Container();
          return ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(1),
                child: Container(
                  height: 9,
                  decoration: BoxDecoration(
                      color: hexToColor('#00A5B9'), shape: BoxShape.circle),
                ),
              );
            },
          );
        },
        disabledBuilder: (context, day, focusedDay) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: height * 0.0023),
            padding: EdgeInsets.all(height * 0.004),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: AppColors.borderColor),
              ),
            ),
            child: Text(
              '${day.day}',
              style: context.textTheme.bodySmall!.copyWith(
                fontSize: 12,
                color: AppColors.kGrey,
              ),
            ),
          );
        },
        outsideBuilder: (context, day, focusedDay) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: height * 0.0023),
            padding: EdgeInsets.all(height * 0.004),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: AppColors.kGrey),
              ),
            ),
            child: Text(
              '${day.day}',
              style: context.textTheme.bodySmall!
                  .copyWith(fontSize: 12, color: AppColors.kGrey),
            ),
          );
        },
        dowBuilder: (context, day) {
          final text = DateFormat.E().format(day);

          return Column(
            children: [
              Divider(thickness: 1.5, height: 15, color: AppColors.kGrey),
              Center(
                child: Text(
                  text,
                  style: TextStyle(color: AppColors.kGrey),
                ),
              ),
              Divider(thickness: 1.5, height: 15, color: AppColors.kGrey),
            ],
          );
        },
        headerTitleBuilder: (context, day) {
          final text = DateFormat.yMMMM().format(day);
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: context.textTheme.titleLarge,
              )
            ],
          );
        },
        todayBuilder: (context, day, focusedDay) {
          const calendarStyle = CalendarStyle();
          final alignment = calendarStyle.cellAlignment;
          // const duration = Duration(milliseconds: 250);

          return LayoutBuilder(
            builder: (context, constraints) {
              var height = constraints.maxHeight;
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Dimens.vSpaceTiny,
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(maxHeight: height),
                      margin: const EdgeInsets.symmetric(vertical: 0),
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: Text(
                        '${day.day}',
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  Dimens.vSpaceTiny,
                  Divider(
                    height: 5,
                    thickness: 1,
                    color: AppColors.borderColor,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
