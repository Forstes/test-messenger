String getInitials(String fullName) {
  List<String> words = fullName.split(' ');
  if (words.isEmpty) return '';

  return words.map((word) => word[0].toUpperCase()).join('');
}
