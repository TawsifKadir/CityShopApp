import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/bottom_sheets/language_sheet.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/expansion.dart';
import 'package:grs/di.dart';
import 'package:grs/dialogs/logout_dialog.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/helpers/profile_helper.dart';
import 'package:grs/library_widgets/circle_image.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/models/dummy/complain_menu.dart';
import 'package:grs/service/auth_service.dart';
import 'package:grs/service/routes.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/complain/officer_complains_view_model.dart';

import '../service/storage_service.dart';

class AppDrawer extends StatelessWidget {
  final ScrollController? menuScroll;
  const AppDrawer({required this.menuScroll});

  @override
  Widget build(BuildContext context) {
    var height = 20.0;
    var viewM = Provider.of<OfficerComplainsViewModel>(context, listen: false);
    var padding = EdgeInsets.only(top: SizeConfig.statusBar + 24, left: 20, right: 20);
    var isOfficer = menuScroll != null && sl<ProfileHelper>().isOfficer;
    var isGro = sl<StorageService>().getUserType.toLowerCase() == 'gro';
    return Drawer(
      width: 70.width,
      child: Container(
        padding: padding,
        height: SizeConfig.height,
        child: ListView(
          padding: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Expanded(child: _profileInfo(context)), const SizedBox(width: 12), const BackMenu()],
            ),
            const SizedBox(height: 40),
            _AppDrawerItem(
              color: grey80,
              icon: Assets.translate_filled,
              title: 'Language Preference'.translate,
              onTap: () => _drawerOnTap(languageBottomSheet),
            ),
            SizedBox(height: height),
            _AppDrawerItem(
              color: grey80,
              icon: Assets.tracker_filled,
              title: 'Complain Tracking'.translate,
              onTap: () => _drawerOnTap(sl<Routes>().trackingScreen().push),
            ),
            SizedBox(height: height),
            if (sl<AuthService>().authStatus) const Divider(color: grey60),
            if (sl<AuthService>().authStatus) SizedBox(height: height),
            if (isOfficer)
              _AppDrawerItem(
                color: grey80,
                icon: Assets.dashboard_filled,
                title: 'Dashboard'.translate,
                onTap: () => _drawerOnTap(sl<Routes>().dashboardScreen().push),
              ),
            if (isOfficer) SizedBox(height: height),
            if (isOfficer)
              Expansion(
                title: _header(icon: Assets.message_filled, title: 'Manage Grievance'.translate),
                childrenPadding: EdgeInsets.zero,
                expandedAlignment: Alignment.centerLeft,
                tilePadding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 10),
                  _expansionItem(menu: complainMenuList[0], onTap: () => _drawerOnTap(() => viewM.selectMenuFromDrawer(0, menuScroll!))),
                  const SizedBox(height: 10),
                  _expansionItem(menu: complainMenuList[1], onTap: () => _drawerOnTap(() => viewM.selectMenuFromDrawer(1, menuScroll!))),
                  const SizedBox(height: 10),
                  _expansionItem(menu: complainMenuList[2], onTap: () => _drawerOnTap(() => viewM.selectMenuFromDrawer(2, menuScroll!))),
                  const SizedBox(height: 10),
                  _expansionItem(menu: complainMenuList[3], onTap: () => _drawerOnTap(() => viewM.selectMenuFromDrawer(3, menuScroll!))),
                  const SizedBox(height: 10),
                  _expansionItem(menu: complainMenuList[4], onTap: () => _drawerOnTap(() => viewM.selectMenuFromDrawer(4, menuScroll!))),
                  const SizedBox(height: 10),
                  _expansionItem(menu: complainMenuList[5], onTap: () => _drawerOnTap(() => viewM.selectMenuFromDrawer(5, menuScroll!))),
                ],
              ),
            if (isOfficer) SizedBox(height: height),
            if (isOfficer)
              Expansion(
                title: _header(icon: Assets.hammer_filled, title: 'Manage Appeal'.translate),
                childrenPadding: EdgeInsets.zero,
                expandedAlignment: Alignment.centerLeft,
                tilePadding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 10),
                  _expansionItem(menu: appealMenuList[0], onTap: () => _drawerOnTap(sl<Routes>().appealComplainsScreen(index: 0).push)),
                  const SizedBox(height: 10),
                  _expansionItem(menu: appealMenuList[1], onTap: () => _drawerOnTap(sl<Routes>().appealComplainsScreen(index: 1).push)),
                  const SizedBox(height: 10),
                  _expansionItem(menu: appealMenuList[2], onTap: () => _drawerOnTap(sl<Routes>().appealComplainsScreen(index: 2).push)),
                ],
              ),
            // if (isOfficer) SizedBox(height: height),
            // if (isOfficer) const Divider(color: grey60),
            // if (isOfficer) SizedBox(height: height),
            // if (isOfficer)
            //   _AppDrawerItem(
            //     color: grey80,
            //     icon: Assets.my_complain_filled,
            //     title: 'My Complains'.translate,
            //     onTap: () => _drawerOnTap(sl<Routes>().myComplainsScreen().push),
            //   ),
            // if (isOfficer && isGro) SizedBox(height: height),
            // if (isOfficer && isGro)
            //   _AppDrawerItem(
            //     color: grey80,
            //     icon: Assets.shield_filled,
            //     title: 'BlackList'.translate,
            //     onTap: () => _drawerOnTap(sl<Routes>().blacklistsScreen().push),
            //   ),
            // if (isOfficer) SizedBox(height: height),
            // if (isOfficer)
            //   _AppDrawerItem(
            //     color: grey80,
            //     icon: Assets.info_filled,
            //     title: 'Blacklist Requests'.translate,
            //     onTap: () => _drawerOnTap(sl<Routes>().blacklistRequestScreen().push),
            //   ),
            if (isOfficer) SizedBox(height: height),
            if (isOfficer) const Divider(color: grey60),
            if (isOfficer) SizedBox(height: height),
            _AppDrawerItem(
              color: grey80,
              icon: Assets.citizen_charter_filled,
              title: 'Citizen Charter'.translate,
              onTap: () => _drawerOnTap(sl<Routes>().citizenCharterScreen().push),
            ),
            SizedBox(height: height),
            _AppDrawerItem(
              color: grey80,
              icon: Assets.star_filled,
              title: 'Improvement Suggestion'.translate,
              onTap: () => _drawerOnTap(sl<Routes>().improvementScreen().push),
              // onTap: () => _drawerOnTap(sl<Routes>().languageScreen().push),
            ),
            SizedBox(height: height),
            _AppDrawerItem(
              color: grey80,
              icon: Assets.question_filled,
              title: 'Frequently Asked Questions'.translate,
              onTap: () => _drawerOnTap(sl<Routes>().questionsScreen().push),
            ),
            SizedBox(height: height),
            if (sl<AuthService>().authStatus) const Divider(color: grey60),
            if (sl<AuthService>().authStatus) SizedBox(height: height),
            if (sl<AuthService>().authStatus)
              _AppDrawerItem(
                color: grey80,
                icon: Assets.profile_filled,
                title: 'Profile Settings'.translate,
                onTap: () => _drawerOnTap(sl<Routes>().profileScreen().push),
              ),
            if (sl<AuthService>().authStatus) SizedBox(height: height),
            if (sl<AuthService>().authStatus)
              _AppDrawerItem(
                color: red.withOpacity(0.9),
                icon: Assets.sign_out,
                title: 'Log out'.translate,
                onTap: () => _drawerOnTap(logoutDialog),
              ),
            SizedBox(height: SizeConfig.bottomNotch ? 24 : height),
            // _AppDrawerItem(color: grey80, icon: Assets.star_filled, title: 'Staff Complaint'.translate, onTap: () {}),
            // _AppDrawerItem(color: grey80, icon: Assets.star_filled, title: 'Grievance Upload'.translate, onTap: () {}),
            // _AppDrawerItem(color: grey80, icon: Assets.star_filled, title: 'Self Motivated Grievance'.translate, onTap: () {}),
          ],
        ),
      ),
    );
  }

  Widget _header({required String icon, required String title}) {
    var label = Text(title, style: sl<TextStyles>().text16_500(grey80));
    var image = SvgImage(image: icon, color: grey80, height: 24, width: 24);
    var imageSection = Container(height: 24, width: 24, alignment: Alignment.center, child: image);
    return Row(children: [imageSection, const SizedBox(width: 10), Flexible(child: label)]);
  }

  Widget _expansionItem({required ComplainMenu menu, required Function() onTap}) {
    var label = Text(menu.label, style: sl<TextStyles>().text16_500(grey80));
    var image = SvgImage(image: menu.icon, color: grey80, height: 20, width: 20);
    var imageSection = Container(height: 24, width: 24, alignment: Alignment.center, child: image);
    return InkWell(
      onTap: onTap,
      child: Row(children: [const SizedBox(width: 30), imageSection, const SizedBox(width: 10), Flexible(child: label)]),
    );
  }

  void _drawerOnTap(Function() itemOnTap) {
    backToPrevious();
    itemOnTap();
  }

  Widget _profileInfo(BuildContext context) {
    var overflow = TextOverflow.ellipsis;
    var profileData = _profileData;
    var errorImage = SvgImage(image: Assets.avatar_filled, fit: BoxFit.cover, height: 40, width: 40);
    var nameText = Text(profileData['name'], maxLines: 1, overflow: overflow, style: sl<TextStyles>().text16_600(black));
    var designationText = Text(profileData['designation'], maxLines: 1, overflow: overflow, style: sl<TextStyles>().text13_400(grey));
    return Row(
      children: [
        CircleImage(
          radius: 23,
          imageUrl: null,
          borderColor: black,
          backgroundColor: grey20,
          placeHolder: errorImage,
          errorWidget: Center(child: errorImage),
          onTap: () => _drawerOnTap(() => sl<Routes>().profileScreen().push()),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(onTap: () => _drawerOnTap(() => sl<Routes>().profileScreen().push()), child: nameText),
              InkWell(onTap: () => _drawerOnTap(() => sl<Routes>().profileScreen().push()), child: designationText),
            ],
          ),
        ),
      ],
    );
  }
}

