module Monopoly
  module Space
    module Property
      class Property < Space

        attr_reader :owner

        def initialize(monopoly, propertygroup, name, sale_price, interest)
          @owner = nil
          @propertygroup = propertygroup
          @sale_price = sale_price
          @interest = interest
          super(monopoly, name)
        end

        def land_action
          if @owner.nil?
            @boardgame.active_player.pay_money(@sale_price)
            @owner = @boardgame.active_player unless @boardgame.active_player.bankrupt?
          else
            @owner.receive_money(@boardgame.active_player.pay_money(interest)) unless @boardgame.active_player == @owner
          end
          super
        end

        :protected

        attr_reader :sale_price

        def interest
          @interest
        end

      end
    end
  end
end