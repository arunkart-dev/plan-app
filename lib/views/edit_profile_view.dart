import 'package:flutter/material.dart';
import 'package:make_plan/widgets/profile/edit_profile_form.dart';
import 'package:provider/provider.dart';
import '../viewmodel/profile_provider.dart';


class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;

  @override
  void initState() {
    final user = context.read<ProfileProvider>().user;
    nameCtrl = TextEditingController(text: user?.name);
    emailCtrl = TextEditingController(text: user?.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: EditProfileForm(
          nameCtrl: nameCtrl,
          emailCtrl: emailCtrl,
        ),
      ),
    );
  }
}
