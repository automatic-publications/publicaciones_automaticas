import 'package:flutter/material.dart';
import 'package:publicaciones_automaticas/widgets/text/list_tile.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.person_2_outlined),
            SizedBox(width: 8),
            Text('Perfil', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration( image: DecorationImage(image: AssetImage('castillo.png'),fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(50)
                    )
                  ),
                  const SizedBox(height: 10),
                  const Text('Marlon Bossa',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  const Text('bossa@email.com',style: TextStyle(color: Colors.grey),),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomListTile(
              icon: Icons.shopping_bag,
              title: 'Mis productos',
              onTap: () {},
            ),
            CustomListTile(
              icon: Icons.payment,
              title: 'Métodos de pago',
              onTap: () {},
            ),
            CustomListTile(
              icon: Icons.location_on,
              title: 'Direcciones de envío',
              onTap: () {},
            ),
            CustomListTile(
              icon: Icons.settings,
              title: 'Configuración',
              onTap: () {},
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}
