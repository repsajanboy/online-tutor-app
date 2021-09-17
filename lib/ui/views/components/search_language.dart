import 'package:flutter/material.dart';
import 'package:justlearn/business_logic/models/languageList/language_list_model.dart';
import 'package:justlearn/services/languageList/language_list_provider.dart';
import 'package:justlearn/services/tutors/tutors_list_api.dart';
import 'package:justlearn/ui/views/screens/tutors_screen.dart';
import 'package:provider/provider.dart';

class SearchLanguageDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final _languageListProvider =
        Provider.of<LanguageListProvider>(context, listen: false);
    final _tutorListProvider =
        Provider.of<TutorsListApi>(context, listen: false);
    final suggestionList = _languageListProvider.languageRes
        .where((p) => p.isoName.contains(query))
        .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        LanguageResult _language = suggestionList[index];
        return ListTile(
          onTap: () {
            print(_language.iso);
            _languageListProvider.selectLanguage(_language);
            _tutorListProvider.clearData();
            _tutorListProvider.getNativeTutorsList(_language.iso);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TutorsScreen(),
              ),
            );
          },
          leading: Icon(Icons.language),
          title: Text('${_language.isoName}'),
        );
      },
    );
  }
}
