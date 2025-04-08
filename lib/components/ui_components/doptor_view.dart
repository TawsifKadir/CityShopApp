import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import 'package:grs/components/dropdowns/divitional_office_dropdown.dart';
import 'package:grs/components/dropdowns/layer_office_dropdown.dart';
import 'package:grs/components/dropdowns/ministry_dropdown.dart';
import 'package:grs/components/dropdowns/origin_dropdown.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/helpers/library_helper.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/component/doptor_view_model.dart';

class DoptorView extends StatelessWidget {
  final bool needService;
  final bool isCitizenCharter;
  final bool isRequired;
  const DoptorView({required this.needService, required this.isCitizenCharter, required this.isRequired});

  @override
  Widget build(BuildContext context) {
    var modelData = Provider.of<DoptorViewModel>(context);
    var viewmodel = Provider.of<DoptorViewModel>(context, listen: false);
    var isOffice = modelData.office != null;
    var isMinistry = !isOffice && modelData.ministryList.haveList;
    var ministryLayer = modelData.ministry?.layerLevel;
    var isOrigin = modelData.ministry != null && ministryLayer != null && ministryLayer == 3;
    var isMiddleLayer = modelData.ministry != null && ministryLayer != null && ministryLayer > 2;
    var isMiddleLayerSelected = modelData.origin != null || modelData.divitionalOffice != null;
    var isLayerOffice = (ministryLayer == 1 || ministryLayer == 2) || isMiddleLayerSelected;
    var middleOfficeLabel = isOrigin ? 'Office origin'.translate : 'Divisional office'.translate;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Choose an office from the list below'.translate, style: sl<TextStyles>().text14_400(black)),
            if (isRequired) const Text(' '),
            if (isRequired) Text('*', style: sl<TextStyles>().text14_600(red)),
          ],
        ),
        const SizedBox(height: 4),
        _typeAheadSearchField(context),
        const SizedBox(height: 16),
        if (isMinistry) Text('Ministry'.translate, style: sl<TextStyles>().text14_400(black)),
        if (isMinistry) const SizedBox(height: 4),
        if (isMinistry)
          MinistryDropdown(
            ministry: modelData.ministry,
            ministryList: modelData.ministryList,
            onChanged: (data) => viewmodel.selectMinistry(data!),
          ),
        if (isMinistry) const SizedBox(height: 16),
        if (isMiddleLayer) Text(middleOfficeLabel, style: sl<TextStyles>().text14_400(black)),
        if (isMiddleLayer) const SizedBox(height: 4),
        if (isMiddleLayer)
          isOrigin
              ? DivitionalOfficeDropdown(
                  divitionalOffice: modelData.divitionalOffice,
                  divitionalOfficeList: modelData.divitionalOfficeList,
                  onChanged: (data) => viewmodel.selectDivisionalOffice(data!),
                )
              : OriginDropdown(
                  origin: modelData.origin,
                  originList: modelData.originList,
                  onChanged: (data) => viewmodel.selectOrigin(data!),
                ),
        if (isMiddleLayer) const SizedBox(height: 16),
        if (isLayerOffice) Text('Office'.translate, style: sl<TextStyles>().text14_400(black)),
        if (isLayerOffice) const SizedBox(height: 4),
        if (isLayerOffice)
          LayerOfficeDropdown(
            layerOffice: modelData.layerOffice,
            layerOfficeList: modelData.layerOfficeList,
            onChanged: (data) => viewmodel.selectOfficeLayer(needService, isCitizenCharter, data!),
          ),
        if (isLayerOffice) const SizedBox(height: 20),
      ],
    );
  }

  Widget _typeAheadSearchField(BuildContext context) {
    var viewModel = Provider.of<DoptorViewModel>(context, listen: false);
    var closeIcon = SvgImage(image: Assets.close, color: black, height: 22);
    return TypeAheadFormField(
      minCharsForSuggestions: 4,
      keepSuggestionsOnLoading: false,
      suggestionsCallback: (pattern) => viewModel.allSearchableOfficeList(),
      itemBuilder: (context, item) => _officeCard(item.office_name),
      transitionBuilder: (context, suggestionsBox, controller) => suggestionsBox,
      loadingBuilder: (context) => sl<LibraryHelper>().typeAheadLoader(context),
      validator: (value) => null,
      onSaved: (value) {},
      onSuggestionSelected: (item) => viewModel.selectSearchedOfficeList(needService, isCitizenCharter, item),
      textFieldConfiguration: sl<LibraryHelper>().typeAheadConfig(
        controller: viewModel.search,
        hint: 'Type here to search office'.translate,
        suffix: InkWell(onTap: viewModel.clearSearchField, child: closeIcon),
      ),
    );
  }

  Widget _officeCard(String office) {
    var padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
    var label = Text(office, style: sl<TextStyles>().text15_600(black));
    return Container(width: double.infinity, padding: padding, child: label);
  }
}
