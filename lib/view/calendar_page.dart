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

  bool _isCurrentMonth(DateTime date) {
    return date.month == _selectedDate.month && date.year == _selectedDate.year;
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('カレンダー',style: TextStyle(color: Colors.white,fontSize: 24),),
        actions: [Center(child: IconButton(onPressed: (){},icon: Icon(Icons.today,color: Colors.white,),),)],
      ),
      body: Column(

        children: [
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: _previousMonth,
              ),
              TextButton(
                child: Text(
                  DateFormat('yyyy年MM月').format(_selectedDate),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: (){},
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: _nextMonth,
              ),
            ],
          ),
          SizedBox(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '日',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '月',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '火',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '水',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '木',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '金',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '土',
                style: TextStyle(fontWeight: FontWeight.bold),
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
              final date = DateTime(_selectedDate.year, _selectedDate.month, dayOfMonth);
              final isCurrentMonth = _isCurrentMonth(date);
              final isToday = _isToday(date);
              final isSelectedDay = _selectedDate.day == dayOfMonth && isCurrentMonth;
              return InkWell(

                onTap: () => _selectDate(dayOfMonth),
                child: Stack(
                  children:<Widget> [
                    Center(child: Container(width: 40,height: 40,decoration:BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelectedDay ? Colors.orange : isToday ? Colors.black12 : null,
                    ),)),
                    Container(
                    alignment: Alignment.center,

                    child: Text(
                      '$dayOfMonth',
                      style: TextStyle(
                        color: isSelectedDay ? Colors.white : isCurrentMonth ? Colors.black : Colors.grey,
                      ),
                    ),
                  )],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
