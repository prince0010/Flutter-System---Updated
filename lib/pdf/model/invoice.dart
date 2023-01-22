class Invoice {
  final String customer;
  final String address;
  final String name;
  final List<LineItem> items;

  Invoice({
    required this.customer,
    required this.address,
    required this.items,
    required this.name,
  });
}

class LineItem {
  final String description;
  final String customername;

  LineItem(this.description, this.customername);
}
