import 'package:svelty/Track.dart';
import 'DatabaseHelper.dart';
import 'Repository.dart';

class TrackRepository implements Repository {
  TrackRepository(this._localDataSource);

  final DatabaseHelper _localDataSource;

  @override
  Future<int> create(entity) {
    return _localDataSource.createFlashCard(
        (entity as Track).weight,
        entity.chest,
        entity.abs,
        entity.hip,
        entity.bottom,
        entity.leg,
        entity.createdAt.millisecondsSinceEpoch,
        entity.toSynchronize);
  }

  @override
  Future<Track> findById(id) {
    return _localDataSource.findById(id);
  }

  @override
  Future<List<Track>> getAll() {
    return _localDataSource.getAllTracks();
  }

  Future<int?> rowCount() {
    return _localDataSource.getTrackCount();
  }
}
