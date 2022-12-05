import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbro/models/move_model.dart';
import 'package:gymbro/providers/fetch_state.dart';
import 'package:gymbro/services/api_service.dart';

final moveProvider =
    StateNotifierProvider.family<_MoveNotifier, FetchState, String>(
  (ref, area) => _MoveNotifier(area),
);

class _MoveNotifier extends StateNotifier<FetchState> {
  final String area;
  _MoveNotifier(this.area) : super(Fetching()) {
    fetch();
  }

  void fetch() async {
    try {
      state = Fetching();
      final result = await api.getMoves(area);
      state = Fetched<List<MoveModel>>(result);
    } catch (e) {
      state = FetchError(e);
      rethrow;
    }
  }
}
