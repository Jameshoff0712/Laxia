class OnBoardingInstructions {
  final String image, heading ,title, subtitle;

  OnBoardingInstructions(this.image, this.heading, this.title, this.subtitle);
}

List<OnBoardingInstructions> onBoardingInstructions = [
  OnBoardingInstructions(
    "assets/images/onboard1.png",
    "Welcome",
    "to Digital Clinic",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Asperiores porro distinctio nemo excepturi labore?",
  ),
  OnBoardingInstructions(
    "assets/images/onboard2.png",
    "Ask",
    "a Doctor Online",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Asperiores porro distinctio nemo excepturi labore?",
  ),
  OnBoardingInstructions(
    "assets/images/onboard3.png",
    "Physician",
    "on You Doorstep",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Asperiores porro distinctio nemo excepturi labore?",
  ),
];
