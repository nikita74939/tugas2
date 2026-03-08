// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../components/text_field.dart';
// import 'package:tugas2/models/user_model.dart';
// import 'package:tugas2/pages/home_page.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController userC = TextEditingController();
//   final TextEditingController passC = TextEditingController();
//   bool isLoggedin = false;
//   String errorMessage = "";

//   void _login() {
//     setState(() {
//       if (userC.text == user1.username && passC.text == user1.password) {
//         errorMessage = "";

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomePage(name: user1.name),
//           ),
//         );
//       } else {
//         errorMessage = "salah oi! sini kubisikin, un: nikita & pass: 044";

//         // Bisa juga pake logika:
//         if (userC.text.isEmpty || passC.text.isEmpty) {
//           errorMessage = "jangan dikosongin dong";
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // image
//             Image.asset('assets/login_img.png', width: 300),

//             const SizedBox(height: 30),

//             Text(
//               'Login dulu ya!',
//               style: GoogleFonts.poppins(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 15),

//             // error message
//             if (errorMessage.isNotEmpty)
//               Text(
//                 errorMessage,
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                   color: Colors.redAccent,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),

//             const SizedBox(height: 20),

//             // username field
//             MyTextField(
//               controller: userC,
//               hintText: 'Username',
//               obsecureText: false,
//             ),

//             const SizedBox(height: 20),

//             // password field
//             MyTextField(
//               controller: passC,
//               hintText: 'Password',
//               obsecureText: true,
//             ),

//             const SizedBox(height: 20),

//             // button login
//             ElevatedButton(
//               onPressed: _login,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.amber,
//                 foregroundColor: Colors.white,
//                 minimumSize: const Size(double.infinity, 54),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               child: Text(
//                 'Login',
//                 style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
