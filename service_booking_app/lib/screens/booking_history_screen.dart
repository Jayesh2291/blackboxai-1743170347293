import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:service_booking_app/bloc/booking_bloc.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BookingBloc>().add(LoadBookings());
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state is BookingsLoaded && state.bookings.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.bookings.length,
              itemBuilder: (context, index) {
                final booking = state.bookings[index];
                return Dismissible(
                  key: Key('$index'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    context.read<BookingBloc>().add(CancelBooking(index));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking['service']['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Provider: ${booking['provider']['name']}',
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Date: ${booking['date']} at ${booking['time']}',
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Status: ${booking['status']}',
                            style: TextStyle(
                              color: booking['status'] == 'Confirmed'
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Amount: \$${booking['amount']}',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text('No bookings yet'),
          );
        },
      ),
    );
  }
}