import 'package:flutter/material.dart';
import 'package:make_plan/viewmodel/profile_provider.dart';
import 'package:provider/provider.dart';
import 'profile_text_field.dart';

class EditProfileForm extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;

  const EditProfileForm({
    super.key,
    required this.nameCtrl,
    required this.emailCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileTextField(
          controller: nameCtrl,
          label: "Name",
        ),
        const SizedBox(height: 12),
        ProfileTextField(
          controller: emailCtrl,
          label: "Email",
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              context.read<ProfileProvider>().updateProfile(
                    nameCtrl.text,
                    emailCtrl.text,
                  );
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ),
      ],
    );
  }
}
