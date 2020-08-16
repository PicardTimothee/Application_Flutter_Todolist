import 'package:flutter/material.dart';
import './task.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TODO();
  }
}

class TODO extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TODOState();
  }
}

class TODOState extends State<TODO> {
  final List<Task> tasks = []; //liste des taches

  void onTaskCreated(String name) {
    setState(() {
      tasks.add(Task(name));
    });
  }

  void onTaskToggled(Task task) {
    setState(() {
      task.setCompleted(!task.isCompleted());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mon Application',
      initialRoute: '/',
      routes: {
        //init du router
        '/': (context) => TODOList(tasks: tasks, onToggle: onTaskToggled),
        '/create': (context) => TODOCreate(
              onCreate: onTaskCreated,
            ),
      },
    );
  }
}

class TODOList extends StatelessWidget {
  final List<Task> tasks;
  final onToggle;

  TODOList({
    @required this.tasks,
    @required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: new Center(
          child: new Text(
            'Application liste de tâches',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: ListView.builder(
          // boucle sur la liste
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              //on crée chaque lignes
              title: Text(
                tasks[index].getName(),
                style: tasks[index].isCompleted()
                    ? new TextStyle(
                        color: Colors.green,
                        decoration: TextDecoration.lineThrough,
                      )
                    : new TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
              ), //on récupère le nom de l'element de la liste puis sa vaeur true / false
              value: tasks[index].isCompleted(),
              onChanged: (_) => onToggle(
                  tasks[index]), //ce que l'on fait quand on appuie sur la tache
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
            context, '/create'), //redirection sur page création
        child: Icon(Icons.add),
      ),
    );
  }
}

class TODOCreate extends StatefulWidget {
  final onCreate;

  TODOCreate({@required this.onCreate});

  @override
  State<StatefulWidget> createState() {
    return TODOCreateState();
  }
}

class TODOCreateState extends State<TODOCreate> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter une tâche')),
      body: Center(
          child: Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                  // Ouvrir le clavier automatiquement
                  autofocus: true,
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: 'Entrer le nom de la tâche',
                  )))),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          //on crée le widget
          widget.onCreate(controller.text);
          Navigator.pop(context);
        },
      ),
    );
  }
}
