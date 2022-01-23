import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:monigate_app/common/widgets/header_clippath.dart';
import 'package:monigate_app/controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              ClipPath(
                clipper: HeaderClipPath(),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  height: 300,
                  width: double.infinity,
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Đăng nhập',
                    style: Theme.of(context).textTheme.headline4!.merge(const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 20,
                right: 20,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Chào mừng bạn',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              Obx(
                                () => TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Tên đăng nhập',
                                    errorText: controller.errorText.value,
                                  ),
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value) => controller.username = value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập tên đăng nhập';
                                    } else {
                                      return controller.errorText.value;
                                    }
                                  },
                                ),
                              ),
                              TextFormField(
                                obscureText: true,
                                onSaved: (value) => controller.password = value,
                                decoration: InputDecoration(focusColor: Theme.of(context).primaryColor, labelText: 'Mật khẩu'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập password';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: double.infinity,
                                child: const Text(
                                  'Quên mật khẩu',
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Consumer(
                                builder: (context, ref, child) {
                                  return SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                      ),
                                      onPressed: () => controller.login(ref),
                                      child: const Text(
                                        'Đăng nhập',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
