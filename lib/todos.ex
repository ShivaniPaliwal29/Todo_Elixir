defmodule Todos do
  def create_todos do
    #old code
    # number_of_tasks = IO.gets("Enter the number of todos you want to add: ")
    # {number_of_tasks, _q} = Integer.parse(number_of_tasks)
    # number_of_tasks

    #cool code - using pipe operator |>
    {number_of_tasks, _} = IO.gets("Enter the number of todos you want to add: ") |> Integer.parse()

    for _ <- 1..number_of_tasks do
      IO.gets("Enter task: ") |> String.trim()
    end
  end

  #todo delete
  def complete_todo(tasks, task) do
    if contains?(tasks, task) do
      List.delete(tasks, task)
    else
      :not_found_error
    end
  end

  #todo add task
  def add_task(tasks, task) do
    List.insert_at(tasks, -1, task)
  end
  def contains?(tasks, task) do
    Enum.member?(tasks, task)
  end

   #search in todo
   def keyword_search(tasks, word) do
    for task <- tasks, String.contains?(task, word) do
       task
    end
  end

  #random task from todos_list
  def random_task(tasks) do
    [task] = Enum.take_random(tasks,1)
    task
  end

  #write in file, todo task
  def save(tasks, filename) do
    #invoking erlang code, converting our list so that it can be written to our file system
    binary = :erlang.term_to_binary(tasks)
    File.write(filename, binary)
  end

  #read from file
  def read(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File does not exist"
    end

    # {_status, binary} = File.read(filename)
    # :erlang.binary_to_term(binary)
  end
end
