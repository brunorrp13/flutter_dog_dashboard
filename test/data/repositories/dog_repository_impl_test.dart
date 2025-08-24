import 'dart:convert';
import 'package:flutter_dog_dashboard/data/datasources/remote_datasource.dart';
import 'package:flutter_dog_dashboard/data/repositories/dog_repository_impl.dart';
import 'package:flutter_dog_dashboard/domain/entities/dog_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../mocks/mocks.mocks.dart';

void main() {
  group('PetRepositoryImpl', () {
    late MockClient mockClient;
    late RemoteDatasourceImpl remoteDatasource;
    late DogRepositoryImpl repository;

    setUp(() {
      mockClient = MockClient();
      remoteDatasource = RemoteDatasourceImpl(mockClient);
      repository = DogRepositoryImpl(remoteDatasource);
    });

    test('returns a Pet when the http call completes successfully', () async {
      when(mockClient.get(Uri.parse('https://dog.ceo/api/breeds/image/random')))
          .thenAnswer((_) async => http.Response(
                jsonEncode({
                  'message':
                      'https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg'
                }),
                200,
              ));

      final dog = await repository.fetchDog();

      expect(dog, isA<DogInfo>());
      expect(dog.imageUrl, contains('dog.ceo'));
      expect(dog.name, isNotEmpty);
    });

    test('throws an exception when http call fails', () async {
      when(mockClient.get(Uri.parse('https://dog.ceo/api/breeds/image/random')))
          .thenAnswer((_) async => http.Response('Not found', 404));

      expect(repository.fetchDog(), throwsException);
    });
  });
}
