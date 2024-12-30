// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'shared_preferences.dart'; // Import file shared_preferences_helper.dart

// class MyDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<SharedPreferences>(
//       future: SharedPreferences
//           .getInstance(), // Mendapatkan instance SharedPreferences
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator(); // Menunggu data
//         } else if (snapshot.hasData) {
//           // Ambil data dari SharedPreferences
//           SharedPreferences prefs = snapshot.data!;
//           String userName = prefs.getString('userName') ?? 'Nama Pengguna';
//           String userEmail = prefs.getString('userEmail') ?? 'email@domain.com';

//           return Drawer(
//             child: ListView(
//               children: [
//                 UserAccountsDrawerHeader(
//                   accountName: Text(userName), // Menampilkan nama pengguna
//                   accountEmail: Text(userEmail), // Menampilkan email pengguna
//                   currentAccountPicture: CircleAvatar(
//                     backgroundImage:
//                         NetworkImage('https://via.placeholder.com/150'),
//                   ),
//                 ),
//                 // Menu-item lainnya di Drawer
//               ],
//             ),
//           );
//         } else {
//           return Text("Error loading user data");
//         }
//       },
//     );
//   }
// }
