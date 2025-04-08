extension ParseDateString on String {
  DateTime get parseDate => DateTime.parse(this);
}

DateTime get currentDate => DateTime.now();
