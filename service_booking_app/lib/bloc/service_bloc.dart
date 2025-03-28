import 'package:flutter_bloc/flutter_bloc.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceInitial()) {
    on<SelectService>((event, emit) {
      emit(ServiceSelected(event.service));
    });
  }
}