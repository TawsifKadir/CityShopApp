import 'package:grs/view_models/officer_actions/give_permission_view_model.dart';
import 'package:provider/provider.dart';

import 'package:grs/di.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/reg_exps.dart';
import 'package:grs/view_models/auth/signin_view_model.dart';
import 'package:grs/view_models/blacklist/blacklist_requests_view_model.dart';
import 'package:grs/view_models/blacklist/blacklists_view_model.dart';
import 'package:grs/view_models/citizen_actions/evidence_material_view_model.dart';
import 'package:grs/view_models/citizen_actions/hearing_date_view_model.dart';
import 'package:grs/view_models/citizen_actions/send_appeal_view_model.dart';
import 'package:grs/view_models/company/citizen_charter_view_model.dart';
import 'package:grs/view_models/company/improvement_view_model.dart';
import 'package:grs/view_models/company/questions_view_model.dart';
import 'package:grs/view_models/complain/add_complain_view_model.dart';
import 'package:grs/view_models/complain/appeal_complains_view_model.dart';
import 'package:grs/view_models/complain/citizen_complains_view_model.dart';
import 'package:grs/view_models/complain/officer_complains_view_model.dart';
import 'package:grs/view_models/complain/tracking_view_model.dart';
import 'package:grs/view_models/complain_details/appeal_complain_details_view_model.dart';
import 'package:grs/view_models/complain_details/citizen_complain_details_view_model.dart';
import 'package:grs/view_models/complain_details/officer_complain_details_view_model.dart';
import 'package:grs/view_models/component/doptor_view_model.dart';
import 'package:grs/view_models/dashboard/dashboard_view_model.dart';
import 'package:grs/view_models/officer_actions/another_office_view_model.dart';
import 'package:grs/view_models/officer_actions/close_complain_view_model.dart';
import 'package:grs/view_models/officer_actions/give_opinion_view_model.dart';
import 'package:grs/view_models/officer_actions/provide_service_view_model.dart';
import 'package:grs/view_models/officer_actions/reject_view_model.dart';
import 'package:grs/view_models/officer_actions/request_document_view_model.dart';
import 'package:grs/view_models/officer_actions/send_for_opinion_view_model.dart';
import 'package:grs/view_models/officer_actions/send_for_permission_view_model.dart';
import 'package:grs/view_models/officer_actions/start_investigation_view_model.dart';
import 'package:grs/view_models/officer_actions/submit_investigation_view_model.dart';
import 'package:grs/view_models/officer_actions/subordinate_office_gro_view_model.dart';
import 'package:grs/view_models/officer_actions/subordinate_office_view_model.dart';
import 'package:grs/view_models/officer_actions/to_appeal_officer_view_model.dart';
import 'package:grs/view_models/onboard/grs_onboard_view_model.dart';
import 'package:grs/view_models/profile/profile_view_model.dart';

class AppHelper {
  String detectLanguage(String text) {
    if (text.isEmpty) return 'en';
    if (sl<RegExps>().english.hasMatch(text)) return 'en';
    return 'bn';
  }

  void updateAllUi() {
    var context = navigatorKey.currentState?.context;
    if (context == null) return;

    Provider.of<GrsOnboardViewModel>(context, listen: false).updateUi();
    Provider.of<SignInViewModel>(context, listen: false).updateUi();
    // Provider.of<SignUpViewModel>(context, listen: false).updateUi();
    // Provider.of<ForgotPinViewModel>(context, listen: false).updateUi();

    // Company
    Provider.of<ImprovementViewModel>(context, listen: false).updateUi();
    Provider.of<QuestionsViewModel>(context, listen: false).updateUi();
    Provider.of<CitizenCharterViewModel>(context, listen: false).updateUi();

    // Complain
    Provider.of<AddComplainViewModel>(context, listen: false).updateUi();
    Provider.of<TrackingViewModel>(context, listen: false).updateUi();
    Provider.of<CitizenComplainsViewModel>(context, listen: false).updateUi();
    Provider.of<OfficerComplainsViewModel>(context, listen: false).updateUi();
    // Provider.of<MyComplainsViewModel>(context, listen: false).updateUi();
    Provider.of<AppealComplainsViewModel>(context, listen: false).updateUi();

    // Complain Details
    Provider.of<CitizenComplainDetailsViewModel>(context, listen: false).updateUi();
    Provider.of<OfficerComplainDetailsViewModel>(context, listen: false).updateUi();
    Provider.of<AppealComplainDetailsViewModel>(context, listen: false).updateUi();

    // Profile
    Provider.of<ProfileViewModel>(context, listen: false).updateUi();

    // Blacklist
    Provider.of<BlacklistsViewModel>(context, listen: false).updateUi();
    Provider.of<BlacklistRequestsViewModel>(context, listen: false).updateUi();

    // Dashboard
    Provider.of<DashboardViewModel>(context, listen: false).updateUi();

    // Officer Actions
    Provider.of<SendForOpinionViewModel>(context, listen: false).updateUi();
    Provider.of<GiveOpinionViewModel>(context, listen: false).updateUi();
    Provider.of<AnotherOfficeViewModel>(context, listen: false).updateUi();
    Provider.of<SubordinateOfficeViewModel>(context, listen: false).updateUi();
    Provider.of<SubOrdinateOfficeGroViewModel>(context, listen: false).updateUi();
    Provider.of<ToAppealOfficerViewModel>(context, listen: false).updateUi();
    Provider.of<ProvideServiceViewModel>(context, listen: false).updateUi();
    Provider.of<SendForPermissionViewModel>(context, listen: false).updateUi();
    Provider.of<GivePermissionViewModel>(context, listen: false).updateUi();
    Provider.of<RequestDocumentViewModel>(context, listen: false).updateUi();
    Provider.of<StartInvestigationViewModel>(context, listen: false).updateUi();
    Provider.of<SubmitInvestigationViewModel>(context, listen: false).updateUi();
    Provider.of<RejectViewModel>(context, listen: false).updateUi();
    Provider.of<CloseComplainViewModel>(context, listen: false).updateUi();

    // Citizen Actions
    Provider.of<HearingDateViewModel>(context, listen: false).updateUi();
    Provider.of<EvidenceMaterialViewModel>(context, listen: false).updateUi();
    Provider.of<SendAppealViewModel>(context, listen: false).updateUi();

    // Components
    Provider.of<DoptorViewModel>(context, listen: false).updateUi();
  }
}
