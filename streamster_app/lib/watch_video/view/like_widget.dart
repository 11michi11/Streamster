import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/watch_video/watch_video.dart';
import 'package:streamster_app/watch_video/repository/feedback_repository.dart';

class LikeWidget extends StatefulWidget {
  final FeedbackRepository feedbackRepository;
  final String videoId;
  final List<String> likedBy;
  final List<String> dislikedBy;

  const LikeWidget(
      {Key key,
      this.feedbackRepository,
      this.videoId,
      this.likedBy,
      this.dislikedBy})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return FeedbackBloc(feedbackRepository: widget.feedbackRepository);
        },
        child: BlocListener<FeedbackBloc, FeedbackState>(
          listener: (context, state) {},
          child: BlocBuilder<FeedbackBloc, FeedbackState>(
              builder: (context, state) {
            return LayoutBuilder(builder: (context, constraints) {
              return Container(
                child: FlatButton(
                    onPressed: () {
                      BlocProvider.of<FeedbackBloc>(context)
                          .add(new LikeEvent(widget.videoId, widget.likedBy));

                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Liked'),
                        backgroundColor: Colors.blueGrey,
                      ));
                    },
                    child: Icon(Icons.favorite, color: Colors.brown, size: 35)),
              );
            });
          }),
        ));
  }
}
