import 'package:app_aula/model/animal.dart';

class AnimalDb {
  static final List<Animal> _animais = [];
  static int _proximoId = 1;

  List<Animal> getAll() {
    final lista = List<Animal>.from(_animais);
    lista.sort((a, b) => a.nome.compareTo(b.nome));
    return lista;
  }

  void insert(Animal animal) {
    animal.id = _proximoId++;
    _animais.add(animal);
  }

  void update(Animal animal) {
    final index = _animais.indexWhere((a) => a.id == animal.id);
    if (index != -1) {
      _animais[index] = animal;
    }
  }

  void delete(int id) {
    _animais.removeWhere((a) => a.id == id);
  }
}
