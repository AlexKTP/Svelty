abstract class Repository<T, K> {

  Future<List<T>> getAll();
  Future<T> findById(K id);
  Future<T>  create(T entity);

}