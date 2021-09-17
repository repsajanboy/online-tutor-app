class ColorsModel {
  int startButton;
  int restartButton;
  int caHighlight;
  int highlightTab;
  int todayProfBg;
  ChoiceButton choices;

  ColorsModel(
      {this.startButton,
      this.restartButton,
      this.caHighlight,
      this.highlightTab,
      this.todayProfBg,
      this.choices});
}

class ChoiceButton {
  int choice1;
  int choice2;
  int choice3;
  int choice4;

  ChoiceButton({this.choice1, this.choice2, this.choice3, this.choice4});
}
