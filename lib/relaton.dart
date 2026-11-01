/// A "relaton" — a person you want to keep in touch with.
class Relaton {
  Relaton({required this.name, this.phone = '', this.birthday});

  final String name;
  final String phone;
  final DateTime? birthday;

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'birthday': birthday?.toIso8601String(),
      };

  factory Relaton.fromJson(Map<String, dynamic> json) => Relaton(
        name: json['name'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        birthday: (json['birthday'] as String?) != null
            ? DateTime.tryParse(json['birthday'] as String)
            : null,
      );

  /// Days until the next birthday, or null if no birthday is set.
  int? get daysUntilBirthday {
    final b = birthday;
    if (b == null) return null;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    var next = DateTime(today.year, b.month, b.day);
    if (next.isBefore(today)) next = DateTime(today.year + 1, b.month, b.day);
    return next.difference(today).inDays;
  }
}
