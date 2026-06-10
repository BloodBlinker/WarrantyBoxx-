import 'package:flutter_test/flutter_test.dart';
import 'package:warranty_vault/domain/services/notification_messages.dart';
import 'package:warranty_vault/domain/services/notification_service.dart';
import 'package:warranty_vault/l10n/app_localizations_en.dart';

void main() {
  final l10n = AppLocalizationsEn();
  final expiry = DateTime(2026, 7, 1);

  test('30-day reminder uses the Appendix C template', () {
    final msg = NotificationMessages.forOffset(l10n,
        offsetDays: 30, itemName: 'Laptop', expiryDate: expiry);
    expect(msg.title, 'Warranty expiring soon');
    expect(msg.body, contains('Laptop'));
    expect(msg.body, contains('30 days'));
  });

  test('7-day reminder mentions the Claim Assistant', () {
    final msg = NotificationMessages.forOffset(l10n,
        offsetDays: 7, itemName: 'Drill', expiryDate: expiry);
    expect(msg.title, 'Act now — 7 days left');
    expect(msg.body, contains('Claim Assistant'));
  });

  test('1-day reminder warns it expires tomorrow', () {
    final msg = NotificationMessages.forOffset(l10n,
        offsetDays: 1, itemName: 'TV', expiryDate: expiry);
    expect(msg.title, contains('Last chance'));
    expect(msg.body, contains('tomorrow'));
  });

  test('non-standard offset falls back to the generic template', () {
    final msg = NotificationMessages.forOffset(l10n,
        offsetDays: 60, itemName: 'Fridge', expiryDate: expiry);
    expect(msg.body, contains('Fridge'));
    expect(msg.body, contains('60'));
  });

  test('notificationId is deterministic and stable per item+offset', () {
    final a = NotificationService.notificationId('item-1', 30);
    final b = NotificationService.notificationId('item-1', 30);
    final c = NotificationService.notificationId('item-1', 7);
    expect(a, b);
    expect(a, isNot(c));
    expect(a, greaterThanOrEqualTo(0));
  });
}
