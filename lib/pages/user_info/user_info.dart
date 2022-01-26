import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../classes/user_repository.dart';
import '../../common_widgets/choose_game.dart';
import '../../models/user.dart' as fs_user;
import '../../providers/user_stream.dart';
import '../../utility/authentication.dart';

class UserInfoPage extends ConsumerStatefulWidget {
  final User user;

  const UserInfoPage({Key? key, required this.user}) : super(key: key);
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends ConsumerState<UserInfoPage> {
  final UserRepository userRepository = UserRepository();
  bool _isSigningOut = false;

  @override
  Widget build(BuildContext context) {
    final userStream = ref.watch(userStreamProvider(widget.user.uid));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("User Info"),
      ),
      body: Center(
        child: userStream.when(
          data: (snapshot) {
            if (snapshot.docs.isEmpty) {
              userRepository.addUser(fs_user.User.fromFireAuth(widget.user));
            } else {
              final user = snapshot.docs[0].data();
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(),
                      ClipOval(
                        child: Material(
                          child: Image.network(
                            user.photoURL ?? "",
                            fit: BoxFit.fitHeight,
                            errorBuilder: (_, __, ___) => Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.person,
                                size: 60,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Hello',
                        style: TextStyle(
                          fontSize: 26,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        user.displayName!,
                        style: TextStyle(
                          fontSize: 26,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => ChooseGame())),
                          child: Text("to Firestore")),
                      if (_isSigningOut)
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      else
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.redAccent,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isSigningOut = true;
                            });
                            await Authentication.signOut(context: context);
                            setState(() {
                              _isSigningOut = false;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Text(
                              'Sign Out',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      //SignOutButton(),
                    ],
                  ),
                ),
              );
            }
            return const CircularProgressIndicator();
          },
          error: (err, stack) => Text('Error: $err'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
