import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:publicaciones_automaticas/blocs/sesion/sesion_bloc.dart';
import 'package:publicaciones_automaticas/widgets/buttons/button.dart';
import 'package:publicaciones_automaticas/widgets/textform/textformfield_p_icon.dart';


class FormLoginScreem extends StatefulWidget {

  //PARAMTREOS
  final SesionState session;
  final Color letraColor;

  const FormLoginScreem({
    super.key,
    required this.session,
    required this.letraColor,
  });

  @override
  State<FormLoginScreem> createState() => _FormLoginScreemState();
}

class _FormLoginScreemState extends State<FormLoginScreem> {
  
  final emailC = TextEditingController(text: 'admin');
  final passwordC = TextEditingController(text: '1234');

  final _keyForm = GlobalKey<FormState>();

  var sessionBloc = SesionBloc(); 

  @override
  void initState() {
    super.initState();
    sessionBloc = BlocProvider.of<SesionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * ( 
        // DeviceType.isTablet(context)? 0.6 : 
        // DeviceType.isMobile(context)? 0.8 :
        0.8
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _keyForm,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: const Text(
                "¡Bienvenido!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Por favor, ingrese los datos."),
              ),
              
              const SizedBox(height: 20),
          
              TextFormFieldP(
                title: 'Correo', 
                subTitle: 'Correo',
                controller: emailC,
                password: false,
                validarEmail: true,
                letraColor: widget.letraColor,
                colores: Colors.white,
                icon: const Icon(Icons.email_outlined,color: Colors.grey)
              ),
          
              const SizedBox(height: 10),
          
              TextFormFieldP(
                title: 'Contraseña', 
                subTitle: 'Contraseña',
                controller: passwordC,
                password: true,
                letraColor: widget.letraColor,
                colores: Colors.white,
                icon: const Icon(Icons.password,color: Colors.grey),
                maxLines: 1,
              ),
              
              const SizedBox(height: 20),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonPS(
                    title: 'Ingresar',
                    onPressed: (){

                      if (_keyForm.currentState!.validate()) {
                        
                        Map<String, dynamic> data = {
                          'username': emailC.text,
                          'password': passwordC.text
                        };
            
                        context.read<SesionBloc>().add(LoginEvent(data: data));
                        
                      }
          
                    },
                    elevation: 3,
                    background: Colors.blue,
                    colorText: Colors.white,
                    icon: Icons.login_outlined,
                    colorIcon: Colors.white,
                    colorHoverText: Colors.white,
                    isLoading: widget.session.isLoadingLogin,
                    colorLoading: Colors.yellow,
                  ),
                ],
              )
          
            ],
          ),
        ),
      ),
    );
  }

}