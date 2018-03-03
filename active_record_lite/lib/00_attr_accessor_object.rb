# class MetaCorgiSnacks
#   def initialize(snack_box, box_id)
#     @snack_box = snack_box
#     @box_id = box_id
#     snack_box.methods.grep(/^get_(.*)_info$/) { MetaCorgiSnacks.define_snack $1 }
#   end
#
#   def method_missing(name, *args)
#     # Your code goes here...
#     info = @snack_box.send("get_#{name}_info", @box_id)
#     tastiness = @snack_box.send("get_#{name}_tastiness", @box_id)
#     treat = "#{name.to_s.split(" ").map(&:capitalize).join(" ")}"
#     result = "#{treat}: #{info}: #{tastiness} "
#     tastiness > 30 ? "* #{result}" : result
#   end
#
#
#   def self.define_snack(name)
#     # Your code goes here...
#     define_method(name) do
#      info = @snack_box.send("get_#{name}_info", @box_id)
#      tastiness = @snack_box.send("get_#{name}_tastiness", @box_id)
#      name = "#{name.split('_').map(&:capitalize).join(' ')}"
#      result = "#{name}: #{info}: #{tastiness}"
#      tastiness > 30 ? "* #{result}" : result
#   end
# end

class AttrAccessorObject
  def self.my_attr_accessor(*names)
      names.each do |name|
        define_method(name) do
          instance_variable_get("@#{name}")
        end

        define_method("#{name}=") do |value|
          instance_variable_set("@#{name}", value)
        end
      end
  end
end
