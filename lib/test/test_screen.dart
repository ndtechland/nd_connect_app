// import 'package:flutter/material.dart';
// import 'package:flutter_foreground_task/flutter_foreground_task.dart';
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Background Location Tracker'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 FlutterForegroundTask.startService(
//                   notificationTitle: 'Location Tracker',
//                   notificationText: 'Updating your location in the background.',
//                 );
//               },
//               child: const Text('Start Background Service'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 FlutterForegroundTask.stopService();
//               },
//               child: const Text('Stop Background Service'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
