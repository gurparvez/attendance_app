String formatName(String name) {
  return name.split(" ").map((word) => word.capitalize()).join(" ");
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}