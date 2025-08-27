import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:publicaciones_automaticas/blocs/publications/mypublications_bloc.dart';
import 'package:publicaciones_automaticas/blocs/sesion/sesion_bloc.dart';
import 'package:publicaciones_automaticas/routes/routes.dart';

void main() {
  runApp(const GuiApp());
}

class GuiApp extends StatelessWidget {
  const GuiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SesionBloc()),
        BlocProvider(create: (_) => MyPublicationsBloc()),
      ],
      child: 
      MaterialApp(
        title: "Estado Publicaciones",
        initialRoute: Routes().login,
        routes: Routes().generatedRoutes(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            toolbarHeight: 60,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          textTheme: GoogleFonts.dmSansTextTheme(),
        ),
      ),
    );
  }
}
