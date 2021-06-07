class OnboardingModel {
  String image;
  String text;
  String title;

  OnboardingModel({this.image, this.text, this.title});
  static List<OnboardingModel> list = [
    OnboardingModel(
      image: "assets/skip/book1.png",
      title: "Get Books",
      text: "You can find your all Favorite Books with highest rating",
    ),
    OnboardingModel(
      image: "assets/skip/searching.png",
      title: "Discover",
      text:
          "Discover your favorite book became easy now, you just need to write your book name and find it",
    ),
    OnboardingModel(
      image: "assets/skip/Booklover.png",
      title: "Favorite",
      text:
          "Search for the books you know you like, and put it in Favorite list and Save List",
    ),
  ];
}
