import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samriddhi_algo_trade_app/features/auth/providers/auth_notifier.dart';
import 'package:samriddhi_algo_trade_app/features/auth/providers/auth_selectors.dart';
import '../../core/routes/app_routes.dart';
import '../../core/themes/app_colors.dart';
import 'widgets/status_badge.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final broker = ref.watch(currentBrokerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Avatar + Name
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.primaryDark],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            user?.name.isNotEmpty == true
                                ? user!.name[0].toUpperCase()
                                : 'T',
                            style: GoogleFonts.spaceMono(
                              color: AppColors.bgDark,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: AppColors.bgCard,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.bgDark,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            size: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    user?.name ?? 'Trader',
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.email ?? '',
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.textMuted,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (broker != null)
                    StatusBadge(
                      label: '🔗 ${broker.brokerName} Connected',
                      color: AppColors.success,
                    )
                  else
                    GestureDetector(
                      onTap: () => context.push(AppRoutes.brokerConnect),
                      child: const StatusBadge(
                        label: '⚠️ Connect Broker',
                        color: AppColors.warning,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Stats row
            Row(
              children: [
                _StatBox(
                  label: 'Strategies',
                  value: '4',
                  icon: Icons.auto_graph_rounded,
                ),
                const SizedBox(width: 12),
                _StatBox(
                  label: 'Total Trades',
                  value: '247',
                  icon: Icons.swap_horiz_rounded,
                ),
                const SizedBox(width: 12),
                _StatBox(
                  label: 'Days Active',
                  value: '30',
                  icon: Icons.calendar_today_outlined,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Account Info
            _SectionCard(
              title: 'Account Details',
              children: [
                _InfoRow(
                  icon: Icons.person_outline,
                  label: 'Full Name',
                  value: user?.name ?? 'N/A',
                ),
                _InfoRow(
                  icon: Icons.mail_outline,
                  label: 'Email',
                  value: user?.email ?? 'N/A',
                ),
                _InfoRow(
                  icon: Icons.phone_outlined,
                  label: 'Mobile',
                  value: user?.mobile ?? 'N/A',
                ),
                _InfoRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'Joined',
                  value: 'March 2026',
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Broker Info
            _SectionCard(
              title: 'Broker Account',
              children: [
                _InfoRow(
                  icon: Icons.link_rounded,
                  label: 'Broker',
                  value: broker?.brokerName ?? 'Not Connected',
                  valueColor: broker != null
                      ? AppColors.success
                      : AppColors.warning,
                ),

                _ActionRow(
                  icon: Icons.swap_horiz_rounded,
                  label: 'Change Broker',
                  onTap: () => context.push(AppRoutes.brokerConnect),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // More
            _SectionCard(
              title: 'More',
              children: [
                _ActionRow(
                  icon: Icons.info_outline_rounded,
                  label: 'About Us',
                  onTap: () => context.push(AppRoutes.about),
                ),
                _ActionRow(
                  icon: Icons.description_outlined,
                  label: 'Terms & Conditions',
                  onTap: () {},
                ),
                _ActionRow(
                  icon: Icons.privacy_tip_outlined,
                  label: 'Privacy Policy',
                  onTap: () {},
                ),
                _ActionRow(
                  icon: Icons.help_outline_rounded,
                  label: 'Help & Support',
                  onTap: () {},
                ),
                _ActionRow(
                  icon: Icons.star_outline_rounded,
                  label: 'Rate the App',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Logout
            OutlinedButton.icon(
              onPressed: () => _showLogoutDialog(context, ref),
              icon: const Icon(
                Icons.logout_rounded,
                size: 18,
                color: AppColors.danger,
              ),
              label: Text(
                'Logout',
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.danger,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.danger),
                foregroundColor: AppColors.danger,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Samriddhi Algo Trade v1.0.0',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textMuted,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.bgCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
        title: Text(
          'Logout?',
          style: GoogleFonts.spaceGrotesk(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'All active strategies will remain paused. You can re-enable them after logging in.',
          style: GoogleFonts.spaceGrotesk(
            color: AppColors.textSecondary,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.spaceGrotesk(color: AppColors.textMuted),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // Navigator.pop(context);
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) context.go(AppRoutes.login);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger),
            child: Text(
              'Logout',
              style: GoogleFonts.spaceGrotesk(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _StatBox({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.spaceMono(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.textMuted,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            title.toUpperCase(),
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: children.asMap().entries.map((e) {
              return Column(
                children: [
                  e.value,
                  if (e.key < children.length - 1)
                    const Divider(
                      height: 1,
                      color: AppColors.border,
                      indent: 50,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textMuted, size: 18),
          const SizedBox(width: 14),
          Text(
            label,
            style: GoogleFonts.spaceGrotesk(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              color: valueColor ?? AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;
  const _ActionRow({
    required this.icon,
    required this.label,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textMuted, size: 18),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                ),
              ),
            ),
            trailing ??
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.textMuted,
                  size: 18,
                ),
          ],
        ),
      ),
    );
  }
}
