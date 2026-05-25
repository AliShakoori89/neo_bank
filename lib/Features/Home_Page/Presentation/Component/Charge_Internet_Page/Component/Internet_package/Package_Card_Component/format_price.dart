String formatPrice(dynamic price) {
  int priceInt = int.tryParse(price.toString()) ?? 0;
  return priceInt.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match match) => '${match[1]},',
  );
}