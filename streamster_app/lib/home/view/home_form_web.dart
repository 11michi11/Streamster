import 'package:flutter/material.dart';
import 'package:streamster_app/common/repository/user_repository.dart';
import 'package:streamster_app/logout/logout_view.dart';

class HomeFormWeb extends StatefulWidget {
  final UserRepository userRepository;

  const HomeFormWeb({Key key, this.userRepository}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeFormWebState(userRepository);
}

class _HomeFormWebState extends State<HomeFormWeb> {
  final UserRepository userRepository;

  _HomeFormWebState(this.userRepository);

  onUploadVideoPressed() {
    Navigator.of(context).pushNamed('/uploadVideo');
  }

  Widget defaultImage() {
    return Container(
        width: 90.0,
        height: 90.0,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    "https://scontent-cph2-1.xx.fbcdn.net/v/t31.0-8/18358881_1293777014069016_6493560286323388419_o.jpg?_nc_cat=104&_nc_sid=09cbfe&_nc_ohc=ObxWnFMAMGgAX9R_SfZ&_nc_ht=scontent-cph2-1.xx&oh=0f5fa0c0ea02b3df77eecd4fc8ab548e&oe=5FAB318A"))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Logout(
        userRepository: userRepository,
      ),
    );
  }
}
