import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/constants.dart';
import 'package:fruts_e_commerce/core/utils/app_images.dart';
import 'package:fruts_e_commerce/core/helper_functions/get_user.dart';
import 'package:fruts_e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),
          const Text(
            'حسابي',
            style: AppTextStyles.bold19,
          ),
          const SizedBox(height: 32),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'edit_profile_view');
            },
            child: Row(
              children: [
                const SizedBox(width: 16),
                Container(
                  width: 73,
                  height: 73,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(Assets.imagesProfileImage2), // Placeholder
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Icon(Icons.person, size: 40, color: Colors.grey), // Fallback icon
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getUser().name,
                        style: AppTextStyles.bold16,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        getUser().email,
                        style: AppTextStyles.regular13.copyWith(
                          color: const Color(0xFF949D9E),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFF949D9E),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildProfileItem(
            icon: Icons.list_alt,
            title: 'طلباتي',
            onTap: () {
              Navigator.pushNamed(context, 'orders_view');
            },
          ),
          _buildProfileItem(
            icon: Icons.location_on_outlined,
            title: 'عناويني',
            onTap: () {
              Navigator.pushNamed(context, 'addresses_view');
            },
          ),
          _buildProfileItem(
            icon: Icons.credit_card,
            title: 'المدفوعات',
            onTap: () {
              Navigator.pushNamed(context, 'payments_view');
            },
          ),
          _buildProfileItem(
            icon: Icons.favorite_border,
            title: 'المفضلة',
            onTap: () {
              Navigator.pushNamed(context, 'favorites_view');
            },
          ),
          _buildProfileItem(
            icon: Icons.info_outline,
            title: 'من نحن',
            onTap: () {
              Navigator.pushNamed(context, 'about_us_view');
            },
          ),
          _buildProfileItem(
            icon: Icons.logout,
            title: 'تسجيل الخروج',
            isLogout: true,
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              await Prefs.setString(kUserData, '');
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: isLogout ? Colors.red : const Color(0xFF4E5556),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bold13.copyWith(
                  color: isLogout ? Colors.red : const Color(0xFF4E5556),
                ),
              ),
            ),
            if (!isLogout)
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFF949D9E),
              ),
          ],
        ),
      ),
    );
  }
}
