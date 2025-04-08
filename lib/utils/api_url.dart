class ApiUrl {

  static String server = '';

  // Auth Officer
  String administrativeLogin = '$server/api/auth/mobile-administrative-login';      //API to login as admin

  // Auth Citizen
  String checkUser = '$server/api/complainant/show?mobile_number=';                //API to check if the mobile number already exists
  String userSignUp = '$server/api/complainant/save';                              //API to register a new user
  String citizenLogin = '$server/api/mobile/login';                                //API to login as user
  String forgotPassword = '$server/api/complainant/mobile/reset/pincode/';         //API to send reset pincode to phone number

  // Citizen Charter
  String charterInfo = '$server/api/citizen-charter/infoNew?office_id=';           //API to get the charter info after text input given and office selected from dropdown

  // Dashboard
  String dashboard = '$server/api/grievance/total?officeId=';                     //API to get dashboard

  // Complain
  String createComplain = '$server/api/grievance/save';                            //API to submit grievance as registered user
  String createPublicComplain = '$server/api/public-grievance/save';               //API to submit user as non-registered user
  String trackComplain = '$server/api/grievance-track?tracking_number=';           //API to track complain using tracking number after admin login
  String allComplains = '$server/api/grievance/list';                              //API to get list of all complains
  String complainDetails = '$server/api/grievance/details?complaint_id=';          //API to see details of complain using the complain id
  String officerComplainMovement = '$server/api/grievance/movement?complaint_id=';                    //API to see the history of the admins working on the complain on admin Dashboard
  String citizenComplainMovement = '$server/api/grievance/complainant/movement?complaint_id=';        //API to check which movement between admins of the complaint on citizen Dashboard

  // Appeal
  String appealHistory = '$server/api/administrative-grievance/departmental-action-officers?complaint_id=';                     //API to get appeal history

  // Blacklist
  String saveAsBlacklist = '$server/api/blacklist/save';                                                    //API to request for new blacklist
  String blacklists = '$server/api/blacklist/index?office_id=';                                             //API to get list of blacklists
  String requestedBlacklists = '$server/api/blacklist/request?office_id=';
  String blacklistStatus = '$server/api/blacklist/status/';                                                 //API to change blacklist status of complainant

  // Action Helper Data
  String branches = '$server/api/doptor/office-organogram/office-unit-designation-employee-map?office_id=';                                 //API to get branches during action
  String subordinateOffice = '$server/api/doptor/office-organogram/subordinate-office-organogram?grievanceId=';                             //API to get subordinate office during action
  String movementOfficers = '$server/api/administrative-grievance/departmental-action-officers?action=SEND_FOR_OPINION&complaint_id=';      //API to get movement officers during action
  String groInfo = '$server/api/grievance/gro-info?complaint_id=';                                                                          //API to get gro info during action

  // Complain Action
  String sendForOpinion = '$server/api/administrative-grievance/send-for-opinion';                    //API to send the grievance for opinion
  String giveOpinion = '$server/api/administrative-grievance/give-opinion';                           //API to give opinion
  String startInvestigation = '$server/api/administrative-grievance/investigation';                   //API to start an investigation
  String submitInvestigation = '$server/api/administrative-grievance/provide-investigation-report';   //API to provide investigation report
  String requestDocument = '$server/api/administrative-grievance/request-document';                   //API to request for documents
  String sendToAnotherOffice = '$server/api/administrative-grievance/send-to-another-office';         //API to send to another office
  String closeComplain = '$server/api/administrative-grievance/close-grievance';                      //API to close a complain
  String rejectComplain = '$server/api/administrative-grievance/reject-grievance';                    //API to close grievance
  String sendToSubordinateOffice = '$server/api/administrative-grievance/send-to-subordinate-office'; //API to send to subordinate office
  String sendToAppealOfficer = '$server/api/administrative-grievance/send-to-subordinate-office';     // API to send to Appeal Officer
  String guidelinesToProvidingService = '$server/api/administrative-grievance/give-guidelines-to-providing-services';   //API to give guidelines for providing service
  String provideInvestigationReport = '$server/api/administrative-grievance/provide-investigation-report';    //API to provide investigation report
  String hearingNotice = '$server/api/administrative-grievance/hearing-notice';                               //API to send for hearing notice
  String takeHearing = '$server/api/administrative-grievance/take-hearing';                                 //API to take hearing
  String approveOrDisApprove = '$server/api/grievance/agree-disagree';                                      //API to approve or disapprove a complain
  String sendForPermission = '$server/api/administrative-grievance/ask-for-permission';                     //API to send for permission
  String givePermission = '$server/api/administrative-grievance/give-permission';                           //API to give permission

  // Appeal Actions
  // String sendAppealOpinion = '$server/api/administrative-grievance/send-for-appeal-opinion';
  String sendAppealOpinion = '$server/api/administrative-grievance/send-for-opinion';                       //API to send for appeal opinion


  // Citizen Actions
  String hearingDate = '$server/api/administrative-grievance/see-date-of-hearing';                          //API to see the date of hearing
  String evidenceMaterial = '$server/api/administrative-grievance/providing-material-for-investigation';    //API to provide more evidence material
  String sendForAppeal = '$server/api/administrative-grievance/request-appeal';                             //API to send for appeal
  String complainRating = '$server/api/grievance/rate-us';

  // Public Apis
  String occupations = '$server/api/occupation/list';                             //API to get a list of all occupations
  String qualifications = '$server/api/qualification/list';                       //API to get a list of all qualifications
  String nationalities = '$server/api/nationality/list';                          //API to get a list of all nationalities
  String saveSuggestion = '$server/api/provide-suggestion';                       //API to send feedback to doptor
  String safety_nets = '$server/api/sp-programme/list';                           //API to get a list of all safety net programs

  // Doptor Apis (Ministry/Division/Office)
  String allOfficeBySearch = '$server/api/doptor/office?';                                                                //API to get the ministries by writing text
  String allMinistries = '$server/api/doptor/api?api_url=custom-layer-level&api_type=POST';                               //API to get all ministries from dropdown
  String divisionalOfficeByLayer = '$server/api/doptor/api?api_url=custom-layer-level&api_type=POST&layer_levels=3';      //API to get the divisional office of the division
  String originsByLayer = '$server/api/doptor/api?api_url=office-origins&api_type=POST&layer_levels=';                    //API to get the origin by layer
  String officesByLayer = '$server/api/doptor/api?api_url=offices&api_type=POST&layer_levels=';                           //API to get the office by layer

  // Service
  String services = '$server/api/service/list?office_id=';                         //API to get list of services in an office
  String servicesByDistrict = '$server/api/service/list?district_id=';

  // Districts
  String divisions = '$server/api/doptor/data?api_url=division&api_type=GET';      //API to get list of all divisions
  String districts = '$server/api/doptor/data?api_url=district&prams=division=';   //API to get list of all districts using division ID
  String sub_districts = '$server/api/doptor/data?api_url=upazilla&prams=district='; //API to get list of sub_districts using district ID
}
