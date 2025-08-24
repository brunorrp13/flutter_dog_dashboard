import 'package:flutter_dog_dashboard/data/datasources/remote_datasource.dart';
import 'package:flutter_dog_dashboard/domain/entities/dog_info.dart';
import 'package:flutter_dog_dashboard/domain/repositories/dog_repository.dart';

class DogRepositoryImpl implements DogRepository {
  final RemoteDatasource remoteDatasource;

  DogRepositoryImpl(this.remoteDatasource);

  @override
  Future<DogInfo> fetchDog() async {
    return remoteDatasource.fetchDog();
  }

  Future<List<String>> fetchRandomDogs({int count = 6}) async {
    return remoteDatasource.fetchRandomDogs(count: count);
  }
}
