import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/widgets/build_app_bar.dart';
import 'package:fruts_e_commerce/features/notifications/presentation/cubits/notifications_cubit.dart';
import 'package:fruts_e_commerce/features/notifications/presentation/views/widgets/notification_item.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';

class NotificationsViewBody extends StatelessWidget {
  const NotificationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(width: 32), // Balance for back button
              Expanded(
                child: buildAppBar(context, title: 'الإشعارات', showBackButton: true),
              ),
              BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  if (state is NotificationsLoaded) {
                    final unreadCount = state.notifications.where((n) => !n.isRead).length;
                    if (unreadCount > 0) {
                      return GestureDetector(
                        onTap: () {
                          context.read<NotificationsCubit>().markAllAsRead();
                        },
                        child: Text(
                          'تحديد الكل مقروء',
                          style: AppTextStyles.regular13.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      );
                    }
                  }
                  return const SizedBox(width: 100); // Placeholder
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                if (state is NotificationsLoaded) {
                  if (state.notifications.isEmpty) {
                    return const Center(child: Text('لا توجد إشعارات'));
                  }
                  return ListView.separated(
                    itemCount: state.notifications.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return NotificationItem(
                        notification: state.notifications[index],
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
