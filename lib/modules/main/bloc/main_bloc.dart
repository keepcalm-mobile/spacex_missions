import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:spacex_missions/models/launch_model.dart';
import 'package:spacex_missions/repositories/main_repo.dart';

part 'main_event.dart';
part 'main_state.dart';

enum ApiResponse { initial, loading, success, error }

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc()
      : super(MainState(
            status: ApiResponse.loading,
            data: [],
            searchResults: [],
            loadItems: 0)) {
    loadMissions();
  }

  void loadMissions() async {
    try {
      final QueryResult result = await MainRepository.instance.getMissions();

      if (result.hasException) {
        emit(state.copyWith(status: ApiResponse.error));
      }

      List<LaunchModel> data = (result.data!['launchesPast'] as List)
          .map((launch) => LaunchModel.fromJson(launch))
          .toList();

      emit(state.copyWith(status: ApiResponse.initial, data: data));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: ApiResponse.error));
    }
  }

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is OnSearch) {
      final List<LaunchModel> results = state.data!
          .where((launch) => launch.missionName
              .toLowerCase()
              .contains(event.query.toLowerCase()))
          .toList();

      if (results.length > 0) {
        int loadItems = results.length > 10 ? 10 : results.length;

        emit(state.copyWith(
            status: ApiResponse.success,
            searchResults: results,
            loadItems: loadItems));
      } else {
        emit(state.copyWith(status: ApiResponse.initial));
      }
    } else if (event is Clear) {
      if (state.status != ApiResponse.initial)
        emit(state.copyWith(status: ApiResponse.initial, searchResults: []));
    } else if (event is LoadMore) {
      if (state.searchResults!.length > state.loadItems! + 10) {
        emit(state.copyWith(loadItems: state.loadItems! + 10));
      } else {
        emit(state.copyWith(loadItems: state.searchResults!.length));
      }
    }
  }
}
