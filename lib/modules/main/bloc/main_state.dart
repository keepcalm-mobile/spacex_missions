part of 'main_bloc.dart';

class MainState extends Equatable {
  final ApiResponse? status;
  final List<LaunchModel>? data;
  final List<LaunchModel>? searchResults;
  final int? loadItems;

  MainState({this.status, this.data, this.searchResults, this.loadItems});

  MainState copyWith(
      {ApiResponse? status,
      List<LaunchModel>? data,
      List<LaunchModel>? searchResults,
      int? loadItems}) {
    return MainState(
        status: status ?? this.status,
        data: data ?? this.data,
        searchResults: searchResults ?? this.searchResults,
        loadItems: loadItems ?? this.loadItems);
  }

  @override
  List<Object> get props => [status!, data!, searchResults!, loadItems!];
}
