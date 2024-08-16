import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jolie/models/bookings.dart';
import 'package:http/http.dart' as http;
import 'package:jolie/common.dart';
import 'dart:convert';

String serverUrl = dotenv.env["SERVER_API_URL"]!;

Future<ApiResponse> getBookings(BuildContext context) async {
  try {
    final response = await http.get(Uri.parse("$serverUrl/appointment"));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<BookingModel> bookings = data.map((item) => BookingModel.fromJson(item)).toList();
      return ApiResponse.success(bookings);
    } else {
      return ApiResponse.error("Failed to load bookings");
    }
  } catch (e) {
    return ApiResponse.error("An error occurred: $e");
  }

}

Future<ApiResponse> deleteBooking(BuildContext context, String id) async {
  try {
    final response = await http.delete(Uri.parse("$serverUrl/appointment/delete/$id"));

    if (response.statusCode == 200) {
      return ApiResponse.success(null);
    } else {
      return ApiResponse.error("Failed to delete booking");
    }
  } catch (e) {
    return ApiResponse.error("An error occurred: $e");
  }
}
