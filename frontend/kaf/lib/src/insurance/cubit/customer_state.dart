part of 'customer_cubit.dart';

@immutable
sealed class CustomerState extends Equatable {
  final bool isLoading;
  // TODO: Fix
  final error;

  const CustomerState({
    required this.isLoading,
    required this.error,
  });
}

@immutable
final class CustomerDetailsState extends CustomerState {
  final Customer? customer;

  const CustomerDetailsState({
    required isLoading,
    this.customer,
    error,
  }) : super(
          isLoading: isLoading,
          error: error,
        );
  @override
  List<Object?> get props => [isLoading, error, customer];
}

@immutable
final class CustomersListState extends CustomerState {
  final List<Customer>? customers;

  const CustomersListState({
    required isLoading,
    this.customers,
    error,
  }) : super(
          isLoading: isLoading,
          error: error,
        );
  @override
  List<Object?> get props => [isLoading, error, customers];
}
