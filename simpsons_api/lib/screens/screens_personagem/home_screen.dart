import 'package:flutter/material.dart';
import 'package:untitled2/models/personagem.dart';
import 'package:untitled2/services/autenticacao_service/auth_service.dart';
import 'package:untitled2/services/personagem_service/personagem_services.dart';
import 'package:untitled2/widgets/confirmarLogout.dart';

import 'detalhes_personagem_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required AuthService authService})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PersonagemServices service = PersonagemServices();

  late Future<List<Personagem>> personagensFuture;
  late List<Personagem> personagens;
  late List<Personagem> personagensFiltrados;

  @override
  void initState() {
    super.initState();
    personagensFuture = _getPersonagens();
  }

  Future<List<Personagem>> _getPersonagens() async {
    personagens = await service.getPersonagens();
    personagensFiltrados = personagens;
    return personagens;
  }

  _filtroPersonagens(String filtro) {
    setState(() {
      personagensFiltrados = personagens
          .where((item) =>
              item.character.toLowerCase().contains(filtro.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: [
            const Text('API Simpsons'),
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.logout,
              ),
                onPressed: () {
                  confirmarLogout(context);
                },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: (value) {
                _filtroPersonagens(value);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.amber.shade300,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                labelText: "Pesquisar Personagem",
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Personagem>>(
              future: personagensFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 5 / 9,
                    ),
                    itemCount: personagensFiltrados.length,
                    itemBuilder: (context, index) {
                      final personagem = personagensFiltrados[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesPersonagemScreen(
                                personagem: personagem,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.amber.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 2,
                          child: Column(
                            children: [
                              ClipRRect(
                                child: Image.network(
                                  personagem.image,
                                  height: 120,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Text(
                                personagem.character,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                if (snapshot.hasError) {
                  debugPrint(snapshot.error.toString());
                  return const Center(
                    child: Text('Erro ao carregar personagens'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.amberAccent,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
