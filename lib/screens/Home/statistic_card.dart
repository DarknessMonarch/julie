import 'bottom_draw.dart';
import 'package:flutter/material.dart';
import 'package:jolie/constant/color.dart';
import 'package:jolie/constant/typography.dart';

class StatisticCard extends StatefulWidget {
  final String status;

  const StatisticCard({required this.status, super.key});

  @override
  State<StatisticCard> createState() => _StatisticCardState();
}

class _StatisticCardState extends State<StatisticCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: double.infinity,
      height: 240.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage("assets/images/users.png"),
                      width: 100.0,
                    ),
                    Text(
                      "02 bookings",
                      textAlign: TextAlign.center,
                      style: Fonts.medium.copyWith(
                        color: lightColor,
                        fontSize: 20.0,
                      ),
                    ),
                  ]),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.status,
                      style: const TextStyle(fontSize: 20),
                    ),
                    SizedBox.fromSize(size: const Size.fromWidth(4.0)),
                    Text(
                      "View Details",
                      textAlign: TextAlign.center,
                      style: Fonts.thin.copyWith(
                        color: secondaryColor,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox.fromSize(size: const Size.fromWidth(4.0)),
                    Center(
                      child: Container(
                        height: double.infinity,
                        width: 40,
                        decoration: BoxDecoration(
                          color: lightColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: primaryColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20.0))),
                                builder: (context) {
                                  return const BottomDraw();
                                });
                          },
                          icon: const Icon(
                            Icons.edit,
                            size: 20.0,
                          ),
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
