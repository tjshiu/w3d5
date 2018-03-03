require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    return @columns if @columns
    columns1 = DBConnection.execute2(<<-SQL)
    SELECT
      *
    FROM
      "#{self.table_name}"
    SQL

    @columns = columns1[0].map(&:to_sym)
  end

  def self.finalize!
    columns.each do |column|
      define_method("#{column}") do
        @attributes[column]
      end
      define_method("#{column}=") do |value|
        self.attributes[column] = value
      end
    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    if @table_name
      @table_name
    else
      @table_name = self.to_s.tableize
    end

  end

  def self.all
    # ...
    # self_name = self.table_name
    all = DBConnection.execute(<<-SQL)
    SELECT
      *
    FROM
      "#{self.table_name}"
    SQL
    self.parse_all(all)
  end

  def self.parse_all(results)
    # ...
    results.map {|option| self.new(option)}
  end

  def self.find(id)
    # ...
    self.all.each {|row| return row if row.id == id}
    nil
  end

  def initialize(params = {})
    # ...
    params.each do |attr_name, value|
      if self.class.columns.include?(attr_name.to_sym)
        self.send("#{attr_name}=", value)
      else
        raise "unknown attribute '#{attr_name}'"
      end
    end

  end

  def attributes
    # ...
    @attributes = {} unless @attributes
    self.instance_variable_set("@attribute", @attributes)
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
