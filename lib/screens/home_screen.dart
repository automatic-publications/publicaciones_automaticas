import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:publicaciones_automaticas/blocs/publications/mypublications_bloc.dart';
import 'package:publicaciones_automaticas/screens/product_detail.dart';
import 'package:publicaciones_automaticas/widgets/text/text_rich.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int selectedIndex = 0;
 var publicacionesBloc;

  List<Map<String, String>> cambiosEstado = [
    {"id": "APROBADO", "nombre": "APROBADO"},
    {"id": "PUBLICADO", "nombre": "PUBLICADO"},
    {"id": "PENDIENTE", "nombre": "PENDIENTE"}
  ];

  late final ValueNotifier<String> _valueCambiosEstados;


  @override
  void initState() {
    super.initState();

    // Estado inicial "pendiente"
    _valueCambiosEstados = ValueNotifier<String>("PENDIENTE");

    // Cargar publicaciones de ese estado
    context.read<MyPublicationsBloc>().add(LoadMyPublicationStatus(estado: _valueCambiosEstados.value),);

    // Recargar automáticamente estado
    _valueCambiosEstados.addListener(() {
      context.read<MyPublicationsBloc>().add(LoadMyPublicationStatus(estado: _valueCambiosEstados.value),);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.mark_chat_read),
            SizedBox(width: 10),
            Text('Publicaciones',style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Gestión de publicaciones ',style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Puede aprobar, desaprobar o ver el estado de la publicación'),
              leading: Icon(Icons.check_circle_outline_rounded),
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _cambiosEstado(context,cambiosEstado,_valueCambiosEstados,),
              ),
            Expanded(
              child: BlocBuilder<MyPublicationsBloc, MyPublicationsState>(
                builder: (context, state) {
                  if (state.publicaciones.isEmpty) {
                    return const Center(
                      child: Text("No hay publicaciones disponibles"),
                    );
                  }
                  return SingleChildScrollView(
                    child: Center(
                      child: Wrap(
                        runSpacing: 15,
                        spacing: 15,
                        alignment: WrapAlignment.start,
                        children: List.generate(
                          state.publicaciones.length, 
                          (i) {
                            final pub = state.publicaciones[i]; 
                            return SizedBox(
                              width: 180,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetail(
                                        productData: {
                                          "image": "${pub.imagenUrl}",
                                          "id": pub.id,
                                          "title": "${removeHtmlTags(pub.descripcion)}",
                                          "estado": "${pub.estado}",
                                          "description": "${removeHtmlTags(pub.descripcion)}",
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 180,
                                            height: 140,
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.vertical(
                                                top: Radius.circular(15),
                                              ),
                                              child: Image.network(pub.imagenUrl!, fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return const Icon(Icons.error,color: Colors.red,);
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextRichP(
                                                  data: [
                                                    {
                                                      'title': '${i + 1}. ${removeHtmlTags(pub.descripcion)}',
                                                      'color': Colors.black,
                                                      'size': 16,
                                                      'bold': true,
                                                    },
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                TextRichP(
                                                  data: [
                                                    {
                                                      'title': 'Estado: ',
                                                      'color': Colors.black87,
                                                      'size': 12,
                                                      'bold': true,
                                                    },
                                                    {
                                                      'title': pub.estado,
                                                      'color': Colors.indigo,
                                                      'size': 14,
                                                      'bold': true,
                                                    },
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Positioned(top: 10, right: 10,
                                        child: Icon(Icons.favorite_rounded,color: Colors.red,size: 30,),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cambiosEstado(BuildContext context, List<Map<String, String>> data,ValueNotifier<String> controlador,) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.indigo, width: 1.5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: ValueListenableBuilder<String>(
          valueListenable: controlador,
          builder: (BuildContext context, String value, Widget? child) {
            return DropdownButton<String>(
              value: value,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controlador.value = newValue;

                  context.read<MyPublicationsBloc>().add(
                        LoadMyPublicationStatus(
                          estado: newValue,
                        ),
                      );
                }
              },
              items: List.generate(data.length, (i) {
                return DropdownMenuItem<String>(
                  value: data[i]['id'],
                  child: Text(removeHtmlTags(data[i]['nombre']!),style: const TextStyle(color: Colors.indigo,),),
                );
              }),
            );
          },
        ),
      ),
    );
  }

   String removeHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }
}