import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:publicaciones_automaticas/blocs/publications/mypublications_bloc.dart';
import 'package:publicaciones_automaticas/screens/utils/utils.dart';

class ProductDetail extends StatefulWidget {
  final Map<String, dynamic> productData;

  const ProductDetail({Key? key, required this.productData}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Utils util = Utils();
  
  
  List<Map<String, String>> cambiosEstado = [
    {"id": "seleccionar", "nombre": "SELECCIONAR"},
    {"id": "aprobado", "nombre": "APROBADO"},
    {"id": "desaprobado", "nombre": "DESAPROBADO"}
  ];

  late final ValueNotifier<String> _valueCambiosEstados;

  @override
  void initState() {
    super.initState();
    final est = widget.productData['estado']?.toString().toLowerCase();
    _valueCambiosEstados = ValueNotifier<String>(
      (est == 'aprobado' || est == 'desaprobado') ? est! : 'seleccionar',
    );
  }

  @override
  void dispose() {
    _valueCambiosEstados.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(widget.productData['image']),fit: BoxFit.cover,),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.blue),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.topic_outlined, color: Colors.blue),
                      const SizedBox(width: 5),
                      Text('Publicación número: ',style: const TextStyle(color: Colors.blue),),
                      const SizedBox(width: 5),
                      Text(widget.productData['id'].toString(),style: const TextStyle(color: Colors.blue),),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(removeHtmlTags(widget.productData['title']),
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 12.0),
                            child: Text('Estado', style: TextStyle(fontSize: 10)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Text(widget.productData['estado'],
                              style: const TextStyle(fontSize: 15,color: Colors.indigo,fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _mejorarDescripcion(removeHtmlTags(widget.productData['title'] ?? '')),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            height: 80,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text('Seleccione si desea realizar un cambio en el estado de la publicación:',style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                _cambiosEstado(context,int.parse(widget.productData['id'].toString()),cambiosEstado,_valueCambiosEstados,),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _cambiosEstado(BuildContext context, int idPublicacion, List<Map<String, String>> data, ValueNotifier<String> controlador,) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.indigo, width: 1.5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
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
                        ChangeStatusPublications(
                          id: idPublicacion,
                          estado: newValue,
                        ),
                      );
                  util.message(context, 'Actualizado con éxito', Colors.green);
                }
                Navigator.pop(context);
                context.read<MyPublicationsBloc>().add(LoadMyPublicationStatus(estado: controlador.value,),);
              },
              items: List.generate(data.length, (i) {
                return DropdownMenuItem<String>(
                  value: data[i]['id'],
                  child: Text(removeHtmlTags(data[i]['nombre']!),
                    style: const TextStyle(
                      color: Colors.indigo,
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }

  Widget _mejorarDescripcion(String text) {
  final List<String> partes = text.split('. ');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: partes.map((p) {
      if (p.trim().isEmpty) return const SizedBox();
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          p.trim() + (p.endsWith('.') ? '' : '.'), 
          style:TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.5),
          textAlign: TextAlign.justify,
        ),
      );
    }).toList(),
  );
}


  String removeHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }
}
