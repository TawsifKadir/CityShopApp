import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/dropdowns/settlement_dropdown.dart';
import 'package:grs/components/list_views/comp_list/movement_officers_list.dart';
import 'package:grs/components/ui_components/attachment_view.dart';
import 'package:grs/components/ui_components/proof_files_view.dart';
import 'package:grs/components/ui_widgets/action_ui_navbar.dart';
import 'package:grs/constants/colors.dart';
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
import 'package:grs/view_models/component/proof_files_view_model.dart';
import 'package:grs/view_models/officer_actions/close_complain_view_model.dart';

class CloseComplainScreen extends StatefulWidget {
  final Complain complain;
  final ActionViewPref viewPref;
  final ActionTypePref typePref;
  const CloseComplainScreen({required this.complain, required this.viewPref, required this.typePref});

  @override
  State<CloseComplainScreen> createState() => _CloseComplainScreenState();
}

class _CloseComplainScreenState extends State<CloseComplainScreen> {
  var viewModel = CloseComplainViewModel();
  var modelData = CloseComplainViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel(widget.complain));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<CloseComplainViewModel>(context, listen: false);
    modelData = Provider.of<CloseComplainViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    var context = navigatorKey.currentState?.context;
    if (context == null) return;
    Provider.of<ProofFilesViewModel>(context, listen: false).disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var padding = const EdgeInsets.symmetric(horizontal: 24);
    var responsive = Responsive(mobile: _mobileView(context));
    var proofModel = Provider.of<ProofFilesViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackMenu(),
        automaticallyImplyLeading: false,
        title: Text('Close Complain'.translate),
        actions: [Center(child: LanguageMenu()), const SizedBox(width: appbarAction)],
      ),
      bottomNavigationBar: _bottomNavBar(context),
      body: Stack(
        children: [
          Container(width: SizeConfig.width, height: SizeConfig.height, padding: padding, child: responsive),
          if (modelData.loader || proofModel.loader) ScreenLoader(),
        ],
      ),
    );
  }

  Widget _mobileView(BuildContext context) {
    var hint = 'Type here ...'.translate;
    var attachment = widget.complain.attachmentInfo;
    var isAllegation = modelData.settlement?.value != null && modelData.settlement!.value == 'CLOSED_ACCUSATION_PROVED';
    var checkIcon = const Icon(Icons.check_box_outline_blank, color: grey, size: 20);
    var checkedIcon = const Icon(Icons.check_box, color: primary, size: 20);
    var icon = modelData.departmentalMeasure ? checkedIcon : checkIcon;
    var departmentalLabel = Text('Taking departmental measures'.translate, style: sl<TextStyles>().text16_400(black));
    var isOfficerList = isAllegation && modelData.departmentalMeasure && modelData.officers.haveList;
    var showField = isAllegation && modelData.departmentalMeasure;
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text('Select a reason'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          SettleDropdown(settlement: modelData.settlement, onChanged: (data) => viewModel.chooseSettlement(data!)),
          const SizedBox(height: 20),
          if (isAllegation)
            InkWell(
              onTap: () => viewModel.setDepartmentalMeasure(),
              child: Row(children: [icon, const SizedBox(width: 4), departmentalLabel]),
            ),
          if (isAllegation) const SizedBox(height: 20),
          if (isOfficerList)
            Text('Select those against whom departmental action will be taken'.translate, style: sl<TextStyles>().text16_400(black)),
          if (isOfficerList) MovementOfficersList(movementOfficers: modelData.officers, onTap: (index) => modelData.selectOfficer(index)),
          if (isOfficerList) const SizedBox(height: 20),
          if (showField) Text('Reasons for Departmental System'.translate, style: sl<TextStyles>().text16_400(black)),
          if (showField) const SizedBox(height: 6),
          if (showField) ModifiedTextField(minLines: 06, maxLines: 12, controller: viewModel.department, hintText: hint),
          if (showField) const SizedBox(height: 20),
          Text("Grievance Redressal Officer's Decision".translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          ModifiedTextField(minLines: 06, maxLines: 12, controller: viewModel.decision, hintText: hint),
          const SizedBox(height: 20),
          Text('Root Cause of Complaint'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          ModifiedTextField(minLines: 06, maxLines: 12, controller: viewModel.rootCause, hintText: hint),
          const SizedBox(height: 20),
          Text('Advice on preventing recurrence of complaints'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          ModifiedTextField(minLines: 06, maxLines: 12, controller: viewModel.advice, hintText: hint),
          const SizedBox(height: 20),
          AttachmentView(attachmentList: attachment ?? []),
          const SizedBox(height: 20),
          ProofFilesView(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _bottomNavBar(BuildContext context) {
    return ActionUiNavbar(
      outlineLabel: 'Back',
      elevatedLabel: 'Close Case',
      loader: modelData.loader,
      outlineOnTap: backToPrevious,
      elevatedOnTap: () => viewModel.sendOnTap(widget.complain, widget.typePref, widget.viewPref),
    );
  }
}
