import 'package:flutter_dog_dashboard/domain/entities/dog_info.dart';
import 'package:flutter_dog_dashboard/domain/repositories/dog_repository.dart';

class GetDogUsecase {
  final DogRepository repository;

  GetDogUsecase(this.repository);

  Future<DogInfo> call() => repository.fetchDog();
}
