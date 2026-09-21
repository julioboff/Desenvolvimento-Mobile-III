import 'package:flutter/material.dart';
import 'package:app_aula/telas/tela_cadastro_pet.dart';
import 'package:app_aula/telas/tela_pets_adotados.dart';

class TelaListaPets extends StatefulWidget {
  const TelaListaPets({super.key});

  @override
  State<TelaListaPets> createState() => _TelaListaPetsState();
}

class _TelaListaPetsState extends State<TelaListaPets> {
  final List<Map<String, dynamic>> pets = [
    {'nome': 'Rex', 'especie': 'Cachorro', 'idade': '2 anos'},
    {'nome': 'Luna', 'especie': 'Gato', 'idade': '1 ano'},
    {'nome': 'Thor', 'especie': 'Cachorro', 'idade': '3 anos'},
  ];

  final List<Map<String, dynamic>> petsAdotados = [];

  String filtroEspecie = 'Todos';

  Future<void> _adicionarPet() async {
    final novoPet = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const TelaCadastroPet()));

    if (novoPet != null) {
      setState(() {
        pets.add({
          'nome': novoPet['nome'],
          'especie': novoPet['especie'],
          'idade': novoPet['idade'],
        });
      });
    }
  }

  void _editarPet(int index) {
    final pet = pets[index];

    final nomeController = TextEditingController(text: pet['nome']);

    final especieController = TextEditingController(text: pet['especie']);

    final idadeController = TextEditingController(text: pet['idade']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar pet'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: especieController,
                  decoration: const InputDecoration(
                    labelText: 'Espécie',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: idadeController,
                  decoration: const InputDecoration(
                    labelText: 'Idade',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nomeController.text.isEmpty ||
                    especieController.text.isEmpty ||
                    idadeController.text.isEmpty) {
                  return;
                }

                setState(() {
                  pets[index]['nome'] = nomeController.text;
                  pets[index]['especie'] = especieController.text;
                  pets[index]['idade'] = idadeController.text;
                });

                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _excluirPet(int index) {
    final nomePet = pets[index]['nome'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir pet'),
          content: Text('Tem certeza que deseja excluir o pet "$nomePet"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  pets.removeAt(index);
                });

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  void _marcarComoAdotado(int index) {
    final pet = pets[index];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Marcar como adotado'),
          content: Text('Deseja marcar "${pet['nome']}" como adotado?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  petsAdotados.add(pet);
                  pets.removeAt(index);
                });

                Navigator.pop(context);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _abrirPetsAdotados() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TelaPetsAdotados(petsAdotados: petsAdotados),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final petsFiltrados = filtroEspecie == 'Todos'
        ? pets
        : pets.where((pet) => pet['especie'] == filtroEspecie).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pets disponíveis'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pets disponíveis para adoção',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Filtrar por espécie',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.filter_list),
              ),
              initialValue: filtroEspecie,
              items: const [
                DropdownMenuItem(value: 'Todos', child: Text('Todos')),
                DropdownMenuItem(value: 'Cachorro', child: Text('Cachorros')),
                DropdownMenuItem(value: 'Gato', child: Text('Gatos')),
              ],
              onChanged: (value) {
                setState(() {
                  filtroEspecie = value ?? 'Todos';
                });
              },
            ),

            const SizedBox(height: 16),

            Expanded(
              child: petsFiltrados.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum pet encontrado para este filtro.',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: petsFiltrados.length,
                      itemBuilder: (context, index) {
                        final pet = petsFiltrados[index];

                        final indiceOriginal = pets.indexOf(pet);

                        return Card(
                          child: ListTile(
                            leading: const Icon(
                              Icons.pets,
                              size: 45,
                              color: Colors.green,
                            ),
                            title: Text(
                              pet['nome'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${pet['especie']} • ${pet['idade']}',
                            ),
                            trailing: PopupMenuButton<String>(
                              onSelected: (opcao) {
                                if (opcao == 'editar') {
                                  _editarPet(indiceOriginal);
                                }

                                if (opcao == 'adotado') {
                                  _marcarComoAdotado(indiceOriginal);
                                }

                                if (opcao == 'excluir') {
                                  _excluirPet(indiceOriginal);
                                }
                              },
                              itemBuilder: (context) {
                                return [
                                  const PopupMenuItem(
                                    value: 'editar',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit),
                                        SizedBox(width: 8),
                                        Text('Editar'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'adotado',
                                    child: Row(
                                      children: [
                                        Icon(Icons.check_circle),
                                        SizedBox(width: 8),
                                        Text('Marcar como adotado'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'excluir',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text('Excluir'),
                                      ],
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: _abrirPetsAdotados,
              icon: const Icon(Icons.home),
              label: const Text('Pets adotados'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: _adicionarPet,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar pet'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
