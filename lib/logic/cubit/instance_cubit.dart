import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:thingy_app/logic/repository/master_repo.dart';
import 'package:thingy_app/models/instance_model.dart';

part 'instance_state.dart';

class InstanceCubit extends Cubit<InstanceState> {
  InstanceCubit() : super(InstanceInitial());
  Future<void> getInstances() async {
    emit(InstanceLoading());
    await MasterRepo()
        .getInstances()
        .then((instances) => emit(InstanceLoaded(instances: instances)))
        .catchError((m) {
      emit(InstanceError(msg: m.toString()));
    });
  }

  Future<void> viewInstance(int instanceId) async {
    emit(InstanceLoading());
    await MasterRepo()
        .viewInstance(instanceId)
        .then((instance) => emit(InstanceSingle(instance: instance)))
        .catchError((msg) {
      emit(InstanceError(msg: msg.toString()));
    });
  }
}
