import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samriddhi_algo_trade_app/core/models/broker_model.dart';
import 'package:samriddhi_algo_trade_app/features/auth/providers/auth_selectors.dart';
import '../../../core/constants/app_constants.dart';
import '../../core/routes/app_routes.dart';
import '../../core/themes/app_colors.dart';

class BrokerConnectScreen extends ConsumerStatefulWidget {
  const BrokerConnectScreen({super.key});

  @override
  ConsumerState<BrokerConnectScreen> createState() =>
      _BrokerConnectScreenState();
}

class _BrokerConnectScreenState extends ConsumerState<BrokerConnectScreen> {
  BrokerModel? _selectedBroker;
  bool _loading = false;

  Future<void> _connect() async {
    if (_selectedBroker == null) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));
    // await ref.read(authStateProvider.notifier).connectBroker(_selectedBroker!);
    // if (mounted) context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    _selectedBroker = ref.watch(currentBrokerProvider);
    final allBroker = ref.watch(allBrokerProvider);
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.link_rounded,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Connect\nYour Broker',
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.textPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Link your broker account to enable automated trading.',
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.info.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.security_outlined,
                      color: AppColors.info,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'We connect via secure API. Your login credentials are never stored.',
                        style: GoogleFonts.spaceGrotesk(
                          color: AppColors.info,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'SELECT BROKER',
                style: GoogleFonts.spaceGrotesk(
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: allBroker!.length,
                  itemBuilder: (_, i) {
                    final broker = allBroker[i];
                    final selected = _selectedBroker == broker;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedBroker = broker),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.primary.withValues(alpha: 0.12)
                              : AppColors.bgCard,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selected
                                ? AppColors.primary
                                : AppColors.border,
                            width: selected ? 1.5 : 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            broker.brokerName,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.spaceGrotesk(
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              fontSize: 13,
                              fontWeight: selected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              _loading
                  ? Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.bgDark,
                          ),
                        ),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: _selectedBroker != null ? _connect : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedBroker != null
                            ? AppColors.primary
                            : AppColors.bgSurface,
                        foregroundColor: _selectedBroker != null
                            ? AppColors.bgDark
                            : AppColors.textMuted,
                      ),
                      child: Text('Connect ${_selectedBroker ?? 'Broker'}'),
                    ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () => context.go(AppRoutes.home),
                  child: Text(
                    'Skip for now',
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.textMuted,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
