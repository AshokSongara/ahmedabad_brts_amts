import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

abstract class FileUseCase<Type, Params> {
  Future<Type> call(Params params,Params params1);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
