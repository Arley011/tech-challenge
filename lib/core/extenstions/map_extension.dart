extension MapExtension on Map {
  /// Put if not null
  void putIfNotNull(String key, dynamic value) {
    if (value != null) {
      this[key] = value;
    }
  }
}