import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/core/services/theme_controller.dart';
import 'package:tasky/screens/user_details_screen.dart';
import 'package:tasky/core/services/shard_pers.dart';
import 'package:tasky/screens/welcom_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _fullname;
  late String _movQuote;
  String? _selectedImagePath;

  void _loadUserDetails() {
    setState(() {
      _fullname =
          SharedPrefsHelper.instance.getStringValue("fullname") ?? "Guset";
      _movQuote =
          SharedPrefsHelper.instance.getStringValue("movQuote") ??
          "One task at a time. One step closer.";

      _selectedImagePath = SharedPrefsHelper.instance.getStringValue(
        "userPhotoPath",
      );
    });
  }

  Future<void> _logout() async {
    await SharedPrefsHelper.instance.remove("Tasks");
    await SharedPrefsHelper.instance.remove("fullname");
    await SharedPrefsHelper.instance.remove("movQuote");
  }

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("My Profile", style: Theme.of(context).textTheme.displaySmall),
          SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: ThemeController.isDark()
                              ? Colors.transparent
                              : Color(0xFFD1DAD6),
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: _selectedImagePath == null
                            ? AssetImage("assets/images/pe.png")
                            : FileImage(File(_selectedImagePath!)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              title: Text("Choose The Photo Soruce"),
                              contentPadding: EdgeInsets.all(16),

                              children: [
                                ListTile(
                                  onTap: () async {
                                    Navigator.pop(context);
                                    XFile? fileIamge = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (fileIamge != null) {
                                      await _saveIamge(fileIamge);
                                      setState(() {
                                        _selectedImagePath = fileIamge.path;
                                      });
                                    }
                                  },
                                  title: Text(
                                    "Galary",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelMedium,
                                  ),
                                  leading: Icon(Icons.photo),
                                ),

                                ListTile(
                                  onTap: () async {
                                    Navigator.pop(context);
                                    XFile? fileIamge = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    if (fileIamge != null) {
                                      await _saveIamge(fileIamge);
                                      setState(() {
                                        _selectedImagePath = fileIamge.path;
                                      });
                                    }
                                  },
                                  title: Text(
                                    "Camera",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelMedium,
                                  ),
                                  leading: Icon(Icons.camera),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: ThemeController.isDark()
                                ? Colors.transparent
                                : Color(0xFFD1DAD6),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.camera_alt_outlined, weight: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  _fullname,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(_movQuote, style: Theme.of(context).textTheme.titleSmall),
                SizedBox(height: 24),
              ],
            ),
          ),
          Align(
            alignment: AlignmentGeometry.centerLeft,
            child: Text(
              "Profile Info",
              style: Theme.of(
                context,
              ).textTheme.displaySmall!.copyWith(fontSize: 20),
            ),
          ),
          SizedBox(height: 8),
          ListTile(
            onTap: () async {
              if (await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UserDetailsScreen();
                      },
                    ),
                  ) ==
                  true) {
                _loadUserDetails();
              }
            },
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset(
              "assets/images/profile.svg",
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.secondary,
                BlendMode.srcIn,
              ),
            ),
            title: Text("User Details"),
            trailing: Icon(Icons.arrow_forward),
          ),
          Divider(endIndent: 1, thickness: 1),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset(
              "assets/images/moon.svg",
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.secondary,
                BlendMode.srcIn,
              ),
            ),
            title: Text("Dark Mood"),
            trailing: ValueListenableBuilder(
              valueListenable: ThemeController.themeValueNotifier,
              builder: (context, value, child) {
                return Switch(
                  value: value == ThemeMode.dark,
                  onChanged: (value) async {
                    await ThemeController.toggleTheme();
                  },
                );
              },
            ),
          ),
          Divider(endIndent: 1, thickness: 1),
          ListTile(
            onTap: () async {
              await _logout();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => WelcomScreen()),
                (route) => false,
              );
            },
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset(
              "assets/images/log-out.svg",
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.secondary,
                BlendMode.srcIn,
              ),
            ),
            title: Text("Log Out"),
            trailing: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }

  Future<void> _saveIamge(XFile image) async {
    Directory appPath = await getApplicationDocumentsDirectory();

    final newPath = await File(image.path).copy("${appPath.path}${image.name}");

    await SharedPrefsHelper.instance.setStringValue(
      "userPhotoPath",
      newPath.path,
    );
  }
}
