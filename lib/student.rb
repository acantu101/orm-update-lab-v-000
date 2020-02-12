require_relative "../config/environment.rb"

class Student
attr_accessor :name, :grade
attr_reader :id

def initialize(name, grade)
  @name = name
  @grade = grade
  @id = id
end

def self.create_table
  sql = <<-SQL
  CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    grade INTEGER)

  SQL
  DB[:conn].execute(sql)
end

def self.drop_table
  sql = <<-SQL DROP TABLE students
  SQL
  DB[:conn].execute(sql)
end

def save
  sql = <<-SQL
  INSERT INTO students (name, grade)
  VLUES (?, ?)
  SQL
  DB[:conn].execute(sql, self.name, self.grade)
end

def self.create(name, grade)
  student = Student.new(name, grade)
  student.save
  student
end

def self.new_from_db(row)
  new_student = self.new
  new_student.id = row[0]
  new_student.name = row[1]
  new_student.grade = row[2]
  new_student

end

def self.find_by_name(name)
  sql = <<-SQL
  SELECT *
  FROM students
  WHERE name = ?
  LIMIT 1
  SQL
  DB[:conn].execute(sql,name).map do |row|
    self.new_from_db(row)
  end.first
end
end

    # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def update
     sql = "UPDATE students SET name = ?, grade = ? WHERE name = ?"
     DB[:conn].execute(sql, self.name, self.grade, self.name)
end

end
