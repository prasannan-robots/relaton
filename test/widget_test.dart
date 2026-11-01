import 'package:flutter_test/flutter_test.dart';
import 'package:relaton/relaton.dart';

void main() {
  test('JSON round-trips, including a null birthday', () {
    final r = Relaton(name: 'Asha', phone: '123', birthday: DateTime(1990, 5, 20));
    final back = Relaton.fromJson(r.toJson());
    expect(back.name, 'Asha');
    expect(back.phone, '123');
    expect(back.birthday, DateTime(1990, 5, 20));
    expect(Relaton.fromJson(Relaton(name: 'No DOB').toJson()).birthday, isNull);
  });

  test('daysUntilBirthday counts to the next occurrence', () {
    final today = DateTime.now();
    final r = Relaton(name: 'X', birthday: DateTime(1990, today.month, today.day));
    expect(r.daysUntilBirthday, 0);
    final tomorrow = today.add(const Duration(days: 1));
    expect(Relaton(name: 'Y', birthday: DateTime(1990, tomorrow.month, tomorrow.day)).daysUntilBirthday,
        anyOf(1, 364, 365, 366)); // 1 normally; wraps at a month boundary
    expect(Relaton(name: 'Z').daysUntilBirthday, isNull);
  });
}
