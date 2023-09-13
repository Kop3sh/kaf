import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaf/src/insurance/cubit/customer_cubit.dart';

import 'customer_details_view.dart';

/// Displays a list of SampleItems.
class CustomerListView extends StatefulWidget {
  static const routeName = '/';

  const CustomerListView({super.key});

  @override
  State<CustomerListView> createState() => _CustomerListViewState();
}

class _CustomerListViewState extends State<CustomerListView> {
  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      context.read<CustomerCubit>().uploadFile(file);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Customer Salary Data'),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.settings),
          //     onPressed: () {
          //       // Navigate to the settings page. If the user leaves and returns
          //       // to the app after it has been killed while running in the
          //       // background, the navigation stack is restored.
          //       // Navigator.restorablePushNamed(context, SettingsView.routeName);

          //       // Navigator.of(context).push(
          //       //   MaterialPageRoute(builder: (context) => SettingsView()),
          //       // );
          //     },
          //   ),
          // ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.upload_file_rounded),
          onPressed: () {
            pickFile();
          },
        ),
        body: Column(
          children: [
            // search bar
            // const Padding(
            //   padding: EdgeInsets.all(16.0),
            //   child: TextField(),
            // ),
            Expanded(
              child: BlocConsumer<CustomerCubit, CustomerState>(
                listener: (context, state) {
                  // if (state.isLoading) {}
                },
                builder: (context, state) {
                  if (state.isLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state.error != null) {
                    return Center(
                      child: Text('error ${state.error}'),
                    );
                  }
                  if (state is CustomersListState) {
                    return RefreshIndicator(
                      onRefresh: () =>
                          context.read<CustomerCubit>().fetchCustomerList(),
                      child: ListView.builder(
                        // Providing a restorationId allows the ListView to restore the
                        // scroll position when a user leaves and returns to the app after it
                        // has been killed while running in the background.
                        restorationId: 'sampleItemListView',
                        itemCount: state.customers!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final customer = state.customers![index];

                          return ListTile(
                              title: Text(customer.name),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(customer.salary.toString()),
                                  Text('${customer.percentage}%'),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CustomerDetailsView(
                                        customerData: customer)));
                                // Navigate to the details page. If the user leaves and returns to
                                // the app after it has been killed while running in the
                                // background, the navigation stack is restored.
                                // Navigator.restorablePushNamed(
                                //     context, CustomerDetailsView.routeName,
                                //     arguments: {'data': customer});
                              });
                        },
                      ),
                    );
                  }
                  return const ColoredBox(color: Colors.red);
                },
              ),
            ),
          ],
        ));
  }
}
