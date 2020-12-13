
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/recommendations/bloc/recommendations_bloc.dart';
import 'package:streamster_app/recommendations/bloc/recommendations_state.dart';
import 'package:streamster_app/recommendations/repository/recommendations_repository.dart';
import 'package:streamster_app/recommendations/view/recommendations_android.dart';
import 'package:streamster_app/recommendations/view/recommendations_web.dart';

class RecommendationsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendationsBloc, RecommendationsState>(builder: (context, state) {
      return LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          return RecommendationsWeb();
        } else {
          return RecommendationsAndroid(state);
        }
      });
    });
  }
}