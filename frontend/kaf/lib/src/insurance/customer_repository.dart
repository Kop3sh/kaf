import 'package:kaf/src/insurance/customer.dart';
import 'package:kaf/src/insurance/insurance_api_client.dart';

class CustomerRepositoy {
  CustomerRepositoy({CustomerApiClient? customerApiClient})
      : _customerApiClient = customerApiClient ?? CustomerApiClient();

  final CustomerApiClient _customerApiClient;

  Future<List<Customer>> getCustomersList() async {
    final customers = await _customerApiClient.customerSearch('');
    return customers;
  }

  Future<Customer> getCustomer(String? customerName) async {
    final customers = await _customerApiClient.customerSearch(customerName);
    // return the first search result
    // final customer = customers.first;

    // return Customer(
    //   id: customer.id,
    //   name: customer.name,
    //   salary: customer.salary,
    //   percentage: customer.percentage,
    // );
    return customers.first;
  }
}
