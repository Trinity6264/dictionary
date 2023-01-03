import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dictionary/constant/enums.dart';
import 'package:equatable/equatable.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  // Connectivity Plugin
  final Connectivity connectivity;
  // Stream listener variable
  StreamSubscription? subscription;
  InternetCubit({required this.connectivity}) : super(InternetInitial()) {
    subscription = connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.mobile);
      } else if (event == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.wifi);
      } else if (event == ConnectivityResult.none) {
        emitInternetDisConnected();
      }
    });
  }
  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));
  void emitInternetDisConnected() => emit(InternetDisConnected());
}
