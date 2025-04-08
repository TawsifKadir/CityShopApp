import 'package:grs/view_models/component/signature_files_view_model.dart';
import 'package:grs/view_models/officer_actions/give_permission_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:grs/view_models/action_unused/more_evidence_view_model.dart';
import 'package:grs/view_models/auth/forgot_pin_view_model.dart';
import 'package:grs/view_models/auth/sign_up_view_model.dart';
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
import 'package:grs/view_models/complain/my_complains_view_model.dart';
import 'package:grs/view_models/complain/officer_complains_view_model.dart';
import 'package:grs/view_models/complain/tracking_view_model.dart';
import 'package:grs/view_models/complain_details/appeal_complain_details_view_model.dart';
import 'package:grs/view_models/complain_details/citizen_complain_details_view_model.dart';
import 'package:grs/view_models/complain_details/officer_complain_details_view_model.dart';
import 'package:grs/view_models/component/branch_officers_view_model.dart';
import 'package:grs/view_models/component/doptor_view_model.dart';
import 'package:grs/view_models/component/proof_files_view_model.dart';
import 'package:grs/view_models/component/signature_view_model.dart';
import 'package:grs/view_models/component/subordinate_officers_view_model.dart';
import 'package:grs/view_models/dashboard/dashboard_view_model.dart';
import 'package:grs/view_models/global_view_model.dart';
import 'package:grs/view_models/officer_actions/another_office_view_model.dart';
import 'package:grs/view_models/officer_actions/approve_disapprove_view_model.dart';
import 'package:grs/view_models/officer_actions/close_complain_view_model.dart';
import 'package:grs/view_models/officer_actions/give_opinion_view_model.dart';
import 'package:grs/view_models/officer_actions/hearing_notice_view_model.dart';
import 'package:grs/view_models/officer_actions/provide_service_view_model.dart';
import 'package:grs/view_models/officer_actions/reject_view_model.dart';
import 'package:grs/view_models/officer_actions/request_document_view_model.dart';
import 'package:grs/view_models/officer_actions/send_for_opinion_view_model.dart';
import 'package:grs/view_models/officer_actions/send_for_permission_view_model.dart';
import 'package:grs/view_models/officer_actions/start_investigation_view_model.dart';
import 'package:grs/view_models/officer_actions/submit_investigation_view_model.dart';
import 'package:grs/view_models/officer_actions/subordinate_office_gro_view_model.dart';
import 'package:grs/view_models/officer_actions/subordinate_office_view_model.dart';
import 'package:grs/view_models/officer_actions/take_hearing_view_model.dart';
import 'package:grs/view_models/officer_actions/to_appeal_officer_view_model.dart';
import 'package:grs/view_models/onboard/grs_onboard_view_model.dart';
import 'package:grs/view_models/profile/profile_view_model.dart';

final List<SingleChildWidget> providers = [
  // On Board
  ChangeNotifierProvider(create: (_) => GrsOnboardViewModel()),
  ChangeNotifierProvider(create: (_) => GlobalViewModel()),

  // Auth
  ChangeNotifierProvider(create: (_) => SignInViewModel()),
  ChangeNotifierProvider(create: (_) => SignUpViewModel()),
  ChangeNotifierProvider(create: (_) => ForgotPinViewModel()),

  // Company
  ChangeNotifierProvider(create: (_) => QuestionsViewModel()),
  ChangeNotifierProvider(create: (_) => CitizenCharterViewModel()),
  ChangeNotifierProvider(create: (_) => ImprovementViewModel()),

  // Dashboard
  ChangeNotifierProvider(create: (_) => DashboardViewModel()),

  // Complain
  ChangeNotifierProvider(create: (_) => TrackingViewModel()),
  ChangeNotifierProvider(create: (_) => AddComplainViewModel()),
  ChangeNotifierProvider(create: (_) => CitizenComplainsViewModel()),
  ChangeNotifierProvider(create: (_) => OfficerComplainsViewModel()),
  ChangeNotifierProvider(create: (_) => MyComplainsViewModel()),
  ChangeNotifierProvider(create: (_) => AppealComplainsViewModel()),

  // Complain Details
  ChangeNotifierProvider(create: (_) => CitizenComplainDetailsViewModel()),
  ChangeNotifierProvider(create: (_) => OfficerComplainDetailsViewModel()),
  ChangeNotifierProvider(create: (_) => AppealComplainDetailsViewModel()),

  // Blacklist
  ChangeNotifierProvider(create: (_) => BlacklistsViewModel()),
  ChangeNotifierProvider(create: (_) => BlacklistRequestsViewModel()),

  // Profile
  ChangeNotifierProvider(create: (_) => ProfileViewModel()),

  // Components
  ChangeNotifierProvider(create: (_) => BranchOfficersViewModel()),
  ChangeNotifierProvider(create: (_) => DoptorViewModel()),
  ChangeNotifierProvider(create: (_) => ProofFilesViewModel()),
  ChangeNotifierProvider(create: (_) => SignatureViewModel()),
  ChangeNotifierProvider(create: (_) => SignatureFilesViewModel()),
  ChangeNotifierProvider(create: (_) => SubordinateOfficersViewModel()),

  // Action unused
  ChangeNotifierProvider(create: (_) => MoreEvidenceViewmodel()),

  // Actions
  ChangeNotifierProvider(create: (_) => SendForOpinionViewModel()),
  ChangeNotifierProvider(create: (_) => GiveOpinionViewModel()),
  ChangeNotifierProvider(create: (_) => AnotherOfficeViewModel()),
  ChangeNotifierProvider(create: (_) => SubordinateOfficeViewModel()),
  ChangeNotifierProvider(create: (_) => SubOrdinateOfficeGroViewModel()),
  ChangeNotifierProvider(create: (_) => ToAppealOfficerViewModel()),
  ChangeNotifierProvider(create: (_) => ProvideServiceViewModel()),
  ChangeNotifierProvider(create: (_) => SendForPermissionViewModel()),
  ChangeNotifierProvider(create: (_) => GivePermissionViewModel()),
  ChangeNotifierProvider(create: (_) => RequestDocumentViewModel()),
  ChangeNotifierProvider(create: (_) => StartInvestigationViewModel()),
  ChangeNotifierProvider(create: (_) => SubmitInvestigationViewModel()),
  ChangeNotifierProvider(create: (_) => HearingNoticeViewModel()),
  ChangeNotifierProvider(create: (_) => TakeHearingViewModel()),
  ChangeNotifierProvider(create: (_) => ApproveDisapproveViewModel()),
  ChangeNotifierProvider(create: (_) => RejectViewModel()),
  ChangeNotifierProvider(create: (_) => CloseComplainViewModel()),

  // Citizen Actions
  ChangeNotifierProvider(create: (_) => HearingDateViewModel()),
  ChangeNotifierProvider(create: (_) => EvidenceMaterialViewModel()),
  ChangeNotifierProvider(create: (_) => SendAppealViewModel()),
];
