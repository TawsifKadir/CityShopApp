import 'package:flutter/material.dart';

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
import 'package:grs/view_models/component/proof_files_view_model.dart';

class ProofFilesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mainAxis = MainAxisAlignment.spaceBetween;
    var viewmodel = Provider.of<ProofFilesViewModel>(context, listen: false);
    var label = Text('Grievance related proofs(if any)'.translate, style: sl<TextStyles>().text16_400(black));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: mainAxis, children: [label, AddButton(onTap: () => viewmodel.getProofFiles())]),
        const SizedBox(height: 4),
        Text('${'file_size_warning'.translate} ${'file_types'.translate}', style: sl<TextStyles>().text13_400(primary.withOpacity(0.7))),
        const SizedBox(height: 8),
        _proofAttachmentsListSection(context),
      ],
    );
  }

  Widget _proofAttachmentsListSection(BuildContext context) {
    var proofModelData = Provider.of<ProofFilesViewModel>(context);
    var proofViewmodel = Provider.of<ProofFilesViewModel>(context, listen: false);
    var proofFiles = proofModelData.proofFiles;
    if (!proofFiles.haveList) return const SizedBox.shrink();
    // if (!proofFiles.haveList) return Text('No new attachments added'.translate, style: sl<TextStyles>().text14_400(black));
    return ProofFileList(
      proofFileList: proofModelData.proofFiles,
      removeOnTap: proofViewmodel.removeProofFile,
      onTap: (index) => photoDialog(type: ImageType.memory, path: proofModelData.proofFiles[index].base64),
    );
  }
}
