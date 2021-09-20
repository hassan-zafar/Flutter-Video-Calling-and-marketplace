import 'package:beloved_care/bottom_bar.dart';
import 'package:beloved_care/cart/cart.dart';
import 'package:beloved_care/consts/theme_data.dart';
import 'package:beloved_care/feeds.dart';
import 'package:beloved_care/inner_screens/product_details.dart';
import 'package:beloved_care/main_screen.dart';
import 'package:beloved_care/orders/order.dart';
import 'package:beloved_care/provider/cart_provider.dart';
import 'package:beloved_care/provider/dark_theme_provider.dart';
import 'package:beloved_care/provider/favs_provider.dart';
import 'package:beloved_care/provider/orders_provider.dart';
import 'package:beloved_care/provider/products.dart';
import 'package:beloved_care/screens/auth/forget_password.dart';
import 'package:beloved_care/screens/auth/login.dart';
import 'package:beloved_care/screens/auth/sign_up.dart';
import 'package:beloved_care/screens/meeting_screen.dart';
import 'package:beloved_care/upload_product_form.dart';
import 'package:beloved_care/user_state.dart';
import 'package:beloved_care/wishlist/wishlist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'screens/landingPage.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "high_importance_channel",
  "High Importance Notifications",
  "This channel is used for important notifications",
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    print('called ,mmmmm');
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error occured'),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return themeChangeProvider;
              }),
              ChangeNotifierProvider(
                create: (_) => Products(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => FavsProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => OrdersProvider(),
              ),
            ],
            child: Consumer<DarkThemeProvider>(
              builder: (context, themeChangeProvider, ch) {
                return MaterialApp(
                  title: 'Better Soul',
                  theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                  home: UserState(),
                  //initialRoute: '/',
                  routes: {
                    // '/': (ctx) => LandingPage(),
                    // WebhookPaymentScreen.routeName: (ctx) =>
                    //     WebhookPaymentScreen(),
                    CartScreen.routeName: (ctx) => CartScreen(),
                    LandingPage.routeName: (ctx) => LandingPage(),

                    Feeds.routeName: (ctx) => Feeds(),
                    WishlistScreen.routeName: (ctx) => WishlistScreen(),
                    MainScreens.routeName: (ctx) => MainScreens(),
                    ProductDetails.routeName: (ctx) => ProductDetails(),
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                    SignUpScreen.routeName: (ctx) => SignUpScreen(),
                    MeetingScreen.routeName: (ctx) => MeetingScreen(),
                    BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
                    UploadProductForm.routeName: (ctx) => UploadProductForm(),
                    ForgetPassword.routeName: (ctx) => ForgetPassword(),
                    OrderScreen.routeName: (ctx) => OrderScreen(),
                  },
                );
              },
            ),
          );
        });
  }
}



// import 'package:beloved_care/screens/home_screen.dart';
// import 'package:beloved_care/screens/introduction_auth_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: NavigationPage(),
//     );
//   }
// }

// class NavigationPage extends StatefulWidget {
//   @override
//   _NavigationPageState createState() => _NavigationPageState();
// }

// class _NavigationPageState extends State<NavigationPage> {
//   bool isLoggedIn = false;

//   @override
//   void initState() {
//     super.initState();
//     FirebaseAuth.instance.authStateChanges().listen((event) {
//       if (event != null) {
//         setState(() {
//           isLoggedIn = true;
//         });
//       } else {
//         setState(() {
//           isLoggedIn = false;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: isLoggedIn == false ? IntroductionAuthScreen() : HomeScreen(),
//     );
//   }
// }
