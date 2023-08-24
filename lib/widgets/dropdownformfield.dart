// import 'package:flutter/material.dart';
// import 'package:jscar/entidades/person_login.dart';

// class MyForm extends StatefulWidget {
//   @override
//   _MyFormState createState() => _MyFormState();
// }

// class _MyFormState extends State<MyForm> {
//   final List<String> dropdownItems =<Nivelautonomia>[] ;
//   String? selectedValue;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         children: [
//           DropdownButtonFormField<String>(
//             value: selectedValue,
//             items: dropdownItems.map((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//             decoration: InputDecoration(
//               labelText: 'Escolha um item',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//             ),
//             onChanged: (String? newValue) {
//               setState(() {
//                 selectedValue = newValue;
//               });
//             },
//           ),
//           SizedBox(height: 20),
//           TextFormField(
//             decoration: InputDecoration(
//               labelText: 'Outro campo de texto',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
