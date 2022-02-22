import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/movies_bloc/post_bloc.dart';
import 'package:flutter_miarmapp/models/post/post_response.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository_impl.dart';
import 'package:flutter_miarmapp/screens/search_json.dart';
import 'package:flutter_miarmapp/widgets/error_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late PostRepository postRepository;

  @override
  void initState() {
    super.initState();
    postRepository = PostRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (context) {
          return PostBloc(postRepository)..add(FetchPostWithType('publicas'));
        },
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(
          children: <Widget>[
            SafeArea(
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: size.width - 30,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black.withOpacity(0.3),
                          )),
                      style: TextStyle(color: Colors.black.withOpacity(0.3)),
                      cursorColor: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            _createPopular(context)
          ],
        ))));
  }

  Widget _createPopular(BuildContext context) {
    return BlocBuilder<PostBloc, PostsState>(
      builder: (context, state) {
        if (state is PostInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostsFechedError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context.watch<PostBloc>().add(FetchPostWithType('publicos'));
            },
          );
        } else if (state is PostsFeched) {
          return _createPopularView(context, state.posts);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _createPopularView(BuildContext context, List<PostPublic> post) {
    final contentHeight = 4.0 * (MediaQuery.of(context).size.width / 2.4) / 3;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 20.0, right: 16.0),
          height: 48.0,
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  'Popular',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward, color: Colors.red),
            ],
          ),
        ),
        SizedBox(
          height: contentHeight,
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return _createPostItem(context, post[index]);
            },
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const VerticalDivider(
              color: Colors.transparent,
              width: 6.0,
            ),
            itemCount: post.length,
          ),
        ),
      ],
    );
  }

  Widget _createPostItem(BuildContext context, PostPublic post) {
    return Container(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height / 3,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(post.fichero), fit: BoxFit.cover)),
        child: Text(post.titulo));
  }
}
