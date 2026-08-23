import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/entites/notification_entity.dart';
import 'package:meta/meta.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial()) {
    _loadDummyNotifications();
  }

  List<NotificationEntity> _notifications = [];

  void _loadDummyNotifications() {
    _notifications = [
      NotificationEntity(
        id: '1',
        title: 'عرض خاص!',
        body: 'احصل على خصم ٢٠٪ على جميع الفواكه الصيفية لفترة محدودة.',
        date: DateTime.now().subtract(const Duration(minutes: 15)),
        isRead: false,
      ),
      NotificationEntity(
        id: '2',
        title: 'تم شحن طلبك',
        body: 'طلبك رقم #١٢٣٤ في الطريق إليك الآن. يمكنك تتبعه من قائمة الطلبات.',
        date: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
      ),
      NotificationEntity(
        id: '3',
        title: 'مرحباً بك في تطبيق فواكه',
        body: 'يسعدنا انضمامك إلينا. استكشف أفضل المنتجات الطازجة يومياً.',
        date: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
    ];
    emit(NotificationsLoaded(notifications: _notifications));
  }

  void markAllAsRead() {
    _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
    emit(NotificationsLoaded(notifications: _notifications));
  }

  void markAsRead(String id) {
    _notifications = _notifications.map((n) {
      if (n.id == id) {
        return n.copyWith(isRead: true);
      }
      return n;
    }).toList();
    emit(NotificationsLoaded(notifications: _notifications));
  }
}
