import 'package:mytodoapp_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class TodoEndpoint extends Endpoint {
  Future<bool> createTodo(Session session, Todo todo) async {
    try {
      await Todo.insert(session, todo);
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<List<Todo>> readTodo(Session session) async {
    return await Todo.find(session);
  }

  Future<bool> updateTodo(Session session, Todo todo) async {
    try {
      await Todo.update(session, todo);
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<bool> deleteTodo(Session session, int id) async {
    var response = await Todo.delete(session, where: (t) => t.id.equals(id));
    return response == 1;
  }

  Future<Todo?> readTodoById(Session session, int id) async {
    var key = "todoId:$id";
    var todo = await session.caches.local.get<Todo>(key);
    print("Read from cache - todo: $todo");
    if (todo == null) {
      print("no data in cache found");
      todo = await Todo.findById(session, id);
      print("Read from database - todo: $todo");
      session.caches.local.put(key, todo!, lifetime: Duration(minutes: 5));
    }
    return todo;
  }
}
