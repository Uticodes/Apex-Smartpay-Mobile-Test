import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/material.dart';

import '../../../app_theme/app_theme.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_text.dart';

class OnboardingSlider extends StatelessWidget {
  final String? image, title, description;

  const OnboardingSlider(
      {super.key,
      required this.image,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80.0,),
            child: Center(
              child: Image(
                image: AssetImage(image!),
                //fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 4.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 84.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextView(
                text: title ?? '',
                color: AppTheme.darkColor,
                align: TextAlign.center,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          heightMargin(16),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextView(
                text: description ?? '',
                align: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppTheme.greyColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SliderModel {
  String? image;
  String? title;
  String? description;

  // Constructor for variables
  SliderModel({this.title, this.description, this.image});

  void setImage(String getImage) {
    image = getImage;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDescription(String getDescription) {
    description = getDescription;
  }

  String? getImage() {
    return image;
  }

  String? getTitle() {
    return title;
  }

  String? getDescription() {
    return description;
  }
}

// List created
List<SliderModel> getSlides() {
  List<SliderModel> slides = [];
  SliderModel sliderModel = new SliderModel();

  // Item 1
  sliderModel.setImage(AppImages.onBoardingSlice1);
  sliderModel.setTitle(AppStrings.onBoardingTitle1);
  sliderModel.setDescription(AppStrings.onBoardingDescription1);
  slides.add(sliderModel);
  sliderModel = SliderModel();

  // Item 2
  sliderModel.setImage(AppImages.onBoardingSlice2);
  sliderModel.setTitle(AppStrings.onBoardingTitle2);
  sliderModel.setDescription(AppStrings.onBoardingDescription2);
  slides.add(sliderModel);
  sliderModel = SliderModel();

  return slides;
}
