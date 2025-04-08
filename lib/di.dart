import 'package:get_it/get_it.dart';

import 'package:grs/helpers/action_data_helper.dart';
import 'package:grs/helpers/app_helper.dart';
import 'package:grs/helpers/complain_helper.dart';
import 'package:grs/helpers/dimension_helper.dart';
import 'package:grs/helpers/file_helper.dart';
import 'package:grs/helpers/graph_helper.dart';
import 'package:grs/helpers/library_helper.dart';
import 'package:grs/helpers/profile_helper.dart';
import 'package:grs/helpers/sort_helper.dart';
import 'package:grs/implementations/http_library.dart';
import 'package:grs/interceptors/api_interceptor.dart';
import 'package:grs/libraries/app_updater.dart';
import 'package:grs/libraries/file_compresser.dart';
import 'package:grs/libraries/file_pickers.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/libraries/image_croppers.dart';
import 'package:grs/libraries/image_pickers.dart';
import 'package:grs/libraries/launchers.dart';
import 'package:grs/libraries/storage.dart';
import 'package:grs/libraries/text_to_speak.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/repositories/action_data_repo.dart';
import 'package:grs/repositories/appeal_repo.dart';
import 'package:grs/repositories/auth_repo.dart';
import 'package:grs/repositories/blacklist_repo.dart';
import 'package:grs/repositories/citizen_action_repo.dart';
import 'package:grs/repositories/complain_repo.dart';
import 'package:grs/repositories/dashboard_repo.dart';
import 'package:grs/repositories/doptor_repo.dart';
import 'package:grs/repositories/officer_action_repo.dart';
import 'package:grs/repositories/public_repo.dart';
import 'package:grs/service/app_api_status.dart';
import 'package:grs/service/auth_service.dart';
import 'package:grs/service/device_service.dart';
import 'package:grs/service/image_service.dart';
import 'package:grs/service/routes.dart';
import 'package:grs/service/storage_service.dart';
import 'package:grs/service/validators.dart';
import 'package:grs/utils/api_url.dart';
import 'package:grs/utils/reg_exps.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/utils/transitions.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Helpers
  sl.registerLazySingleton<ActionDataHelper>(ActionDataHelper.new);
  sl.registerLazySingleton<AppHelper>(AppHelper.new);
  sl.registerLazySingleton<ComplainHelper>(ComplainHelper.new);
  sl.registerLazySingleton<DimensionHelper>(DimensionHelper.new);
  sl.registerLazySingleton<FileHelper>(FileHelper.new);
  sl.registerLazySingleton<GraphHelper>(GraphHelper.new);
  sl.registerLazySingleton<LibraryHelper>(LibraryHelper.new);
  sl.registerLazySingleton<ProfileHelper>(ProfileHelper.new);
  sl.registerLazySingleton<SortHelper>(SortHelper.new);

  /// Interceptors
  sl.registerLazySingleton<ApiInterceptor>(HttpLibrary.new);

  /// Libraries
  sl.registerLazySingleton<AppUpdater>(AppUpdater.new);
  sl.registerLazySingleton<FileCompressor>(FileCompressor.new);
  sl.registerLazySingleton<FilePickers>(FilePickers.new);
  sl.registerLazySingleton<Formatters>(Formatters.new);
  sl.registerLazySingleton<ImageCroppers>(ImageCroppers.new);
  sl.registerLazySingleton<ImagePickers>(ImagePickers.new);
  sl.registerLazySingleton<Launchers>(Launchers.new);
  sl.registerLazySingleton<Storage>(Storage.new);
  sl.registerLazySingleton<TextToSpeak>(TextToSpeak.new);
  sl.registerLazySingleton<Toasts>(Toasts.new);

  /// Repositories
  sl.registerLazySingleton<OfficerActionRepository>(OfficerActionRepository.new);
  sl.registerLazySingleton<ActionDataRepository>(ActionDataRepository.new);
  sl.registerLazySingleton<AppealRepository>(AppealRepository.new);
  sl.registerLazySingleton<AuthRepository>(AuthRepository.new);
  sl.registerLazySingleton<BlacklistRepository>(BlacklistRepository.new);
  sl.registerLazySingleton<CitizenActionRepository>(CitizenActionRepository.new);
  sl.registerLazySingleton<ComplainRepository>(ComplainRepository.new);
  sl.registerLazySingleton<DashboardRepository>(DashboardRepository.new);
  sl.registerLazySingleton<DoptorRepository>(DoptorRepository.new);
  sl.registerLazySingleton<PublicRepository>(PublicRepository.new);

  /// Services
  // Always Active Services
  sl.registerFactory(Routes.new);
  // Lazy Services
  sl.registerLazySingleton<AuthService>(AuthService.new);
  sl.registerLazySingleton<AppApiStatus>(AppApiStatus.new);
  sl.registerLazySingleton<DeviceService>(DeviceService.new);
  sl.registerLazySingleton<ImageService>(ImageService.new);
  sl.registerLazySingleton<StorageService>(StorageService.new);
  sl.registerLazySingleton<Validators>(Validators.new);

  /// Utils
  sl.registerLazySingleton<ApiUrl>(ApiUrl.new);
  sl.registerLazySingleton<RegExps>(RegExps.new);
  sl.registerLazySingleton<TextStyles>(TextStyles.new);
  sl.registerLazySingleton<Transitions>(Transitions.new);
}
