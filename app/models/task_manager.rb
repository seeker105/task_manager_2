require 'sequel'
require 'pry'
require_relative 'task'

class TaskManager
  attr_reader :database

  def initialize
    @database = Sequel.sqlite('db/task_manager.sqlite')
  end

  def create(task)
    raw_tasks.insert(task)
  end

  def raw_tasks
    database.from(:tasks)
  end

  def all
    result = database.from(:tasks).map do |task|
      Task.new(task)
    end
    result ||= []
  end

  def raw_task(id)
    raw_tasks.where(:id => id).to_a.first
  end

  def find(id)
    Task.new(raw_task(id))
  end

  def update(id, task)
    raw_tasks.where(:id => id).update(task)
  end

  def destroy(id)
    raw_tasks.where(:id => id).delete
  end

end
