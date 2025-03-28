part of 'booking_bloc.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class ProviderSelected extends BookingState {
  final Map<String, dynamic> provider;

  ProviderSelected(this.provider);
}

class BookingConfirmed extends BookingState {
  final Map<String, dynamic> bookingDetails;

  BookingConfirmed(this.bookingDetails);
}