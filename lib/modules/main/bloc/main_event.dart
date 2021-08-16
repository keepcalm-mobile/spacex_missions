part of 'main_bloc.dart';

class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class OnSearch extends MainEvent {
  final String query;

  OnSearch(this.query);

  @override
  List<Object> get props => [query];
}

class Clear extends MainEvent {}

class LoadMore extends MainEvent {}
