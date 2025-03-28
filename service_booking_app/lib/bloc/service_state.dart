part of 'service_bloc.dart';

abstract class ServiceState {}

class ServiceInitial extends ServiceState {}

class ServiceSelected extends ServiceState {
  final Map<String, dynamic> service;

  ServiceSelected(this.service);
}