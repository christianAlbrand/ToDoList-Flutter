
import 'package:flutter/material.dart';
import 'toDoListTareasActions.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final controller = TextEditingController();

  List<String> tareas = [
    'tarea1',
    'tarea2',
    'tarea3',
    'tarea4',
    'tarea5',
  ];

  void agregarTarea() {
    if (controller.text.isEmpty) return;

    setState(() {
      tareas.add(controller.text);
      controller.clear();
    });
  }

  void editarTarea(int index, String nombre) {
    setState(() {
      tareas[index] = nombre;
    });
  }

  void eliminarTarea(int index) {
    setState(() {
      tareas.removeAt(index);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EDF3),
      appBar: AppBar(
        shadowColor: Colors.black54,
        title: const Text(
          'To Do List',
          style: TextStyle(color: Colors.black54),
          
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Ingresa una tarea...',
                    contentPadding: EdgeInsets.all(12),
                  ),
                  onSubmitted: (_) => agregarTarea(),
                ),
              ),
              IconButton(
                onPressed: agregarTarea,
                icon: const Icon(Icons.add),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                
              ),
            ],
          ),
          Expanded(
            child: ReorderableListView.builder(
              itemCount: tareas.length,
              onReorder: (anterior, nuevo) {
                setState(() {
                  if (nuevo > anterior) nuevo--;
                  final tarea = tareas.removeAt(anterior);
                  tareas.insert(nuevo, tarea);
                });
              },
              itemBuilder: (context, index) {
                return TareaItem(
                  key: ValueKey(tareas[index]),
                  nombre: tareas[index],
                  onEditar: (nombre) => editarTarea(index, nombre),
                  onEliminar: () => eliminarTarea(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
