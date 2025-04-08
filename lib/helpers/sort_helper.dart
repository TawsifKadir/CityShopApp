import 'package:grs/extensions/list_ext.dart';
import 'package:grs/models/complain/complain.dart';

class SortHelper {
  List<Complain> sortComplainId(List<Complain> complains) {
    if (!complains.haveList) return [];
    complains.sort((idA, idB) => (idB.id ?? 00000).compareTo(idA.id ?? 00000));
    complains = complains.toSet().toList();
    return complains;
  }
}
