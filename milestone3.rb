require "date"

class Todo
  def initialize(text,date,completed)
    @text=text;
    @date=date;
    @completed=completed;
  end
  def overdue?
    if @date<Date.today
        return true;
    end
  end
  def due_later?
    if @date>Date.today
        return true;
    end
  end
  def due_today?
    if @date==Date.today
        return true;
    end
  end

  def to_displayable_string
    string_pattern=@completed?"[X] #{@text}":"[] #{@text}"
    string_pattern+=due_later?||overdue? ? @date.to_s : ""
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end
  def add(cTodo)
    @todos.push(cTodo);
  end
  def overdue
    TodosList.new(@todos.select { |todo| todo.overdue? })
  end  
  def due_today
    TodosList.new(@todos.select { |todo| todo.due_today? })
  end
  def due_later
    TodosList.new(@todos.select { |todo| todo.due_later? })
  end
  def to_displayable_list
    displayable_array=@todos.map{|todo| todo.to_displayable_string}
    displayable_list_array=displayable_array.join("\n");
  end
end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"