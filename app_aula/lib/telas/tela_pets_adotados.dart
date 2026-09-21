import 'package:flutter/material.dart';

class TelaPetsAdotados extends StatefulWidget {
  final List<Map<String, dynamic>> petsAdotados;

  const TelaPetsAdotados({super.key, required this.petsAdotados});

  @override
  State<TelaPetsAdotados> createState() => _TelaPetsAdotadosState();
}

class _TelaPetsAdotadosState extends State<TelaPetsAdotados> {
  late List<Map<String, dynamic>> petsAdotados;

  @override
  void initState() {
    super.initState();
    petsAdotados = List.from(widget.petsAdotados);
  }

  void _voltarParaDisponiveis(int index) {
    final pet = petsAdotados[index];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Voltar para disponíveis'),
          content: Text(
            'Deseja marcar "${pet['nome']}" novamente como disponível para adoção?',
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
                setState(() {
                  petsAdotados.removeAt(index);
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

  void _excluirPet(int index) {
    final nomePet = petsAdotados[index]['nome'];

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
                  petsAdotados.removeAt(index);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pets adotados'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pets que já foram adotados',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: petsAdotados.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum pet foi adotado ainda.',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: petsAdotados.length,
                      itemBuilder: (context, index) {
                        final pet = petsAdotados[index];

                        return Card(
                          child: ListTile(
                            leading: const Icon(
                              Icons.home,
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
                                if (opcao == 'disponivel') {
                                  _voltarParaDisponiveis(index);
                                }

                                if (opcao == 'excluir') {
                                  _excluirPet(index);
                                }
                              },
                              itemBuilder: (context) {
                                return [
                                  const PopupMenuItem(
                                    value: 'disponivel',
                                    child: Row(
                                      children: [
                                        Icon(Icons.undo),
                                        SizedBox(width: 8),
                                        Text('Marcar como disponível'),
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
          ],
        ),
      ),
    );
  }
}
