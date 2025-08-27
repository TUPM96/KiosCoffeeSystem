// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_UserStore.isLoading'))
      .value;
  Computed<TextEditingController>? _$userEmailControllerComputed;

  @override
  TextEditingController get userEmailController =>
      (_$userEmailControllerComputed ??= Computed<TextEditingController>(
              () => super.userEmailController,
              name: '_UserStore.userEmailController'))
          .value;
  Computed<TextEditingController>? _$passwordControllerComputed;

  @override
  TextEditingController get passwordController =>
      (_$passwordControllerComputed ??= Computed<TextEditingController>(
              () => super.passwordController,
              name: '_UserStore.passwordController'))
          .value;

  late final _$isLoggedInAtom =
      Atom(name: '_UserStore.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$isRememberMeAtom =
      Atom(name: '_UserStore.isRememberMe', context: context);

  @override
  bool get isRememberMe {
    _$isRememberMeAtom.reportRead();
    return super.isRememberMe;
  }

  @override
  set isRememberMe(bool value) {
    _$isRememberMeAtom.reportWrite(value, super.isRememberMe, () {
      super.isRememberMe = value;
    });
  }

  late final _$emailAtom = Atom(name: '_UserStore.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_UserStore.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$successAtom = Atom(name: '_UserStore.success', context: context);

  @override
  Observable<bool> get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(Observable<bool> value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$flushbarAtom =
      Atom(name: '_UserStore.flushbar', context: context);

  @override
  Flushbar<dynamic> get flushbar {
    _$flushbarAtom.reportRead();
    return super.flushbar;
  }

  @override
  set flushbar(Flushbar<dynamic> value) {
    _$flushbarAtom.reportWrite(value, super.flushbar, () {
      super.flushbar = value;
    });
  }

  late final _$loginFutureAtom =
      Atom(name: '_UserStore.loginFuture', context: context);

  @override
  ObservableFuture<UserInfo?> get loginFuture {
    _$loginFutureAtom.reportRead();
    return super.loginFuture;
  }

  @override
  set loginFuture(ObservableFuture<UserInfo?> value) {
    _$loginFutureAtom.reportWrite(value, super.loginFuture, () {
      super.loginFuture = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_UserStore.login', context: context);

  @override
  Future<dynamic> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn},
isRememberMe: ${isRememberMe},
email: ${email},
password: ${password},
success: ${success},
flushbar: ${flushbar},
loginFuture: ${loginFuture},
isLoading: ${isLoading},
userEmailController: ${userEmailController},
passwordController: ${passwordController}
    ''';
  }
}
