import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbro/models/gym_model.dart';
import 'package:gymbro/providers/fetch_state.dart';
import 'package:gymbro/services/api_service.dart';

final gymProvider = StateNotifierProvider<_GymNotifier, FetchState>(
  (ref) => _GymNotifier(),
);

class _GymNotifier extends StateNotifier<FetchState> {
  _GymNotifier() : super(Fetching()) {
    fetch();
  }

  void fetch() async {
    try {
      state = Fetching();
      final result = await api.getGyms();
      state = Fetched<List<GymModel>>(result);
    } catch (e) {
      state = FetchError(e);
    }
  }
}
