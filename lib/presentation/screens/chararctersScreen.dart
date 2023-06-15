import 'package:bloc_state_management/business/cubit/characters_cubit.dart';
import 'package:bloc_state_management/data/models/characters_model.dart';
import 'package:bloc_state_management/presentation/widgets/characters_item.dart';
import 'package:bloc_state_management/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late List<CharactersModel> allCharacters;
  late List<CharactersModel> searchedCharacters;
  bool _isSearching = false;
  final input = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getCharacters();
  }

  Widget buildSearch() {
    return TextField(
      controller: input,
      cursorColor: MyColors.red,
      decoration: InputDecoration(
          hintText: 'find a character',
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColors.red, fontSize: 15)),
      style: TextStyle(color: MyColors.red, fontSize: 15),
      onChanged: (searched) {
        getSearchedChar(searched);
      },
    );
  }

  void getSearchedChar(String searched) {
    searchedCharacters = allCharacters
        .where((char) => char.name.toLowerCase().startsWith(searched))
        .toList();
    setState(() {});
  }

  List<Widget> buildAction() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(Icons.clear))
      ];
    } else {
      return [IconButton(onPressed: startSearch, icon: Icon(Icons.search))];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void stopSearching() {
    clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      input.clear();
    });
  }

  Widget buildBlockWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = state.characters;
        return buildLoadedListWidget();
      } else {
        return showLoading();
      }
    });
  }

  Widget showLoading() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.red,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.black,
        child: Column(children: [buildCharactersList()]),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: allCharacters.length,
        itemBuilder: (context, index) {
          return CharacterItem(
            character: allCharacters[index],
          );
        });
  }

  Widget buildAppTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: Colors.blueGrey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.red,
        title: _isSearching ? buildSearch() : buildAppTitle(),
        actions: buildAction(),
      ),
    );
  }
}
