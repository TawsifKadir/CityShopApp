import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'package:grs/components/ui_widgets/add_button.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/image_memory.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/component/signature_view_model.dart';

class SignatureView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var modelData = Provider.of<SignatureViewModel>(context);
    var viewmodel = Provider.of<SignatureViewModel>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Your Signature'.translate, style: sl<TextStyles>().text16_400(black)),
            modelData.signature == null ? AddButton(onTap: viewmodel.getImageFromGallery) : _clearMenu(context),
          ],
        ),
        SizedBox(height: modelData.signature == null ? 6 : 10),
        modelData.signature == null ? _noSignature(context) : _signatureView(context),
      ],
    );
  }

  Widget _clearMenu(BuildContext context) {
    var icon = SvgImage(image: Assets.close, color: red, height: 20);
    var label = Text('Clear', style: sl<TextStyles>().text16_500(red));
    var viewmodel = Provider.of<SignatureViewModel>(context, listen: false);
    return InkWell(
      onTap: viewmodel.clearSignature,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [icon, const SizedBox(width: 04), label],
      ),
    );
  }

  Widget _noSignature(BuildContext context) {
    var border = Border.all(color: grey80);
    var radius = BorderRadius.circular(6);
    var message = 'No signature uploaded yet'.translate;
    var icon = SvgImage(image: Assets.info_outline, color: black, height: 20);
    var label = Text(message, style: sl<TextStyles>().text14_400(black));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(border: border, color: cardShade.withOpacity(0.03), borderRadius: radius),
      child: Row(children: [icon, const SizedBox(width: 10), Expanded(child: label)]),
    );
  }

  Widget _signatureView(BuildContext context) {
    var modelData = Provider.of<SignatureViewModel>(context);
    var image = modelData.signature?.unit8List;
    var error = SvgImage(image: Assets.image_outline, width: 100, height: 80, fit: BoxFit.cover, color: grey80);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageMemory(imagePath: image, size: 100, radius: 04, errorWidget: error),
        const SizedBox(width: 10),
        Expanded(child: _signatureDetails(context)),
      ],
    );
  }

  Widget _signatureDetails(BuildContext context) {
    var hint = 'Write here'.translate;
    var modelData = Provider.of<SignatureViewModel>(context);
    var viewModel = Provider.of<SignatureViewModel>(context, listen: false);
    var path = modelData.signature!.file.path;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(basename(path), maxLines: 1, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text14_500(black)),
        const SizedBox(height: 12),
        ModifiedTextField(controller: viewModel.note, hintText: hint),
      ],
    );
  }
}
