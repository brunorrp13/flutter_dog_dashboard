import 'dart:convert';

import 'package:flutter_dog_dashboard/domain/entities/dog_info.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDatasource {
  Future<DogInfo> fetchDog();
  Future<List<String>> fetchRandomDogs({int count = 1});
}

class RemoteDatasourceImpl implements RemoteDatasource {
  static const String petsBox = 'pets';
  final http.Client client;

  RemoteDatasourceImpl(this.client);

  @override
  Future<DogInfo> fetchDog() async {
    final response =
        await client.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return DogInfo(
        name: '',
        ownerName: '',
        saved: false,
        age: 1,
        imageUrl: data['message'],
        countryOfOrigin: '',
      );
    } else {
      throw Exception('Failed to fetch pet status');
    }
  }

  @override
  Future<List<String>> fetchRandomDogs({int count = 6}) async {
    final urls = <String>[];
    for (int i = 0; i < count; i++) {
      final response = await client
          .get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        urls.add(data['message'] as String);
      }
    }
    return urls;
  }
}
