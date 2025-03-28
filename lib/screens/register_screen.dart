import 'package:crudtutorial/api/users.dart';
import 'package:crudtutorial/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:crudtutorial/utils/helpers/snackbar_helper.dart';

import '../components/app_text_form_field.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_constants.dart';
import '../values/app_regex.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  String? selectedPosition;
  bool isLoading = false;

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  register() async {
    setState(() => isLoading = true);
    fieldValidNotifier.value = false;
    print('test');
    var response = await ApiService.registerUser(nameController.text, emailController.text, passwordController.text, selectedPosition!); 
    setState(() => isLoading = false);

    if(response['status_code'] == 201){
      SnackbarHelper.showSnackBar(response['message'], backgroundColor: AppColors.successResponse);
      NavigationHelper.pushReplacementNamed(AppRoutes.login);
    }
    else {
      SnackbarHelper.showSnackBar(response['message'], backgroundColor: AppColors.errorResponse); 
      Future.delayed(const Duration(milliseconds: 2500),(){
        fieldValidNotifier.value = true;
      }); 
    }
  }

  void initializeControllers() {
    nameController = TextEditingController()..addListener(controllerListener);
    emailController = TextEditingController()..addListener(controllerListener);
    passwordController = TextEditingController()..addListener(controllerListener);
    confirmPasswordController = TextEditingController()..addListener(controllerListener);
  }

  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void controllerListener() {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty &&
        email.isEmpty &&
        password.isEmpty &&
        confirmPassword.isEmpty) return;

    if (AppRegex.emailRegex.hasMatch(email) &&
        AppRegex.passwordRegex.hasMatch(password) &&
        AppRegex.passwordRegex.hasMatch(confirmPassword)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Stack(
        children: [
          if (isLoading)
            Positioned.fill(
              child: Container( 
                color: Colors.white,
                child: Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                )),
              ),
            ),

        //main content  
        ListView(
            children: [ 
              const GradientBackground(
                children: [
                  Text(AppStrings.register, style: AppTheme.titleLarge),
                  SizedBox(height: 4),
                  Text(AppStrings.createYourAccount, style: AppTheme.bodySmall),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      
                      //name
                      AppTextFormField(
                        autofocus: true,
                        labelText: AppStrings.name,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterName
                              : value.length < 4
                                  ? AppStrings.invalidName
                                  : null;
                        },
                        controller: nameController,
                      ),

                      // email
                      AppTextFormField(
                        labelText: AppStrings.email,
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterEmailAddress
                              : AppConstants.emailRegex.hasMatch(value)
                                  ? null
                                  : AppStrings.invalidEmailAddress;
                        },
                      ),

                      //password
                      ValueListenableBuilder<bool>(
                        valueListenable: passwordNotifier,
                        builder: (_, passwordObscure, __) {
                          return AppTextFormField(
                            obscureText: passwordObscure,
                            controller: passwordController,
                            labelText: AppStrings.password,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (_) => _formKey.currentState?.validate(),
                            validator: (value) {
                              return value!.isEmpty
                                  ? AppStrings.pleaseEnterPassword
                                  : AppConstants.passwordRegex.hasMatch(value)
                                      ? null
                                      : AppStrings.invalidPassword;
                            },
                            suffixIcon: Focus(
                              /// If false,
                              ///
                              /// disable focus for all of this node's descendants
                              descendantsAreFocusable: false,

                              /// If false,
                              ///
                              /// make this widget's descendants un-traversable.
                              // descendantsAreTraversable: false,
                              child: IconButton(
                                onPressed: () =>
                                    passwordNotifier.value = !passwordObscure,
                                style: IconButton.styleFrom(
                                  minimumSize: const Size.square(48),
                                ),
                                icon: Icon(
                                  passwordObscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      //confirm password
                      ValueListenableBuilder(
                        valueListenable: confirmPasswordNotifier,
                        builder: (_, confirmPasswordObscure, __) {
                          return AppTextFormField(
                            labelText: AppStrings.confirmPassword,
                            controller: confirmPasswordController,
                            obscureText: confirmPasswordObscure,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (_) => _formKey.currentState?.validate(),
                            validator: (value) {
                              return value!.isEmpty
                                  ? AppStrings.pleaseReEnterPassword
                                  : AppConstants.passwordRegex.hasMatch(value)
                                      ? passwordController.text ==
                                              confirmPasswordController.text
                                          ? null
                                          : AppStrings.passwordNotMatched
                                      : AppStrings.invalidPassword;
                            },
                            suffixIcon: Focus(
                              /// If false,
                              ///
                              /// disable focus for all of this node's descendants.
                              descendantsAreFocusable: false,

                              /// If false,
                              ///
                              /// make this widget's descendants un-traversable.
                              // descendantsAreTraversable: false,
                              child: IconButton(
                                onPressed: () => confirmPasswordNotifier.value =
                                    !confirmPasswordObscure,
                                style: IconButton.styleFrom(
                                  minimumSize: const Size.square(48),
                                ),
                                icon: Icon(
                                  confirmPasswordObscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      
                      RadioListTile(
                        title: Text("Admin"),
                        value: "admin",
                        groupValue: selectedPosition,
                        onChanged: (value) {
                          setState(() {
                            selectedPosition = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text("Supervisor"),
                        value: "supervisor",
                        groupValue: selectedPosition,
                        onChanged: (value) {
                          setState(() {
                            selectedPosition = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text("Staff"),
                        value: "staff",
                        groupValue: selectedPosition,
                        onChanged: (value) {
                          setState(() {
                            selectedPosition = value.toString();
                          });
                        },
                      ),
                      

                      // submit button
                      ValueListenableBuilder(
                        valueListenable: fieldValidNotifier,
                        builder: (_, isValid, __) {
                          return FilledButton(
                            onPressed: isValid || !isLoading
                                ? () async { 
                                  await register();
                                }
                                : null, 
                            child: const Text(AppStrings.register),
                          );
                        },
                      ), 
                    ], 
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.iHaveAnAccount,
                    style: AppTheme.bodySmall.copyWith(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () => NavigationHelper.pushReplacementNamed(AppRoutes.login),
                    child: const Text(AppStrings.login),
                  ),
                ],
              ), 
            ],  
          ),
         
        ],
      ),
    );
  }
}
