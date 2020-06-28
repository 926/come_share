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
