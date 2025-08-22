import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:publicaciones_automaticas/blocs/sesion/sesion_bloc.dart';
import 'package:publicaciones_automaticas/routes/routes.dart';

import 'form_register.dart';
import 'form_login.dart';

class LoginScreem extends StatefulWidget {
  const LoginScreem({super.key});

  @override
  State<LoginScreem> createState() => _LoginScreemState();
}

class _LoginScreemState extends State<LoginScreem> {
  
  final letraColor = Color.fromARGB(255, 0, 0, 0);

  var sessionBloc = SesionBloc();

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    sessionBloc = BlocProvider.of<SesionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SesionBloc, SesionState>(
      listener: (context, session) {
        if (session.response['status'] != null) {
          validator(session.response);
        }
      },
      listenWhen: (previous, current) {
        return previous.response != current.response;
      },
      child: BlocBuilder<SesionBloc, SesionState>(
        builder: (context, session) {
          return Scaffold(
            //backgroundColor: Colors.white,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: _scrollController,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        session.isLogin ? 
                          FormLoginScreem(session: session, letraColor: letraColor) 
                        : 
                          FormRegisterScreem(session: session, letraColor: letraColor),
                    
                        const SizedBox(height: 10),
                        
                        notLogin(session),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }

  TextButton notLogin(SesionState session) {
    return TextButton(
      onPressed: session.isLoadingLogin? null : () {
        sessionBloc.add(ChangeScreenEvent(isLogin: !session.isLogin));
      },
      child: Text.rich(
        TextSpan(
          children: [
            session.isLogin ?
              TextSpan(
                children: [
                  TextSpan(text:"¿No tienes cuenta? ",style: TextStyle(color: Colors.grey)),
                  TextSpan(text:"Regístrate",style: TextStyle(color: Colors.blue)),
                ]
              )
            :
              TextSpan(
                children: [
                  TextSpan(text:"¿Ya tienes cuenta? ",style: TextStyle(color: Colors.grey)),
                  TextSpan(text:"Inicia sesión",style: TextStyle(color: Colors.blue)),
                ]
              )
          ],
          style: const TextStyle(fontSize: 16),
        ) 
      ),
    );
  }

  void validator(Map data) {

    if (data['status'] == 200) {

      Navigator.of(context).pushReplacementNamed(
        Routes().home
      );

    }else
    if (data['status'] == 400 || data['status'] == 404) {

      //ShowMessage(context).message(data['error'],Colors.orange,null);
      debugPrint(data['error']);

    }else
    if (data['status'] == 500) {

      //ShowMessage(context).message('Se presento un error interno, intente mas tarde.',Colors.red,null);
      debugPrint('Se presento un error interno, intente mas tarde.');
    
    }

  }

}
