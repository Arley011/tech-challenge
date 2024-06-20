class NumbersUtil {
  static num? getMinElement(Iterable<num?> elements) {
    return elements.reduce((value, element) {
      if (value != null && element != null) {
        return value < element ? value : element;
      } else if (value != null) {
        return value;
      } else if (element != null) {
        return element;
      } else {
        return null;
      }
    });
  }

  static num? getMaxElement(Iterable<num?> elements) {
    return elements.reduce((value, element) {
      if (value != null && element != null) {
        return value > element ? value : element;
      } else if (value != null) {
        return value;
      } else if (element != null) {
        return element;
      } else {
        return null;
      }
    });
  }
}
