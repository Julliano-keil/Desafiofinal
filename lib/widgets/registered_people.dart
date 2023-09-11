import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositorio_de_dados/signup_controller.dart';

class RegisteredList extends StatelessWidget {
  const RegisteredList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpController>(
        create: (context) => SignUpController(),
        child: Consumer<SignUpController>(builder: (_, state, __) {
          return ListView.builder(
            itemCount: state.listaPeople.length,
            itemBuilder: (context, index) {
              final person = state.listaPeople[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  child: Card(
                    color: Colors.white,
                    elevation: 14,
                    child: ListTile(
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacementNamed('/Autonomyedite',
                                  arguments: person);
                        },
                        icon: const Icon(Icons.lock_person_outlined),
                      ),
                      title: Text(
                        person.nomeloja!,
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(person.cnpj.toString()),
                    ),
                  ),
                  onTap: () {},
                ),
              );
            },
          );
        }));
  }
}
