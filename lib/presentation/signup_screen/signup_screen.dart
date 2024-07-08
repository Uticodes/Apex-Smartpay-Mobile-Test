import 'package:apex_smartpay_mobile_test/data/models/country_model.dart';
import 'package:apex_smartpay_mobile_test/presentation/signup_screen/cubit/signup_cubit.dart';
import 'package:apex_smartpay_mobile_test/presentation/signup_screen/cubit/signup_state.dart';
import 'package:apex_smartpay_mobile_test/utils/extension_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_theme/app_theme.dart';
import '../../di/injection.dart';
import '../../utils/app_images.dart';
import '../../utils/app_toolbar.dart';
import '../../utils/constants.dart';
import '../../utils/custom_app_button.dart';
import '../../utils/custom_text_field.dart';
import '../../utils/loader.dart';
import '../../utils/softkey_focus.dart';
import '../../utils/validations.dart';
import '../set_pin_screen/set_pin_screen.dart';
import 'country_list_widget.dart';
import 'country_view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.email});

  final String email;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _cubit = getIt.get<SignUpCubit>();
  final _formKey = GlobalKey<FormState>();
  late Future<List<CountryModel>> countriesFuture;
  List<CountryModel> countries = [];
  List<CountryModel> filteredCountries = [];
  CountryModel? selectedCountry;
  String? _selectedOption;
  int selectedCountryIndex = -1;
  final _fullNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _countryController = TextEditingController();

  String get _fullName => _fullNameController.text.trim();

  String get firstName {
    final nameParts = _fullName.split(" ");
    return nameParts.isNotEmpty ? nameParts.first : "";
  }

  String get _username => _userNameController.text.trim();

  String get _password => _passwordController.text.trim();

  String get _country => _countryController.text.trim();

  bool enableButton() {
    final fullName = isValidFullName(_fullName);
    final username = _username.isNotEmpty;
    final password = isValidPassword(_password);
    final country = _country.isNotEmpty;

    return fullName && username && password && country;
  }

  @override
  void initState() {
    super.initState();
    preloadCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<SignUpCubit, SignUpState>(
        bloc: _cubit,
        listener: (context, state) {
          state.maybeWhen(
            error: (errorMessage, errors) {
              handleError(errorMessage, errors: errors);
            },
            success: (response) {
              context.push(SetPinScreen(firstName: firstName,));
              setState(() {});
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return SafeArea(
              child: state.maybeWhen(
                  loading: () => const LoadingView(),
                  orElse: () {
                    return SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 10),
                          child: Column(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                heightMargin(8),
                                const AppToolbar(
                                  shouldPopBack: true,
                                ),
                                heightMargin(24),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, right: 4),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      RichText(
                                        text: const TextSpan(
                                          text: "Hey there! tell us a bit \n",
                                          style: TextStyle(
                                            fontFamily: fontFamily,
                                            fontSize: 24,
                                            color: AppTheme.darkColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "about",
                                              style: TextStyle(
                                                fontFamily: fontFamily,
                                                fontSize: 24,
                                                color: AppTheme.darkColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " yourself",
                                              style: TextStyle(
                                                fontFamily: fontFamily,
                                                fontSize: 24,
                                                color: AppTheme.darkBlueColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      heightMargin(30),
                                      CustomTextField(
                                        controller: _fullNameController,
                                        hintText: "Full name",
                                        validator: fullNameTextFieldValidator,
                                        onChanged: (_) => setState(() {}),
                                      ),
                                      heightMargin(16),
                                      CustomTextField(
                                        controller: _userNameController,
                                        hintText: "Username",
                                        validator: usernameTextFieldValidator,
                                        onChanged: (_) => setState(() {}),
                                      ),
                                      heightMargin(16),
                                      CountryList(
                                        onTap: () {
                                          showCountryListBottomSheet(
                                              context, countries,
                                                  (country) {
                                                selectedCountry = country;
                                                _selectedOption = country.code;
                                                _countryController.text =
                                                    country.name;
                                                debugPrint(
                                                    "Get country: ${country
                                                        .name}");
                                                setState(() {});
                                              });
                                        },
                                        countryName: selectedCountry?.name ??
                                            "",
                                        countryFlag: selectedCountry?.flag ??
                                            "",
                                        countryCode: selectedCountry?.code ??
                                            "",
                                        selected: _selectedOption
                                            .toString()
                                            .isNotEmpty,
                                        controller: _countryController,
                                      ),
                                      heightMargin(16),
                                      CustomTextField(
                                        controller: _passwordController,
                                        hintText: "Password",
                                        validator: passwordTextFieldValidator,
                                        textInputAction: TextInputAction.done,
                                        isPasswordField: true,
                                        onChanged: (_) => setState(() {}),
                                      ),
                                      heightMargin(30),
                                      AppButton(
                                        onPressed: () {
                                          hideKeyboard(context);
                                          _cubit.registerUser(
                                              fullName: _fullName,
                                              userName: _username,
                                              email: widget.email,
                                              country: selectedCountry!.code.toString(),
                                              password: _password);
                                        },
                                        title: "Sign Up",
                                        isEnabled: enableButton(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    );
                  })
          );
        },
      ),
    );
  }

  Future<void> preloadCountries() async {
    try {
      countries = await loadCountries();
      filteredCountries = countries;
      setState(() {});
    } catch (error) {
      debugPrint('Failed to load countries: $error');
    }
  }

  void filterCountries(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCountries = countries;
      } else {
        filteredCountries = countries
            .where((country) =>
        country.name.toLowerCase().contains(query.toLowerCase()) ||
            country.code.toLowerCase().contains(query.toLowerCase()) ||
            country.dialCode.contains(query))
            .toList();
      }
    });
  }

  void resetFilter() {
    setState(() {
      filteredCountries = countries;
    });
  }

  void showCountryListBottomSheet(BuildContext context,
      List<CountryModel> countries, Function(CountryModel) countrySelected) {
    final searchController = TextEditingController();
    showModalBottomSheet(
      elevation: 10,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 617,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    heightMargin(32),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 56,
                            child: Center(
                              child: CustomTextField(
                                controller: searchController,
                                hintText: "Search",
                                // validator: usernameTextFieldValidator,
                                prefixIcon:
                                SvgPicture.asset(AppImages.searchIcon),
                                onChanged: (value) {
                                  filterCountries(value);
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                        widthMargin(9),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    heightMargin(20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = filteredCountries[index];
                          return GestureDetector(
                            onTap: () {
                              selectedCountryIndex = index;
                              selectedCountry = country;
                              setState(() {
                                _selectedOption = country.code;
                                _countryController.text = country.name;
                              });
                              countrySelected(country);
                              debugPrint(
                                  "Clicked country selected: $country| ${country
                                      .name}");
                              Navigator.of(context).pop(selectedCountry);
                              filteredCountries = [];
                            },
                            child: CountryView(
                              countryName: country.name,
                              countryFlag: country.flag,
                              countryCode: country.code,
                              index: selectedCountryIndex == index,
                              isSelected: _selectedOption
                                  .toString()
                                  .isNotEmpty,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      resetFilter();
    });
  }
}
