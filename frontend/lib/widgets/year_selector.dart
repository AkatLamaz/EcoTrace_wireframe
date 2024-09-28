import 'package:flutter/material.dart';

class YearSelector extends StatelessWidget {
  final int selectedYear;
  final List<int> availableYears;
  final ValueChanged<int> onYearSelected;

  const YearSelector({
    super.key,
    required this.selectedYear,
    required this.availableYears,
    required this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Year'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 450, // Ustaw maksymalną szerokość okna dialogowego
        ),
        child: SizedBox(
          width: double.maxFinite, // Ustal szerokość na maksymalną
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: availableYears.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 elementy w wierszu
              crossAxisSpacing: 10.0, // Odstępy między elementami w wierszu
              mainAxisSpacing: 10.0, // Odstępy między wierszami
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  //print('Year selected: ${availableYears[index]}'); // Debug print
                  onYearSelected(availableYears[index]);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedYear == availableYears[index]
                        ? Colors.blue
                        : Colors.grey[200], // Zmiana koloru dla wybranego roku
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${availableYears[index]}',
                    style: TextStyle(
                      color: selectedYear == availableYears[index]
                          ? Colors.white
                          : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
