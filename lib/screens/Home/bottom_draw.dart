import 'dart:async';
import 'package:intl/intl.dart';
import 'package:jolie/common.dart';
import 'package:jolie/models/date_available.dart';
import 'package:jolie/database/database_helper.dart';

class BottomDraw extends StatefulWidget {
  const BottomDraw({super.key});

  @override
  State<BottomDraw> createState() => _BottomDrawState();
}



class _BottomDrawState extends State<BottomDraw> {
  final dateController = TextEditingController();
  Set<String> availableDates = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAvailableDates();
  }

  Future<void> _loadAvailableDates() async {
    final dbHelper = DatabaseHelper();
    final dates = await dbHelper.getAvailableDates();
    if (mounted) {
      setState(() {
        availableDates = dates.map((date) => date.date).toSet();
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: secondaryColor,
              onSurface: secondaryColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: secondaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null && mounted) {
      final formattedDate = DateFormat('EEEE/dd/MMM').format(selectedDate);
      setState(() {
        dateController.text = formattedDate;
      });
    }
  }

  Future<void> addAvailableDates() async {
    if (dateController.text.isNotEmpty) {
      final newDate = dateController.text;
      if (mounted) {
        setState(() {
          availableDates.add(newDate);
          dateController.clear();
        });
      }

      final dbHelper = DatabaseHelper();
      await dbHelper.insertAvailableDate(AvailableDateModel(date: newDate));
    }
  }

  Future<void> removeAvailableDates(String date) async {
    if (mounted) {
      setState(() {
        availableDates.remove(date);
      });
    }

    final dbHelper = DatabaseHelper();
    await dbHelper.deleteAvailableDate(date);
  }

  Future<void> _saveAvailableDates() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate a delay for saving the data
      await Future.delayed(const Duration(seconds: 2));

      // Save the availableDates to the database
      final dbHelper = DatabaseHelper();
      await Future.wait(
        availableDates.map((date) => dbHelper.insertAvailableDate(AvailableDateModel(date: date))),
      );

      if (mounted) {
        Navigator.pop(context);
        _showSuccessToast();
      }
    } catch (e) {
      if (mounted) {
        _showFailureToast();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSuccessToast() {
    successToast(context, "Dates saved successfully");
  }

  void _showFailureToast() {
    failureToast(context, "Error saving dates");
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: lightColor, width: 12.0),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: lightColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Add booking dates available",
                          textAlign: TextAlign.center,
                          style: Fonts.medium.copyWith(
                            color: secondaryColor,
                            fontSize: 18.0,
                          ),
                        ),
                        const Icon(Icons.assignment_rounded,
                            color: secondaryColor, size: 40.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: ListView.builder(
                  itemCount: availableDates.length,
                  itemBuilder: (BuildContext context, int index) {
                    final date = availableDates.elementAt(index);
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: const Border(
                            top: BorderSide(color: lightColor, width: 4.0),
                            bottom: BorderSide(color: lightColor, width: 4.0)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Transform.rotate(
                                angle: 45 * 3.14 / 180,
                                child: const Icon(
                                  Icons.push_pin_sharp,
                                  color: secondaryColor,
                                  size: 20.0,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                date,
                                textAlign: TextAlign.start,
                                style: Fonts.thin.copyWith(
                                  color: secondaryColor,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            hoverColor: tertiaryColor.withOpacity(0.5),
                            onPressed: () => removeAvailableDates(date),
                            icon: const Icon(
                              Icons.delete,
                              color: tertiaryColor,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: SizedBox(
                    height: 60.0,
                    child: TextField(
                      style: Fonts.regular.copyWith(
                        color: secondaryColor,
                        fontSize: 16.0,
                      ),
                      controller: dateController,
                      readOnly: true,
                      onTap: _selectDate,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: lightColor,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.edit_calendar_rounded,
                            color: secondaryColor, size: 30.0),
                        hintText: "Tap to choose a date",
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                SizedBox(
                  height: 60.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: addAvailableDates,
                    child: const Icon(Icons.add, color: lightColor, size: 30.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 60.0,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: _isLoading ? null : _saveAvailableDates,
                child: _isLoading
                    ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(lightColor),
                )
                    : Text(
                  "Save",
                  textAlign: TextAlign.start,
                  style: Fonts.medium.copyWith(
                    color: lightColor,
                    fontSize: 16.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
