class OnBoardingInstructions {
  final String image, heading, title, subtitle;

  OnBoardingInstructions(this.image, this.heading, this.title, this.subtitle);
}

List<OnBoardingInstructions> onBoardingInstructions = [
  OnBoardingInstructions(
    "assets/images/home/Home1.svg",
    "施術を探そう",
    "日記を読んで自分の悩みを解決する\n施術を見つける",
    "",
  ),
  OnBoardingInstructions(
    "assets/images/home/Home2.svg",
    "   したい施術の名医や\n人気クリニックが簡単に見つかる",
    "日記や評価から簡単に自分にあった\nドクターやクリニックが見つかります",
    "",
  ),
  OnBoardingInstructions( 
    "assets/images/home/Home3.svg",
    "電話不要！たった1分で予約が完了",
    "アプリから簡単に自分が希望するドクター\nを予約することができます",
    "",
  ),
  OnBoardingInstructions(
    "assets/images/home/Home4.svg",
    "みんなに共有しよう",
    "自分が受けた施術の日記を書いてみんな\nに教えてあげよう",
    "",
  ),
];
