import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/contact_tracing/model/contact_tracing.dart';
import 'package:monigate_app/contact_tracing/states/contact_tracing_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

final contactTracingStateProvider = StateNotifierProvider<ContactTracingNotifier, ContractTracingState>((ref) {
  return ContactTracingNotifier();
});

class ContactTracingNotifier extends StateNotifier<ContractTracingState> {
  ContactTracingNotifier() : super(const ContractTracingState.initial());

  getContactTracing() async {
    final pref = await SharedPreferences.getInstance();
    final json = pref.getString('tracing');

    if (json == null) {
      state = const ContractTracingState.empty();
      return;
    }

    final List<dynamic> tracingListJson = jsonDecode(json);
    state = ContractTracingState.data(tracingListJson.map((element) => ContactTracing.fromJson(element)).toList());

    // state = tracing == null ? const ContractTracingState.empty() : ContractTracingState.data(tracing);
  }

  clearHistory() async {
    state = const ContractTracingState.empty();
    final pref = await SharedPreferences.getInstance();
    pref.remove('tracing');
  }
}
