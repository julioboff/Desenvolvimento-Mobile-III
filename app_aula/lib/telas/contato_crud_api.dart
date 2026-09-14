import 'package:app_aula/api/contato_helper_api.dart';
import 'package:app_aula/model/contato.dart';
import 'package:flutter/material.dart';

class ContatoCrusAPIPage extends StatefulWidget {
  const ContatoCrusAPIPage({super.key});

  @override
  State<ContatoCrusAPIPage> createState() => _ContatoCrusAPIPageState();
}

class _ContatoCrusAPIPageState extends State<ContatoCrusAPIPage> {
  List<Contato> lista = [];
  Contato? selecionado;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _editarFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _carregarLista();
  }

  void _carregarLista() async {
    final dados = await ContatoApi().getAll();
    setState(() {
      lista = dados;
    });
  }

  void _inserirOuEditar({Contato? selecionado}) async {
    setState(() {
      this.selecionado = selecionado;
    });
    await showDialog(
      context: context,
      builder: (context) => dialogEditarWidget(),
    );
  }

  void _salvar() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro nos dados. Verifique.')),
      );
      return;
    }

    if (selecionado!.id == null) {
      await ContatoApi().insert(selecionado!);
    } else {
      await ContatoApi().update(selecionado!);
    }

    _carregarLista();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Dados salvos com sucesso!')));
    Navigator.pop(context);
  }

  void _excluir() async {
    await ContatoApi().delete(selecionado!.id!);
    _carregarLista();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Excluído com sucesso!')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          scrollDirection: Axis.vertical,
          children: lista
              .map(
                (obj) => ListTile(
                  leading: Icon(Icons.person),
                  title: Row(
                    children: [
                      SizedBox(width: 150, child: Text('${obj.nome}')),
                      Text('Email ${obj.email}'),
                    ],
                  ),

                  onTap: () => _inserirOuEditar(selecionado: obj),
                ),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _inserirOuEditar(selecionado: Contato()),
        child: const Icon(Icons.person_add),
      ),
    );
  }

  Widget dialogEditarWidget() {
    return AlertDialog(
      title: Text(selecionado!.id == null ? 'Novo Usuário' : 'Editar Usuário'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Digite o nome do usuário',
                  border: OutlineInputBorder(),
                ),
                focusNode: _editarFocusNode,
                initialValue: selecionado!.nome,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome do usuário deve ser preenchido.';
                  }
                  if (value.length < 2) {
                    return 'O nome do usuário deve ter pelo menos 2 caracteres.';
                  }
                  selecionado!.nome = value;
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Digite o e-mail',
                  border: OutlineInputBorder(),
                ),
                initialValue: selecionado!.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O e-mail do usuário deve ser preenchido.';
                  }
                  if (value.length < 2) {
                    return 'O e-mail do usuário deve ter pelo menos 2 caracteres.';
                  }
                  selecionado!.email = value;
                  return null;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Digite a senha',
                  border: OutlineInputBorder(),
                ),
                initialValue: selecionado!.telefone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O telefone do usuário deve ser preenchido.';
                  }
                  if (value.length < 10) {
                    return 'O telefone do usuário deve ter pelo menos 10 caracteres.';
                  }
                  selecionado!.telefone = value;
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton.icon(
          icon: const Icon(Icons.save),
          onPressed: () async {
            _salvar();
          },
          label: const Text('Salvar'),
        ),
        TextButton.icon(
          icon: const Icon(Icons.cancel),
          onPressed: () => Navigator.pop(context),
          label: const Text('Cancelar'),
        ),
        TextButton.icon(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _excluir(),
          label: const Text(
            'Excluir',
            style: TextStyle(fontSize: 14, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