Map<String, dynamic> get _profileData {
  if (!sl<AuthService>().authStatus) {
    return {'name': 'Guest'.translate, 'designation': 'guest@gmail.com'.translate, 'image': null};
  } else if (sl<ProfileHelper>().isCitizen) {
    var profile = sl<ProfileHelper>().citizenProfile;
    return {'name': profile.name ?? '', 'designation': profile.email ?? '', 'image': null};
  } else if (sl<ProfileHelper>().isOfficer) {
    var profile = sl<ProfileHelper>().employee;
    var designation_name = sl<ProfileHelper>().officeInfo.designation_name;
    return {'name': profile.name, 'designation': designation_name, 'image': null};
  } else {
    return {'name': 'Guest'.translate, 'designation': 'guest@gmail.com'.translate, 'image': null};
  }
}

class _AppDrawerItem extends StatelessWidget {
  final Function() onTap;
  final Color color;
  final String title;
  final String icon;
  const _AppDrawerItem({required this.title, required this.onTap, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    var width = const SizedBox(width: 10);
    var style = sl<TextStyles>().text16_500(color);
    var image = SvgImage(image: icon, color: color, height: 24, width: 24);
    var imageSection = Container(height: 24, width: 24, alignment: Alignment.center, child: image);
    var label = Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: style);
    return InkWell(onTap: onTap, child: Row(children: [imageSection, width, Flexible(child: label)]));
  }
}
