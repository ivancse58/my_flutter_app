import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'data/repositories/country_favorite_repository_impl.dart';
import 'data/repositories/country_repository_impl.dart';
import 'data/services/country_api_service.dart';
import 'domain/repositories/country_favorite_repository.dart';
import 'domain/repositories/country_repository.dart';
import 'domain/usecase/get_countries_usecase.dart';
import 'domain/usecase/get_fav_country_usecase.dart';
import 'domain/usecase/get_saved_countries_usecase.dart';
import 'domain/usecase/set_fav_country_usecase.dart';
import 'models/country.dart';

final injector = GetIt.asNewInstance();

Future<void> initializeDependencies(
  Function(String) openBox,
  Alice alice,
) async {
  Hive.registerAdapter(CountryModelAdapter());
  Hive.registerAdapter(LanguageModelAdapter());
  Hive.registerAdapter(CurrencyModelAdapter());
  await openBox('CountryData');
  await openBox('CountryFavorite');

  // Dio client
  injector.registerSingleton<Dio>(Dio());
  // Service
  injector.registerSingleton<CountryApiService>(CountryApiService(
    injector(),
    alice,
  ));

  // Repository
  injector
      .registerSingleton<CountryRepository>(CountryRepositoryImpl(injector()));

  injector.registerSingleton<CountryFavoriteRepository>(
      CountryFavoriteRepositoryImpl());

  // UseCases
  injector.registerSingleton<GetCountryUseCase>(GetCountryUseCase(injector()));
  injector.registerSingleton<GetSavedCountriesUseCase>(
      GetSavedCountriesUseCase(injector()));

  injector.registerSingleton<SetFavCountryUseCase>(
      SetFavCountryUseCase(injector()));
  injector.registerSingleton<GetFavCountryUseCase>(
      GetFavCountryUseCase(injector()));
}
