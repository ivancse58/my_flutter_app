import 'package:dio/dio.dart';
// code copy from : https://github.com/devmuaz/flutter_clean_architecture under MIT License

abstract class DataState<T> {
  final T? data;
  final DioError? error;

  const DataState({required this.data, required this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data, error: null);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioError error) : super(data: null, error: error);
}
