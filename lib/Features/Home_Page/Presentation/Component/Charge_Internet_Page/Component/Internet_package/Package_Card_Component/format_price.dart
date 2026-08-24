String formatPrice(dynamic price) {
  if (price == null) return '۰';
  
  String priceStr = price.toString().replaceAll(',', '');
  int priceInt = int.tryParse(priceStr) ?? 0;
  
  return priceInt.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match match) => '${match[1]},',
  );
}