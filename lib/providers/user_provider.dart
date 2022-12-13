import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbro/models/basic_user_model.dart';
import 'package:gymbro/providers/fetch_state.dart';

import '../services/api_service.dart';

final userProvider = StateNotifierProvider<_UserNotifier, FetchState>(
  (ref) => _UserNotifier(),
);

class _UserNotifier extends StateNotifier<FetchState> {
  _UserNotifier() : super(Fetching()) {
    fetch();
  }

  void fetch() async {
    try {
      state = Fetching();
      final result = await api.getUserDetail();
      state = Fetched<List<BasicUserModel>>(result);
    } catch (e) {
      state = FetchError(e);
      rethrow;
    }
  }
}
