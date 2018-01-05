class Student
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name,:grade
  attr_reader :id
  DB = {:conn=>SQLite3::Database.new("db/students.db")}

  def initialize(name=nil,grade=nil,id=nil)
    @name = name
    @grade = grade
  end
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
      SQL
      DB[:conn].execute(sql)
  end
  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end
  def save
    sql = <<-SQL
      INSERT INTO students (name,grade) VALUES (?, ?)
    SQL

    DB[:conn].execute(sql,@name,@grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")
  end

end
