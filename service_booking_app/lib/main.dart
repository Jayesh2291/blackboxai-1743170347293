import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:service_booking_app/models/booking.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_booking_app/bloc/auth_bloc.dart';
import 'package:service_booking_app/bloc/service_bloc.dart';
import 'package:service_booking_app/bloc/booking_bloc.dart';
import 'package:service_booking_app/screens/home_screen.dart';
import 'package:service_booking_app/screens/login_screen.dart';
import 'package:service_booking_app/screens/email_verification_screen.dart';
import 'package:service_booking_app/screens/service_details_screen.dart';
import 'package:service_booking_app/screens/booking_history_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(BookingAdapter());
  await Hive.openBox<Booking>('bookings');
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ServiceBloc(),
        ),
        BlocProvider(
          create: (context) => BookingBloc(),
        ),
      ],
      child: const ServiceBookingApp(),
    ),
  );
}

class ServiceBookingApp extends StatelessWidget {
  const ServiceBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            if (!state.isEmailVerified) {
              return const EmailVerificationScreen();
            }
            return const HomeScreen();
          }
          return const LoginScreen();
        },
      ),
      routes: {
        '/history': (context) => const BookingHistoryScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
    }
}