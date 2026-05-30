int generateIdempotentKey() {
  // استفاده از milliseconds since epoch
  return DateTime.now().millisecondsSinceEpoch;
}