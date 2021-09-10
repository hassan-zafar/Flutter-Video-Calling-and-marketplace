// import 'package:beloved_care/main_screen.dart';
// import 'package:beloved_care/universal_variables.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

// class LoginScreen extends StatefulWidget {
//   // static const routeName = '/LoginScreen';

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();

//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   loginUser() async {
//     try {
//       int ctr = 0;
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: _emailController.text, password: _passwordController.text);

//       Navigator.of(context).popAndPushNamed(MainScreens.routeName);
//     } catch (err) {
//       print(err);
//       var snackBar = SnackBar(
//         content: Text(
//           err.toString().substring(30),
//           style: ralewayStyle(15),
//         ),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: Stack(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height / 2,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: GradientColors.blue,
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 "Login",
//                 style: montserratStyle(45, Colors.black),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height / 1.6,
//               margin: EdgeInsets.only(left: 30, right: 30),
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 5,
//                     blurRadius: 5,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20)),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 100,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width / 1.7,
//                     child: TextField(
//                       controller: _emailController,
//                       style: montserratStyle(18, Colors.black),
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                           hintText: "Email",
//                           prefixIcon: Icon(Icons.email),
//                           hintStyle: ralewayStyle(
//                             20,
//                             Colors.grey,
//                           )),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width / 1.7,
//                     child: TextField(
//                       controller: _passwordController,
//                       style: montserratStyle(18, Colors.black),
//                       decoration: InputDecoration(
//                         hintText: "Password",
//                         prefixIcon: Icon(Icons.lock),
//                         hintStyle: ralewayStyle(
//                           20,
//                           Colors.grey,
//                         ),
//                       ),
//                       keyboardType: TextInputType.text,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   InkWell(
//                     onTap: loginUser,
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 2,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(colors: GradientColors.blue),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Login",
//                           style: ralewayStyle(25, Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
