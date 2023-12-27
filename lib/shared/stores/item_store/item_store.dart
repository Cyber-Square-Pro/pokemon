import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:app/shared/models/item.dart';
import 'package:app/shared/repositories/item_repository.dart';

part 'item_store.g.dart';

class ItemStore = ItemStoreBase with _$ItemStore;

abstract class ItemStoreBase with Store {
  final ItemRepository _itemRepository = GetIt.instance<ItemRepository>();

  @observable
  List<Item> _items = [];

  @observable
  String? _filter;

  @computed
  String? get filter => _filter;

  @computed
  List<Item> get items {
    if (_filter != null) {
      return _items
          .where((it) => it.name.toLowerCase().contains(_filter!.toLowerCase()))
          .toList();
    }

    return _items;
  }

  @action
  void setFilter(String filter) {
    _filter = filter;
  }

  @action
  void clearFilter() {
    _filter = null;
  }

  @action
  Future<void> fetchItems() async {
    _items = await _itemRepository.fetchItems();
  }
}
