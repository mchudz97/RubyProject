require_relative '../lib/statki/board.rb'

RSpec.describe 'Statki' do
   
    context '.returnPositions Board method' do
        it 'when not in line' do
            b = Board.new
            expect{b.returnPositions("A1","B3")}.to raise_error(ArgumentError)
        end
        it 'when incorrect values' do
            b = Board.new
            expect{b.returnPositions("AA", "B1")}.to raise_error(ArgumentError)
        end
    end
    context '.isCrossing Board method' do
        it 'when crossing #1' do
            b = Board.new
            b.ship_pos=["D3 D7"]
            expect(b.isCrossing("D1", "D3")).to eq(true)
        end
        it 'when crossing #2' do
            b = Board.new
            b.ship_pos=["D3 D7"]
            expect(b.isCrossing("B5", "E5")).to eq(true)
        end
        it 'when not crossing ' do
            b = Board.new
            b.ship_pos=["D3 D7"]
            expect(b.isCrossing("C3", "C7")).to eq(false)
        end
        
    end
    context '.getSize Board method' do
        it 'when wrong parameters' do
            b = Board.new
            expect{b.getSize("B3","D4")}.to raise_error(ArgumentError)
        end
        it 'when valid parameters using x_axis' do
            b = Board.new
            expect(b.getSize("B3","B7")).to eq(5)
        end
        it 'when valid parameters using y_axis' do
            b = Board.new
            expect(b.getSize("A4","D4")).to eq(4)
        end
    end
    context '.addShip Board method' do
        it 'input validation by arg format #1' do
        
            b = Board.new
            expect{b.addShip(1,2)}.to raise_error(ArgumentError)
        end
        it 'input validation by arg format #2' do
            b = Board.new
            expect{b.addShip("A","B")}.to raise_error(ArgumentError)
        end
        it 'input validation by arg format #3' do
            b = Board.new
            expect{b.addShip("A1","B")}.to raise_error(ArgumentError)
        end
        it 'input validation by arg format #4' do
            b = Board.new
            expect{b.addShip("A","B1")}.to raise_error(ArgumentError)
        end
        it 'input validation by arg format #5' do
            b = Board.new
            expect{b.addShip(1,"B1")}.to raise_error(ArgumentError)
        end
        it 'input validation by arg format #6' do
            b = Board.new
            expect{b.addShip("A1",1)}.to raise_error(ArgumentError)
        end
        it 'input validation by ship size #1' do
            b = Board.new
            expect{b.addShip("A1","B1")}.to raise_error(ArgumentError)
        end
        it 'input validation by ship size #2' do
            b = Board.new
            expect{b.addShip("A1","A2")}.to raise_error(ArgumentError)
        end
        it 'when input is valid' do
            b = Board.new
            expect(b.addShip("A1","A4")).to eq(true)
        end
        it 'when reached ship limit' do
            b = Board.new 
            b.addShip("A0","A4")
            expect{b.addShip("B0","B4")}.to raise_error(ArgumentError)
        end
        it 'when added ship crosses other ship' do
            b = Board.new
            b.addShip("B0","B4")
            expect(b.addShip("A1","D1")).to eq(false)
        end
    end
    context 'checking fillBoardWithShips Board method' do
        it 'is filling not throwing anything unexpected' do
        b = Board.new
        expect{b.fillBoardWithShips()}.to_not raise_error
        end
    end
    context 'checking local variable logic' do
        it 'are ship limits working correctly #1' do
            b = Board.new
            templimit = b.ship_limits[0..2]
            b.addShip("A0","A2")
            b.addShip("B0","B4")
            templimit[0] -= 1
            templimit[2] -= 1
            expect(b.ship_limits).to eq(templimit)

        end
        it 'are ship limits working correctly #2' do
            b = Board.new
            templimit = b.ship_limits[0..2]
            b.addShip("A0","A2")
            b.addShip("B0","B4")
            
            expect(b.ship_limits).to_not eq(templimit)

        end
        it 'are ship positions working correctly #1' do
            b = Board.new
            b.addShip("A0","A3")
            expect(b.ship_pos[0]).to eq("A0 A3")
        end

    end
    context '.returnBoardAsString Board method' do
        it 'when board is clear' do
            testString = "X0123456789\nA##########\nB##########\nC##########\nD##########\nE##########\nF##########"+
            "\nG##########\nH##########\nI##########\nJ##########"
            b = Board.new
            expect(b.returnBoardAsString()).to eq(testString)
        end 
        it 'when board have a ship' do
            testString = "X0123456789\nAo#########\nBo#########\nCo#########\nD##########\nE##########\nF##########"+
            "\nG##########\nH##########\nI##########\nJ##########"
            b = Board.new
            b.addShip("A0","C0")
            expect(b.returnBoardAsString()).to eq(testString)
        end
    end
    context '.attacked Board method' do
        it 'when invalid argument #1' do
            b = Board.new
            expect{b.attacked("B")}.to raise_error(ArgumentError)
        end
        it 'when invalid argument #2' do
            b = Board.new
            expect{b.attacked("B11")}.to raise_error(ArgumentError)
        end
        it 'when invalid argument #3' do
            b = Board.new
            expect{b.attacked(11111111111111)}.to raise_error(ArgumentError)
        end
        it 'when missed' do
            b = Board.new
            expect(b.attacked("A0")).to eq(false)
        end
        it 'when hit' do
            b = Board.new
            b.addShip("A0","A3")
            expect(b.attacked("A2")).to eq(true)
        end
        it 'board behaviour when missed' do
            b = Board.new
            b.attacked("A0")
            testString = "X0123456789\nAx#########\nB##########\nC##########\nD##########\nE##########\nF##########"+
            "\nG##########\nH##########\nI##########\nJ##########"
            expect(b.returnBoardAsString()).to eq(testString)
        end
        it 'board behaviour when ship hit' do
            b = Board.new
            b.addShip("A0", "A3")
            b.attacked("A2")
            testString = "X0123456789\nAooXo######\nB##########\nC##########\nD##########\nE##########\nF##########"+
            "\nG##########\nH##########\nI##########\nJ##########"
            expect(b.returnBoardAsString()).to eq(testString)
        end
    end

end