require_relative "room"

class Hotel
    attr_reader :rooms
  def initialize(name, room_info)
    @name = name
    @rooms = {}
    room_info.each { |k, v| @rooms[k] = Room.new(v) }
  end

  def name
    @name.split.map { |word| word.capitalize }.join(" ")
  end

  def room_exists?(room)
    rooms.has_key?(room)
  end

  def check_in(person,room)
    if self.room_exists?(room)
        if @rooms[room].add_occupant(person)
            puts "check in successful"
        else
            puts "sorry, room is full"
        end
    else
        puts "sorry, room does not exist"
    end
  end

  def has_vacancy?
    count = 0
    @rooms.each { |k, num| count += 1 if num.available_space > 0 }
    count >= 1
  end

  def list_rooms
    @rooms.each do |room, space|
       puts "#{room} #{space.available_space}"
    end
  end
end
