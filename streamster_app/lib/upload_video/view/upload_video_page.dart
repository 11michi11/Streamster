
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/upload_video/bloc/upload_video_bloc.dart';
import 'package:streamster_app/upload_video/upload_video.dart';

class UploadVideoPage extends StatelessWidget {

  final UploadVideoRepository uploadVideoRepository;

  UploadVideoPage({Key key,@required this.uploadVideoRepository})
      : assert(uploadVideoRepository!= null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Video") ,backgroundColor: Colors.brown,  leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ), ),
      body: BlocProvider(
        create: (context) {
          return UploadVideoBloc(uploadVideoRepository: uploadVideoRepository);
        },
        child: UploadVideoForm()
      )
      );
  }
}