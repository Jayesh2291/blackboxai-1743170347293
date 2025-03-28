import 'package:flutter/material.dart';
import 'package:service_booking_app/screens/booking_confirmation_screen.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> service;

  const ServiceDetailsScreen({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: service['color'].withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  service['icon'],
                  size: 48,
                  color: service['color'],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              service['title'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Service Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            ),
            const SizedBox(height: 24),
            const Text(
              'Available Providers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/men/${index + 1}.jpg',
                      ),
                    ),
                    title: Text('Provider ${index + 1}'),
                    subtitle: const Text('4.8 ★ (120 reviews)'),
                    trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingConfirmationScreen(
                            provider: {
                              'name': 'Provider ${index + 1}',
                              'rating': '4.8',
                              'image': 'https://randomuser.me/api/portraits/men/${index + 1}.jpg',
                            },
                            service: service,
                          ),
                        ),
                      );
                    },
                      child: const Text('Book Now'),
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
}