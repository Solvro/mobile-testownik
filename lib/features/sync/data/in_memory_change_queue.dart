import 'src/change_queue_base.dart';

final class InMemoryQueueStorage implements QueueStorage {
  InMemoryQueueStorage([Map<String, String>? values])
    : _values = values ?? <String, String>{};

  final Map<String, String> _values;

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> write(String key, String value) async {
    _values[key] = value;
  }

  @override
  Future<void> remove(String key) async {
    _values.remove(key);
  }

  @override
  Future<bool> containsKey(String key) async => _values.containsKey(key);
}

final class InMemoryChangeQueue extends ChangeQueueBase {
  InMemoryChangeQueue({
    required super.userId,
    Map<String, String>? values,
    super.onCorruptData,
  }) : super(storage: InMemoryQueueStorage(values));
}
