import 'package:csv/csv.dart';

_loadDb() {
  List<List<dynamic>> data =
      const CsvToListConverter().convert('assets/db/main.csv');
  print(data);
}

main() {
  _loadDb();
}
