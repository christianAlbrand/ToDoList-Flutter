import 'package:flutter/material.dart';

class TareaItem extends StatelessWidget {
  final String nombre;
  final Function(String) onEditar;
  final VoidCallback onEliminar;

  const TareaItem({
    super.key,
    required this.nombre,
    required this.onEditar,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key!,
      background: Container(
        color: Colors.blue,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          final controller = TextEditingController(text: nombre);

          final resultado = await showDialog<String>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Editar tarea'),
              content: TextField(controller: controller),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context, controller.text),
                  child: const Text('Guardar'),
                ),
              ],
            ),
          );

          if (resultado != null && resultado.trim().isNotEmpty) {
            onEditar(resultado.trim());
          }

          return false;
        }

        return await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Eliminar tarea'),
                content: Text('¿Eliminar "$nombre"?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Eliminar'),
                  ),
                ],
              ),
            ) ??
            false;
      },
      onDismissed: (_) => onEliminar(),
      child: ListTile(
        title: Text(nombre),
        trailing: const Icon(Icons.drag_handle),
      ),
    );
  }
}
