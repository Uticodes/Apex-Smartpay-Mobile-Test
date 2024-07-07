class OnboardingModel {
  final String title, subTitle, imagePathOne, imagePathTwo, index;

  OnboardingModel(
    this.title,
    this.subTitle,
    this.imagePathOne,
    this.imagePathTwo,
    this.index,
  );
}

List<OnboardingModel> onboardingItemList = [
  OnboardingModel(
    'Finance app the safest and most trusted',
    'Your finance work starts here. Our here to help you track and deal with speeding up your transactions.',
    'assets/png/ic_onboarding_device_one.png',
    'assets/png/ill_onboarding_one.png',
    '1',
  ),
  OnboardingModel(
    'The fastest transaction process only here',
    'Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.',
    'assets/png/ic_onboarding_device_two.png',
    'assets/png/ill_onboarding_two.png',
    '2',
  )
];
