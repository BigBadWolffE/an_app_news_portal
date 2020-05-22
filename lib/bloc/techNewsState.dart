import 'package:anappnewsportal/models/otherNewsModels.dart';
import 'package:anappnewsportal/models/topNewsModels.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class TechState extends Equatable {}

class TechInitialState extends TechState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TechLoadingState extends TechState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TechLoadedState extends TechState {

  List<ArticlesTech> articles;

  TechLoadedState({@required this.articles});

  @override
  // TODO: implement props
  List<Object> get props => [articles];
}

class TechErrorState extends TechState {

  String message;

  TechErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}