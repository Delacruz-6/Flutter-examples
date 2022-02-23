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
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
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
                  ),
                ],
              ),
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
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: MediaQuery.of(context).size.width - 20,
      height: MediaQuery.of(context).size.height - 180,
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(post.length, (index) {
          String file =
              post.elementAt(index).fichero.replaceAll('localhost', '10.0.2.2');
          return _createPostItem(context, post.elementAt(index));
        }),
      ),
    );
  }

  Widget _createPostItem(BuildContext context, PostPublic post) {
    String file = post.ficheroMob.replaceAll('localhost', '10.0.2.2');
    return Container(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height / 3,
        child: Image.network('${file}', fit: BoxFit.cover));
  }
}
