import 'package:graphql_flutter/graphql_flutter.dart';

class MainRepository {
  static final MainRepository _instance = MainRepository._internal();

  factory MainRepository() {
    return _instance;
  }

  MainRepository._internal();

  static MainRepository get instance => _instance;

  final HttpLink _httpLink = HttpLink('https://api.spacex.land/graphql');

  static const String readMissions = r'''
  {
  launchesPast {
    mission_name
    details
  }
}
  ''';

  late GraphQLClient _client;

  GraphQLClient getGraphQLClient() {
    _client = GraphQLClient(
        link: _httpLink, cache: GraphQLCache(store: InMemoryStore()));

    return _client;
  }

  Future<QueryResult> getMissions() async {
    try {
      final result = await getGraphQLClient()
          .query(QueryOptions(document: gql(readMissions)));

      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
