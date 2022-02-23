import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_miarmapp/models/user/user_response.dart';
import 'package:flutter_miarmapp/repository/user_repository/user_repository.dart';
import 'package:flutter_miarmapp/repository/user_repository/user_repository_impl.dart';
import 'package:flutter_miarmapp/screens/home_screen.dart';
import 'package:flutter_miarmapp/screens/profile_screen.dart';
import 'package:flutter_miarmapp/screens/search_screen.dart';
import 'package:flutter_miarmapp/widgets/error_page.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late UserRepository userRepository;

  @override
  void initState() {
    super.initState();
    userRepository = UserRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> pages = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return UserBloc(userRepository)..add(FetchUserWithType('Perfil'));
        },
        child: Scaffold(
          body: pages[_currentIndex],
          bottomNavigationBar: _createPopular(context),
        ));
  }

  Widget _createPopular(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserFechedError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<UserBloc>().add(FetchUserWithType('Perfil'));
            },
          );
        } else if (state is UserFeched) {
          return _buildBottomBar(context, state.user);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _buildBottomBar(BuildContext context, UserResponse user) {
    String avatar = user.avatar.replaceAll('localhost', '10.0.2.2');

    return Container(
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(
            color: Color(0xfff1f1f1),
            width: 1.0,
          ),
        )),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Icon(Icons.home,
                  color: _currentIndex == 0
                      ? Colors.black
                      : const Color(0xff999999)),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            GestureDetector(
              child: Icon(Icons.search,
                  color: _currentIndex == 1 ? Colors.black : Color(0xff999999)),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: 0.1),
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: _currentIndex == 2
                          ? Colors.black
                          : Colors.transparent,
                      width: 2),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(avatar)),
                ),
              ),
            ),
          ],
        ));
  }
}
