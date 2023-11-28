part of 'instance_cubit.dart';

@immutable
sealed class InstanceState {}

final class InstanceInitial extends InstanceState {}

final class InstanceLoading extends InstanceState {}

final class InstanceLoaded extends InstanceState {
  final List<InstanceModel> instances;

  InstanceLoaded({required this.instances});
}

final class InstanceSingle extends InstanceState {
  final InstanceModel instance;

  InstanceSingle({required this.instance});
}

final class InstanceError extends InstanceState {
  final String msg;

  InstanceError({required this.msg});
}
