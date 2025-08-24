import '../entities/dog_info.dart';

abstract class DogRepository {
  Future<DogInfo> fetchDog();
  Future<List<String>> fetchRandomDogs({int count = 6});
}
