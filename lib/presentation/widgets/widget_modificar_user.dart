import 'package:flutter/material.dart';

class ModificarUserWidget extends StatefulWidget {
  final String idUser;
  final String initialUsername;
  final String initialAvatar;

  const ModificarUserWidget({
    required this.idUser,
    required this.initialUsername,
    required this.initialAvatar,
    super.key,
  });

  @override
  State<ModificarUserWidget> createState() => _ModificarUserWidgetState();
}

class _ModificarUserWidgetState extends State<ModificarUserWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _avatarController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialUsername);
    _avatarController = TextEditingController(text: widget.initialAvatar);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text("Modificar informacion del usuario"),

              const SizedBox(height: 10),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),
              TextFormField(
                controller: _avatarController,
                decoration: const InputDecoration(labelText: 'Notas'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context, {
                          'idUser': widget.idUser,
                          'username': _usernameController.text,
                          'avatar': _avatarController.text,
                        });
                      }
                    },
                    child: const Text('Actualizar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}