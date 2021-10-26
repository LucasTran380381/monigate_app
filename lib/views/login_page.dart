import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:monigate_app/controllers/login_controller.dart';
import 'package:monigate_app/widgets/header_clippath.dart';

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
                    'Login',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .merge(const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 20,
                right: 20,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Welcome to Monigate',
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
                                    labelText: 'Username',
                                    errorText: controller.errorText.value,
                                  ),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.phone,
                                  onSaved: (value) =>
                                      controller.username = value,
                                  validator: (value) =>
                                      GetUtils.isEmail(value ?? '')
                                          ? null
                                          : 'Invalid email',
                                ),
                              ),
                              TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    focusColor: Theme.of(context).primaryColor,
                                    labelText: 'P'
                                        'assword'),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                width: double.infinity,
                                child: const Text(
                                  'forgot passsword',
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                  ),
                                  onPressed: controller.onLogin,
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text('Or'),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Theme.of(context).primaryColor),
                                ),
                              )
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
