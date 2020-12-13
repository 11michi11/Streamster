import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamster_app/admin/admin.dart';
import 'package:get_it/get_it.dart';
import 'package:streamster_app/home/view/home_page.dart';
import 'package:streamster_app/login/repository/login_repository.dart';
import 'package:streamster_app/recommendations/recommendations.dart';
import 'package:streamster_app/register/repository/register_repository.dart';
import 'package:streamster_app/search/repository/search_repository.dart';
import 'package:streamster_app/upload_video/bloc/upload_video_bloc.dart';
import 'package:streamster_app/upload_video/upload_video.dart';
import 'admin/view/admin_page.dart';
import 'common/app_config.dart';
import 'common/common.dart';
import 'login/login.dart';
import 'my_videos/repository/my_videos_repository.dart';
import 'my_videos/view/my_videos_page.dart';
import 'preferences/preferences.dart';
import 'register/bloc/register_bloc.dart';
import 'register/view/register_page.dart';
import 'search/search.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

void main({String env}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final config = await AppConfig.forEnvironment(env);
  getIt.registerSingleton(config);
  final loginRepository = LoginRepository();
  final userRepository = UserRepository();
  final registerRepository = RegisterRepository();
  final adminRepository = AdminRepository();
  final uploadVideoRepository = UploadVideoRepository();
  final myVideosRepository = MyVideosRepository();
  final searchRepository = SearchRepository();
  final preferencesRepository = PreferencesRepository();
  final recommendationsRepository = RecommendationsRepository();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LoginBloc>(
        create: (context) {
          return LoginBloc(
              loginRepository: loginRepository, userRepository: userRepository);
        },
      ),
      BlocProvider<RegisterBloc>(
        create: (context) {
          return RegisterBloc(registerRepository: registerRepository);
        },
      ),
      BlocProvider<AdminBloc>(
        create: (context) {
          return AdminBloc(
              adminRepository: adminRepository, userRepository: userRepository);
        },
      ),
      BlocProvider<UploadVideoBloc>(
        create: (context) {
          return UploadVideoBloc(uploadVideoRepository: uploadVideoRepository);
        },
      ),
      BlocProvider<SearchBloc>(
        create: (context) {
          return SearchBloc(searchRepository: searchRepository);
        },
      ),
      BlocProvider<PreferencesBloc>(
        create: (context) {
          return PreferencesBloc(
              preferencesRepository: preferencesRepository,
              userRepository: userRepository);
        },
      ),
      BlocProvider<RecommendationsBloc>(
          create: (context) {
            return RecommendationsBloc(recommendationsRepository: recommendationsRepository);
          })

    ],
    child: App(
      userRepository: userRepository,
      loginRepository: loginRepository,
      registerRepository: registerRepository,
      adminRepository: adminRepository,
      uploadVideoRepository: uploadVideoRepository,
      myVideosRepository: myVideosRepository,
      searchRepository: searchRepository,
      preferencesRepository: preferencesRepository,
      recommendationsRepository: recommendationsRepository,
    ),
  ));
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  final LoginRepository loginRepository;
  final RegisterRepository registerRepository;
  final AdminRepository adminRepository;
  final UploadVideoRepository uploadVideoRepository;
  final MyVideosRepository myVideosRepository;
  final SearchRepository searchRepository;
  final PreferencesRepository preferencesRepository;
  final RecommendationsRepository recommendationsRepository;

  App({
    Key key,
    @required this.userRepository,
    @required this.loginRepository,
    @required this.registerRepository,
    @required this.adminRepository,
    @required this.uploadVideoRepository,
    @required this.myVideosRepository,
    @required this.searchRepository,
    @required this.preferencesRepository,
    @required this.recommendationsRepository
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FilmMaster',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/login': (context) => LoginPage(
            loginRepository: loginRepository, userRepository: userRepository),
        '/register': (context) =>
            RegisterPage(registerRepository: registerRepository),
        '/admin': (context) => AdminPage(
            adminRepository: adminRepository, userRepository: userRepository),
        '/home': (context) => HomePage(
            userRepository: userRepository, searchRepository: searchRepository),
        '/uploadVideo': (context) =>
            UploadVideoPage(uploadVideoRepository: uploadVideoRepository),
        '/myVideos': (context) => MyVideosPage(
            myVideosRepository: myVideosRepository,
            userRepository: userRepository),
        '/search': (context) => SearchPage(searchRepository: searchRepository), //Search Page
        '/preferences': (context) => PreferencesPage( // Preferences Page
          preferencesRepository: preferencesRepository,
          userRepository: userRepository,
            ),
        '/recommendations': (context) => RecommendationsPage(recommendationsRepository: recommendationsRepository) //Recommendations
      },
      initialRoute: '/login',
    );
  }
}
