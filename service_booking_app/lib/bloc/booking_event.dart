part of 'booking_bloc.dart';

abstract class BookingEvent {}

class SelectProvider extends BookingEvent {
  final Map<String, dynamic> provider;

  SelectProvider(this.provider);
}

class ConfirmBooking extends BookingEvent {
  final Map<String, dynamic> bookingDetails;

  ConfirmBooking(this.bookingDetails);
}