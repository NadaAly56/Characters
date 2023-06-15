import 'package:bloc/bloc.dart';
import 'package:bloc_state_management/data/repository/characters_repo.dart';
import 'package:meta/meta.dart';

import '../../data/models/characters_model.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepo charactersRepo;
  List<CharactersModel> characters = [];
  CharactersCubit(this.charactersRepo) : super(CharactersInitial());

  List<CharactersModel> getCharacters() {
    charactersRepo.getCharacters().then((char) {
      print(char);
      emit(CharactersLoaded(characters: char));
      characters = char;
    });
    return characters;
  }
}
