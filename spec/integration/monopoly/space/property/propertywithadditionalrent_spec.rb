require File.expand_path(File.dirname(__FILE__) + '/../../../../spec_helper')

describe "Monopoly::PropertyWithAdditionalRent." do
  before do
    players = []
    @player1 = Monopoly::Player.new("player1")
    players << @player1
    @player2 = Monopoly::Player.new("player2")
    players << @player2
    settings = Monopoly::Settings.new(players)
    @monopoly = Monopoly::Monopoly.new(settings)
  end

  it "get_interest() Als een vastgoed geen rente heeft hoeft speler die op het vastgoed land $0 te betalen" do
    @player1.reset
    @player1.receive_money(1)
    additionalrent = double("additionalrent", :receiver => nil, :rent_percentage => 0)
    property = Monopoly::Space::Property::PropertyWithAdditionalRent.new(Monopoly::Space::Property::Property.new(@monopoly, nil, 'test', 0, 0), additionalrent)
    property.land_action
    @player1.money.should eq(1)
  end

  # bij geen eigenaar word persoon die op het vakje land automatisch eigenaar

  it "get_interest() Als een vastgoed met $1 huur en speler 1 als eigenaar die moet de speler 2 die op het vastgoed land $1 betalen aan speler 1." do
    @player2.reset
    @player1.reset
    @player2.receive_money(1)
    additionalrent = double("additionalrent", :receiver => nil, :rent_percentage => 0)
    property = Monopoly::Space::Property::PropertyWithAdditionalRent.new(Monopoly::Space::Property::Property.new(@monopoly, nil, 'test', 0, 1), additionalrent)
    allow(@monopoly).to receive(:active_player) {@player1}
    property.land_action
    allow(@monopoly).to receive(:active_player) {@player2}
    property.land_action
    @player2.money.should eq(0)
    @player1.money.should eq(1)
  end

  it "get_interest() Als een vastgoed met $1 huur en speler 1 als eigenaar die geen verhoogde huur ontvangt dan moet speler 2 die op het vastgoed land $1 betalen aan speler 1." do
    @player2.reset
    @player1.reset
    @player2.receive_money(1)
    additionalrent = double("additionalrent", :receiver => @player1, :rent_percentage => 1)
    property = Monopoly::Space::Property::PropertyWithAdditionalRent.new(Monopoly::Space::Property::Property.new(@monopoly, nil, 'test', 0, 1), additionalrent)
    allow(@monopoly).to receive(:active_player) {@player1}
    property.land_action
    allow(@monopoly).to receive(:active_player) {@player2}
    property.land_action
    @player2.money.should eq(0)
    @player1.money.should eq(1)
  end

  it "get_interest() Als een vastgoed met $1 huur en speler 1 als eigenaar die een verhoogde huur ontvangt van 0% dan moet speler 2 die op het vastgoed land $1 betalen aan speler 1." do
    @player2.reset
    @player1.reset
    @player2.receive_money(1)
    additionalrent = double("additionalrent", :receiver => @player1, :rent_percentage => 0)
    property = Monopoly::Space::Property::PropertyWithAdditionalRent.new(Monopoly::Space::Property::Property.new(@monopoly, nil, 'test', 0, 1), additionalrent)
    allow(@monopoly).to receive(:active_player) {@player1}
    property.land_action
    allow(@monopoly).to receive(:active_player) {@player2}
    property.land_action
    @player2.money.should eq(0)
    @player1.money.should eq(1)
  end

  it "get_interest() Als een vastgoed met $1 huur en speler 1 als eigenaar die een verhoogde huur ontvangt van 10% dan moet speler 2 die op het vastgoed land $1,1 betalen aan speler 1." do
    @player2.reset
    @player1.reset
    @player2.receive_money(1.1)
    additionalrent = double("additionalrent", :receiver => @player1, :rent_percentage => 10)
    property = Monopoly::Space::Property::PropertyWithAdditionalRent.new(Monopoly::Space::Property::Property.new(@monopoly, nil, 'test', 0, 1), additionalrent)
    allow(@monopoly).to receive(:active_player) {@player1}
    property.land_action
    allow(@monopoly).to receive(:active_player) {@player2}
    property.land_action
    @player2.money.round(0).should eq(0)
    @player1.money.should eq(1)
  end

  it "get_interest() Als een vastgoed geen huur heeft en speler 1 als eigenaar die een verhoogde huur van 10% ontvangt dan moet speler 2 die op het vastgoed land $0 betalen aan speler 1." do
    @player2.reset
    @player1.reset
    @player2.receive_money(1)
    additionalrent = double("additionalrent", :receiver => @player1, :rent_percentage => 10)
    property = Monopoly::Space::Property::PropertyWithAdditionalRent.new(Monopoly::Space::Property::Property.new(@monopoly, nil, 'test', 0, 0), additionalrent)
    allow(@monopoly).to receive(:active_player) {@player1}
    property.land_action
    allow(@monopoly).to receive(:active_player) {@player2}
    property.land_action
    @player2.money.should eq(1)
    @player1.money.round(0).should eq(0)
  end

end