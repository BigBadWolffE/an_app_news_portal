import 'package:anappnewsportal/models/topNewsModels.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class SportsState extends Equatable {}

class SportsInitialState extends SportsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SportsLoadingState extends SportsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SportsLoadedState extends SportsState {

  List<Articles> articles;

  SportsLoadedState({@required this.articles});

  @override
  // TODO: implement props
  List<Object> get props => [articles];
}

class SportsErrorState extends SportsState {

  String message;

  SportsErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}