import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical/Models/source.dart';
import 'package:practical/Network/api_request.dart';
import 'package:practical/Repository/articlerepo.dart';
import 'package:practical/Services/auth.dart';

import '../source_cubit.dart';
import 'articlescreen.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.auth,}) : super(key: key);
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News Info'),
          actions: [
            FlatButton(
              child: Text(
                'Logout',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              onPressed: _signOut,
            ),
          ],
        ),
        body: Center(
          child: BlocBuilder<SourceCubit, SourceState>(
            builder: (context, state) {
              if (state is SourceInitial) {
                return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                      strokeWidth: 6,
                    ));
              } else if (state is SourceLoading) {
                return Center(
                    child: CircularProgressIndicator(
                      color: Colors.redAccent,
                      strokeWidth: 6,
                    ));
              } else if (state is SourceLoaded) {
                final sources = state.sources;
                return _buildListView(context, sources);
              }

              return Center(child: Text("Coudn't connect to server. !!"));
            },
          ),
        )
    );
  }
}

Widget _buildListView(BuildContext context, List<Sources> sources) {
  ArticleRepository repository =
  ArticleRepository(ApiRequest(Dio()));
  return ListView.builder(
    itemCount: 5, //sources.length
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BlocProvider(
                          create: (context) {
                            return SourceCubit(repository);
                          },
                          child: ArticleScreen())));
        },
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          padding: EdgeInsets.all(4),
          child: SizedBox(
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            sources[index].name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            sources[index].description.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                "Category : " +
                                    sources[index].category.toString(),
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, bottom: 4),
                              child: Text(
                                "Country : " +
                                    sources[index].country.toString(),
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}