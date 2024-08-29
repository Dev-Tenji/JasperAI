import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';
import 'package:gal/gal.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jasper_ai/ChangeDP.dart';
import 'package:jasper_ai/bottomNav.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:jasper_ai/HomeScreen.dart';
import 'package:jasper_ai/SignUp.dart';
import 'package:jasper_ai/usermodels.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:url_launcher/url_launcher.dart';

class Applogic {
  static final pb = PocketBase('https://ayacomart.pockethost.io');
  static void CheckSignUp(BuildContext context) {
    String id = User.getID();
    Timer(const Duration(seconds: 5), () {
      if (id == '') {
        Navigator.of(context).push(PageAnimationTransition(
            page: Signup(), pageAnimationType: FadeAnimationTransition()));
      } else {
        Navigator.of(context).push(PageAnimationTransition(
            page: Bottomnav(), pageAnimationType: FadeAnimationTransition()));
      }
    });
  }

  static Widget EmptyWidget(BuildContext context) {
    CheckSignUp(context);
    return SizedBox.shrink();
  }

  static Widget EmptyWidget2() {
    return SizedBox.shrink();
  }

  static Future SignUp(String username, String password, String email) async {
    final body = <String, dynamic>{
      "username": username,
      "email": email,
      "emailVisibilty": true,
      "password": password,
      "passwordConfirm": password,
    };
    try {
      await User.init();
      String id = User.getID();
      final record = await pb.collection('users').create(body: body);
      id = record.id;
      await User.SetID(id);
      //await pb.collection('users').requestVerification('test@example.com');
    } catch (e) {
      print(e.toString());
    }
  }

