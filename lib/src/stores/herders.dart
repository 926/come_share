import 'dart:convert' as convert;
import 'package:mobx/mobx.dart';
import 'package:come_share/src/models/herder.dart';
import 'package:come_share/src/servives/herders.dart';

part 'herders.g.dart';

class HerdersStore = HerdersStoreBase with _$HerdersStore;

abstract class HerdersStoreBase with Store {
  final HerdersService _herdersService;

  @observable
  bool initialLoading;

  @observable
  ObservableList<Herder> herders;

  HerdersStoreBase(this._herdersService) {
    initialLoading = true;
    herders = ObservableList<Herder>();
  }

  @action
  Future<List<Herder>> saveAllHerders(List<Herder> _herders) async {
    herders = ObservableList.of(_herders);
    await _herdersService.saveAllHerdersRpc.request(herders);
    return herders;
  }

  @action
  Future<void> init() async {
    await loadTasks();
    initialLoading = false;
  }

  @action
  Future<void> loadTasks() async {
    final _herders = await _herdersService.getHerdersRpc.request(null);
    herders = ObservableList.of(_herders);
    initialLoading = false;
  }

  @action
  Future<Herder> createHerder(Herder herderData) async {
    final herder = await _herdersService.createHerderRpc.request(herderData);
    herders.add(herder);
    return herder;
  }

  @action
  Future<Herder> updateHerder(Herder herder) async {
    final updateHerder = await _herdersService.updateHerderRpc.request(herder);
    final herderIndex = updateHerder.id;
    herders[herderIndex] = updateHerder;
    return updateHerder;
  }

  @action
  Future<Herder> disableHerder(Herder herderdata) async {
    final disableHerder =
        await _herdersService.disableHerderRpc.request(herderdata);
    final herderIndex = disableHerder.id;
    herders[herderIndex] = disableHerder;
    return disableHerder;
  }

  @action
  Future<Herder> restoreHerder(Herder herderData) async {
    final restoredHerder =
        await _herdersService.restoreHerderRpc.request(herderData);
    var herderIndex = restoredHerder.id;
    herders[herderIndex] = restoredHerder;
    return restoredHerder;
  }

  @action
  Future<ObservableList<Herder>> deleteForeverHerder(Herder herder) async {
    await _herdersService.deleteForeverHerderRpc.request(herder);
    herders.remove(herder);
    return herders;
  }

  @action
  Future<ObservableList<Herder>> deleteAllHerders(
      List<Herder> theseHerders) async {
    await _herdersService.deleteAllHerdersRpc.request(theseHerders);
    herders.clear();
    return herders;
  }

  @action
  Future<ObservableList<Herder>> importHerders(String json) async {
    final _herders = (convert.json.decode(json) as List)
        .cast<Map>()
        .cast<Map<String, dynamic>>()
        .map((herder) => Herder.fromJson(herder))
        .toList();
    herders = ObservableList.of(_herders);
    await _herdersService.saveAllHerdersRpc.request(herders);
    return herders;
  }

  @action
  Future<ObservableList<Herder>> importHerdersFromMongo(
      List<Herder> _herders) async {
    herders = ObservableList.of(_herders);
    await _herdersService.saveAllHerdersRpc.request(_herders.toList());
    return herders;
  }

  @action
  List<Herder> searchHerderByQr(String queryString) =>
      herders.where((p) => p.qrcode.toString() == queryString).toList();
}
