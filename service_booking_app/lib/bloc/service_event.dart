part of 'service_bloc.dart';

abstract class ServiceEvent {}

class SelectService extends ServiceEvent {
  final Map<String, dynamic> service;

  SelectService(this.service);
}