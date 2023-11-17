import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'instance_state.dart';

class InstanceCubit extends Cubit<InstanceState> {
  InstanceCubit() : super(InstanceInitial());
}
