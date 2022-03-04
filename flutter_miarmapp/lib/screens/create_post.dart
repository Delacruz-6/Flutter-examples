import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/image_pick_bloc/image_pick_bloc_bloc.dart';
import 'package:flutter_miarmapp/bloc/post_bloc/post_bloc.dart';
import 'package:flutter_miarmapp/models/post/post_dto.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository_impl.dart';
import 'package:flutter_miarmapp/screens/menu_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<CreatePostScreen> {
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  late TextEditingController _typecontroller = TextEditingController();
  late String tipoPerfil = '';
  late String tipo = '';
  late String photo = '';
  String _dropdownValue = 'PUBLICO';

  DateTime fecha = DateTime.now();

  bool _isloading = false;

  File? avatar = null;
  String path = "";

  final _formKey = GlobalKey<FormState>();

  List<XFile>? _imageFileList;
  final format = DateFormat("yyyy-MM-dd");
  late PostRepository postRepository;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  void initState() {
    postRepository = PostRepositoryImpl();

    _titlecontroller.text = 'Titulaso';
    _descriptioncontroller.text = 'Illo esto va de lujo';

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _titlecontroller.dispose();
    _descriptioncontroller.dispose();
  }

  void navigatorToHome() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MenuScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ImagePickBlocBloc();
            },
          ),
          BlocProvider(
            create: (context) {
              return PostBloc(postRepository);
            },
          ),
        ],
        child: _createBody(context),
      ),
    );
  }

  _createBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: BlocConsumer<PostBloc, PostsState>(
                listenWhen: (context, state) {
          return state is PostSuccessState || state is PostsFechedError;
        }, listener: (context, state) async {
          if (state is PostSuccessState) {
            navigatorToHome();
          } else if (state is PostsFechedError) {
            _showSnackbar(context, state.message);
          }
        }, buildWhen: (context, state) {
          return state is RegisterInitialState || state is RegisterLoadingState;
        }, builder: (ctx, state) {
          if (state is RegisterInitialState) {
            return buildForm(ctx);
          } else if (state is RegisterLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return buildForm(ctx);
          }
        })),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget buildForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 55, bottom: 20),
              child: Text(
                'Miarmapp',
                style: TextStyle(
                  fontFamily: 'Billabong',
                  color: Colors.black,
                  fontSize: 50,
                ),
              ),
            ),
            BlocConsumer<ImagePickBlocBloc, ImagePickBlocState>(
                listenWhen: (context, state) {
                  return state is ImageSelectedSuccessState;
                },
                listener: (context, state) {},
                buildWhen: (context, state) {
                  return state is ImagePickBlocInitial ||
                      state is ImageSelectedSuccessState;
                },
                builder: (context, state) {
                  if (state is ImageSelectedSuccessState) {
                    photo = state.pickedFile.path;
                    print('PATH ${state.pickedFile.path}');
                    return Column(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0), //or 15.0
                        child: Container(
                          height: 267.0,
                          width: 200.0,
                          color: Colors.blueGrey,
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Image.file(File(photo))),
                        ),
                      ),
                    ]);
                  }
                  return Center(
                      child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<ImagePickBlocBloc>(context).add(
                                const SelectImageEvent(ImageSource.gallery));
                          },
                          child: const Text('Agregar Imagen')));
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: TextFormField(
                controller: _titlecontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Titulo',
                    labelText: 'Titulo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Titulo incorrecto';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: TextFormField(
                controller: _descriptioncontroller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Descripcion',
                    labelText: 'Descripcion'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Descripcion incorrecta';
                  }
                  return null;
                },
              ),
            ),
            DropdownButton(
              dropdownColor: Colors.white70,
              value: _dropdownValue,
              items: [
                DropdownMenuItem(child: Text("Publico"), value: "PUBLICO"),
                DropdownMenuItem(
                  child: Text("Privado"),
                  value: "PRIVADO",
                )
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _dropdownValue = newValue!;
                });
              },
            ),
            const Divider(
              height: 40,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.grey,
            ),
            SizedBox(
                height: 50, //height of button
                width: 300, //width of button
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      final registerDto = PostDto(
                        titulo: _titlecontroller.text,
                        descripcion: _descriptioncontroller.text,
                        tipoPublicacion: _dropdownValue,
                      );

                      BlocProvider.of<PostBloc>(context)
                          .add(DoRegisterEvent(registerDto, photo));
                    }
                  },
                  child: Text('Crear publicación'),
                )),
          ],
        ))));
  }
}
