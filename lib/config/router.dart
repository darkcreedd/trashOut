import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trash_out/authentication/auth_screen.dart';
import 'package:trash_out/authentication/forgot_password_page.dart';
import 'package:trash_out/authentication/recover_account.dart';
import 'package:trash_out/authentication/sign_in_page.dart';
import 'package:trash_out/authentication/sign_up_page.dart';
import 'package:trash_out/bin_request/bin_request_confirmation_screen.dart';
import 'package:trash_out/features/points_redeeming/card_confirmation.dart';
import 'package:trash_out/features/points_redeeming/company_page.dart';
import 'package:trash_out/features/points_redeeming/redeem_points_page.dart';
import 'package:trash_out/features/profile/about_app_page.dart';
import 'package:trash_out/features/profile/account_page.dart';
import 'package:trash_out/features/profile/profile_page.dart';
import 'package:trash_out/bin_request/request_bin.dart';
import 'package:trash_out/dashboard/default_page.dart';
import 'package:trash_out/dashboard/home_page.dart';
import 'package:trash_out/dashboard/pickups_page.dart';
import 'package:trash_out/features/Notifcations/notifications_page.dart';
import 'package:trash_out/features/Notifcations/pickup_scheduling/domestic_waste_specification_page.dart';
import 'package:trash_out/features/Notifcations/pickup_scheduling/industrial_waste_specification_page.dart';
import 'package:trash_out/features/Notifcations/pickup_scheduling/medical_waste_specification_page.dart';
import 'package:trash_out/features/profile/support_page.dart';

import '../features/pickup_scheduling/date_and_time_picking_page.dart';
import '../features/pickup_scheduling/pickup_schedule_confirmation_page.dart';
import '../features/pickup_scheduling/waste_classification_guide.dart';

// Create keys for `root` & `section` navigator avoiding unnecessary rebuilds
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthChecker(),
    ),
    GoRoute(
      path: '/signIn',
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: '/signUp',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/forgotPassword',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/otpScreen',
      builder: (context, state) => const RecoverAccount(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // Return the widget that implements the custom shell (e.g a BottomNavigationBar).
        // The [StatefulNavigationShell] is passed to be able to navigate to other branches in a stateful way.
        return ScaffoldWithNavbar(navigationShell);
      },
      branches: [
        // The route branch for the 1º Tab
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
          // Add this branch routes
          // each routes with its sub routes if available e.g feed/uuid/details
          routes: <RouteBase>[
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
              routes: <RouteBase>[
                GoRoute(
                  path: 'redeemPoints',
                  builder: (context, state) => const RedeemPointsPage(),
                ),
                GoRoute(
                  path: 'companyPage/:companyName/:companyLogo',
                  name:
                      'companyPage', // 👈 Defination of params in the path is important
                  builder: (context, state) => CompanyPage(
                    companyName: state.pathParameters['companyName']!,
                    companyLogo: state.pathParameters['companyLogo']!,
                  ),
                ),
                GoRoute(
                  path: 'cardConfirmation/:companyLogo/:points/:price',
                  name:
                      'cardConfirmation', // 👈 Defination of params in the path is important
                  builder: (context, state) => CardConfirmation(
                    companyLogo: state.pathParameters['companyLogo']!,
                    points: state.pathParameters['points']!,
                    price: state.pathParameters['price']!,
                  ),
                ),
                GoRoute(
                  path: 'domestic',
                  builder: (context, state) =>
                      const DomesticWasteSpecificationPage(),
                ),
                GoRoute(
                  path: 'wasteClassification',
                  builder: (context, state) => const WasteClassificationPage(),
                ),
                GoRoute(
                  path: 'home/date',
                  name: 'date',
                  builder: (context, state) => const DateAndTimePickingPage(),
                ),
                GoRoute(
                  path: 'home/pickupConfirmation',
                  name: 'pickupConfirmation',
                  builder: (context, state) =>
                      const PickupScheduleConfirmationPage(),
                ),
                GoRoute(
                  path: 'medical',
                  builder: (context, state) =>
                      const MedicalWasteSpecificationPage(),
                ),
                GoRoute(
                  path: 'industrial',
                  builder: (context, state) =>
                      const IndustrialWasteSpecificationPage(),
                ),
                // GoRoute(
                //   path: 'commercial',
                //   builder: (context, state) =>
                //       const CommercialWasteSpecificationPage(),
                // ),
              ],
            ),
          ],
        ),

        // The route branch for 2º Tab
        StatefulShellBranch(
          routes: <RouteBase>[
            // Add this branch routes
            // each routes with its sub routes if available e.g shope/uuid/details
            GoRoute(
              path: '/pickups',
              builder: (context, state) => const PickupsPage(),
            ),
          ],
        ),

        // The route branch for 3º Tab
        StatefulShellBranch(
          routes: <RouteBase>[
            // Add this branch routes
            // each routes with its sub routes if available e.g shope/uuid/details
            GoRoute(
              path: '/maps',
              builder: (context, state) => const NotificationsPage(),
            ),
          ],
        ),

        // The route branch for 4º Tab
        StatefulShellBranch(
          routes: <RouteBase>[
            // Add this branch routes
            // each routes with its sub routes if available e.g shope/uuid/details

            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
            GoRoute(
              path: '/account',
              builder: (context, state) => const AccountPage(),
            ),
            GoRoute(
              path: '/requestBin',
              builder: (context, state) => const RequestBinPage(),
            ),
            GoRoute(
              path: '/binConfirmationPage/:binImage/:material/:price/:size',
              name:
                  'binConfirmationPage', // 👈 Defination of params in the path is important
              builder: (context, state) => BinRequestConfirmationPage(
                binImage: state.pathParameters['binImage']!,
                material: state.pathParameters['material']!,
                price: state.pathParameters['price']!,
                size: state.pathParameters['size']!,
              ),
            ),
            GoRoute(
              path: '/notifications',
              builder: (context, state) => const NotificationsPage(),
            ),
            GoRoute(
              path: '/support',
              builder: (context, state) => const SupportPage(),
            ),
            GoRoute(
              path: '/about',
              builder: (context, state) => const AboutAppPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
