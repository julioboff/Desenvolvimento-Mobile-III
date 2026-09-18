import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:app_aula/db/animal_db.dart';
import 'package:app_aula/model/animal.dart';
import 'tela_cadastro_animal.dart';

class TelaListaAnimais extends StatefulWidget {
  const TelaListaAnimais({super.key});

  @override
  State<TelaListaAnimais> createState() => _TelaListaAnimaisState();
}

class _TelaListaAnimaisState extends State<TelaListaAnimais> {
  final _animalDb = AnimalDb();

  Future<void> _abrirCadastro({Animal? animal}) async {
    final salvou = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => TelaCadastroAnimal(animal: animal)),
    );
    if (salvou == true) {
      setState(() {});
    }
  }

  void _excluir(int id) {
    setState(() {
      _animalDb.delete(id);
    });
  }

  void _imprimir() {
    html.window.print();
  }

  @override
  Widget build(BuildContext context) {
    final animais = _animalDb.getAll();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Animais Disponíveis (ONG)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            tooltip: 'Imprimir lista',
            onPressed: _imprimir,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirCadastro(),
        child: const Icon(Icons.add),
      ),
      body: animais.isEmpty
          ? const Center(
              child: Text(
                'Nenhum animal cadastrado ainda.\nToque em + para adicionar.',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: animais.length,
              itemBuilder: (context, index) {
                final animal = animais[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.pets)),
                    title: Text('${animal.nome} (${animal.especie})'),
                    subtitle: Text(
                      '${animal.raca} • ${animal.idade} anos • ${animal.pelagem} • ${animal.peso} kg',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          tooltip: 'Editar',
                          onPressed: () => _abrirCadastro(animal: animal),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          tooltip: 'Excluir',
                          onPressed: () => _excluir(animal.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
