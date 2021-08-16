import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_missions/modules/main/bloc/main_bloc.dart';
import 'package:spacex_missions/modules/main/components/results_item.dart';
import 'package:spacex_missions/modules/main/components/text_input.dart';

class MainScreen extends StatelessWidget {
  final MainBloc mainBloc = MainBloc();
  final TextStyle textStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w700);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("SpaceX Missions")),
        body: BlocBuilder<MainBloc, MainState>(
            bloc: mainBloc,
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    TextInput(
                      label: "Type your search query",
                      enabled: state.status != ApiResponse.loading,
                      onChanged: (String? text) {
                        if (text!.length > 3)
                          mainBloc.add(OnSearch(text));
                        else
                          mainBloc.add(Clear());
                      },
                    ),
                    _buildContent(state),
                    _buildLoadMoreButton(state)
                  ],
                ),
              );
            }));
  }

  Widget _buildContent(MainState state) {
    if (state.status == ApiResponse.success) {
      return ListView.builder(
        itemCount: state.loadItems,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ResultsItem(
              missionName: state.searchResults![index].missionName,
              missionDetails: state.searchResults![index].details);
        },
      );
    } else if (state.status == ApiResponse.initial) {
      return Text("No results", style: textStyle);
    } else if (state.status == ApiResponse.error) {
      return Text("Error loading missions data", style: textStyle);
    } else {
      return CupertinoActivityIndicator();
    }
  }

  Widget _buildLoadMoreButton(MainState state) {
    if (state.searchResults!.length > state.loadItems!) {
      return SafeArea(
        child: ElevatedButton(
            onPressed: () {
              mainBloc.add(LoadMore());
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
            child: Text("Load more")),
      );
    } else
      return Container();
  }
}
