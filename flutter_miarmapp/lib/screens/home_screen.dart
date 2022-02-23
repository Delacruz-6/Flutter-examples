import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/movies_bloc/post_bloc.dart';
import 'package:flutter_miarmapp/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_miarmapp/models/post/post_response.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository_impl.dart';
import 'package:flutter_miarmapp/widgets/error_page.dart';
import 'package:flutter_miarmapp/widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return BlocProvider(
        create: (context) {
          return PostBloc(postRepository)..add(FetchPostWithType('publicas'));
        },
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(
                  Icons.camera_alt,
                  size: 20,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              title: const Text(
                'Miarmapp',
                style: TextStyle(
                    fontFamily: 'Billabong',
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.live_tv,
                    size: 20,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    size: 20,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    /*Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ChatPage()));*/
                  },
                ),
              ],
            ),
            body: _createPopular(context)));
  }
}

Widget story(String image, name) {
  return Padding(
    padding: const EdgeInsets.only(right: 12),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(0.1),
          width: 76,
          height: 76,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFc05ba6), width: 3)),
          child: ClipOval(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(
              color: Colors.black.withOpacity(.8), fontWeight: FontWeight.w500),
        )
      ],
    ),
  );
}

Widget _post(BuildContext context, PostPublic post) {
  String file = post.fichero.replaceAll('localhost', '10.0.2.2');

  String fileAvatar =
      post.avatarPropietario.replaceAll('localhost', '10.0.2.2');

  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(.3)))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(fileAvatar),
          ),
          title: Text(
            post.titulo,
            style: TextStyle(
                color: Colors.black.withOpacity(.8),
                fontWeight: FontWeight.w400,
                fontSize: 21),
          ),
          trailing: const Icon(Icons.more_vert),
        ),
        Image.network('${file}',
            fit: BoxFit.cover, width: double.infinity, height: 200),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: const <Widget>[
                  Icon(Icons.favorite_border, size: 31),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(Icons.comment_sharp, size: 31),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(Icons.send, size: 31),
                ],
              ),
              const Icon(Icons.bookmark_border, size: 31)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(
            'Me gusta de 33 personas más',
            style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(.8)),
          ),
        )
      ],
    ),
  );
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
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: GridView.count(
      crossAxisCount: 1,
      children: List.generate(post.length, (index) {
        String file =
            post.elementAt(index).fichero.replaceAll('localhost', '10.0.2.2');
        return _post(context, post.elementAt(index));
      }),
    ),
  );
}
