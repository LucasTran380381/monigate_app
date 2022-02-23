import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/change_password/providers/submit_button_state_provider.dart';
import 'package:monigate_app/notification/services/notification_service.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  late final TextEditingController _oldPasswordController;
  late final TextEditingController _newPasswordController;
  final formKey = GlobalKey<FormState>();
  bool isWrongPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thay đổi mật khẩu',
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                obscureText: true,
                controller: _oldPasswordController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'Vui lòng nhập mật khẩu ít nhất 8 ký tự';
                  }

                  if (isWrongPassword) {
                    return 'Sai mật khẩu';
                  }

                  return null;
                },
                decoration: const InputDecoration(
                    label: Text(
                  'Mật khẩu hiện tại',
                )),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(label: Text('Mật khẩu mới')),
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'Vui lòng nhập mật khẩu ít nhất 8 ký tự';
                  }
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(label: const Text('Xác nhận mật khẩu')),
                validator: (value) {
                  if (value != _newPasswordController.text) {
                    return 'Xác nhận mật khẩu không đúng';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: !ref.watch(changePasswordButtonProvider)
                    ? null
                    : () async {
                        isWrongPassword = false;
                        final isValid = formKey.currentState?.validate() ?? false;
                        if (!isValid) {
                          return;
                        }

                        final result =
                            await ref.read(changePasswordButtonProvider.notifier).submit(_oldPasswordController.text, _newPasswordController.text);
                        // final result = await ref.read(authServiceProvider).changePassword(_oldPasswordController.text, _newPasswordController.text);

                        if (result == 'success') {
                          ref.read(notificationServiceProvider).showNotification('Thay đổi mật khẩu', 'Thay đổi mật khẩu thành công', '');
                          Navigator.of(context).pop();
                        }

                        if (result == 'wrong password') {
                          isWrongPassword = true;
                          formKey.currentState?.validate();
                        }

                        print('result $result');
                      },
                child: const Text('Cập nhật'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
