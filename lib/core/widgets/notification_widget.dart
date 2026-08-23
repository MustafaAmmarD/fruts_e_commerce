import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruts_e_commerce/core/utils/app_images.dart';
import 'package:fruts_e_commerce/core/widgets/scale_on_tap.dart';
import 'package:fruts_e_commerce/features/notifications/presentation/cubits/notifications_cubit.dart';
import 'package:fruts_e_commerce/features/notifications/presentation/views/notifications_view.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: ScaleOnTap(
        onTap: () {
          Navigator.pushNamed(context, NotificationsView.routeName);
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const ShapeDecoration(
                color: Color(0xFFEEF8ED),
                shape: OvalBorder(),
              ),
              child: SvgPicture.asset(Assets.imagesNotification),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  if (state is NotificationsLoaded) {
                    final unreadCount = state.notifications.where((n) => !n.isRead).length;
                    if (unreadCount > 0) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2)
                        ),
                        child: Text(
                          unreadCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}