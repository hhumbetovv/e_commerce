class DeepEquality {
  static bool listEquals(List? a, List? b) {
    if (a == b) {
      return true;
    }

    if (a == null || b == null) {
      return false;
    }

    if (a.length != b.length) {
      return false;
    }

    for (int i = 0; i < a.length; i++) {
      if (a[i] is List && b[i] is List) {
        if (!listEquals(a[i], b[i])) {
          return false;
        }
      } else if (a[i] is Set && b[i] is Set) {
        if (!listEquals(a[i].toList(), b[i].toList())) {
          return false;
        }
      } else if (a[i] is Map && b[i] is Map) {
        if (!listEquals(a[i].entries.toList(), b[i].entries.toList())) {
          return false;
        }
      } else if (a[i] != b[i]) {
        return false;
      }
    }

    return true;
  }
}
