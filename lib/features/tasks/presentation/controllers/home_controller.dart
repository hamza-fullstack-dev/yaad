import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/task_providers.dart';

part 'home_controller.g.dart';

@riverpod
class HomeController extends _$HomeController {
  @override
  void build() {}

  Future<void> toggleTask(String id) async {
    HapticFeedback.lightImpact();
    await ref.read(taskRepositoryProvider).toggleComplete(id);
  }

  Future<void> deleteTask(String id) async {
    await ref.read(taskRepositoryProvider).deleteTask(id);
  }
}
