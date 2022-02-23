import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monigate_app/edit_profile/providers/profile_provider.dart';
import 'package:monigate_app/edit_profile/providers/submit_button_provider.dart';
import 'package:monigate_app/models/user.dart';
import 'package:monigate_app/notification/services/notification_service.dart';

class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Thay đổi thông tin'),
          centerTitle: false,
        ),
        body: state.when(data: (User user) {
          final isLoading = !ref.watch(updateProfileButtonProvider);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: user.lastName,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(label: Text('Họ')),
                    onSaved: (value) => user.lastName = value ?? '',
                  ),
                  TextFormField(
                    initialValue: user.firstName,
                    decoration: const InputDecoration(label: Text('Tên')),
                    onSaved: (value) => user.firstName = value ?? '',
                  ),
                  TextFormField(
                    initialValue: user.phone,
                    decoration: const InputDecoration(
                      label: Text('Số điện thoại'),
                    ),
                    onSaved: (value) => user.phone = value ?? '',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            _formKey.currentState?.save();
                            print(user);
                            final result = await ref.read(updateProfileButtonProvider.notifier).updateProfile(user);
                            if (result == 'success') {
                              ref.read(notificationServiceProvider).showNotification('Cập nhật thông tin', 'Cập nhật thông tin thành công', '');
                              Navigator.of(context).pop();
                              return;
                            }

                            print('result: $result');

                            ref.read(notificationServiceProvider).showNotification(
                                'Cập nhật thông tin',
                                'Cập nhật thông tin thất bại vui lòng thử '
                                    'lại',
                                '');
                          },
                    child: const Text('Cập nhật'),
                  ),
                ],
              ),
            ),
          );
        }, error: (Object error, StackTrace? stackTrace) {
          return Text(error.toString());
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }));
  }
}
