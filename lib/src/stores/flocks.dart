import 'dart:convert' as convert;
import 'package:mobx/mobx.dart';

import 'package:come_share/src/models/flock.dart';
import 'package:come_share/src/servives/flocks.dart';

part 'flocks.g.dart';

class FlocksStore = FlocksStoreBase with _$FlocksStore;

abstract class FlocksStoreBase with Store {
  final FlocksService _flocksService;

  @observable
  ObservableList<Flock> flocks;

  @observable
  bool initialLoading;

  @observable
  DateTime now;

  FlocksStoreBase(this._flocksService) {
    initialLoading = true;
    flocks = ObservableList<Flock>();
  }

  @action
  Future<void> init() async {
    final _flocks = await _flocksService.getFlocksRpc.request(null);
    flocks = ObservableList.of(_flocks);
    initialLoading = false;
  }

  @action
  Future<List<Flock>> saveAllFlocks(List<Flock> _flocks) async {
    flocks = ObservableList.of(_flocks);
    await _flocksService.saveAllFlocksRpc.request(flocks);
    return flocks;
  }

  @action
  Future<ObservableList<Flock>> importPastFlocks(String json) async {
    final _flocks = (convert.json.decode(json) as List)
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map((flock) => Flock.fromJson(flock))
        .toList();
    flocks = ObservableList.of(_flocks);
    await _flocksService.saveAllFlocksRpc.request(flocks);
    return flocks;
  }

  @action
  Future<Flock> addFlock(Flock flockData) async {
    final flock = await _flocksService.addFlockRpc.request(flockData);
    flocks.add(flock);
    return flock;
  }

  @action
  Future<Flock> disableFlock(Flock flockData) async {
    final disabledFlock =
        await _flocksService.disableFlockRpc.request(flockData);
    flocks[disabledFlock.id] = disabledFlock;
    return disabledFlock;
  }

  @action
  Future<Flock> restoreFlock(Flock flockData) async {
    final restoredFlock =
        await _flocksService.restoreFlockRpc.request(flockData);
    flocks[restoredFlock.id] = restoredFlock;
    return restoredFlock;
  }

  @action
  List<Flock> searchFlockById(String queryString) =>
      flocks.where((f) => f.id.toString() == queryString).toList();

  @action
  int todayFlockCount(DateTime date) =>
      flocks
          .where((f) => f.date.year == date.year)
          .where((f) => f.date.month == date.month)
          .where((f) => f.date.day == date.day)
          .length ??
      0;

  @action
  int todayFlockFirst(DateTime date) => flocks
      .firstWhere(
          (f) =>
              f.date.year == date.year &&
              f.date.month == date.month &&
              f.date.day == date.day,
          orElse: () => null)
      ?.id;

  @action
  int todayFlockLast(DateTime date) => flocks
      .lastWhere(
          (f) =>
              f.date.year == date.year &&
              f.date.month == date.month &&
              f.date.day == date.day,
          orElse: () => null)
      ?.id;
}
