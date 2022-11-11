import 'package:equatable/equatable.dart';

class Params extends Equatable {
  final dynamic data;

  Params({required this.data});

  @override
  List<Object> get props => [data];
}