import 'package:anappnewsportal/bloc/techNewsEvent.dart';
import 'package:anappnewsportal/bloc/techNewsState.dart';
import 'package:anappnewsportal/models/otherNewsModels.dart';
import 'package:anappnewsportal/src/apiProvider.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class TechNewsBloc extends Bloc<TechEvent, TechState>{
  ArticlesTechProvider repository;

  TechNewsBloc({@required this.repository});

  @override
  // TODO: implement initialState
  TechState get initialState => TechInitialState();

  @override
  Stream<TechState> mapEventToState(TechEvent event) async*{
    if(event is FetchTechEvent){
      yield TechLoadingState();
      try{
        List<ArticlesTech> articles = await repository.getArticles();
        yield TechLoadedState(articles:articles);
      }catch(exception){
        yield TechErrorState(message: exception.toString());
      }
    }

  }


}