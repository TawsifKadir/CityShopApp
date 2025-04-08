extension ListExtension on List<dynamic>? {
  bool get haveList {
    if (this == null) return false;
    return this!.length > 0 ? true : false;
  }
}
