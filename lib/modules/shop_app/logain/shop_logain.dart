import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter/layout/shop_app/shop_Home.dart';
import 'package:udemy_flutter/modules/shop_app/logain/cubit/cubit.dart';
import 'package:udemy_flutter/modules/shop_app/logain/cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(

      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context , state) {
          if (state is ShopLoginSuccessState)
            {
              if (state.loginModel.status)
                {
                 // print(state.loginModel.date.token);
                 //  print(state.loginModel.message);

                 CacheHelper.saveData(key: 'token', value:state.loginModel.message ).then((value){
                   navigateAndFinish(context, ShopLayout(),);
                 });
                }else
                  {
                    print(state.loginModel.message);
                    showToast (
                      text:state.loginModel.message,
                      state: ToastStates.WARNING,
                    );

                  }
            }
        },
        builder: (context , state) {
          return  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.blueAccent
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Login now to browse our Medical care',
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.grey,
                            )),
                        SizedBox(height: 30),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopLoginCubit.get(context).suffix,
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                          onSubmit: (value){
                            if (formKey.currentState.validate())
                            {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text, password: passwordController.text);
                            }
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password is too password';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is ! ShopLoginLoadingState ,
                          builder : (context) =>
                              defaultButton(
                                  function: () {
                                    if (formKey.currentState.validate())
                                    {
                                      ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text, password: passwordController.text);
                                    }
                                  },
                                  text: 'Login', isUpperCase: true
                              ),
                            fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t Have An Account ?'),
                            defaultTextButton(
                                function: (){
                                  navigateTo(context, ShopLoginScreen());
                                },
                                text: 'Register'
                            ),              ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
