part of 'peer_config_bloc.dart';

@immutable
sealed class PeerConfigState {}

final class PeerConfigInitial extends PeerConfigState {}

final class PeerConfigLoading extends PeerConfigState {}

final class PeerConfigInitialised extends PeerConfigState {
  final NearbyService nearbyService;
  PeerConfigInitialised(this.nearbyService);
}

final class PeerConfigError extends PeerConfigState {
  final Failure failure;
  PeerConfigError(this.failure);
}
