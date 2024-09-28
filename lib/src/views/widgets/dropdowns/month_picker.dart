import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class MonthPicker extends StatefulWidget {
//   final Function(String) onMonthSelected;
//
//   const MonthPicker({super.key, required this.onMonthSelected});
//
//   @override
//   State<MonthPicker> createState() => _MonthPickerState();
// }
//
// class _MonthPickerState extends State<MonthPicker> {
//   String? _selectedMonth;
//   List<String> _months = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _generateMonths();
//   }
//
//   void _generateMonths() {
//     DateTime now = DateTime.now();
//     for (int i = 1; i <= now.month; i++) {
//       _months.add(DateFormat('MMMM').format(DateTime(now.year, i)));
//     }
//     _selectedMonth = _months.last;
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       widget.onMonthSelected(_selectedMonth!);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: _selectedMonth,
//       hint: const Text("Select a Month"),
//       items: _months.map((String month) {
//         return DropdownMenuItem<String>(
//           value: month,
//           child: Text(month),
//         );
//       }).toList(),
//       onChanged: (String? newValue) {
//         setState(() {
//           _selectedMonth = newValue;
//           widget.onMonthSelected(_selectedMonth!);
//         });
//       },
//     );
//   }
// }

class MonthPicker extends StatefulWidget {
  final Function(String) onMonthSelected;

  const MonthPicker({Key? key, required this.onMonthSelected})
      : super(key: key);

  @override
  _MonthPickerState createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  late List<String> _months;
  late String? _selectedMonth;

  @override
  void initState() {
    super.initState();
    _months = _generateMonths();
    _selectedMonth = _months.last;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onMonthSelected(_selectedMonth!);
    });
  }

  List<String> _generateMonths() {
    DateTime now = DateTime.now();
    List<String> months = [];
    for (int i = 1; i <= now.month; i++) {
      months.add(DateFormat('MMMM').format(DateTime(now.year, i)));
    }
    return months;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedMonth,
      hint: const Text("Select Month"),
      items: _months.map((String month) {
        return DropdownMenuItem<String>(
          value: month,
          child: Text(month),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedMonth = newValue;
          widget.onMonthSelected(_selectedMonth!);
        });
      },
      dropdownColor: Theme.of(context).colorScheme.surface,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      icon: Icon(
        Icons.arrow_drop_down,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      underline: Container(
        height: 2,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
