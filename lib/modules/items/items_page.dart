import 'package:app/shared/widgets/loading_spinner.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobx/mobx.dart';
import 'package:app/shared/models/item.dart';
import 'package:app/shared/stores/item_store/item_store.dart';
import 'package:app/shared/utils/image_utils.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  static const _pageSize = 20;

  final ItemStore _itemStore = GetIt.instance<ItemStore>();

  final PagingController<int, Widget> _pagingController =
      PagingController(firstPageKey: 0);

  late ReactionDisposer filterReactionDisposer;

  @override
  void initState() {
    _fetchItems();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    filterReactionDisposer = reaction((_) => _itemStore.filter, (_) {
      _pagingController.refresh();
    });

    super.initState();
  }

  Future<void> _fetchItems() async {
    await _itemStore.fetchItems();
  }

  double getItemsPagePadding(Size size) {
    double horizontalPadding = 0;

    if (size.width > 1200) {
      horizontalPadding = size.width * 0.15;
    } else {
      horizontalPadding = 10;
    }

    return horizontalPadding;
  }

  void _fetchPage(int pageKey) async {
    final maxRange = _itemStore.items.length;
    final initialRange = pageKey * _pageSize;
    final finalRange = (pageKey * _pageSize) + _pageSize > maxRange
        ? maxRange
        : (pageKey * _pageSize) + _pageSize;

    List<Widget> items = [];

    for (int index = initialRange; index < finalRange; index++) {
      final item = _itemStore.items[index];

      items.add(await _buildItemWidget(item: item));
    }

    if (maxRange == finalRange) {
      _pagingController.appendLastPage(items);
    } else {
      _pagingController.appendPage(items, pageKey + 1);
    }
  }

  Future<ListTile> _buildItemWidget({required Item item}) {
    return Future.delayed(
      Duration.zero,
      () {
        final TextTheme textTheme = Theme.of(context).textTheme;

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          tileColor: textTheme.bodySmall?.color?.withOpacity(0.1),
          leading: item.imageUrl != null
              ? ImageUtils.networkImage(
                  url: item.imageUrl!,
                  height: 30,
                  width: 30,
                )
              : const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                  size: 20,
                ),
          title: Text(
            item.name,
            style: TextStyle(
              fontFamily: 'Circular',
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              fontSize: 15.sp,
            ),
          ),
          trailing: Text(
            item.category,
            style: textTheme.titleSmall!.copyWith(
              fontFamily: 'Circular',
              fontWeight: FontWeight.normal,
              fontSize: 13.sp,
            ),
          ),
          subtitle: item.effect.trim().isNotEmpty
              ? Text(
                  item.effect,
                  style: textTheme.bodySmall!.copyWith(
                    fontFamily: 'Circular',
                    height: 1.3,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : null,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Observer(builder: (_) {
      if (_itemStore.items.isEmpty) {
        return SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              loadingSpinner(context),
            ],
          ),
        );
      } else {
        return SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: getItemsPagePadding(size),
          ),
          sliver: PagedSliverList.separated(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Widget>(
              itemBuilder: (context, item, index) => item,
            ),
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
          ),
        );
      }
    });
  }
}
