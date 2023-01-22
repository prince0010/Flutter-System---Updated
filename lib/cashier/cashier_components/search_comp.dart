class Item {
  final String title;

  Item({
    required this.title,
  });
}

class ItemPager {
  int pageIndex = 0;
  final int pageSize;

  ItemPager({
    this.pageSize = 10,
  });
  List<Item> next() {
    List<Item> batch = [];
    return batch;
  }

  List<Item> nextBatch() {
    List<Item> batch = [];

    for (int i = 0; i < pageSize; i++) {
      batch.add(Item(title: 'Item ${pageIndex * pageSize + i}'));
    }

    pageIndex += 1;

    return batch;
  }
}
