// const String _androidId = 'ca.immitrack';
// const String _iOSId = 'ca.immitrack';

class AppUpdater {
  /*Future<void> initAppUpdate() async {
    var context = navigatorKey.currentState?.context;
    if (context == null) return;
    try {
      var newVersion = NewVersion(androidId: _androidId, iOSId: _iOSId);
      var status = await newVersion.getVersionStatus();
      if (status != null && status.canUpdate) _appUpdateDialog(context, newVersion, status);
    } catch (error) {
      if (kDebugMode) print(error);
    }
  }*/

  /*void _appUpdateDialog(BuildContext context, NewVersion newVersion, VersionStatus status) {
    var availableInfo = 'A new version of ImmiTrack is available!';
    var versionInfo = 'Version ${status.storeVersion} is now available-you have ${status.localVersion} ☺';
    var upgradeInfo = 'Would you like to update it now?';
    var updateNote = '\n' + '$availableInfo $versionInfo' + '\n\n' + upgradeInfo;
    newVersion.showUpdateDialog(
      context: context,
      versionStatus: status,
      allowDismissal: false,
      dialogText: updateNote,
      updateButtonText: 'Update Now',
      dismissButtonText: 'No Thanks',
      dialogTitle: 'Update ImmiTrack?',
      dismissAction: () => Navigator.of(context).pop(),
    );
  }*/
}
