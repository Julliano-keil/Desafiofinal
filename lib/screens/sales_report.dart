// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../casos_de_usos/form_validator.dart';
// import '../casos_de_usos/settings_code.dart';
// import '../entidades/autonomy_level.dart';
// import '../entidades/person.dart';
// import '../repositorio_de_dados/autonomy_level_controller.dart';
// import '../repositorio_de_dados/person_controler.dart';
// import '../repositorio_de_dados/sales_controller.dart';
// import '../widgets/dialog.dart';
// import '../widgets/form_pagelogs.dart';
// import 'registered_people_screen.dart';

// class SalesReport extends StatelessWidget {
//   SalesReport({super.key});

//   final Settingscode color = Settingscode();

//   @override
//   Widget build(BuildContext context) {
//     final person = ModalRoute.of(context)!.settings.arguments as Person?;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () async =>
//               Navigator.of(context).pushReplacement(MaterialPageRoute(
//             builder: (context) => Registeredpeople(),
//           )),
//           icon: const Icon(Icons.arrow_back_outlined),
//         ),
//         backgroundColor: Colors.black,
//         title: const Center(
//           child: Text('Autonomias'),
//         ),
//       ),
//       body: AnimatedContainer(
//         width: double.infinity,
//         height: double.infinity,
//         color: color.cor,
//         duration: const Duration(seconds: 2),
//         child: Stack(
//           children: [
//             Container(
//               color: color.cor,
//               width: 430,
//               height: 400,
//               child: Container(
//                 width: 420,
//                 height: 382,
//                 decoration: const BoxDecoration(
//                   color: Colors.amber,
//                   borderRadius: BorderRadius.only(
//                     bottomRight: Radius.circular(200),
//                   ),
//                 ),
//                 //
//               ),
//             ),
//             Positioned(
//               top: 400,
//               child: Container(
//                 color: Colors.amber,
//                 width: 430,
//                 height: 411,
//                 child: Container(
//                   width: 420,
//                   height: 400,
//                   decoration: const BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(150),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SalesReportScreen(
//               person: person ?? Person(),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SalesReportScreen extends StatelessWidget {
 
  

//   @override
//   Widget build(BuildContext context) {
// final state = Provider.of<PersonControler>(context);
//     final userid = state.loggedUser!.id;
//     return ChangeNotifierProvider(
//       create: (context) {
//         return SaleController(person: userid!, vehicle: vehicle);
//       },
//       child: Consumer<AutonomilevelControler>(
//         builder: (_, state, __) {
//           return ListView.builder(
//             shrinkWrap: true,
//             itemCount: state.listaAutonomy.length,
//             itemBuilder: (context, index) {
//               final autonomy = state.listaAutonomy[index];
//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: InkWell(
//                   child: Card(
//                     color: Colors.white,
//                     elevation: 45,
//                     child: ListTile(
//                       trailing: PopupMenuButton<String>(
//                         onSelected: (choice) async {
//                           if (choice == 'Opção 2') {
//                             await Navigator.of(context, rootNavigator: true)
//                                 .pushReplacement(MaterialPageRoute(
//                               builder: (context) => EditAutonomy(
//                                 person: person,
//                                 autonomy: autonomy,
//                               ),
//                             ));
//                             if (context.mounted) {
//                               CustomDialog.showSuccess(
//                                   context,
//                                   ' ',
//                                   'Popule (🖋️)o formulario'
//                                       ' para alterar');
//                             }
//                           } else if (choice == 'Opção 3' && person.id != 1) {
//                             await showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return AlertDialog(
//                                   title: const Text(
//                                     'Deletar ⚠️',
//                                     style: TextStyle(
//                                         fontSize: 25,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   content: const Text(
//                                     'Deseja mesmo apagar o nivel '
//                                     ' de usuario ?',
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () async {
//                                         await state.delete(autonomy);
//                                         if (context.mounted) {
//                                           Navigator.of(context).pop();
//                                         }
//                                       },
//                                       child: const Text('Sim'),
//                                     ),
//                                     TextButton(
//                                       onPressed: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: const Text('Não'),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//                           } else {
//                             CustomDialog.showSuccess(
//                                 context,
//                                 '⚠️',
//                                 'O Nivel do usuario ${person.nomeloja}'
//                                     ' nao pode ser excluido');
//                           }
//                         },
//                         itemBuilder: (context) {
//                           return <PopupMenuEntry<String>>[
//                             const PopupMenuItem<String>(
//                               value: 'Opção 2',
//                               child: Text('Editar Nivel'),
//                             ),
//                             const PopupMenuItem<String>(
//                               value: 'Opção 3',
//                               child: Text('Deletar Usuario'),
//                             ),
//                           ];
//                         },
//                       ),
//                       title: Text(
//                         'Nivel do(a) ${person.nomeloja.toString()}',
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                       subtitle: Text(autonomy.name),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

