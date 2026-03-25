import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samriddhi_algo_trade_app/core/models/broker_model.dart';
import 'package:samriddhi_algo_trade_app/features/auth/providers/auth_notifier.dart';
import '../../../core/models/user_model.dart';
part 'auth_selectors.g.dart';

@riverpod
UserModel? currentUser(Ref ref) {
  final authState = ref.watch(authProvider);
  return authState.when(
    data: (data) => data.user,
    error: (_, _) => null,
    loading: () => null,
  );
}

@riverpod
List<BrokerModel>? allBroker(Ref ref) {
  final authState = ref.watch(authProvider);
  return authState.when(
    data: (data) => data.allBroker,
    error: (_, _) => null,
    loading: () => null,
  );
}

@riverpod
BrokerModel? currentBroker(Ref ref) {
  final authState = ref.watch(authProvider);

  return authState.when(
    data: (data) {
      final brokers = data.allBroker;
      final selectedId = data.userBrokerId;

      if (brokers == null || selectedId == null) return null;

      return brokers.firstWhere(
        (b) => b.brokerId == selectedId,
        orElse: () => brokers.first,
      );
    },
    loading: () => null,
    error: (_, _) => null,
  );
}
