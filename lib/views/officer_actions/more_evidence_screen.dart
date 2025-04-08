import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/ui_components/attachment_view.dart';
import 'package:grs/components/ui_widgets/action_ui_navbar.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/action_unused/more_evidence_view_model.dart';

class MoreEvidenceScreen extends StatefulWidget {
  final Complain complain;
  final ActionViewPref viewPref;
  final ActionTypePref typePref;

  const MoreEvidenceScreen({required this.complain, required this.viewPref, required this.typePref});

  @override
  State<MoreEvidenceScreen> createState() => _MoreEvidenceScreenState();
}

class _MoreEvidenceScreenState extends State<MoreEvidenceScreen> {
  var viewModel = MoreEvidenceViewmodel();
  var modelData = MoreEvidenceViewmodel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<MoreEvidenceViewmodel>(context, listen: false);
    modelData = Provider.of<MoreEvidenceViewmodel>(context);
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
        title: Text('Provide More Evidence'.translate),
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
    var attachment = widget.complain.attachmentInfo;
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text('Your Note'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          ModifiedTextField(minLines: 06, maxLines: 12, controller: viewModel.note, hintText: hint),
          const SizedBox(height: 20),
          AttachmentView(attachmentList: attachment ?? []),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _bottomNavBar(BuildContext context) {
    return ActionUiNavbar(
      outlineLabel: 'Back',
      elevatedLabel: 'Submit Report',
      outlineOnTap: backToPrevious,
      loader: modelData.loader,
      elevatedOnTap: () => viewModel.sendOnTap(widget.complain),
    );
  }
}
