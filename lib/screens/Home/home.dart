import 'dart:math';
import 'package:intl/intl.dart';
import 'package:jolie/common.dart';
import 'package:jolie/models/bookings.dart';
import 'package:jolie/database/database_helper.dart';
import 'package:jolie/screens/Home/statistic_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<BookingModel> bookingList = [];

  final List<String> women = [
    "🧒🏽",
    "👧🏽",
    "👩🏽‍🦱",
    "👩🏽‍🦳",
    "👩🏽‍🦰",
    "🧕🏽",
    "👸🏽"
  ];

  String getRandomWomen() {
    return women[Random().nextInt(women.length)];
  }

  String formatContact(String contact) {
    final buffer = StringBuffer();
    buffer.write(contact.substring(0, 2)); // +1
    buffer.write(' (');
    buffer.write(contact.substring(2, 5)); // (000)
    buffer.write(') ');
    buffer.write(contact.substring(5, 8)); // 000
    buffer.write('-');
    buffer.write(contact.substring(8)); // 000
    return buffer.toString();
  }

  // Get current date in dd/mm format
  var currentDate = DateFormat('EEEE, d MMM').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    final dbHelper = DatabaseHelper();
    final bookings = await dbHelper.getBookings();
    setState(() {
      bookingList = bookings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox.fromSize(size: const Size.fromHeight(100.0)),
            Text(
              '👋🏽, Julie',
              style: Fonts.medium.copyWith(
                color: secondaryColor,
                fontSize: 40,
              ),
            ),
            SizedBox.fromSize(size: const Size.fromHeight(5.0)),
            Text(
              currentDate,
              style: Fonts.thin.copyWith(
                color: secondaryColor,
                fontSize: 20.0,
              ),
            ),
            SizedBox.fromSize(size: const Size.fromHeight(20.0)),
            StatisticCard(
              status: bookingList.isNotEmpty
                  ? "💆🏽 Working"
                  : "😤 Busy",
              bookingNo: bookingList.length.toString(),
            ),
            SizedBox.fromSize(size: const Size.fromHeight(20.0)),
            Text(
              "Bookings",
              style: Fonts.medium.copyWith(
                color: secondaryColor,
                fontSize: 20.0,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: bookingList.length,
                itemBuilder: (context, index) {
                  final booking = bookingList[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: const Border(
                          top: BorderSide(color: lightColor, width: 8.0),
                          bottom: BorderSide(color: lightColor, width: 8.0)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              getRandomWomen(),
                              style: Fonts.medium.copyWith(
                                color: secondaryColor,
                                fontSize: 40.0,
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  booking.email,
                                  style: Fonts.medium.copyWith(
                                    color: secondaryColor,
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                    color: lightColor,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Text(
                                    formatContact(booking.contact),
                                    style: Fonts.thin.copyWith(
                                      color: secondaryColor,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: lightColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Add logic to delete booking
                              _deleteBooking(booking.id);
                            },
                            icon: const Icon(Icons.delete,
                                color: tertiaryColor, size: 30.0),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteBooking(int id) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.deleteBooking(id as String);
    _loadBookings(); // Reload bookings after deletion
  }
}
