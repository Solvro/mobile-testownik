import 'package:shared_preferences/shared_preferences.dart';

import 'src/change_queue_base.dart';

final class SharedPreferencesQueueStorage implements QueueStorage {
  const SharedPreferencesQueueStorage(this._preferences);

  final SharedPreferencesAsync _preferences;

  @override
  Future<String?> read(String key) => _preferences.getString(key);

  @override
  Future<void> write(String key, String value) =>
      _preferences.setString(key, value);

  @override
  Future<void> remove(String key) => _preferences.remove(key);

  @override
  Future<bool> containsKey(String key) => _preferences.containsKey(key);
}

final class SharedPreferencesChangeQueue extends ChangeQueueBase {
  SharedPreferencesChangeQueue({
    required super.userId,
    SharedPreferencesAsync? preferences,
    super.onCorruptData,
  }) : super(
         storage: SharedPreferencesQueueStorage(
           preferences ?? SharedPreferencesAsync(),
         ),
       );
}
