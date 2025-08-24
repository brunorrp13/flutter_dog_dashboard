// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$httpClientHash() => r'7f0620a393673068316af3b9d3fe7fff063ec774';

/// Provides a single [http.Client] instance to be used for all HTTP requests.
/// Ensures dependency injection and testability.
///
/// Copied from [httpClient].
@ProviderFor(httpClient)
final httpClientProvider = AutoDisposeProvider<http.Client>.internal(
  httpClient,
  name: r'httpClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$httpClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HttpClientRef = AutoDisposeProviderRef<http.Client>;
String _$remoteDatasourceHash() => r'ae0da35061e09e2eec86d696bcdc93ddd45ca111';

/// Provides the [RemoteDatasource] implementation using [http.Client].
/// This datasource handles all external API requests.
///
/// Copied from [remoteDatasource].
@ProviderFor(remoteDatasource)
final remoteDatasourceProvider = AutoDisposeProvider<RemoteDatasource>.internal(
  remoteDatasource,
  name: r'remoteDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$remoteDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemoteDatasourceRef = AutoDisposeProviderRef<RemoteDatasource>;
String _$localHiveDatasourceHash() =>
    r'779b57e05e09f6f5dc0e433cad655c26834ed9db';

/// Provides the [LocalHiveDatasource] implementation.
/// This datasource manages persistence of Dog data using Hive locally.
///
/// Copied from [localHiveDatasource].
@ProviderFor(localHiveDatasource)
final localHiveDatasourceProvider =
    AutoDisposeProvider<LocalHiveDatasource>.internal(
  localHiveDatasource,
  name: r'localHiveDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localHiveDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocalHiveDatasourceRef = AutoDisposeProviderRef<LocalHiveDatasource>;
String _$dogRepositoryHash() => r'0fc7e2f3297a42f7549ed2bb105df4c80611df93';

/// A [Provider] that exposes the [DogRepositoryImpl].
///
/// The repository sits between the data sources and use cases,
/// orchestrating remote/local data fetching and domain entity conversion.
///
/// Copied from [dogRepository].
@ProviderFor(dogRepository)
final dogRepositoryProvider = AutoDisposeProvider<DogRepositoryImpl>.internal(
  dogRepository,
  name: r'dogRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dogRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DogRepositoryRef = AutoDisposeProviderRef<DogRepositoryImpl>;
String _$randomDogsHash() => r'758496e25e2400e724065db48c441547174a7ece';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// A [FutureProvider] that fetches random dog images from the repository.
/// Takes an [int count] parameter to control how many images are retrieved.
///
/// Copied from [randomDogs].
@ProviderFor(randomDogs)
const randomDogsProvider = RandomDogsFamily();

/// A [FutureProvider] that fetches random dog images from the repository.
/// Takes an [int count] parameter to control how many images are retrieved.
///
/// Copied from [randomDogs].
class RandomDogsFamily extends Family<AsyncValue<List<String>>> {
  /// A [FutureProvider] that fetches random dog images from the repository.
  /// Takes an [int count] parameter to control how many images are retrieved.
  ///
  /// Copied from [randomDogs].
  const RandomDogsFamily();

  /// A [FutureProvider] that fetches random dog images from the repository.
  /// Takes an [int count] parameter to control how many images are retrieved.
  ///
  /// Copied from [randomDogs].
  RandomDogsProvider call(
    int count,
  ) {
    return RandomDogsProvider(
      count,
    );
  }

  @override
  RandomDogsProvider getProviderOverride(
    covariant RandomDogsProvider provider,
  ) {
    return call(
      provider.count,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'randomDogsProvider';
}

/// A [FutureProvider] that fetches random dog images from the repository.
/// Takes an [int count] parameter to control how many images are retrieved.
///
/// Copied from [randomDogs].
class RandomDogsProvider extends AutoDisposeFutureProvider<List<String>> {
  /// A [FutureProvider] that fetches random dog images from the repository.
  /// Takes an [int count] parameter to control how many images are retrieved.
  ///
  /// Copied from [randomDogs].
  RandomDogsProvider(
    int count,
  ) : this._internal(
          (ref) => randomDogs(
            ref as RandomDogsRef,
            count,
          ),
          from: randomDogsProvider,
          name: r'randomDogsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$randomDogsHash,
          dependencies: RandomDogsFamily._dependencies,
          allTransitiveDependencies:
              RandomDogsFamily._allTransitiveDependencies,
          count: count,
        );

  RandomDogsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.count,
  }) : super.internal();

  final int count;

  @override
  Override overrideWith(
    FutureOr<List<String>> Function(RandomDogsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RandomDogsProvider._internal(
        (ref) => create(ref as RandomDogsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        count: count,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<String>> createElement() {
    return _RandomDogsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RandomDogsProvider && other.count == count;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, count.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RandomDogsRef on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `count` of this provider.
  int get count;
}

class _RandomDogsProviderElement
    extends AutoDisposeFutureProviderElement<List<String>> with RandomDogsRef {
  _RandomDogsProviderElement(super.provider);

  @override
  int get count => (origin as RandomDogsProvider).count;
}

String _$getDogUsecaseHash() => r'a46dda2646f5aa2c2c0c986fe047dfd359bb230e';

/// Provides a [GetDogUsecase] instance, which encapsulates business logic
/// for fetching dog-related data from the repository.
///
/// Copied from [getDogUsecase].
@ProviderFor(getDogUsecase)
final getDogUsecaseProvider = AutoDisposeProvider<GetDogUsecase>.internal(
  getDogUsecase,
  name: r'getDogUsecaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getDogUsecaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetDogUsecaseRef = AutoDisposeProviderRef<GetDogUsecase>;
String _$graphQLClientHash() => r'e6ec68745c5c402a6c83f68466777d2d191a6e42';

/// Provides a [GraphQLClient] for fetching data from public GraphQL endpoints.
/// Here, it connects to the countries API.
///
/// Copied from [graphQLClient].
@ProviderFor(graphQLClient)
final graphQLClientProvider = AutoDisposeProvider<GraphQLClient>.internal(
  graphQLClient,
  name: r'graphQLClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$graphQLClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GraphQLClientRef = AutoDisposeProviderRef<GraphQLClient>;
String _$countriesHash() => r'dcbdb428e791cd3d2855ceab668281b65ef1fbd0';

/// Fetches a list of countries using the GraphQL client.
/// Returns `code`, `name`, and `capital` fields for each country.
///
/// Copied from [countries].
@ProviderFor(countries)
final countriesProvider =
    AutoDisposeFutureProvider<List<Map<String, dynamic>>>.internal(
  countries,
  name: r'countriesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$countriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CountriesRef = AutoDisposeFutureProviderRef<List<Map<String, dynamic>>>;
String _$getDogHash() => r'a80ea1324a9f6322fa02898db30a9ab62dde8d5f';

/// AsyncNotifier to manage a single Dog's state across the app.
///
/// - Handles creation, updating, and saving of Dog data.
/// - Exposes methods for updating each field individually.
/// - Maintains dog state in memory and persists when requested.
///
/// Copied from [GetDog].
@ProviderFor(GetDog)
final getDogProvider =
    AutoDisposeAsyncNotifierProvider<GetDog, DogInfo>.internal(
  GetDog.new,
  name: r'getDogProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getDogHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GetDog = AutoDisposeAsyncNotifier<DogInfo>;
String _$isStatusVisibleHash() => r'ee53c2f1c771334b455b29a4736c65f1a3019ffd';

/// A simple state notifier controlling Dog status visibility in the UI.
/// Can toggle between `true` (visible) and `false` (hidden).
///
/// Copied from [IsStatusVisible].
@ProviderFor(IsStatusVisible)
final isStatusVisibleProvider =
    AutoDisposeNotifierProvider<IsStatusVisible, bool>.internal(
  IsStatusVisible.new,
  name: r'isStatusVisibleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isStatusVisibleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsStatusVisible = AutoDisposeNotifier<bool>;
String _$showErrorHash() => r'7bd3edbddd76939cc723e3158fb90098ead7e740';

/// Controls whether to show error messages on the UI.
///
/// - `true` = errors should be visible.
/// - `false` = errors are hidden.
///
/// Copied from [ShowError].
@ProviderFor(ShowError)
final showErrorProvider = AutoDisposeNotifierProvider<ShowError, bool>.internal(
  ShowError.new,
  name: r'showErrorProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$showErrorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ShowError = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
