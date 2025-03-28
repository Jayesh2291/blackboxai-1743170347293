import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_booking_app/models/booking.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final List<Booking> _bookings = [];

  BookingBloc() : super(BookingInitial()) {
    on<SelectProvider>((event, emit) {
      emit(ProviderSelected(event.provider));
    });
    on<ConfirmBooking>((event, emit) {
      final booking = Booking(
        serviceTitle: event.bookingDetails['service']['title'],
        providerName: event.bookingDetails['provider']['name'],
        date: event.bookingDetails['date'],
        time: event.bookingDetails['time'],
        status: event.bookingDetails['status'],
        amount: event.bookingDetails['amount'],
      );
      _bookings.add(booking);
      emit(BookingConfirmed(booking.toMap()));
    });
    on<LoadBookings>((event, emit) {
      emit(BookingsLoaded(_bookings.map((b) => b.toMap()).toList()));
    });
    on<CancelBooking>((event, emit) {
      _bookings.removeAt(event.index);
      emit(BookingCancelled(event.index));
    });
  }
}
