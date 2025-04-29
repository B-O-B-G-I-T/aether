part of 'peer_bloc.dart';

@immutable
sealed class PeerState {}

final class PeerInitial extends PeerState {}

final class PeerLoading extends PeerState {}

final class PeerConnected extends PeerState {
  final List<PeerEntity> connectedPeers;

  PeerConnected({required this.connectedPeers});
}

final class PeerConnecting extends PeerState {}

final class PeerLoaded extends PeerState {
  final List<PeerEntity> peers;
  final List<PeerEntity>? connectedPeers;

  PeerLoaded({required this.peers, this.connectedPeers});
}

final class PeerError extends PeerState {
  final Failure failure;

  PeerError({required this.failure});
}
