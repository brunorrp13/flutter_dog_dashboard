import 'package:hive/hive.dart';

class LocalHiveDatasource {
  static const String dogsBox = 'dogs';

  Future<void> saveDog(Map<String, dynamic> dogData) async {
    final box = await Hive.openBox(dogsBox);
    await box.add(dogData);
  }
}
