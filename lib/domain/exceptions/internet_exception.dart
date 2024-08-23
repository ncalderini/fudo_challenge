class InternetException<E> implements Exception {
  final E? cachedData;

  InternetException({this.cachedData});
}