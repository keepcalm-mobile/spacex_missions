import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_missions/modules/main/bloc/main_bloc.dart';

void main() {
  group("Main bloc tests", () {
    test("Initial state", () {
      final bloc = MainBloc();
      expect(
          bloc.state,
          MainState(
              status: ApiResponse.loading,
              data: [],
              searchResults: [],
              loadItems: 0));
    });

    blocTest("OnSearch event",
        build: () => MainBloc(),
        act: (mainBloc) => (mainBloc as MainBloc).add(OnSearch("test")),
        expect: () => [
              MainState(
                  status: ApiResponse.initial,
                  data: [],
                  searchResults: [],
                  loadItems: 0)
            ]);

    blocTest("Clear event",
        build: () => MainBloc(),
        act: (mainBloc) => (mainBloc as MainBloc).add(Clear()),
        expect: () => [
              MainState(
                  status: ApiResponse.initial,
                  data: [],
                  searchResults: [],
                  loadItems: 0)
            ]);

    blocTest("LoadMore event",
        build: () => MainBloc(),
        act: (mainBloc) => (mainBloc as MainBloc).add(LoadMore()),
        expect: () => [
              MainState(
                  status: ApiResponse.loading,
                  data: [],
                  searchResults: [],
                  loadItems: 0)
            ]);
  });
}
