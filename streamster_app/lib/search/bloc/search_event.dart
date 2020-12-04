import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchBySearchTerm extends SearchEvent {
  final String searchTerm;

  const SearchBySearchTerm({@required this.searchTerm});

  @override
  List<Object> get props => [searchTerm];
}
