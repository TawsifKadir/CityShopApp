import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/flutter_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/helpers/profile_helper.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/repositories/officer_action_repo.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/view_models/component/proof_files_view_model.dart';

class SubmitInvestigationViewModel with ChangeNotifier {
  bool loader = false;
  var report = TextEditingController();

  void initViewModel() {
    var context = navigatorKey.currentState?.context;
    if (context == null) return;
    report.text = 'initial_text_for_submit_investigation'.translate;
    Provider.of<ProofFilesViewModel>(context, listen: false).initViewModel();
  }

  void disposeViewModel() {
    loader = false;
    report.clear();
  }

  void updateUi() => notifyListeners();

  void _loader(bool data) {
    loader = data;
    notifyListeners();
  }

  void sendOnTap(Complain complain, ActionTypePref typePref, ActionViewPref viewPref) {
    minimizeKeyboard();
    var context = navigatorKey.currentState?.context;
    if (context == null) return;
    var message1 = 'Please write a report to submit investigation'.translate;
    if (report.text.isEmpty) return sl<Toasts>().warningToast(message: message1, isTop: true);
    var proofFilesModel = Provider.of<ProofFilesViewModel>(context, listen: false);
    if (!proofFilesModel.validateProofFiles()) return;
    _submitInvestigationApi(complain, typePref, viewPref);
  }

  Future<void> _submitInvestigationApi(Complain complain, ActionTypePref typePref, ActionViewPref viewPref) async {
    _loader(true);
    var context = navigatorKey.currentState!.context;
    var body = _submitInvestigationBody(context, complain);
    var proofFiles = Provider.of<ProofFilesViewModel>(context, listen: false).proofFiles;
    var response = await sl<OfficerActionRepository>().submitInvestigation(typePref, body, proofFiles);
    if (response) backToPrevious();
    if (response && viewPref == ActionViewPref.details_view) backToPrevious();
    _loader(false);
  }

  Map<String, String> _submitInvestigationBody(BuildContext context, Complain complain) {
    var filenames;

    var username = sl<ProfileHelper>().officerProfile?.username;
    var officeId = sl<ProfileHelper>().officeInfo.officeId;
    var employeeRecordId = sl<ProfileHelper>().officerProfile?.employeeRecordId;
    var proofFiles = Provider.of<ProofFilesViewModel>(context, listen: false).proofFiles;
    if (proofFiles.length > 0) filenames = proofFiles.map((item) => item.name.text).join(',');
    Map<String, String> bodyInformation = {};
    if (complain.id != null) bodyInformation['complaint_id'] = '${complain.id}';
    if (officeId != null) bodyInformation['office_id'] = '$officeId';
    if (username != null) bodyInformation['username'] = username;
    if (employeeRecordId != null) bodyInformation['to_employee_record_id'] = '$employeeRecordId';
    bodyInformation['note'] = report.text;
    if (filenames != null) bodyInformation['fileNameByUser'] = filenames;
    return bodyInformation;
  }
}
