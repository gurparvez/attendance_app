import 'package:attendance_app/src/models/api_response.dart';
import 'package:attendance_app/src/models/department.model.dart';
import 'package:attendance_app/src/providers/user_provider.dart';
import 'package:attendance_app/src/routes/routes.dart';
import 'package:attendance_app/src/services/api/api.dart';
import 'package:attendance_app/src/utils/format_name.dart';
import 'package:attendance_app/src/views/widgets/buttons/button_text_primary_red.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  String avatarUrl = "";
  bool _isPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  TextEditingController _newPasswordController = TextEditingController();
  String password = "";
  String department = "";
  bool _loadingDepartment = true;
  String _responseErrorDepartment = "";
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

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    if (user != null && !_hasFetchedDepartment) {
      String departmentId = user.user!.departmentId!;
      getDepartment(departmentId);
      _hasFetchedDepartment =
          true; // Mark as fetched to avoid repeated API calls
    }

    if (_responseErrorDepartment.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Text(_responseErrorDepartment),
        ),
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
                        formatName(user!.user!.name!),
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
                      leading: Icon(Icons.badge_outlined),
                      title: Text(user.user!.auid!),
                    ),
                    ListTile(
                      leading: Icon(Icons.apartment_outlined),
                      title: Text(formatName(department)),
                    ),
                    ListTile(
                      leading: Icon(Icons.supervised_user_circle_outlined),
                      title: Text(formatName(user.user!.role!)),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text(user.user!.email!),
                    ),
                    ListTile(
                      leading: Icon(Icons.lock),
                      title: Text("*******"),
                      trailing: Icon(
                        Icons.refresh,
                      ),
                      onTap: () {

                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
            Row(
              children: [
                SizedBox(width: 20,),
                ButtonTextPrimaryRed(text: "Logout", onPressed: () {}),
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
