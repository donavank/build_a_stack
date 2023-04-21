import 'dart:async';

import '../providers/web_service_provider.dart';
import './pet.dart';

class PetRepository {
  final IWebServiceProvider _provider;

  final StreamController<List<String>> _listStreamController = StreamController();
  final StreamController<Pet> _petStreamController = StreamController();

  List<String> names = [];
  Map<String, Pet> _pets = {};

  get listStream => _listStreamController.stream;
  get petStream => _petStreamController.stream;

  PetRepository(this._provider) {
    Timer.periodic( const Duration(seconds: 1), (timer) => pollPetNames() );
  }

  void pollPetNames() async {
    List<String> newNames = await _provider.getNames();

    if(newNames != names)
    {
      names = newNames;
      _listStreamController.sink.add(names);
    }
  }

  Pet? getPet(String name) {
    Pet? pet = _pets[name];

    if(pet == null) {
      _provider.getPet(name).then((Pet? pet) {
        if (pet == null) {
          return;
        }
        _pets[pet.name] = pet;
        _petStreamController.sink.add(pet);
      });
    }

    return pet;
  }


}