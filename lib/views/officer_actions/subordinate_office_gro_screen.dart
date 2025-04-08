import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/bottom_sheets/subordinate_officers_sheet.dart';
import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/list_views/comp_list/selected_officers_list.dart';
import 'package:grs/components/ui_components/attachment_view.dart';
import 'package:grs/components/ui_widgets/action_ui_navbar.dart';
import 'package:grs/components/ui_widgets/add_button.dart';
import 'package:grs/components/ui_widgets/no_officer_view.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/constants/date_formats.dart';
import 'package:grs/core_widgets/date_picker_view.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/component/subordinate_officers_view_model.dart';
import 'package:grs/view_models/officer_actions/subordinate_office_gro_view_model.dart';

class SubordinateOfficeGroScreen extends StatefulWidget {
  final Complain complain;
  final ActionViewPref viewPref;
  final ActionTypePref typePref;
  const SubordinateOfficeGroScreen({required this.complain, required this.viewPref, required this.typePref});

  @override
  State<SubordinateOfficeGroScreen> createState() => _SubordinateOfficeGroScreenState();
}

class _SubordinateOfficeGroScreenState extends State<SubordinateOfficeGroScreen> {
  var viewModel = SubOrdinateOfficeGroViewModel();
  var modelData = SubOrdinateOfficeGroViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel(complain: widget.complain));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<SubOrdinateOfficeGroViewModel>(context, listen: false);
    modelData = Provider.of<SubOrdinateOfficeGroViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    var context = navigatorKey.currentState?.context;
    if (context == null) return;
    Provider.of<SubordinateOfficersViewModel>(context, listen: false).disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var padding = const EdgeInsets.symmetric(horizontal: 24);
    var responsive = Responsive(mobile: _mobileView(context));
    var subordinateModel = Provider.of<SubordinateOfficersViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackMenu(),
        automaticallyImplyLeading: false,
        title: Text('Send to concerned office for opinion'.translate),
        actions: [Center(child: LanguageMenu()), const SizedBox(width: appbarAction)],
      ),
      bottomNavigationBar: _bottomNavBar(context),
      body: Stack(
        children: [
          Container(width: SizeConfig.width, height: SizeConfig.height, padding: padding, child: responsive),
          if (modelData.loader || subordinateModel.loader) ScreenLoader(),
        ],
      ),
    );
  }

  Widget _mobileView(BuildContext context) {
    var attachment = widget.complain.attachmentInfo;
    var note = 'Write your note here'.translate;
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text('Select last date'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          DatePickerView(
            showPicker: true,
            lastDate: DateTime(2050),
            firstDate: DateTime(2000),
            dateFormat: DATE_FORMAT_4,
            initialDate: modelData.lastDate,
            hint: 'Select a date'.translate,
            onChanged: (date) => setState(() => modelData.lastDate = date),
          ),
          const SizedBox(height: 20),
          Text('Your note'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          ModifiedTextField(minLines: 06, maxLines: 12, controller: viewModel.note, hintText: note),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select Designated Officers'.translate, style: sl<TextStyles>().text16_400(black)),
              AddButton(onTap: () => subordinateOfficersBottomSheet(isMultiSelect: true)),
            ],
          ),
          const SizedBox(height: 06),
          Text('select_the_person_to_be'.translate, style: sl<TextStyles>().text14_400(primary.withOpacity(0.7))),
          const SizedBox(height: 6),
          _selectedOfficersList(context),
          const SizedBox(height: 20),
          AttachmentView(attachmentList: attachment ?? []),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _selectedOfficersList(BuildContext context) {
    var subordinateModel = Provider.of<SubordinateOfficersViewModel>(context);
    var officers = subordinateModel.selectedOfficers;
    if (!officers.haveList) return NoOfficerSelectedView();
    var subordinateViewModel = Provider.of<SubordinateOfficersViewModel>(context, listen: false);
    return SelectedOfficersList(
      isRecipient: true,
      isCommitteeHead: true,
      selectedOfficers: officers,
      recipientOnTap: (index) => subordinateViewModel.selectAsRecipient(index),
      removeOnTap: (index) => subordinateViewModel.removeSelectedOfficer(true, index),
      committeeHeadOnTap: (index) => subordinateViewModel.selectCommitteeHead(index),
    );
  }

  Widget _bottomNavBar(BuildContext context) {
    var subordinateModel = Provider.of<SubordinateOfficersViewModel>(context);
    // Provider.of<SubordinateOfficersViewModel>(context, listen: false).testMethod();
    return ActionUiNavbar(
      outlineLabel: 'Back',
      elevatedLabel: 'Send',
      outlineOnTap: backToPrevious,
      loader: modelData.loader || subordinateModel.loader,
      elevatedOnTap: () => viewModel.sendOnTap(widget.complain, widget.typePref, widget.viewPref),
    );
  }
}
