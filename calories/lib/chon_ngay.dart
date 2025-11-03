import 'package:flutter/material.dart';

class chon_ngay extends StatefulWidget {
  final Function(DateTime)
  onDateSelected;

  const chon_ngay({
    Key? key,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<chon_ngay> createState() =>
      _chon_ngayState();
}

class _chon_ngayState
    extends State<chon_ngay> {
  DateTime selectedDate =
      DateTime.now();
  late ScrollController
  _scrollController;

  final int totalDays = DateTime(
    DateTime.now().year,
    DateTime.now().month + 1,
    0,
  ).day;

  @override
  void initState() {
    super.initState();
    _scrollController =
        ScrollController();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
          final middle =
              (totalDays / 2) * 60.0;
          if (_scrollController
              .hasClients) {
            _scrollController.jumpTo(
              middle,
            );
          }
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _getShortWeekday(int wd) {
    switch (wd) {
      case 1:
        return 'T2';
      case 2:
        return 'T3';
      case 3:
        return 'T4';
      case 4:
        return 'T5';
      case 5:
        return 'T6';
      case 6:
        return 'T7';
      case 7:
        return 'CN';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection:
            Axis.horizontal,
        itemCount: totalDays,
        itemBuilder: (context, index) {
          final day = index + 1;
          final date = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            day,
          );
          final isSelected =
              selectedDate.day == day;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
              });
              widget.onDateSelected(
                date,
              );
            },
            child: Container(
              width: 60,
              margin:
                  const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.teal
                    : Colors.grey[200],
                borderRadius:
                    BorderRadius.circular(
                      10,
                    ),
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                children: [
                  Text(
                    _getShortWeekday(
                      date.weekday,
                    ),
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Colors
                                .black54,
                    ),
                  ),
                  Text(
                    '$day',
                    style: TextStyle(
                      fontWeight:
                          FontWeight
                              .bold,
                      fontSize: 18,
                      color: isSelected
                          ? Colors.white
                          : Colors
                                .black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
