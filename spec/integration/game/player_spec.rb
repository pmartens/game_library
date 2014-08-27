#require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Game::Player ->" do

  before do
    @players = []
    (1..2).each do |i|
      @players << Game::Player.new("player#{i}")
    end
  end

  it "When player without name joins the game an exception will be raised" do
    expect { Game::Player.new('') }.to raise_error("Player name empty!")
  end

  it "When player with name joins the game no exception will be raised" do
    expect { Game::Player.new('test') }.to_not raise_error
  end

  it "When player is on position 0 changes to 2, the position is 2 and the last position is 0." do
    p = Game::Player.new("player1")
    p.position = 2
    p.position.should eq(2)
    p.last_position.should eq(0)
  end

  it "When player is on position 1 changes to 2, the position is 2 and the last position is 1." do
    p = Game::Player.new("player1")
    p.position = 1
    p.position = 2
    p.position.should eq(2)
    p.previous_position.should eq(1)
  end

end
