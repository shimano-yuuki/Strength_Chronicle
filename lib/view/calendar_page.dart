import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();

  void _previousMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 1);
    });
  }

  void _selectDate(int day) {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, day);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('カレンダー'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: _previousMonth,
              ),
              Text(
                DateFormat('yyyy年MM月').format(_selectedDate),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: _nextMonth,
              ),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemBuilder: (BuildContext context, int index) {
              final dayOfMonth = index + 1;
              return InkWell(
                onTap: () => _selectDate(dayOfMonth),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _selectedDate.day == dayOfMonth ? Colors.blue : null,
                  ),
                  child: Text(
                    '$dayOfMonth',
                    style: TextStyle(
                      color: _selectedDate.day == dayOfMonth ? Colors.white : null,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}