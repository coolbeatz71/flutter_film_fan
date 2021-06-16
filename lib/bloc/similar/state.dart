part of 'bloc.dart';

abstract class SimilarState extends Equatable {
  @override
  List<Object> get props => [];
}

class SimilarLoading extends SimilarState {}

class SimilarSuccess extends SimilarState {
  final Similar data;

  SimilarSuccess({@required this.data});

  @override
  List<Object> get props => [data];
}

class SimilarFail extends SimilarState {
  final String message;

  SimilarFail({@required this.message});

  @override
  List<Object> get props => [message];
}
