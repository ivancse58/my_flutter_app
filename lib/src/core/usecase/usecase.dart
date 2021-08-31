// code copy from : https://github.com/devmuaz/flutter_clean_architecture under MIT License
abstract class UseCase<T, P> {
  Future<T> call({required P params});
}
