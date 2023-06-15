// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_state_management/data/services/characters_services.dart';
import 'package:bloc_state_management/data/models/characters_model.dart';

class CharactersRepo {
  final CharactersServices charactersServices;
  CharactersRepo({
    required this.charactersServices,
  });

  Future<List<CharactersModel>> getCharacters() async {
    final characters = await charactersServices.getCharacters();
    return characters.map((char) => CharactersModel.fromJson(char)).toList();
  }
}
