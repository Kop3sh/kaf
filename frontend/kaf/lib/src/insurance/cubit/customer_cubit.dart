import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kaf/src/insurance/customer.dart';
import 'package:kaf/src/insurance/customer_repository.dart';
import 'package:kaf/src/insurance/insurance_api_client.dart';
import 'package:meta/meta.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit(
    this._customerRepositoy,
  ) : super(
          const CustomersListState(isLoading: true),
        );

  final CustomerRepositoy _customerRepositoy;

  Future<void> fetchCustomer(String name) async {
    emit(const CustomersListState(
      isLoading: true,
    ));

    try {
      final customerDetails = await _customerRepositoy.getCustomer(name);
      print(customerDetails);
      emit(
        CustomerDetailsState(isLoading: false, customer: customerDetails),
      );
    } on CustomerRequestFailure {
      emit(CustomerDetailsState(
          isLoading: false, error: Exception('CustomerRequestFailure')));
    } on CustomerNotFound {
      emit(CustomerDetailsState(
          isLoading: false, error: Exception('CustomerNotFound')));
    } on CustomerSerializationFailure {
      emit(CustomerDetailsState(
          isLoading: false, error: Exception('CustomerSerializationFailure')));
    }
  }

  Future<void> fetchCustomerList() async {
    emit(const CustomerDetailsState(
      isLoading: true,
    ));

    try {
      final customers = await _customerRepositoy.getCustomersList();

      print(customers);
      emit(
        CustomersListState(isLoading: false, customers: customers),
      );
    } on CustomerRequestFailure {
      emit(CustomerDetailsState(
          isLoading: false, error: Exception('CustomerRequestFailure')));
    } on CustomerNotFound {
      emit(CustomerDetailsState(
          isLoading: false, error: Exception('CustomerNotFound')));
    } on CustomerSerializationFailure {
      emit(CustomerDetailsState(
          isLoading: false, error: Exception('CustomerSerializationFailure')));
    }
  }

  // Future<void> refreshWeather() async {
  //   if (!state.status.isSuccess) return;
  //   if (state.weather == Weather.empty) return;
  //   try {
  //     final weather = Weather.fromRepository(
  //       await _customerRepositoy.getWeather(state.weather.location),
  //     );
  //     final units = state.temperatureUnits;
  //     final value = units.isFahrenheit
  //         ? weather.temperature.value.toFahrenheit()
  //         : weather.temperature.value;

  //     emit(
  //       state.copyWith(
  //         status: WeatherStatus.success,
  //         temperatureUnits: units,
  //         weather: weather.copyWith(temperature: Temperature(value: value)),
  //       ),
  //     );
  //   } on Exception {
  //     emit(state);
  //   }
  // }
}
