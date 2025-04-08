import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/dropdowns/witness_dropdown.dart';
import 'package:grs/components/ui_widgets/action_ui_navbar.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/constants/date_formats.dart';
import 'package:grs/core_widgets/date_picker_view.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/core_widgets/time_picker_view.dart';
import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/officer_actions/hearing_notice_view_model.dart';

class HearingNoticeScreen extends StatefulWidget {
  final Complain complain;
  final ActionViewPref viewPref;
  final ActionTypePref typePref;

  const HearingNoticeScreen({required this.complain, required this.viewPref, required this.typePref});

  @override
  State<HearingNoticeScreen> createState() => _HearingNoticeScreenState();
}

class _HearingNoticeScreenState extends State<HearingNoticeScreen> {
  var viewModel = HearingNoticeViewModel();
  var modelData = HearingNoticeViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel(widget.complain));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<HearingNoticeViewModel>(context, listen: false);
    modelData = Provider.of<HearingNoticeViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var padding = const EdgeInsets.symmetric(horizontal: 24);
    var responsive = Responsive(mobile: _mobileView(context));
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackMenu(),
        automaticallyImplyLeading: false,
        title: Text('Request to Attend Hearing'.translate),
        actions: [Center(child: LanguageMenu()), const SizedBox(width: appbarAction)],
      ),
      bottomNavigationBar: _bottomNavBar(context),
      body: Stack(
        children: [
          Container(width: SizeConfig.width, height: SizeConfig.height, padding: padding, child: responsive),
          if (modelData.loader) ScreenLoader(),
        ],
      ),
    );
  }

  Widget _mobileView(BuildContext context) {
    var hint = 'Write your note here'.translate;
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text('Hearing Date'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          DatePickerView(
            showPicker: true,
            lastDate: DateTime(2050),
            firstDate: DateTime(2000),
            dateFormat: DATE_FORMAT_4,
            initialDate: modelData.hearingDate,
            hint: 'Select the date of hearing'.translate,
            onChanged: (date) => setState(() => modelData.hearingDate = date),
          ),
          const SizedBox(height: 20),
          Text('Hearing Time'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          TimePickerView(
            showPicker: true,
            timeFormat: DATE_FORMAT_5,
            initialTime: modelData.hearingTime,
            hint: 'Select the time of hearing'.translate,
            onChanged: (date) => setState(() => modelData.hearingTime = date),
          ),
          const SizedBox(height: 20),
          Text('Select witness'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          WitnessDropdown(
            witness: modelData.witness,
            witnessList: modelData.witnessList,
            onChanged: (data) => setState(() => modelData.witness = data!),
          ),
          const SizedBox(height: 20),
          Text('Hearing note'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          ModifiedTextField(minLines: 06, maxLines: 12, controller: viewModel.note, hintText: hint),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _bottomNavBar(BuildContext context) {
    return ActionUiNavbar(
      outlineLabel: 'Back',
      elevatedLabel: 'Send',
      outlineOnTap: backToPrevious,
      loader: modelData.loader,
      elevatedOnTap: () => viewModel.sendOnTap(widget.complain, widget.typePref, widget.viewPref),
    );
  }
}
