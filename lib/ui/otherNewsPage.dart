import 'package:anappnewsportal/bloc/techNewsBloc.dart';
import 'package:anappnewsportal/bloc/techNewsEvent.dart';
import 'package:anappnewsportal/bloc/techNewsState.dart';
import 'package:anappnewsportal/models/otherNewsModels.dart';
import 'package:anappnewsportal/ui/otherDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherHomePage extends StatefulWidget {
  @override
  _OtherHomePageState createState() => _OtherHomePageState();
}

class _OtherHomePageState extends State<OtherHomePage>{
  TechNewsBloc articleBloc;

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<TechNewsBloc>(context);
    articleBloc.add(FetchTechEvent());
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
                  backgroundColor: Colors.deepPurple,
                  title: Text("Top News"),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        articleBloc.add(FetchTechEvent());
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
                child: BlocListener<TechNewsBloc, TechState>(
                  listener: (context, state) {
                    if (state is TechErrorState) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<TechNewsBloc, TechState>(
                    builder: (context, state) {
                      if (state is TechInitialState) {
                        return buildLoading();
                      } else if (state is TechLoadingState) {
                        return buildLoading();
                      } else if (state is TechLoadedState) {
                        return buildArticleList(state.articles);
                      } else if (state is TechErrorState) {
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

  Widget buildArticleList(List<ArticlesTech> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              leading: ClipOval(
                child: Hero(
                  tag: articles[pos].urlToImage != null ?  false : articles[pos].urlToImage== null,
                  child: FadeInImage(
                    image: articles[pos].urlToImage != null ? NetworkImage(articles[pos].urlToImage) :AssetImage('gallery.png'),
                    placeholder:AssetImage('gallery.png'),
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
//                  child: Image.network(
//                    articles[pos].urlToImage,
//                    fit: BoxFit.cover,
//                    loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress){
//                      if (loadingProgress == null) return child;
//                      return Center(
//                          child: CircularProgressIndicator(
//                          value: loadingProgress.expectedTotalBytes != null ?
//                          loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
//                              : null,
//                      ),
//                      );
//                    },
//                    height: 70.0,
//                    width: 70.0,
//                  ),
                ),
              ),
              title: Text(articles[pos].title),
              subtitle: Text(articles[pos].publishedAt),
            ),
            onTap: () {
              navigateToArticleDetailPage(context, articles[pos]);
            },
          ),
        );
      },
    );
  }

  void navigateToArticleDetailPage(BuildContext context, ArticlesTech article) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TechDetailPage(
        article: article,
      );
    }));
  }


}