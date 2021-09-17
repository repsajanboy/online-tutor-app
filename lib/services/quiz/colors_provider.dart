import 'package:justlearn/business_logic/models/quiz/colors_model.dart';

class ColorsProvider {
  Future<ColorsModel> get setColors async {
    // RemoteConfigService rcService = await RemoteConfigService.getInstance();

    ChoiceButton choiceButton = new ChoiceButton(
        choice1: 0xFF0071C0,
        choice2: 0xFFF44336,
        choice3: 0xFF7030A1,
        choice4: 0xFFFDC101);
    ColorsModel cm = new ColorsModel(
        startButton: 0xFF32a83a,
        restartButton: 0xFF32a83a,
        caHighlight: 0xFF32a83a,
        highlightTab: 0xFF32a83a,
        todayProfBg: 0xFFFFFFFF,
        choices: choiceButton);

    return cm;
  }
}
