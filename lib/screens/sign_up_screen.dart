// import 'package:firebase_auth/firebase_auth.dart';
// import "package:flutter/material.dart";
// import 'package:flutter/services.dart';
// import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

// import '../universal_variables.dart';

// class SignUpScreen extends StatefulWidget {
//   static const routeName = '/SignUpScreen';

//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _usernameController = TextEditingController();
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   signUpUser() async {
//     try {
//       await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//               email: _emailController.text, password: _passwordController.text)
//           .then((value) {
//         String uid = value.user!.uid;
//         userCollection.doc(uid).set({
//           "username": _usernameController.text,
//           "email": _emailController.text,
//           "password": _passwordController.text,
//           "uid": uid,
//         });
//       });
//       Navigator.of(context).pop();
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
//                 "Sign Up",
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
//                       controller: _usernameController,
//                       style: montserratStyle(18, Colors.black),
//                       decoration: InputDecoration(
//                         hintText: "Username",
//                         prefixIcon: Icon(Icons.person),
//                         hintStyle: ralewayStyle(
//                           20,
//                           Colors.grey,
//                         ),
//                       ),
//                       keyboardType: TextInputType.text,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
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
//                     onTap: signUpUser,
//                     child: Container(
//                       width: MediaQuery.of(context).size.width / 2,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(colors: GradientColors.pink),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Sign up",
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
