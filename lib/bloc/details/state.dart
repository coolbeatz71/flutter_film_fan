part of 'bloc.dart';

abstract class DetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

class DetailsLoading extends DetailsState {}

class DetailsSuccess extends DetailsState {
  final Details data;

  DetailsSuccess({@required this.data});

  @override
  List<Object> get props => [data];
}

class DetailsFail extends DetailsState {
  final String message;

  DetailsFail({@required this.message});

  @override
  List<Object> get props => [message];
}
