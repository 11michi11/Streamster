import 'package:equatable/equatable.dart';

abstract class RecommendationsEvent extends Equatable {

  const RecommendationsEvent();
}

class GetRecommendations extends RecommendationsEvent {

  GetRecommendations();

  @override
  List<Object> get props => [];


}