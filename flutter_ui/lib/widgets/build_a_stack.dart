import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/pet_repository.dart';
import '../data/pet_bloc.dart';

class BuildAStack extends StatelessWidget {
  final PetRepository _petRepository;
  const BuildAStack(this._petRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    String initialName = _petRepository.names.isEmpty ? "" : _petRepository.names.first;

    PetBlocState initialState = PetBlocState(_petRepository.names, initialName, _petRepository.getPet(initialName));

    return BlocProvider<PetBloc>(
        create: (context) => PetBloc(_petRepository, initialState),
        child: MaterialApp(
          title: "Build-A-Stack",
          home: Scaffold(
            appBar: AppBar(
              title: Text("Build-A-Stack Pets"),
            ),
            body: BlocBuilder<PetBloc, PetBlocState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: ListView(
                          children: createListRows(state)
                      )
                    ),
                    Flexible(
                      flex: 3,
                      child: PetInfoView( state.currentPetData )
                    )
                  ]
                );
              }
            )
          )
      )
    );
  }

  List<Widget> createListRows(PetBlocState state) {
    List<Widget> rows = [];

    for(String pet in state.names)
    {
      rows.add(Text(pet));
    }

    return rows;
  }
}