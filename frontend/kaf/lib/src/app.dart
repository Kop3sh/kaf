import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kaf/src/insurance/cubit/customer_cubit.dart';
import 'package:kaf/src/insurance/customer_repository.dart';
import 'package:kaf/src/insurance/views/customer_list_view.dart';

// import 'insurance/customer.dart';
// import 'insurance/views/customer_details_view.dart';
// import 'insurance/views/customer_list_view.dart';
// import 'settings/settings_view.dart';
import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class InsuranceApp extends StatelessWidget {
  const InsuranceApp({
    super.key,
    required this.settingsController,
    required CustomerRepositoy customerRepositoy,
  }) : _customerRepositoy = customerRepositoy;

  final SettingsController settingsController;

  final CustomerRepositoy _customerRepositoy;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return RepositoryProvider.value(
      value: _customerRepositoy,
      child: BlocProvider(
        create: (context) => CustomerCubit(context.read<CustomerRepositoy>())
          ..fetchCustomerList(),
        child: AnimatedBuilder(
          animation: settingsController,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              home: const CustomerListView(),
              // Providing a restorationScopeId allows the Navigator built by the
              // MaterialApp to restore the navigation stack when a user leaves and
              // returns to the app after it has been killed while running in the
              // background.
              restorationScopeId: 'app',

              // Provide the generated AppLocalizations to the MaterialApp. This
              // allows descendant Widgets to display the correct translations
              // depending on the user's locale.
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''), // English, no country code
              ],

              // Use AppLocalizations to configure the correct application title
              // depending on the user's locale.
              //
              // The appTitle is defined in .arb files found in the localization
              // directory.
              onGenerateTitle: (BuildContext context) =>
                  AppLocalizations.of(context)!.appTitle,

              // Define a light and dark color theme. Then, read the user's
              // preferred ThemeMode (light, dark, or system default) from the
              // SettingsController to display the correct theme.
              theme: ThemeData(),
              darkTheme: ThemeData.dark(),
              themeMode: settingsController.themeMode,

              // Define a function to handle named routes in order to support
              // Flutter web url navigation and deep linking.
              // onGenerateRoute: (RouteSettings routeSettings) {
              //   final args = routeSettings.arguments;
              //   return MaterialPageRoute<void>(
              //     settings: routeSettings,
              //     builder: (BuildContext context) {
              //       switch (routeSettings.name) {
              //         case SettingsView.routeName:
              //           return SettingsView(controller: settingsController);
              //         case CustomerDetailsView.routeName:
              //           return CustomerDetailsView();
              //         case SampleItemListView.routeName:
              //         default:
              //           return const SampleItemListView();
              //       }
              //     },
              //   );
              // },
            );
          },
        ),
      ),
    );
  }
}
