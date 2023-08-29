import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositorio_de_dados/person_controler.dart';

class RegisteredList extends StatelessWidget {
  const RegisteredList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PersonControler(),
        child: Consumer<PersonControler>(builder: (_, state, __) {
          state.loadata();
          return ListView.builder(
            itemCount: state.listaPeople.length,
            itemBuilder: (context, index) {
              final person = state.listaPeople[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: Colors.white,
                  elevation: 14,
                  child: InkWell(
                    onTap: () {},
                    child: ListTile(
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.people_alt_outlined),
                      ),
                      title: Text(
                        person.nomeloja,
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(person.cnpj.toString()),
                    ),
                  ),
                ),
              );
            },
          );
        }));
  }
}