  static Future EmailVerify(String email, BuildContext context, String username,
      String Password) async {
    await User.init();
    String id = User.getID();
    await pb.collection('users').requestVerification(email);
    if (pb.authStore.isValid) {
      try {
        await pb.collection('users').confirmVerification(pb.authStore.token);
        await User.SetEmail(email);
        await User.SetUsername(username);
        await User.SetPassword(Password);
        await User.SignUpType('AUTH_PASS');
        await User.SetToken(pb.authStore.token);
        Navigator.of(context).push(PageAnimationTransition(
            page: Bottomnav(), pageAnimationType: FadeAnimationTransition()));
      } catch (e) {
        print(e.toString());
      }
    } else {
      await pb.collection('users').delete(id);
      await User.SetID('');
    }
    AlertDialog alertDialog = AlertDialog(
      insetPadding: EdgeInsets.only(top: 24, right: 40, left: 40, bottom: 220),
      content: Column(
        children: [
          Image.asset(
            'assets/email.png',
            height: 100,
            width: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'We have sent you an email',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 47, 143, 221)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'Click on the email verification link sent to you on $email. Then click on confirm',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 47, 143, 221)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: Row(
              children: [
                Text(
                  "Didn't receive the email yet?",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 47, 143, 221)),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              await pb.collection('users').requestVerification(email);
              if (pb.authStore.isValid) {
                try {
                  await pb
                      .collection('users')
                      .confirmVerification(pb.authStore.token);
                  Navigator.of(context).push(PageAnimationTransition(
                      page: Bottomnav(),
                      pageAnimationType: FadeAnimationTransition()));
                } catch (e) {
                  print(e.toString());
                }
              } else {
                await pb.collection('users').delete(id);
                await User.SetID('');
              }
            },
            child: Text(
              'Send Again',
              style: TextStyle(
                  decorationColor: const Color.fromARGB(255, 47, 143, 221),
                  color: const Color.fromARGB(255, 47, 143, 221),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 7),
            child: MaterialButton(
              height: 50,
              elevation: 3,
              color: Colors.white,
              shape: StadiumBorder(),
              onPressed: () async {
                try {
                  await pb
                      .collection('users')
                      .confirmVerification(pb.authStore.token);
                  Navigator.of(context).push(PageAnimationTransition(
                      page: Bottomnav(),
                      pageAnimationType: FadeAnimationTransition()));
                } catch (e) {
                  print(e.toString());
                }
              },
              child: Center(
                child: Text(
                  'Confirm',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 47, 143, 221),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await pb.collection('users').delete(id);
            await User.SetID('');
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  static Future GoogleSign(BuildContext context) async {
    await User.init();
    String id = User.getID();
    final authData =
        await pb.collection('users').authWithOAuth2('google', (url) async {
      await launchUrl(url);
    });
    if (pb.authStore.isValid) {
      try {
        id = authData.record!.id;
        print('ur $id');

        await User.SetID(id);
        await User.SetToken(pb.authStore.token);
        await User.SignUpType('AUTH_GOOGLE');
        Navigator.of(context).push(PageAnimationTransition(
            page: Bottomnav(), pageAnimationType: FadeAnimationTransition()));
      } catch (e) {
        print('${e.toString()}');
      }
    }
  }

  static Future Login(
      String username, String password, BuildContext context) async {
    await User.init();

    String id = User.getID();
    final authData = await pb.collection('users').authWithPassword(
          username,
          password,
        );
    if (pb.authStore.isValid) {
      id = pb.authStore.model.id;
      await User.SetID(id);
      Navigator.of(context).push(PageAnimationTransition(
          page: Bottomnav(), pageAnimationType: FadeAnimationTransition()));
    }
  }

  static SignOut(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      insetPadding: EdgeInsets.only(left: 70, right: 50), //70
      titlePadding: EdgeInsets.only(left: 70, top: 10, bottom: 10), //50
      title: Text(
        'Are you sure?',
        style: TextStyle(color: Colors.blue, fontSize: 15),
      ),
      actions: [
        MaterialButton(
          color: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          onPressed: () => null,
          child: Text(
            'Sign out',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  static QrCode(BuildContext context) async {
    await User.init();
    String username = User.getUsername();
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.white,
      content: PrettyQrView.data(
        data:
            'Hey am $username and am using the jasper ai to solve all my problems wish to join me',
        decoration: const PrettyQrDecoration(
          image: PrettyQrDecorationImage(
            image: AssetImage('assets/robo1.png'),
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  void OnImageSend() async {
    ImagePicker picker = ImagePicker();
    XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
  }

  static UpdateInfo(BuildContext context) {
    User.init();
    String id = User.getID();
    final usernameT = TextEditingController();
    final bio = TextEditingController();
    var authkey = GlobalKey<FormState>();
    String username = User.getUsername();
    String Bio = User.getBio();
    AlertDialog alertDialog = AlertDialog(
      titlePadding: EdgeInsets.only(top: 10, left: 110),
      surfaceTintColor: const Color.fromARGB(255, 135, 201, 255),
      title: GestureDetector(
        child: Stack(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/robo1.png'),
            ),
            Positioned(
                top: 30,
                left: 50,
                child: Icon(
                  Icons.edit,
                ))
          ],
        ),
      ),
      content: Form(
        key: authkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 10), //right:52
              child: Container(
                width: 270,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  // initialValue: username,
                  controller: usernameT,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15),
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Username',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty && value.length < 6) {
                      // Applogic.PopNotify(
                      //     context,
                      //     '',
                      //     'Please ensure both the username and the bio are not empty',
                      //     ContentType.warning);
                      return 'Please enter your username and it should be more than 6 characters';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 10), //right:52
              child: Container(
                width: 270,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  initialValue: Bio,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15),
                    prefixIcon: Icon(Icons.book),
                    hintText: 'Bio',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty && value.length < 6) {
                      // Applogic.PopNotify(
                      //     context,
                      //     '',
                      //     'Please ensure both the username and the bio are not empty and are mor than 6 characters',
                      //     ContentType.warning);
                      return 'Please enter your Bio and it should be more than 6 characters';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                color: Colors.blue,
                onPressed: () async {
                  if (authkey.currentState!.validate()) {
                    try {
                      await User.SetUsername(usernameT.text);
                      await User.SetBio(bio.text);
                      final body = <String, dynamic>{
                        'username': usernameT.text,
                      };
                      final record =
                          await pb.collection('users').update(id, body: body);
                      Applogic.Loader(context);
                      Applogic.PopNotify(
                          context,
                          'Success',
                          'your profile as been updated successfully',
                          ContentType.success);
                      Navigator.pop(context);
                    } catch (e) {
                      Applogic.PopNotify(
                          context,
                          'Failed',
                          'a problem occured while updating your profile please check your internet connection, and try again',
                          ContentType.failure);
                    }
                  }
                },
                child: Text(
                  'Save changes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  static CE(BuildContext context) {
    final email = TextEditingController();
    AlertDialog alertDialog = AlertDialog(
      surfaceTintColor: const Color.fromARGB(255, 135, 201, 255),
      // titlePadding: EdgeInsets.only(top: 10, left: 110),
      // title: Stack(
      //   children: [
      //     CircleAvatar(
      //       radius: 30,
      //       backgroundImage: AssetImage('assets/robo1.png'),
      //     ),
      //     Positioned(
      //         top: 30,
      //         left: 50,
      //         child: Icon(
      //           Icons.edit,
      //         ))
      //   ],
      // ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20, bottom: 10), //right:52
            child: Container(
              width: 270,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 15),
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty || value.length < 8) {
                    return 'Please enter an Email';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: 50,
              color: Colors.blue,
              onPressed: () async {
                await User.init();

                String auth = await User.getSUT();
                String token = await User.getToken();
                String password = await User.getPassword();
                if (auth == 'AUTH_PASS') {
                  await pb.collection('users').confirmEmailChange(
                        token,
                        password,
                      );
                  if (pb.authStore.isValid) {
                    await User.SetEmail(email.text);
                    PopNotify(context, 'Success', 'email changed successfully',
                        ContentType.success);
                    Navigator.pop(context);
                  }
                } else {
                  PopNotify(
                      context,
                      '',
                      'Sorry you signed up through google email change can not be done',
                      ContentType.failure);
                }
                Applogic.Loader(context);
              },
              child: Text(
                'Change email',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  static CP(BuildContext context) {
    final pass = TextEditingController();
    AlertDialog alertDialog = AlertDialog(
      surfaceTintColor: const Color.fromARGB(255, 135, 201, 255),
      // titlePadding: EdgeInsets.only(top: 10, left: 110),
      // title: Stack(
      //   children: [
      //     CircleAvatar(
      //       radius: 30,
      //       backgroundImage: AssetImage('assets/robo1.png'),
      //     ),
      //     Positioned(
      //         top: 30,
      //         left: 50,
      //         child: Icon(
      //           Icons.edit,
      //         ))
      //   ],
      // ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20, bottom: 10), //right:52
            child: Container(
              width: 270,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: pass,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 15),
                  prefixIcon: Icon(Icons.password),
                  hintText: 'Password',
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty || value.length < 8) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: 50,
              color: Colors.blue,
              onPressed: () async {
                await User.init();

                String auth = User.getSUT();
                String token = User.getToken();
                if (auth == 'AUTH_PASS') {
                  await pb.collection('users').confirmPasswordReset(
                        token,
                        pass.text,
                        pass.text,
                      );
                  if (pb.authStore.isValid) {
                    await User.SetPassword(pass.text);
                    PopNotify(context, 'Success',
                        'password changed successfully', ContentType.success);
                    Navigator.pop(context);
                  }
                } else {
                  PopNotify(
                      context,
                      '',
                      'Sorry you signed up through google password change can not be done',
                      ContentType.failure);
                }
                Applogic.Loader(context);
              },
              child: Text(
                'Change passord',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  static void trt(BuildContext context) async {
    await User.init();
    String email = await User.getEmail();
    PopNotify(
        context,
        '',
        'we have sent an email to $email \n please click on the link before adding your new email',
        ContentType.warning);
  }

  static Widget CEP2(BuildContext context, OverlayEntry? entry) {
    return Material(
      color: Colors.transparent,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          height: 140, //150
          width: 140, //190
          child: Column(
            children: [
              // ListTile(
              //   title: Text('Change Email'),
              // ),
              // ListTile(
              //   title: Text('Change Password'),
              // )
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: TextButton(
                    onPressed: () {
                      CE(context);
                      entry!.remove();
                    },
                    child: Text(
                      'Change Email',
                      style: TextStyle(color: Colors.black),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    CP(context);
                    entry!.remove();
                  },
                  child: Text('Change Password',
                      style: TextStyle(color: Colors.black))),
            ],
          ),
        ),
      ),
    );
  }

  static void ShowOverlay(BuildContext context, OverlayEntry? entry) async {
    OverlayState overlay = Overlay.of(context);
    entry = OverlayEntry(
      builder: (context) =>
          Positioned(top: 250, left: 120, child: Applogic.CEP2(context, entry)),
    );
    overlay.insert(entry);
    await Future.delayed(Duration(seconds: 2));
    entry.remove();
  }

  // static void ShowOverlay2(
  //   BuildContext context,
  // ) async {
  //   OverlayState overlay = Overlay.of(context);
  //   final entry = OverlayEntry(
  //     builder: (context) => Positioned(top: 50, left: 40, child: REC(context)),
  //   );
  //   overlay.insert(entry);
  //   await Future.delayed(Duration(seconds: 5));

  //   entry.remove();
  // }

  static SaveImg(Uint8List uint8list, BuildContext context) async {
    try {
      await Gal.putImageBytes(uint8list, album: 'JasperAI');
      PopNotify(context, 'saved', '', ContentType.success);
    } on GalException catch (e) {
      PopNotify(context, 'error', '${e.type.message}', ContentType.failure);
    }
  }
  // static Future<String> convertTextToImage(
  //   String prompt,
  // ) async {
  //   // Uint8List imageData = Uint8List(0);

  //   const baseUrl = 'https://api.stability.ai';
  //   final url = Uri.parse(
  //       '$baseUrl/v1alpha/generation/stable-diffusion-512-v2-1/text-to-image');

  //   // Make the HTTP POST request to the Stability Platform API
  //   final response = await http.post(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization':
  //           //add ypur secreat key here
  //           'Bearer sk-klH7OjhNFK05y2yR9NPHkBlc9SZPSbFSdheOtCTc1biFoP2u',
  //       'Accept': 'image/png',
  //     },
  //     body: jsonEncode({
  //       'cfg_scale': 15,
  //       'clip_guidance_preset': 'FAST_BLUE',
  //       'height': 512,
  //       'width': 512,
  //       'samples': 1,
  //       'steps': 150,
  //       'seed': 0,
  //       'style_preset': "3d-model",
  //       'text_prompts': [
  //         {
  //           'text': prompt,
  //           'weight': 1,
  //         }
  //       ],
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     return response.body;
  //   }
  //   return '';
  // }
  // Widget ImgGen(BuildContext context,String prompt) {
  //   return FutureBuilder<dynamic>(
  //     // Call the generate() function to get the image data
  //     future: convertTextToImage(prompt, context),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         // While waiting for the image data, display a loading indicator
  //         return const CircularProgressIndicator();
  //       } else if (snapshot.hasError) {
  //         // If an error occurred while getting the image data, display an error
  //         return Text('Error: ${snapshot.error}');
  //       } else if (snapshot.hasData) {
  //         // If the image data is available, display the image using Image.memory()
  //         return Image.memory(snapshot.data!);
  //       } else {
  //         // If no data is available, display a placeholder or an empty container
  //         return Container();
  //       }
  //     },
  //   );
  // }

  static Future ForgotPass(String email, BuildContext context) async {
    await pb.collection('users').requestPasswordReset(email);
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.blue,
      title: Text(
        'Forgot password?',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20, bottom: 10), //right:52
            child: Container(
              width: 270,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 15),
                  prefixIcon: Icon(Icons.email),
                  hintText: 'please enter email',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: 50,
              color: Colors.blue,
              onPressed: () => null,
              child: Text(
                'Sign Up',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

  static dynamic PopNotify(BuildContext context, String title, String message,
      ContentType content) async {
    OverlayPortalController overlayPortalController = OverlayPortalController();
    overlayPortalController.toggle();

    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: content,
        color: Colors.blue,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
    ));
  }

  static Future<void> Loader(BuildContext context) async {
    context.loaderOverlay.show();
    await Future.delayed(Duration(seconds: 3));
    context.loaderOverlay.hide();
  }

  static Future<void> NavLoader(BuildContext context, Widget page) async {
    context.loaderOverlay.show();
    await Future.delayed(Duration(seconds: 3));
    context.loaderOverlay.hide();
    Navigator.of(context).push(PageAnimationTransition(
        page: page, pageAnimationType: FadeAnimationTransition()));
  }

  static dynamic PopNotify2(
      BuildContext context, String title, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: ContentType.success,
        color: Colors.blue,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
    ));
  }
}
