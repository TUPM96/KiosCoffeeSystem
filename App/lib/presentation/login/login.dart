import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/core/widgets/app_icon_widget.dart';
import 'package:boilerplate/core/widgets/empty_app_bar_widget.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/core/widgets/rounded_button_widget.dart';
import 'package:boilerplate/core/widgets/textfield_widget.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/utils/conversion/extensions.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../di/service_locator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //stores:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final FormStore _formStore = getIt<FormStore>();
  final UserStore _userStore = getIt<UserStore>();

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  //ui state :-----------------------------------------------------------------
  late AppLocalizations locale;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    // _userEmailController =
  }

  @override
  void didChangeDependencies() {
    locale = context.appLocale;
    _formStore.setUserId(_userStore.email);
    _formStore.setPassword(_userStore.password);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: Stack(
        children: <Widget>[
          Center(child: _buildRightSide()),
          Observer(
            builder: (context) {
              return _userStore.isLoggedIn
                  ? navigate(context)
                  : _showErrorMessage(_formStore.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _userStore.isLoading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildRightSide() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppIconWidget(image: Assets.appLogo),
            _buildOnboardingButton(),
            SizedBox(height: 24.0),
            _buildUserIdField(),
            _buildPasswordField(),
            _buildRememberMeButton(),
            SizedBox(
              height: context.mediaQuery.size.height * .05,
            ),
            _buildSignInButton()
          ],
        ),
      ),
    );
  }

  Widget _buildUserIdField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          title: 'User Name',
          hint: locale.translate('login_et_user_email'),
          inputType: TextInputType.emailAddress,
          icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _userStore.userEmailController,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setUserId(value);
          },
          errorText: _formStore.formErrorStore.userEmail,
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          title: 'Password',
          hint: locale.translate('login_et_user_password'),
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          inputAction: TextInputAction.none,
          icon: Icons.lock,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _userStore.passwordController,
          // focusNode: _passwordFocusNode,
          errorText: _formStore.formErrorStore.password,
          onChanged: (value) {
            _formStore.setPassword(value);
          },
        );
      },
    );
  }

  Widget _buildRememberMeButton() {
    return Align(
      alignment: FractionalOffset.centerLeft,
      child: CheckboxListTile(
        value: _userStore.isRememberMe,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
        dense: true,
        checkColor: Colors.white,
        activeColor: AppColors.successColor,
        title: Transform.translate(
          offset: Offset(-Dimens.horizontal_padding, 0),
          child: Text(
            locale.translate('login_btn_remember_me'),
            style: context.textTheme.labelMedium,
          ),
        ),
        onChanged: (value) {
          setState(() {
            _userStore.isRememberMe = !_userStore.isRememberMe;
          });
        },
      ),
    );
  }

  Widget _buildSignInButton() {
    return RoundedButtonWidget(
      buttonText: locale.translate('login_btn_sign_in'),
      textColor: Colors.white,
      onPressed: () async {
        print('in page' + _formStore.userEmail.toString());
        print('in page' + _formStore.password.toString());

        if (_formStore.userEmail.isNotEmpty && _formStore.password.isNotEmpty) {
          DeviceUtils.hideKeyboard(context);
          _userStore.login(_userStore.userEmailController.text,
              _userStore.passwordController.text);
        } else {
          _showErrorMessage('Please fill in all fields');
        }
      },
    );
  }

  Widget _buildOnboardingButton() {
    return Column(
      children: [
        Text(
          locale.translate('login_title'),
          style: context.textTheme.titleLarge,
        ),
        Text(
          locale.translate('login_subtitle'),
          style: context.textTheme.bodyMedium,
        )
      ],
    );
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
    });

    return Container();
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: locale.translate('home_tv_error'),
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  onCheckboxChanged(bool value) {}

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
