import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:grs/bottom_sheets/language_sheet.dart';
import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/dialogs/delete_account_dialog.dart';
import 'package:grs/dialogs/logout_dialog.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/helpers/profile_helper.dart';
import 'package:grs/library_widgets/circle_image.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/models/dummy/data_type.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/global_view_model.dart';
import 'package:grs/view_models/profile/profile_view_model.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var viewModel = ProfileViewModel();
  var modelData = ProfileViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<ProfileViewModel>(context, listen: false);
    modelData = Provider.of<ProfileViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var logoutLoader = Provider.of<GlobalViewModel>(context).logoutLoader;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: false,
        leading: const BackMenu(),
        automaticallyImplyLeading: false,
        title: Text('Your Profile'.translate),
        actions: [Center(child: LanguageMenu()), const SizedBox(width: appbarAction)],
      ),
      body: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Container(width: SizeConfig.width, height: SizeConfig.height, child: Responsive(mobile: _mobileView(context))),
          if (modelData.loader || logoutLoader) ScreenLoader(),
        ],
      ),
    );
  }

  Map<String, dynamic> get _profileData {
    if (sl<ProfileHelper>().isCitizen) {
      var profile = sl<ProfileHelper>().citizenProfile;
      return {'name': profile.name ?? '', 'designation': profile.email ?? '', 'image': null};
    } else {
      var profile = sl<ProfileHelper>().employee;
      var office = sl<ProfileHelper>().officeInfo;
      return {'name': profile.name, 'designation': '${office.designation_name}, ${office.office_name}', 'image': null};
    }
  }

  Widget _mobileView(BuildContext context) {
    var isCitizen = sl<ProfileHelper>().isCitizen;
    var profile = sl<ProfileHelper>().citizenProfile;
    var employee = sl<ProfileHelper>().employee;
    var profileInfoStyle = sl<TextStyles>().text14_400(black);
    var citizenGender = profile.gender == null ? '' : gender_types.firstWhere((item) => item.value == profile.gender).label;
    var officerGender = profile.gender == null ? '' : gender_types.firstWhere((item) => item.value == profile.gender).label;
    // var office = sl<ProfileHelper>().officeInfo;
    // var street = profile?.permanentAddressStreet;
    // var house = profile?.permanentAddressHouse;
    /*var nidType = profile?.identificationType == null || profile!.identificationType!.isEmpty
        ? identity_types.first
        : identity_types.firstWhere((item) => item.value == profile.identificationType);*/
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 20),
        Center(
          child: CircleImage(
            radius: 45,
            imageUrl: null,
            backgroundColor: grey20,
            placeHolder: Center(child: Lottie.asset(Assets.image_loader, width: 100, height: 100)),
            errorWidget: Center(child: SvgImage(image: Assets.user_filled, color: grey, height: 50)),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Center(child: Text(_profileData['name'], textAlign: TextAlign.center, style: sl<TextStyles>().text16_600(black))),
        ),
        const SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Center(child: Text(_profileData['designation'], textAlign: TextAlign.center, style: sl<TextStyles>().text14_400(black))),
        ),
        const SizedBox(height: 40),
        _profileItemHeader(label: 'Basic Information'.translate),
        const SizedBox(height: 20),
        _profileItem(
          onTap: () {},
          color: grey,
          icon: Assets.call_outline,
          title: 'Phone number'.translate,
          child: Text(isCitizen ? profile.mobileNumber ?? '' : employee.personalMobile ?? '', style: profileInfoStyle),
        ),
        const SizedBox(height: 20),
        /*_profileItem(
          onTap: () {},
          color: grey,
          icon: Assets.calendar_outline,
          title: 'Desi'.translate,
          child: Text(office?.designation_name ?? '', style: profileInfoStyle),
          // child: Text(joiningDate ?? '', style: profileInfoStyle),
        ),*/
        // const SizedBox(height: 24),
        _profileItem(
          onTap: () {},
          color: grey,
          title: 'Gender'.translate,
          icon: Assets.mosque_outline,
          child: Text(isCitizen ? citizenGender : officerGender, style: profileInfoStyle),
        ),
        const SizedBox(height: 24),
        _profileItem(
          onTap: () {},
          color: grey,
          icon: Assets.id_card_outline,
          title: 'National Id'.translate,
          child: Text(isCitizen ? '${profile.nationalityId ?? ''}' : employee.nid ?? '', style: profileInfoStyle),
        ),
        /*const SizedBox(height: 24),
        _profileItem(
          onTap: () {},
          color: grey,
          title: 'Address'.translate,
          icon: Assets.id_card_outline,
          child: Text('${employee.add == null ? '' : '$street, '}${house ?? ''}', style: profileInfoStyle),
        ),*/
        const SizedBox(height: 32),
        _profileItemHeader(label: 'Preferences'.translate),
        const SizedBox(height: 20),
        _profileItem(
          color: grey,
          title: 'Language Preference'.translate,
          icon: Assets.language_outline,
          onTap: languageBottomSheet,
          child: SvgImage(image: Assets.caret_right, color: grey),
        ),
        const SizedBox(height: 32),
        _profileItemHeader(label: 'Account & Security Settings'.translate),
        const SizedBox(height: 20),
        // _profileItem(
        //   color: grey,
        //   icon: Assets.bin_outline,
        //   // onTap: yourFeedbackDialog,
        //   onTap: accountDeleteDialog,
        //   title: 'Delete Account'.translate,
        //   child: SvgImage(image: Assets.caret_right, color: grey),
        // ),
        // const SizedBox(height: 20),
        _profileItem(
          color: red,
          title: 'Log Out'.translate,
          icon: Assets.sign_out,
          onTap: logoutDialog,
          child: SvgImage(image: Assets.caret_right, color: red),
        ),
      ],
    );
  }

  Widget _profileItemHeader({required String label}) {
    return Container(
      color: grey20,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text15_600(grey)),
    );
  }

  Widget _profileItem({
    required String icon,
    required String title,
    required Color color,
    required Widget child,
    required Function() onTap,
  }) {
    var size08 = const SizedBox(width: 8);
    var size16 = const SizedBox(width: 16);
    var image = Container(height: 24, width: 24, alignment: Alignment.center, child: SvgImage(image: icon, color: color));
    var label = Flexible(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text14_500(color)));
    var titleSection = Expanded(child: Row(children: [image, size08, label]));
    return InkWell(
      onTap: onTap,
      child: Container(
        color: transparent,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [titleSection, size16, child]),
      ),
    );
  }
}
