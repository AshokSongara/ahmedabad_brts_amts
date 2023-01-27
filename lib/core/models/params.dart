import 'package:equatable/equatable.dart';

class Params extends Equatable {
  final dynamic data;

  const Params({required this.data});

  @override
  List<Object> get props => [data];
}