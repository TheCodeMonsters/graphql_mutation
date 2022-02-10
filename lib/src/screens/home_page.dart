import 'package:flutter/material.dart';
import 'package:flutter_mutation/src/screens/update_user.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:flutter_mutation/src/screens/user.dart';

import 'add_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Query(
        options: QueryOptions(document: gql(User.query)),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            return const Center(child: CircularProgressIndicator());
          } else if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: result.data!['User']?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(result.data!['User'][index]['name']),
                subtitle: Text(result.data!['User'][index]['email']),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateUser(
                      name: result.data!['User'][index]['name'],
                      email: result.data!['User'][index]['email'],
                      id: result.data!['User'][index]['id'],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddUser(),
          ),
        ),
      ),
    );
  }
}
