import 'package:anappnewsportal/models/topNewsModels.dart';
import 'package:anappnewsportal/src/apiProvider.dart';
import 'package:bloc/bloc.dart';
import 'package:anappnewsportal/bloc/sportsNewsBlocEvent.dart';
import 'package:anappnewsportal/bloc/sportsNewsBlocState.dart';
import 'package:meta/meta.dart';

class SportsNewsBloc extends Bloc<SportsEvent, SportsState>{
  ArticlesProvider repository;

  SportsNewsBloc({@required this.repository});

  @override
  // TODO: implement initialState
  SportsState get initialState => SportsInitialState();

  @override
  Stream<SportsState> mapEventToState(SportsEvent event) async*{
    if(event is FetchSportsEvent){
      yield SportsLoadingState();
      try{
        List<Articles> articles = await repository.getArticles();
        yield SportsLoadedState(articles: articles);
      }catch(exception){
        yield SportsErrorState(message: exception.toString());
      }
    }

  }


}