import 'dart:async';
import 'dart:math';

import 'package:flutter_dog_dashboard/data/datasources/local_hive_datasource.dart';
import 'package:flutter_dog_dashboard/data/datasources/remote_datasource.dart';
import 'package:flutter_dog_dashboard/domain/entities/dog_info.dart';
import 'package:flutter_dog_dashboard/domain/usecases/get_dog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'data/repositories/dog_repository_impl.dart';

part 'providers.g.dart';

/// Provides a single [http.Client] instance to be used for all HTTP requests.
/// Ensures dependency injection and testability.
@riverpod
http.Client httpClient(Ref ref) => http.Client();

/// Provides the [RemoteDatasource] implementation using [http.Client].
/// This datasource handles all external API requests.
@riverpod
RemoteDatasource remoteDatasource(Ref ref) {
  return RemoteDatasourceImpl(httpClient(ref));
}

/// Provides the [LocalHiveDatasource] implementation.
/// This datasource manages persistence of Dog data using Hive locally.
@riverpod
LocalHiveDatasource localHiveDatasource(Ref ref) {
  return LocalHiveDatasource();
}

/// A [Provider] that exposes the [DogRepositoryImpl].
///
/// The repository sits between the data sources and use cases,
/// orchestrating remote/local data fetching and domain entity conversion.
@riverpod
DogRepositoryImpl dogRepository(Ref ref) {
  final datasource = ref.watch(remoteDatasourceProvider);
  return DogRepositoryImpl(datasource);
}

/// A [FutureProvider] that fetches random dog images from the repository.
/// Takes an [int count] parameter to control how many images are retrieved.
@riverpod
Future<List<String>> randomDogs(Ref ref, int count) async {
  final repo = ref.watch(dogRepositoryProvider);
  return repo.fetchRandomDogs(count: count);
}

/// Provides a [GetDogUsecase] instance, which encapsulates business logic
/// for fetching dog-related data from the repository.
@riverpod
GetDogUsecase getDogUsecase(Ref ref) {
  final repo = ref.watch(dogRepositoryProvider);
  return GetDogUsecase(repo);
}

/// AsyncNotifier to manage a single Dog's state across the app.
///
/// - Handles creation, updating, and saving of Dog data.
/// - Exposes methods for updating each field individually.
/// - Maintains dog state in memory and persists when requested.
@riverpod
class GetDog extends _$GetDog {
  @override
  Future<DogInfo> build() async {
    return emptyDogInfo();
  }

  /// Creates a blank [DogInfo] with a random age between 1–15.
  DogInfo emptyDogInfo() {
    final randomAge = Random().nextInt(15) + 1;
    return DogInfo(
      name: '',
      ownerName: '',
      saved: false,
      age: randomAge,
      imageUrl: '',
      countryOfOrigin: '',
    );
  }

  /// Updates the dog's saved status.
  void updateSavedStatus(bool saved) {
    state.whenData((dog) {
      final updatedDog = dog.copyWith(saved: saved);
      state = AsyncData(updatedDog);
    });
  }

  /// Updates the dog's name and replaces the current state.
  void updateName(String newName) {
    state.whenData((dog) {
      final updatedDog = dog.copyWith(name: newName);
      state = AsyncData(updatedDog);
    });
  }

  /// Updates the dog's country of origin and replaces the current state.
  void updateCountryOfOrigin(String country) {
    state.whenData((dog) {
      final updatedDog = dog.copyWith(countryOfOrigin: country);
      state = AsyncData(updatedDog);
    });
  }

  /// Updates the dog's photo URL (network).
  Future<void> updateDogPhoto(String filePath) async {
    state.whenData((dog) {
      final updatedDog = dog.copyWith(imageUrl: filePath);
      state = AsyncData(updatedDog);
    });
  }

  /// Updates the owner's photo (stored locally as file path).
  Future<void> updateOwnerPhoto(String filePath) async {
    state.whenData((dog) {
      final updatedDog = dog.copyWith(ownerImageUrl: filePath);
      state = AsyncData(updatedDog);
    });
  }

  /// Updates the owner's name.
  Future<void> updateOwnerName(String name) async {
    state.whenData((dog) {
      final updatedDog = dog.copyWith(ownerName: name);
      state = AsyncData(updatedDog);
    });
  }

  /// Refreshes the current Dog state by resetting data.
  Future<void> refresh() async {
    state = const AsyncLoading();
    ref.read(getDogProvider.notifier).resetData();
  }

  /// Saves the current dog into local storage using Hive.
  ///
  /// - If required fields are empty, shows validation errors.
  /// - Otherwise, persists the dog and resets state.
  Future<void> saveDog() async {
    final showError = ref.watch(showErrorProvider.notifier);
    state.whenData((dog) async {
      // Validate required fields
      if (dog.name.isEmpty ||
          dog.ownerName.isEmpty ||
          dog.countryOfOrigin.isEmpty ||
          dog.imageUrl.isEmpty ||
          dog.ownerImageUrl == null ||
          dog.ownerImageUrl!.isEmpty) {
        showError.show();
        return;
      }

      // Save valid dog data
      state.whenData((dog) async {
        final localHiveDatasource = ref.read(localHiveDatasourceProvider);
        await localHiveDatasource.saveDog({
          'name': dog.name,
          'countryOfOrigin': dog.countryOfOrigin,
          'imageUrl': dog.imageUrl,
          'ownerName': dog.ownerName,
          'ownerImageUrl': dog.ownerImageUrl,
        });
        ref.read(getDogProvider.notifier).updateSavedStatus(true);
        showError.hide();
      });
    });
  }

  /// Resets Dog state to an empty [DogInfo] and hides errors.
  void resetData() async {
    ref.read(showErrorProvider.notifier).hide();
    state = await AsyncValue.guard(() async {
      return ref.read(getDogProvider.notifier).emptyDogInfo();
    });
  }
}

/// A simple state notifier controlling Dog status visibility in the UI.
/// Can toggle between `true` (visible) and `false` (hidden).
@riverpod
class IsStatusVisible extends _$IsStatusVisible {
  @override
  bool build() => true;

  /// Toggles the current visibility state.
  void toggle() => state = !state;
}

/// Provides a [GraphQLClient] for fetching data from public GraphQL endpoints.
/// Here, it connects to the countries API.
@riverpod
GraphQLClient graphQLClient(Ref ref) {
  final httpLink = HttpLink('https://countries.trevorblades.com/');

  return GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: httpLink,
  );
}

/// Fetches a list of countries using the GraphQL client.
/// Returns `code`, `name`, and `capital` fields for each country.
@riverpod
Future<List<Map<String, dynamic>>> countries(Ref ref) async {
  final client = ref.watch(graphQLClientProvider);

  const query = r'''
    query {
      countries {
        code
        name
        capital
      }
    }
  ''';

  final result = await client.query(QueryOptions(document: gql(query)));

  if (result.hasException) {
    throw result.exception!;
  }

  final countries = result.data?['countries'] as List<dynamic>;

  return countries.cast<Map<String, dynamic>>();
}

/// Controls whether to show error messages on the UI.
///
/// - `true` = errors should be visible.
/// - `false` = errors are hidden.
@riverpod
class ShowError extends _$ShowError {
  @override
  bool build() => false;

  /// Shows error messages.
  void show() => state = true;

  /// Hides error messages.
  void hide() => state = false;
}
