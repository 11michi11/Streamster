

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/common/common.dart';
import 'package:streamster_app/recommendations/bloc/recommendations_bloc.dart';
import 'package:streamster_app/recommendations/repository/recommendations_repository.dart';
import 'package:streamster_app/recommendations/view/recommendations_form.dart';

class RecommendationsPage extends StatelessWidget {
  final RecommendationsRepository recommendationsRepository;
  final UserRepository userRepository;

  RecommendationsPage({Key key, @required this.recommendationsRepository, @required this.userRepository})
      : assert(recommendationsRepository != null, userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
            create: (context) {
              return RecommendationsBloc(recommendationsRepository: recommendationsRepository, userRepository: userRepository);
            },
            child: RecommendationsForm());
  }
}
