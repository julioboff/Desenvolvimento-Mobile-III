import 'package:flutter/material.dart';
import 'package:app_aula/telas/tela_cadastro_pet.dart';

class TelaListaPets extends StatefulWidget {
  const TelaListaPets({super.key});

  @override
  State<TelaListaPets> createState() => _TelaListaPetsState();
}

class _TelaListaPetsState extends State<TelaListaPets> {
  final List<Map<String, String>> pets = [
    {'nome': 'Rex', 'especie': 'Cachorro', 'idade': '2 anos'},
    {'nome': 'Luna', 'especie': 'Gata', 'idade': '1 ano'},
    {'nome': 'Thor', 'especie': 'Cachorro', 'idade': '3 anos'},
  ];

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

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: ListView.builder(
                itemCount: pets.length,
                itemBuilder: (context, index) {
                  final pet = pets[index];

                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.pets,
                        size: 45,
                        color: Colors.green,
                      ),
                      title: Text(
                        pet['nome']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${pet['especie']} • ${pet['idade']}'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
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
