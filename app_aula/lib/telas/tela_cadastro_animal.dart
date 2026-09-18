import 'package:flutter/material.dart';
import 'package:app_aula/db/animal_db.dart';
import 'package:app_aula/model/animal.dart';

class TelaCadastroAnimal extends StatefulWidget {
  final Animal? animal;

  const TelaCadastroAnimal({super.key, this.animal});

  @override
  State<TelaCadastroAnimal> createState() => _TelaCadastroAnimalState();
}

class _TelaCadastroAnimalState extends State<TelaCadastroAnimal> {
  final _formKey = GlobalKey<FormState>();
  final _animalDb = AnimalDb();

  late TextEditingController _nomeController;
  late TextEditingController _especieController;
  late TextEditingController _racaController;
  late TextEditingController _idadeController;
  late TextEditingController _pelagemController;
  late TextEditingController _pesoController;
  late TextEditingController _observacoesController;

  bool get _editando => widget.animal != null;

  @override
  void initState() {
    super.initState();
    final a = widget.animal;
    _nomeController = TextEditingController(text: a?.nome ?? '');
    _especieController = TextEditingController(text: a?.especie ?? '');
    _racaController = TextEditingController(text: a?.raca ?? '');
    _idadeController = TextEditingController(text: a?.idade.toString() ?? '');
    _pelagemController = TextEditingController(text: a?.pelagem ?? '');
    _pesoController = TextEditingController(text: a?.peso.toString() ?? '');
    _observacoesController = TextEditingController(text: a?.observacoes ?? '');
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;

    final nome = _nomeController.text.trim();
    final especie = _especieController.text.trim();
    final raca = _racaController.text.trim();
    final idade = int.parse(_idadeController.text.trim());
    final pelagem = _pelagemController.text.trim();
    final peso = double.parse(_pesoController.text.trim().replaceAll(',', '.'));
    final observacoes = _observacoesController.text.trim();

    if (_editando) {
      final animal = widget.animal!;
      animal.nome = nome;
      animal.especie = especie;
      animal.raca = raca;
      animal.idade = idade;
      animal.pelagem = pelagem;
      animal.peso = peso;
      animal.observacoes = observacoes;
      _animalDb.update(animal);
    } else {
      final animal = Animal(
        nome: nome,
        especie: especie,
        raca: raca,
        idade: idade,
        pelagem: pelagem,
        peso: peso,
        observacoes: observacoes,
      );
      _animalDb.insert(animal);
    }

    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _especieController.dispose();
    _racaController.dispose();
    _idadeController.dispose();
    _pelagemController.dispose();
    _pesoController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editando ? 'Editar Animal' : 'Cadastrar Animal'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Informe o nome' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _especieController,
              decoration: const InputDecoration(
                labelText: 'Espécie (ex: Cachorro, Gato)',
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Informe a espécie' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _racaController,
              decoration: const InputDecoration(labelText: 'Raça'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Informe a raça' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _idadeController,
              decoration: const InputDecoration(labelText: 'Idade (anos)'),
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Informe a idade';
                if (int.tryParse(v.trim()) == null) return 'Idade inválida';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _pelagemController,
              decoration: const InputDecoration(
                labelText: 'Pelagem (ex: Curta, Longa, Sem pelo)',
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Informe a pelagem' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _pesoController,
              decoration: const InputDecoration(labelText: 'Peso (kg)'),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Informe o peso';
                if (double.tryParse(v.trim().replaceAll(',', '.')) == null) {
                  return 'Peso inválido';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _observacoesController,
              decoration: const InputDecoration(labelText: 'Observações'),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _salvar,
              child: Text(_editando ? 'Salvar alterações' : 'Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
