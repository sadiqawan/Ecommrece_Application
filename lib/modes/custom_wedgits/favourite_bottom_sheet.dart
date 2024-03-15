// import 'package:flutter/material.dart';
//
// class FavouriteBottomSheet extends StatefulWidget {
//   final BuildContext context;
//
//   const FavouriteBottomSheet({super.key, required this.context});
//
//   @override
//   State<FavouriteBottomSheet> createState() => _FavouriteBottomSheetState();
// }
//
// class _FavouriteBottomSheetState extends State<FavouriteBottomSheet> {
//   void _showBottomSheet() {
//     showModalBottomSheet(
//       context: widget.context,
//       builder: (BuildContext bc) {
//         return Container(
//           child: Wrap(
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.album),
//                 title: Text('Option 1'),
//                 onTap: () {
//                   // Add your functionality here
//                   Navigator.pop(context); // Close the bottom sheet
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.album),
//                 title: Text('Option 2'),
//                 onTap: () {
//                   // Add your functionality here
//                   Navigator.pop(context); // Close the bottom sheet
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(); // You can return any Widget here
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _showBottomSheet(); // Call the method to show the bottom sheet when the widget is initialized
//   }
// }
