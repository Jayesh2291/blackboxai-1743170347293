import 'package:hive/hive.dart';

part 'booking.g.dart';

@HiveType(typeId: 0)
class Booking {
  @HiveField(0)
  final String serviceTitle;

  @HiveField(1)
  final String providerName;

  @HiveField(2)
  final String date;

  @HiveField(3)
  final String time;

  @HiveField(4)
  final String status;

  @HiveField(5)
  final double amount;

  Booking({
    required this.serviceTitle,
    required this.providerName,
    required this.date,
    required this.time,
    required this.status,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'service': {'title': serviceTitle},
      'provider': {'name': providerName},
      'date': date,
      'time': time,
      'status': status,
      'amount': amount,
    };
  }
}
