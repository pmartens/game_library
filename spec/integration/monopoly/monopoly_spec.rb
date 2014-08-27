#require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Monopoly::Monopoly ->" do

  before do
    players = []
    (1..3).each do |i|
      players << Monopoly::Player.new("player#{i}")
    end
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  # Intialize settings
  it "1. Monopoly exists of 40 spaces" do
    @monopoly.gameboard.space_count.should eq(40)
  end

  it "2. Monopoly will be played with two dices?" do
    @monopoly.settings.dice.class.should eq(Game::DuoTraditionalDice.new.class)
  end

  # restart game
  it "3. When a game starts each player as an initial amount of 1500." do
    @monopoly.settings.players[0].money.should eq(1500)
    @monopoly.settings.players[1].money.should eq(1500)
    @monopoly.settings.players[2].money.should eq(1500)
  end

  # winner
  it "4. The game is won when only one player has sufficient funds." do
    @monopoly.settings.players[1].pay_money(1600)
    @monopoly.settings.players[2].pay_money(1600)
    @monopoly.winner.should eq(@monopoly.settings.players[0])
  end

  it "5. There is no winner if more then two players are not bankrupt." do
    @monopoly.settings.players[1].pay_money(1600)
    @monopoly.winner.should be_nil
  end

  it "6. Give message 'Game played' when there is a winner." do
    @monopoly.settings.players[1].pay_money(1600)
    @monopoly.settings.players[2].pay_money(1600)
    expect { @monopoly.throw_dice }.to raise_error("game played")
  end

  # next_player
  it "7. A player may throw again when he throws double." do
    allow(@monopoly.settings.dice).to receive(:value) {2}
    allow(@monopoly.settings.dice).to receive(:double?) {true}
    @monopoly.throw_dice
    @monopoly.active_player.should eq(@monopoly.settings.players[0])
  end

  it "8. A player may NOT throw again when he throws NOT double." do
    allow(@monopoly.settings.dice).to receive(:value) {3}
    allow(@monopoly.settings.dice).to receive(:double?) {false}
    @monopoly.throw_dice
    @monopoly.active_player.should eq(@monopoly.settings.players[1])
  end

  it "9. When player starts on startposition and throws 4, he lands on incometax." do
    allow(@monopoly.settings.dice).to receive(:value) {4}
    allow(@monopoly.settings.dice).to receive(:double?) {false}
    @monopoly.active_player.should eq(@monopoly.settings.players[0])
    @monopoly.throw_dice
    @monopoly.settings.players[0].position.should eq(4)
    @monopoly.gameboard.space(4).name.should eq("incometax")
  end

  it "10. When player starts on position brink(3) and throws 7, he lands on space Jail (30)." do
    allow(@monopoly.settings.dice).to receive(:value) {7}
    allow(@monopoly.settings.dice).to receive(:double?) {false}
    @monopoly.active_player.should eq(@monopoly.settings.players[0])
    @monopoly.settings.players[0].position = 3
    @monopoly.throw_dice
    @monopoly.settings.players[0].position.should eq(30)
    @monopoly.gameboard.space(30).name.should eq("Jail")
  end

  it "11. When player starts on position Barteljorisstraat (11) and throws 9, he lands on space freeparking (20)" do
    allow(@monopoly.settings.dice).to receive(:value) {9}
    allow(@monopoly.settings.dice).to receive(:double?) {false}
    @monopoly.active_player.should eq(@monopoly.settings.players[0])
    @monopoly.settings.players[0].position = 11
    @monopoly.throw_dice
    @monopoly.settings.players[0].position.should eq(20)
    @monopoly.gameboard.space(20).name.should eq("freeparking")
  end

  it "12. When player starts on position kans (7) and throws 9, he lands on space Neude (16)" do
    allow(@monopoly.settings.dice).to receive(:value) {9}
    allow(@monopoly.settings.dice).to receive(:double?) {false}
    @monopoly.active_player.should eq(@monopoly.settings.players[0])
    @monopoly.settings.players[0].position = 7
    @monopoly.throw_dice
    @monopoly.settings.players[0].position.should eq(16)
    @monopoly.gameboard.space(16).name.should eq("Neude")
  end

  it "13. When player starts on position Ketelstraat (8) and throws 9, he lands on space fonds (17)" do
    allow(@monopoly.settings.dice).to receive(:value) {9}
    allow(@monopoly.settings.dice).to receive(:double?) {false}
    @monopoly.active_player.should eq(@monopoly.settings.players[0])
    @monopoly.settings.players[0].position = 8
    @monopoly.throw_dice
    @monopoly.settings.players[0].position.should eq(17)
    @monopoly.gameboard.space(17).name.should eq("fonds")
  end

  it "14. When player starts on position station south (5) and throws 8, he lands on space Zijlweg (13)" do
    allow(@monopoly.settings.dice).to receive(:value) {8}
    allow(@monopoly.settings.dice).to receive(:double?) {false}
    @monopoly.active_player.should eq(@monopoly.settings.players[0])
    @monopoly.settings.players[0].position = 5
    @monopoly.throw_dice
    @monopoly.settings.players[0].position.should eq(13)
    @monopoly.gameboard.space(13).name.should eq("Zijlweg")
  end

end