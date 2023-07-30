import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trash_out/state/state.dart';
import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/custom_button.dart';
import 'package:trash_out/widgets/gap.dart';

class DateAndTimePickingPage extends ConsumerStatefulWidget {
  const DateAndTimePickingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DateAndTimePickingPageState();
}

class _DateAndTimePickingPageState
    extends ConsumerState<DateAndTimePickingPage> {
  String dropdownValue = "6am - 8am";
  List<String> timeSlots = [
    '6am - 8am',
    '9am - 11pm',
    '12pm - 2pm',
    '3pm - 5pm',
  ];
  DateTime newSelectedDay = DateTime.now();
  DateTime? newfocusedDay = DateTime.now();
  String newSelectedTime = '6am - 8am';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            splashRadius: 25.sp,
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        title: const Text("Schedule Pickup"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Text(
              "Select Date",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
            Card(
              elevation: 2,
              child: TableCalendar(
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(newSelectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      newSelectedDay = selectedDay;
                      newfocusedDay = focusedDay;
                    });
                  }
                },
                selectedDayPredicate: (day) {
                  return isSameDay(newSelectedDay, day);
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    newfocusedDay = focusedDay;
                  });
                },
                calendarFormat: CalendarFormat.month,
                availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                headerStyle: HeaderStyle(
                  rightChevronIcon: Icon(
                    Icons.arrow_forward_ios,
                    color: KColors.green300,
                  ),
                  leftChevronIcon: Icon(
                    Icons.arrow_back_ios,
                    color: KColors.green300,
                  ),
                  titleCentered: true,
                  titleTextStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                ),
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
              ),
            ),
            Gap(15.h),
            Text(
              "Select Time",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
            Gap(10.h),
            Container(
              padding: const EdgeInsets.all(10).w,
              height: 50.h,
              width: 200.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.grey[300]),
              child: Center(
                child: DropdownButton<String>(
                  underline: const Text(''),
                  value: dropdownValue,
                  items:
                      timeSlots.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        // style: theme.textTheme.bodyMedium,
                      ),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      newSelectedTime = dropdownValue;
                    });
                    print(newSelectedTime);
                  },
                ),
              ),
            ),
            Gap(10.h),
            const Text(
              "Pickup schedules are unavailable outside the given time slots \nSelected date must be in the present month.",
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
                text: "Proceed to Confirm",
                onPressed: () {
                  ref.read(wasteDateTimeProvider.notifier).addWasteDateTime(
                      wasteDate: newSelectedDay, wasteTime: newSelectedTime);

                  context.push('/pickupConfirmation');
                }),
            SizedBox(
              height: 20.h,
            ),
          ]),
        ),
      ),
    );
  }
}
