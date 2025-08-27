// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:boilerplate/domain/usecase/profile/get_profile_usecase.dart';
import 'package:boilerplate/domain/usecase/profile/logout_account_usecase.dart';
import 'package:mobx/mobx.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  _ProfileStore(this._logoutAccountUseCase, this._getProfileUseCase) {
    _setupDisposers();
  }

  final LogoutAccountUseCase _logoutAccountUseCase;
  final GetProfileUseCase _getProfileUseCase;

  //observable
  @observable
  Profile profile = Profile.empty();

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() async {
    _disposers = [
      autorun((_) => getProfileInfo()),
    ];
  }

  //setter & getter
  static ObservableFuture<void> logoutFuture =
      ObservableFuture<void>.value(null);

  @observable
  ObservableFuture<Profile> fetchProfileFuture =
      ObservableFuture.value(Profile.empty());

  @computed
  bool get loading => fetchProfileFuture.status == FutureStatus.pending;

  //method
  Future<void> logoutAccount() async {
    final future = _logoutAccountUseCase.call(params: null);
    logoutFuture = ObservableFuture(future);

    logoutFuture
        .then(
          (value) {},
        )
        .catchError(
          (err) => throw Exception('Terjadi masalah'),
        );
  }

  Future<void> getProfileInfo() async {
    final future = _getProfileUseCase.call(params: null);
    fetchProfileFuture = ObservableFuture(future);

    fetchProfileFuture.then((value) {
      this.profile = value;
      print('value get store' + value.email);
    }).catchError(
      (err) => throw Exception('Terjadi masalah'),
    );
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

class Profile {
  final String email;
  final String address;
  final String phoneNumber;

  Profile(
      {required this.email, required this.address, required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'address': address,
      'phone_number': phoneNumber,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      email: map['email'] as String,
      address: map['address'] as String,
      phoneNumber: map['phone_number'] as String,
    );
  }

  factory Profile.empty() {
    return Profile(address: '', email: '', phoneNumber: '');
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);
}
