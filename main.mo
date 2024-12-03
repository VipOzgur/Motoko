actor ToDoList {

    // ToDo
    type Task = {
        id: Nat;         
        description: Text; 
        completed: Bool;   
    };

    
    var tasks: [Task] = [];
    var nextId: Nat = 0; 

    // Yeni görev ekleme 
    public func addTask(description: Text) : async Task {
        let newTask = {
            id = nextId;
            description = description;
            completed = false;
        };
        tasks := Array.append(tasks, [newTask]);
        nextId += 1;
        return newTask;
    };

    //görevleri listeleme
    public query func getTasks() : async [Task] {
        return tasks;
    };

    // Görevi tamamlandı olarak işaretleme
    public func completeTask(id: Nat) : async ?Task {
        let index = Array.findIndex<Task>(tasks, func (task) { task.id == id });
        switch (index) {
            case (?i) {
                tasks[i].completed := true;
                return ?tasks[i];
            };
            case null {
                return null; // Görev bulunamadı
            };
        };
    };

    // Tamamlanmış görevleri silme
    public func removeCompletedTasks() : async Nat {
        let initialLength = tasks.size();
        tasks := Array.filter<Task>(tasks, func (task) { !task.completed });
        return initialLength - tasks.size(); // Silinen görev sayısını döndür
    };
};
