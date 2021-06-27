// import 'dart:ui';

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Counter Demo',
//       theme: ThemeData.light(),
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.blueGrey,
//           centerTitle: true,
//           title: Text("Demo App"),
//         ),
//         body: Stacked(),
//       ),
//     );
//   }
// }

// class Stacked extends StatefulWidget {
//   @override
//   _StackedState createState() => _StackedState();
// }

// class _StackedState extends State<Stacked> {
//   final List<String> images = [
//     "1.jpg",
//     "2.jpg",
//     "3.jpg",
//     "4.jpg",
//     "5.jpg",
//     "6.jpg",
//     "7.jpg",
//     "8.jpg",
//     "9.jpg",
//     "10.jpg",
//   ];

//   bool _showPreview = false;
//   String _image = "assets/images/1.jpg";

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Stack(
//       children: [
//         GridView.builder(
//           itemCount: images.length,
//           gridDelegate:
//               SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//           itemBuilder: (BuildContext context, int index) {
//             return GestureDetector(
//               onLongPress: () {
//                 setState(() {
//                   _showPreview = true;
//                   _image = "assets/images/${images[index]}";
//                 });
//               },
//               onLongPressEnd: (details) {
//                 setState(() {
//                   _showPreview = false;
//                 });
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0),
//                   ),
//                   clipBehavior: Clip.hardEdge,
//                   child: Image.asset("assets/images/${images[index]}"),
//                 ),
//               ),
//             );
//           },
//         ),
//         if (_showPreview) ...[
//           BackdropFilter(
//             filter: ImageFilter.blur(
//               sigmaX: 5.0,
//               sigmaY: 5.0,
//             ),
//             child: Container(
//               color: Colors.grey.withOpacity(0.6),
//             ),
//           ),
//           Container(
//             child: Center(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10.0),
//                 child: Image.asset(
//                   _image,
//                   height: 300,
//                   width: 300,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ],
//     ));
//   }
// }
