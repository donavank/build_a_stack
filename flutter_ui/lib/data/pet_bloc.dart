import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import './pet_repository.dart';
import './pet.dart';

class PetBloc extends Bloc<PetBlocEvent, PetBlocState> {
  final PetRepository _repository;

  PetBloc(this._repository, PetBlocState initialState) : super(initialState) {
    // Listen on repository streams
    _repository.listStream.listen((names) => add(ListUpdateEvent(names)));
    _repository.petStream.listen((pet) => add(PetLoadedEvent(pet)));

    // Register callbacks for event types
    on<PetLoadedEvent>(_handlePetLoaded);
    on<ListUpdateEvent>((event, emitter) => emitter(PetBlocState.of(state, names: event.names )));
  }

  void _handlePetLoaded(PetLoadedEvent event, Emitter<PetBlocState> emitter) async {
    Pet pet = event.pet;

    if(pet.name == state.currentPet) {
      emitter(PetBlocState.of(state, currentPetData: pet));
    }
  }
}

class PetBlocState {
  List<String> names;
  String currentPet = "";
  Pet? currentPetData;

  PetBlocState(this.names, this.currentPet, this.currentPetData);

  static PetBlocState of(PetBlocState oldState,
      {
        List<String>? names,
        String? currentPet,
        Pet? currentPetData
      }
  ) {

    // Call constructor passing optional arguments if they are not null
    return PetBlocState(names ?? oldState.names, currentPet ?? oldState.currentPet, currentPetData ?? currentPetData);
  }
}

abstract class PetBlocEvent {}

class ListUpdateEvent extends PetBlocEvent {
  List<String> names;

  ListUpdateEvent(this.names);
}

class PetLoadedEvent extends PetBlocEvent {
  Pet pet;

  PetLoadedEvent(this.pet);
}
