// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:icofont_flutter/icofont_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:trash_out/widgets/custom_button.dart';
// import 'package:trash_out/widgets/custom_email_field.dart';
// import 'package:trash_out/widgets/custom_textfield.dart';
// import 'package:trash_out/widgets/gap.dart';

// class AccountPage extends ConsumerStatefulWidget {
//   const AccountPage({Key? key}) : super(key: key);

//   @override
//   ConsumerState<AccountPage> createState() => _AccountPageState();
// }

// class _AccountPageState extends ConsumerState<AccountPage> {
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   File? _selectedImage; // Add this variable to store the selected image

//   Future<void> _pickImage() async {
//     final pickedImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       _selectedImage = File(pickedImage.path);
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var mediaQ = MediaQuery.sizeOf(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Account"),
//         leading: IconButton(
//           splashRadius: 25.0,
//           onPressed: () => context.pop(),
//           icon: const Icon(
//             Icons.arrow_back_ios_new,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Card(
//                 elevation: 1,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 child: Container(
//                   height: mediaQ.height * 0.3,
//                   width: mediaQ.width,
//                   padding: const EdgeInsets.all(16).w,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20.r),
//                   ),
//                   child: Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 50.r,
//                         backgroundImage: _selectedImage != null
//                             ? FileImage(_selectedImage!)
//                             : null,
//                       ),
//                       Text(FirebaseAuth.instance.currentUser!.displayName!),
//                       Text(FirebaseAuth.instance.currentUser!.email!),
//                       IconButton(
//                         splashColor: Colors.black.withOpacity(0.5),
//                         onPressed: _pickImage, // Call the image picker function
//                         icon: Icon(MdiIcons.cameraPlusOutline),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Gap(20.h),
//               Card(
//                 elevation: 1,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.r),
//                 ),
//                 child: Container(
//                   height: mediaQ.height * 0.5,
//                   width: mediaQ.width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.r),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0).w,
//                     child: Column(
//                       children: [
//                         const CustomTextField(
//                             icon: IcoFontIcons.user, label: "New Username"),
//                         Gap(15.h),
//                         CustomEmailField(
//                             icon: MdiIcons.email, label: "New Email"),
//                         Gap(20.h),
//                         CustomButton(
//                           text: "Save",
//                           onPressed: () async {
//                             String userName = usernameController.text.trim();
//                             String email = emailController.text.trim();

//                             // Update user display name
//                             await FirebaseAuth.instance.currentUser!
//                                 .updateDisplayName(userName)
//                                 .then((value) => ScaffoldMessenger.of(context)
//                                     .showSnackBar(const SnackBar(
//                                         backgroundColor: Colors.green,
//                                         content: Text('Username updated'))));

//                             // Update user email
//                             await FirebaseAuth.instance.currentUser!
//                                 .updateEmail(email)
//                                 .then((value) => ScaffoldMessenger.of(context)
//                                     .showSnackBar(const SnackBar(
//                                         backgroundColor: Colors.green,
//                                         content: Text(
//                                             'Email updated, verify it to complete the process.'))));
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trash_out/widgets/custom_button.dart';
import 'package:trash_out/widgets/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../providers/auth_provider.dart';
import '../utils/colors.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
  }

  final _formKey = GlobalKey<FormState>(); // Add this line

  Future<String?> uploadProfilePicture(String imagePath) async {
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_pictures')
        .child(FirebaseAuth.instance.currentUser!.uid);

    final UploadTask uploadTask = storageReference.putFile(File(imagePath));
    final TaskSnapshot storageTaskSnapshot = await uploadTask;
    final String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        leading: IconButton(
          splashRadius: 25.0,
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  height: mediaQ.height * 0.3,
                  width: mediaQ.width,
                  padding: const EdgeInsets.all(16).w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: CachedNetworkImageProvider(
                            FirebaseAuth.instance.currentUser!.photoURL ?? ''),
                        child: IconButton(
                          splashColor: Colors.black.withOpacity(0.5),
                          onPressed: () async {
                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(
                                source: ImageSource.gallery);

                            if (pickedFile != null) {
                              final imageUrl =
                                  await uploadProfilePicture(pickedFile.path);

                              if (imageUrl != null) {
                                await FirebaseAuth.instance.currentUser!
                                    .updatePhotoURL(imageUrl);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('Profile picture updated'),
                                ));
                                await FirebaseAuth.instance.currentUser!
                                    .updatePhotoURL(imageUrl);
                                ref
                                    .read(userProfilePictureProvider.notifier)
                                    .updateProfilePicture(imageUrl);

                                setState(() {});
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.red,
                                  content:
                                      Text('Failed to upload profile picture'),
                                ));
                              }
                            }
                          },
                          icon: Icon(MdiIcons.cameraPlusOutline),
                        ),
                      ),
                      Text(FirebaseAuth.instance.currentUser!.displayName!),
                      Text(FirebaseAuth.instance.currentUser!.email!),
                      IconButton(
                        splashColor: Colors.black.withOpacity(0.5),
                        onPressed: () async {
                          final picker = ImagePicker();
                          final pickedFile = await picker.pickImage(
                              source: ImageSource.gallery);

                          if (pickedFile != null) {
                            final imageUrl =
                                await uploadProfilePicture(pickedFile.path);

                            if (imageUrl != null) {
                              await FirebaseAuth.instance.currentUser!
                                  .updatePhotoURL(imageUrl);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Profile picture updated'),
                              ));
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                backgroundColor: Colors.red,
                                content:
                                    Text('Failed to upload profile picture'),
                              ));
                            }
                          }
                        },
                        icon: Icon(MdiIcons.cameraPlusOutline),
                      )
                    ],
                  ),
                ),
              ),
              Gap(20.h),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Container(
                    height: mediaQ.height * 0.5,
                    width: mediaQ.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0).w,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50.h,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Username is required';
                                  }
                                  return null;
                                },
                                controller: usernameController,
                                cursorColor: KColors.green300,
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  hintText: "New Username",
                                  prefixIcon: const Icon(
                                    IcoFontIcons.user,
                                    color: Colors.grey,
                                  ),
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: KColors.green300),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              ),
                            ),
                            Gap(15.h),
                            SizedBox(
                              height: 50.h,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  }
                                  if (!RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                    return 'Enter a valid email address';
                                  }
                                  return null;
                                },
                                controller: emailController,
                                cursorColor: KColors.green300,
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  hintText: "New Email",
                                  prefixIcon: Icon(
                                    MdiIcons.email,
                                    color: Colors.grey,
                                  ),
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: KColors.green300),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              ),
                            ),
                            Gap(20.h),
                            CustomButton(
                              text: "Save",
                              onPressed: () async {
                                // Valid form, proceed with saving
                                String userName =
                                    usernameController.text.trim();
                                String email = emailController.text.trim();

                                if (usernameController.text.isNotEmpty) {
                                  // Update user display name
                                  await FirebaseAuth.instance.currentUser!
                                      .updateDisplayName(userName)
                                      .then((value) {
                                    setState(() {});
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text('Username updated')));
                                  });
                                }

                                // Update user email
                                if (emailController.text.isNotEmpty) {
                                  await FirebaseAuth.instance.currentUser!
                                      .updateEmail(email)
                                      .then((value) => ScaffoldMessenger.of(
                                              context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                  'Email updated, verify it to complete the process.'))));
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
