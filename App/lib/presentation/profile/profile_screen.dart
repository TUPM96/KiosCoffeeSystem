import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/widgets/app_bar_widget.dart';
import 'package:boilerplate/core/widgets/readonly_textfield.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/presentation/profile/store/profile_store.dart';
import 'package:boilerplate/utils/conversion/extensions.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileStore _profileStore = getIt<ProfileStore>();
  final UserStore _userStore = getIt<UserStore>();
  final ThemeStore _themeStore = getIt<ThemeStore>();

  late final TextEditingController _emailController;
  late final TextEditingController _addressController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_profileStore.loading) {
      print('kepanggil ga?');
      _profileStore.getProfileInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_profileStore.profile.email);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppBar(
          trKey: 'home_profile',
          suffix: '',
        ),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              minRadius: 70,
            ),
            Dimens.vSpaceRegular,
            Text('Rizal Heryadi', style: context.textTheme.headlineSmall),
            Dimens.vSpaceLarge,
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            runSpacing: 10.0,
            children: [
              ReadOnlyTextFieldWidget(
                _profileStore.profile.email,
                icon: Icons.email,
                hintText: 'Email Here',
              ),
              ReadOnlyTextFieldWidget(
                _profileStore.profile.address,
                icon: Icons.location_on_sharp,
                hintText: 'Location Here',
              ),
              ReadOnlyTextFieldWidget(
                _profileStore.profile.phoneNumber,
                icon: Icons.phone,
                hintText: 'Phone Here',
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: LimitedBox(
            maxWidth: 600,
            child: ElevatedButton(
              style: context.elevatedButtonTheme.style!.copyWith(
                backgroundColor:
                    MaterialStatePropertyAll(AppColors.logoutColor),
                fixedSize: MaterialStatePropertyAll(
                  Size(context.mediaQuery.size.width, 40),
                ),
              ),
              onPressed: () async {
                await _profileStore.logoutAccount().then((value) {
                  _themeStore.resetTabIndex();
                  _userStore.logout();
                  context.navigator.pushNamedAndRemoveUntil(
                    Routes.login,
                    (route) => false,
                  );
                });
              },
              child: Text('Logout'),
            ),
          ),
        ),
        Spacer(
          flex: 3,
        ),
      ],
    );
  }
}
