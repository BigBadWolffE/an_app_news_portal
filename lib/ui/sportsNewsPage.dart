import 'package:anappnewsportal/bloc/sportsNewsBloc.dart';
import 'package:anappnewsportal/bloc/sportsNewsBlocEvent.dart';
import 'package:anappnewsportal/bloc/sportsNewsBlocState.dart';
import 'package:anappnewsportal/models/topNewsModels.dart';
import 'package:anappnewsportal/ui/sportsDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SportsNewsBloc articleBloc;

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<SportsNewsBloc>(context);
    articleBloc.add(FetchSportsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(30.0),
                child: AppBar(
                  backgroundColor: Colors.blueGrey,
                  title: Text("Top News",style: TextStyle(
                      color: Colors.white,fontSize: 14.0,fontFamily:'Distant Galaxy'
                  ),),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        articleBloc.add(FetchSportsEvent());
                      },
                    ),
//                  IconButton(
//                    icon: Icon(Icons.info),
//                    onPressed: () {
//                      navigateToAoutPage(context);
//                    },
//                  )
                  ],
                ),

              ),
              body: Container(
                child: BlocListener<SportsNewsBloc, SportsState>(
                  listener: (context, state) {
                    if (state is SportsErrorState) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<SportsNewsBloc, SportsState>(
                    builder: (context, state) {
                      if (state is SportsInitialState) {
                        return buildLoading();
                      } else if (state is SportsLoadingState) {
                        return buildLoading();
                      } else if (state is SportsLoadedState) {
                        return buildArticleList(state.articles);
                      } else if (state is SportsErrorState) {
                        return buildErrorUi(state.message);
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(List<Articles> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              leading: ClipOval(
                child: Hero(
                  tag: articles[pos].urlToImage,
                  child: Image.network(
                    articles[pos].urlToImage,
                    fit: BoxFit.cover,
                    height: 70.0,
                    width: 70.0,
                  ),
                ),
              ),
              title: Text(articles[pos].title,style: TextStyle(
                color: Colors.black,fontSize: 14.0,fontStyle:FontStyle.normal
              ),),
              subtitle: Text(articles[pos].publishedAt,style: TextStyle(
                  color: Colors.black,fontSize: 14.0,fontStyle:FontStyle.normal
              )),
            ),
            onTap: () {
              navigateToArticleDetailPage(context, articles[pos]);
            },
          ),
        );
      },
    );
  }

  void navigateToArticleDetailPage(BuildContext context, Articles article) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SportsDetailPage(
        article: article,
      );
    }));
  }

  void navigateToAoutPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
//      return AboutPage();
    }));
  }
}