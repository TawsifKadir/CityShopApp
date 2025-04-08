import 'package:flutter/material.dart';
import 'package:grs/components/list_views/comp_list/signature_file_list.dart';
import 'package:grs/view_models/component/signature_files_view_model.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/list_views/comp_list/proof_file_list.dart';
import 'package:grs/components/ui_widgets/add_button.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/dialogs/photo_dialog.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/utils/text_styles.dart';

class SignatureFilesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mainAxis = MainAxisAlignment.spaceBetween;
    var viewmodel = Provider.of<SignatureFilesViewModel>(context, listen: false);
    var label = Text('Signature Related Files'.translate, style: sl<TextStyles>().text16_400(black));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: mainAxis, children: [label, AddButton(onTap: () => viewmodel.getSignatureFiles())]),
        const SizedBox(height: 16),
        _signatureAttachmentsListSection(context),
        const SizedBox(height: 8),
        Text('${'file_size_warning'.translate} ${'file_types'.translate}', style: sl<TextStyles>().text13_400(primary.withOpacity(0.7))),
      ],
    );
  }

  Widget _signatureAttachmentsListSection(BuildContext context) {
    var signatureModelData = Provider.of<SignatureFilesViewModel>(context);
    var signatureViewmodel = Provider.of<SignatureFilesViewModel>(context, listen: false);
    var signatureFiles = signatureModelData.signatureFiles;
    if (!signatureFiles.haveList) return const SizedBox.shrink();
    // if (!signatureFiles.haveList) return Text('No new attachments added'.translate, style: sl<TextStyles>().text14_400(black));
    return SignatureFileList(
      signatureFileList: signatureModelData.signatureFiles,
      removeOnTap: signatureViewmodel.removeSignatureFile,
      onTap: (index) => photoDialog(type: ImageType.memory, path: signatureModelData.signatureFiles[index].base64),
    );
  }
}
