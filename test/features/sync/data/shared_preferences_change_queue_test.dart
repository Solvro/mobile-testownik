import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_testownik/features/sync/data/change_queue.dart';
import 'package:mobile_testownik/features/sync/data/shared_preferences_change_queue.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import 'test_helpers.dart';

final class _SharedPreferencesHarness implements QueueTestHarness {
  @override
  Future<ChangeQueue> create({
    required String userId,
    QueueCorruptionReporter? onCorruptData,
  }) async {
    return SharedPreferencesChangeQueue(
      userId: userId,
      onCorruptData: onCorruptData,
    );
  }

  @override
  Future<void> seedRaw(String userId, String value) {
    return SharedPreferencesAsync().setString('queue.$userId', value);
  }

  @override
  Future<String?> readRaw(String key) {
    return SharedPreferencesAsync().getString(key);
  }
}

void main() {
  setUp(() {
    final previous = SharedPreferencesAsyncPlatform.instance;
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    addTearDown(() {
      SharedPreferencesAsyncPlatform.instance = previous;
    });
  });

  runChangeQueueContractTests(() => _SharedPreferencesHarness());
}
