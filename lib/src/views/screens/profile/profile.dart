import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/department.model.dart';
import 'package:attendance_app/src/providers/user_provider.dart';
import 'package:attendance_app/src/services/api/api.dart';
import 'package:attendance_app/src/utils/format_name.dart';
import 'package:attendance_app/src/views/screens/profile/reset_password.dart';
import 'package:attendance_app/src/views/widgets/buttons/button_text_primary_red.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  String name = "";
  String role = "";
  String auid = "";
  String email = "";

  String avatarUrl = "";
  String password = "";
  String department = "";
  bool _loadingDepartment = true;
  String _responseErrorDepartment = "";
  String _responseErrorLogout = "";
  bool _hasFetchedDepartment = false;

  @override
  void initState() {
    super.initState();
  }

  void getDepartment(String departmentId) async {
    setState(() {
      _loadingDepartment = true;
    });
    try {
      ApiResponse<DepartmentModel> response =
          await Api().user.getDepartmentFromId(departmentId);

      if (response.success) {
        setState(() {
          department = response.data.name!;
        });
      }
    } catch (e) {
      setState(() {
        _responseErrorDepartment = e.toString().replaceAll("Exception: ", "");
        debugPrint(_responseErrorDepartment);
      });
    } finally {
      setState(() {
        _loadingDepartment = false;
      });
    }
  }

  void logout() async {
    try {
      Api().user.logout(ref);
      context.go("/");
    } catch (e) {
      _responseErrorLogout = e.toString().replaceAll("Exception: ", "");
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final appUser = ref.watch(userProvider);

    if (appUser != null && !_hasFetchedDepartment) {
      String departmentId = appUser.user.departmentId!;
      getDepartment(departmentId);
      _hasFetchedDepartment = true;
    }

    if (appUser is StudentUser) {
      name = appUser.student.user?.name ?? "User";
      role = appUser.student.user?.role ?? "User";
      auid = appUser.student.user?.auid ?? "000000000";
      email = appUser.student.user?.email ?? "user@auts.ac.in";
    } else if (appUser is TeacherUser) {
      name = appUser.teacher.user?.name ?? "User";
      role = appUser.teacher.user?.role ?? "User";
      auid = appUser.teacher.user?.auid ?? "000000000";
      email = appUser.teacher.user?.email ?? "user@auts.ac.in";
    }

    if (_responseErrorDepartment.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Text(_responseErrorDepartment),
        ),
      );
    }

    if (_responseErrorLogout.isNotEmpty) {
      Fluttertoast.showToast(
        msg: _responseErrorLogout,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Static part (User avatar, background, name)
            Stack(
              children: [
                ClipPath(
                  clipper: ProfileClipper(),
                  child: Container(
                    color: Theme.of(context).colorScheme.primary,
                    height: 200,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        formatName(name),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Section 2: Conditional part (Profile options or loading indicator)
            _loadingDepartment
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.badge_outlined),
                        title: Text(auid),
                      ),
                      ListTile(
                        leading: const Icon(Icons.apartment_outlined),
                        title: Text(formatName(department)),
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.supervised_user_circle_outlined),
                        title: Text(formatName(role)),
                      ),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: Text(email),
                      ),
                      ListTile(
                        leading: const Icon(Icons.vpn_key),
                        title: const Text("*******"),
                        trailing: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled:
                                  true, // For full-height sheet on keyboard popup
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              builder: (context) => Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: const ResetPassword(),
                              ),
                            );
                          },
                          child: const Text("Reset Password"),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                ButtonTextPrimaryRed(
                  text: "Logout",
                  onPressed: () {
                    logout();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
