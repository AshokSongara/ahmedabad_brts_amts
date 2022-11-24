import 'package:equatable/equatable.dart';

abstract class MobileNumberLoginState extends Equatable {
  const MobileNumberLoginState();

  @override
  List<Object> get props => [];
}

class MobileNumberLoginInitialState extends MobileNumberLoginState{}
class MobileNumberValidationErrorState extends MobileNumberLoginState{}
class MobileNumberLoginErrorState extends MobileNumberLoginState{}
class MobileNumberLoginSuccessState extends MobileNumberLoginState{}
class MobileNumberLoadingState extends MobileNumberLoginState{}