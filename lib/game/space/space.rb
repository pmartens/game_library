module Game
  module Space
    class Space

      attr_reader :name

      def initialize(boardgame, name)
        @name = name.nil? ? 'Space' : name
        @boardgame = boardgame
      end

      def execute_action(action_name)
        #puts "Position: #{@boardgame.gameboard.space_index(self)} Space: #{@name} Action: #{action_name}"
        case action_name
          when "always"
            always_action
            nil
          when "start"
            start_action
          when "pass"
            pass_action
            false
          when "target"
            land_action
            true #halt
          else
            raise "Space action not exists in Space class."
        end
      end

      def always_action
      end

      def start_action
        false
      end

      def pass_action
        false
      end

      def land_action
        @boardgame.active_player.position = @boardgame.gameboard.space_index(self)
      end

    end
  end
end