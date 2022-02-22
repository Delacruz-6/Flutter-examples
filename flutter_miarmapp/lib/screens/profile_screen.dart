import 'package:flutter/material.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository_impl.dart';
import 'package:flutter_miarmapp/screens/edit_profile_screen.dart';
import 'package:flutter_miarmapp/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  void navigatorEdit() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "JordiWild",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
          actions: const [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.black,
                  ),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          width: 100.0,
                          height: 100.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/avatar.png')),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: const [
                                    TextButton(
                                      onPressed: null,
                                      child: Text(
                                        "3",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Text("Publicaciones"),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()));
                                      },
                                      child: Text(
                                        "1.567",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Text(
                                      "Seguidores",
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginScreen()));
                                        },
                                        child: Text("465",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black))),
                                    Text("Siguiendo"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("JordiWild"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text("jordiWild@prueba.com"),
                        )
                      ],
                    ),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      width: 320,
                      child: Center(
                        child: GestureDetector(
                          onTap: navigatorEdit,
                          child: Container(
                            child: const Text(
                              " Editar perfil",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 2),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(
                  height: 10,
                ),
                SingleChildScrollView(
                    child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                        child: TabBar(
                          indicatorColor: Colors.grey,
                          controller: tabController,
                          tabs: [
                            const Tab(
                                icon: Icon(
                              Icons.person_pin_outlined,
                              color: Colors.grey,
                            )),
                            const Tab(
                                icon: Icon(
                              Icons.person_search,
                              color: Colors.grey,
                            )),
                          ],
                        ),
                      ),
                      Container(
                        height: 400,
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            Align(
                                alignment: Alignment.topCenter,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        width: 120,
                                        height: 150,
                                        child: const Image(
                                          image: AssetImage(
                                              "assets/images/post1.jpg"),
                                          fit: BoxFit.contain,
                                        )),
                                    Container(
                                        width: 120,
                                        height: 150,
                                        child: const Image(
                                          image: AssetImage(
                                              "assets/images/post1.jpg"),
                                          fit: BoxFit.contain,
                                        )),
                                    Container(
                                        width: 120,
                                        height: 150,
                                        child: const Image(
                                          image: AssetImage(
                                              "assets/images/post1.jpg"),
                                          fit: BoxFit.contain,
                                        )),
                                  ],
                                )),
                            Align(
                                alignment: Alignment.topCenter,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        width: 120,
                                        height: 150,
                                        child: const Image(
                                          image: AssetImage(
                                              "assets/images/post1.jpg"),
                                          fit: BoxFit.contain,
                                        )),
                                    Container(
                                        width: 120,
                                        height: 150,
                                        child: const Image(
                                          image: AssetImage(
                                              "assets/images/post1.jpg"),
                                          fit: BoxFit.contain,
                                        )),
                                    Container(
                                        width: 120,
                                        height: 150,
                                        child: const Image(
                                          image: AssetImage(
                                              "assets/images/post1.jpg"),
                                          fit: BoxFit.contain,
                                        )),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}
