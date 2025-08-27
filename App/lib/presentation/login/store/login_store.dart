// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/domain/usecase/user/get_login_info_usecase.dart';
import 'package:boilerplate/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:boilerplate/domain/usecase/user/save_access_token_usecase.dart';
import 'package:boilerplate/domain/usecase/user/save_login_in_status_usecase.dart';
import 'package:boilerplate/domain/usecase/user/save_login_info_usecase.dart';
import 'package:boilerplate/domain/usecase/user/save_profile_usecase.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entity/user/user.dart';
import '../../../domain/usecase/user/login_usecase.dart';

part 'login_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // constructor:---------------------------------------------------------------
  _UserStore(
    this._isLoggedInUseCase,
    this._saveLoginStatusUseCase,
    this._saveAccessTokenUseCase,
    this._saveProfileUseCase,
    this._saveLoginInfoUseCase,
    this._getLoginInfoUseCase,
    this._loginUseCase,
    this.formErrorStore,
    this.errorStore,
  ) {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    _isLoggedInUseCase.call(params: null).then((value) async {
      isLoggedIn = value;
    });
  }

  // use cases:-----------------------------------------------------------------
  final IsLoggedInUseCase _isLoggedInUseCase;
  final SaveLoginStatusUseCase _saveLoginStatusUseCase;
  final SaveAccessTokenUseCase _saveAccessTokenUseCase;
  final SaveProfileUseCase _saveProfileUseCase;
  final SaveLoginInformationUseCase _saveLoginInfoUseCase;
  final GetLoginInfoUsecase _getLoginInfoUseCase;
  final LoginUseCase _loginUseCase;

  //text controller:------------------------------------------------------------
  late TextEditingController _userEmailController;
  late TextEditingController _passwordController;

  // stores:--------------------------------------------------------------------
  // for handling form errors
  final FormErrorStore formErrorStore;

  // store for handling error messages
  final ErrorStore errorStore;

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() async {
    _userEmailController = TextEditingController(text: email);
    _passwordController = TextEditingController(text: password);

    await getLoginInfo();

    _disposers = [
      reaction((_) => success, (_) => success.value = false, delay: 200),
      reaction((_) => this.isLoggedIn, (p0) async {
        await getLoginInfo();
      }),
      // reaction((_) => this.formErrorStore, (p0) async {
      //   this
      // }),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<UserInfo?> emptyLoginResponse =
      ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  @observable
  bool isLoggedIn = false;

  @observable
  bool isRememberMe = false;

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  Observable<bool> success = Observable(false);

  @observable
  Flushbar flushbar = Flushbar(
    message: '',
  );

  @observable
  ObservableFuture<UserInfo?> loginFuture = emptyLoginResponse;

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  @computed
  TextEditingController get userEmailController => _userEmailController;

  @computed
  TextEditingController get passwordController => _passwordController;

  // actions:-------------------------------------------------------------------
  Future getLoginInfo() async {
    final future = _getLoginInfoUseCase.call(params: 0);
    future.then((value) {
      this.email = value.username;
      this.password = value.password;
    });
  }

  @action
  Future login(String email, String password) async {
    final LoginParams loginParams =
        LoginParams(username: email, password: password);
    final future = _loginUseCase.call(params: loginParams);
    loginFuture = ObservableFuture(future);

    await future.then((value) async {
      await _saveLoginStatusUseCase.call(params: true);
      this.isLoggedIn = true;
      this.success.value = true;
      await _saveAccessTokenUseCase.call(params: value!.accessToken);
      await _saveProfileUseCase.call(params: value);

      if (this.isRememberMe == true) {
        await _saveLoginInfoUseCase.call(params: loginParams);
      }
    }).catchError((e) {
      if (e.runtimeType.toString() != "_TypeError") {
        flushbar = FlushbarHelper.createError(
          title: '',
          message: 'Make sure you use the registered email and password',
          duration: Duration(seconds: 2),
        );
        this.isLoggedIn = false;
        this.success.value = false;
      }
      throw e;
    });
  }

  logout() async {
    this.isLoggedIn = false;
    await _saveLoginStatusUseCase.call(params: false);
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
    _userEmailController.dispose();
    _passwordController.dispose();
  }
}
