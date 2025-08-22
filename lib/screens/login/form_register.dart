import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:publicaciones_automaticas/blocs/sesion/sesion_bloc.dart';
import 'package:publicaciones_automaticas/widgets/buttons/button.dart';
import 'package:publicaciones_automaticas/widgets/textform/textformfield_p_icon.dart';


class FormRegisterScreem extends StatefulWidget {

  //PARAMTREOS
  final SesionState session;
  final Color letraColor;

  const FormRegisterScreem({
    super.key,
    required this.session,
    required this.letraColor,
  });

  @override
  State<FormRegisterScreem> createState() => _FormRegisterScreemState();
}

class _FormRegisterScreemState extends State<FormRegisterScreem> {

  final userC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

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
        // DeviceType.isTablet(context)? 0.63 : 
        // DeviceType.isMobile(context)? 0.83 :
        0.33 
      ),
      child: Form(
        key: _keyForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
        
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: const Text(
              "Registrarse",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Por favor, complete el formulario."),
            ),
        
            const SizedBox(height: 10),
        
            TextFormFieldP(
              title: 'Usuario', 
              subTitle: 'Usuario',
              valLength: 5,
              controller: userC,
              password: false,
              validarEmail: false,
              validarSpacing: true,
              letraColor: widget.letraColor,
              colores: Colors.white,
              icon: const Icon(Icons.person_outline_rounded,color: Colors.grey)
            ),
        
            const SizedBox(height: 10),
        
            TextFormFieldP(
              title: 'correo@example.com', 
              subTitle: 'correo@example.com',
              controller: emailC,
              password: false,
              validarEmail: true,
              letraColor: widget.letraColor,
              colores: Colors.white,
              icon: const Icon(Icons.email_outlined,color: Colors.grey)
            ),
        
            const SizedBox(height: 10),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [

                Expanded(
                  flex: 11,
                  child: TextFormFieldP(
                    title: 'Contraseña', 
                    subTitle: 'Contraseña',
                    controller: passwordC,
                    password: true,
                    validarEmail: false,
                    validarPassword: true,
                    letraColor: widget.letraColor,
                    colores: Colors.white,
                    icon: const Icon(Icons.password,color: Colors.grey)
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.info_outline),
                    tooltip: "Requisitos de contraseña:\n\n"
                              "- Minimo 8 caracteres.\n"
                              "- Contiene al menos 1 número.\n"
                              "- Contiene al menos 1 carácter especial.\n"
                              "- Contiene al menos una letra mayúscula.\n"
                              "- Contiene al menos una letra minúscula.\n"
                  ),
                ),

              ],
            ),
        
            const SizedBox(height: 5),

            TextButton(
              style: ButtonStyle(
                overlayColor: WidgetStatePropertyAll(Colors.transparent)
              ),
              onPressed: (){
                sessionBloc.add(ChangeScreenEvent(isLogin: true));
              }, 
              child: Text('Reenviar codigo.',style: TextStyle(color: Colors.green))
            ),
        
            const SizedBox(height: 10),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonPS(
                  title: 'Enviar',
                  onPressed: (){

                    if (_keyForm.currentState!.validate()) {
                        
                      // Map<String, dynamic> data = {
                      //   'username': userC.text,
                      //   'password': passwordC.text,
                      //   'email': emailC.text
                      // };

                      //sessionBloc.add(RegisterEvent(data: data));  
                    }
                  },
                  elevation: 5,
                  background: Colors.green,
                  colorText: Colors.white,
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
    );
  }

}