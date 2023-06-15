import 'package:bloc_state_management/business/cubit/characters_cubit.dart';
import 'package:bloc_state_management/data/repository/characters_repo.dart';
import 'package:bloc_state_management/data/services/characters_services.dart';
import 'package:bloc_state_management/presentation/screens/characters_details.dart';
import 'package:flutter/material.dart';
import 'package:bloc_state_management/presentation/screens/chararctersScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App_Router {
  late CharactersRepo charactersRepo;
  late CharactersCubit charactersCubit;

  App_Router() {
    charactersRepo = CharactersRepo(charactersServices: CharactersServices());
    charactersCubit = CharactersCubit(charactersRepo);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      CharactersCubit(charactersRepo),
                  child: CharacterScreen(),
                ));

      case 'character_detailes':
        return MaterialPageRoute(builder: (_) => CharacterDetailesScreen());
    }
  }
}
