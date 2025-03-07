import 'package:flutter/material.dart';

class DateSliderWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final DateTime? selectedDate;

  const DateSliderWidget({
    super.key,
    required this.onDateSelected,
    this.selectedDate,
  });

  @override
  _DateSliderWidgetState createState() => _DateSliderWidgetState();
}

class _DateSliderWidgetState extends State<DateSliderWidget> {
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _yearController;

  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  void initState() {
    super.initState();
    final now = widget.selectedDate ?? DateTime.now();
    _dayController = FixedExtentScrollController(initialItem: now.day - 1);
    _monthController = FixedExtentScrollController(initialItem: now.month - 1);
    _yearController = FixedExtentScrollController(initialItem: now.year - 1990);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        children: [
          Expanded(
            child: _buildWheelColumn(
              controller: _dayController,
              items: List.generate(31, (index) => (index + 1).toString()),
              onChanged: (index) => _updateDate(),
            ),
          ),
          Expanded(
            child: _buildWheelColumn(
              controller: _monthController,
              items: months,
              onChanged: (index) => _updateDate(),
            ),
          ),
          Expanded(
            child: _buildWheelColumn(
              controller: _yearController,
              items: List.generate(50, (index) => (1990 + index).toString()),
              onChanged: (index) => _updateDate(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWheelColumn({
    required FixedExtentScrollController controller,
    required List<String> items,
    required Function(int) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withAlpha(51)),
          bottom: BorderSide(color: Colors.white.withAlpha(51)),
        ),
      ),
      child: ListWheelScrollView(
        controller: controller,
        itemExtent: 50,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onChanged,
        children: items.map((item) {
          return Center(
            child: Text(
              item,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _updateDate() {
    final day = _dayController.selectedItem + 1;
    final month = _monthController.selectedItem + 1;
    final year = 1990 + _yearController.selectedItem;
    widget.onDateSelected(DateTime(year, month, day));
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }
}
