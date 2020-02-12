require_relative "../config/environment.rb"

class Student
attr_accessor :name, :grade
attr_reader :id

def initialize(name, grade)
  @name = name
  @grade = grade
  @id = id
end

 

    # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def update
     sql = "UPDATE students SET name = ?, grade = ? WHERE name = ?"
     DB[:conn].execute(sql, self.name, self.grade, self.name)
end

end
