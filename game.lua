Game = Object:extend()

function Game:new()
    self.turn = "w"
end

function Game:getTurn()
    return self.turn
end

function Game:setTurn(color)
    self.turn = color
end
    
function Game:validateMove(board)
    local pieces = board:getPieces()
    local pressed = board:getMoved()
    local lastMove = board:getLastMove()

    if pieces[pressed]:getColor() == self.turn then
        local king = board:getKing(self.turn)
        if  self:checkMovement(pieces, pieces[pressed]:getColor(), lastMove, pressed) then
            if not self:isKingInCheck(king, pieces) then
                print("king not in check")
                local capturedPiece = self:checkPieceToBeCaptured(pieces, lastMove, pressed)
                print("captured1")
                print(capturedPiece)
                if pieces[pressed]:checkPossibleCasteling(pieces, board) == false  then
                    return false
                end
                pieces[pressed]:updatePos(lastMove)
                --If moved piece leaves king checkmated, go back
                if self:isKingInCheck(king, pieces) then
                    self:resetCapturedFlags(pieces)
                    return false
                else
                    print("king not check 3")
                    if capturedPiece then
                        print("voy a capturar")
                        print(capturedPiece:getName())
                        board:removeCapturedPiece(capturedPiece)
                        self:resetCapturedFlags(pieces)
                    end
                    return true
                end
            else
                print("king in check")
                local capturedPiece = self:checkPieceToBeCaptured(pieces, lastMove, pressed)
                pieces[pressed]:updatePos(lastMove)
                print(capturedPiece)
                print(pieces[pressed]:getActualPos())
                print("captured2")
                --Checks if king is still in check after moving
                if self:isKingInCheck(king, pieces) then
                    print("king in check 2")
                    local a = {}
                    table.insert(a, capturedPiece)
                    print(self:isKingInCheck(king, a))
                    --If the piece that has king in check can be captured
                    if capturedPiece and self:isKingInCheck(king, a) then
                        print("add piece?")
                        board:removeCapturedPiece(capturedPiece)
                        self:resetCapturedFlags(pieces)
                        return true
                        --board:addPiece(capturedPiece)
                    end
                    return false
                elseif capturedPiece then
                    print("king not check 2")
                    board:removeCapturedPiece(capturedPiece)
                    self:resetCapturedFlags(pieces)
                end
                return true
                
            end
        end
    end
    return false
end


function Game:nextTurn()
    if game:getTurn() == "w" then
        game:setTurn("b")
    else
        game:setTurn("w")
    end
end

function Game:finished()
end

function Game:checkmated()
end

function Game:checkMovement(pieces, color, movement, pressed)
    local xf,yf = movement:getEnd();
    local xo,yo = movement:getStart();

    if (pieces[pressed]:validateMovement(movement)) then
        for key, piece in pairs(pieces) do
            if (piece) then
                local x,y = piece:getActualPos()
                if  pieces[pressed]:checkTrajectory(x, y, xf, yf, xo, yo) and
                    pressed ~= key then
                        print("check1")
                    return false
                end
                if  piece:checkPos(color, xf, yf) and
                    pressed ~= key then
                        print("check2")
                    return false
                end
                if  piece:checkCoordinates(xf, yf) and
                    not pieces[pressed]:canCapture(movement, piece) and
                    pressed ~= key then
                        print("check3")
                    return false
                end
            end
        end
    else
        for key, piece in pairs(pieces) do
            --print(piece)
            if  piece and
                pieces[pressed]:canCapture(movement, piece) and 
                pressed ~= key then
                return true
            elseif not piece then
                print("check4")
                return false
            end
            --print(piece:getName())
            --print(pieces[pressed]:getName())
        end
        print("check5")
        return false
    end
    return true
end


function Game:isKingInCheck(king, pieces)
    local opponent = "w"
    if self.turn == "w" then
        opponent = "b"
    else
        opponent = "w"
    end
    for key, piece in pairs(pieces) do
        if piece:getColor() == opponent and self:canPieceCapture(key, king, pieces) then
            return true
        end
    end
    return false
end



function Game:checkPieceToBeCaptured(pieces, movement, pressed)
    local xf,yf = movement:getEnd();
    for key, piece in pairs(pieces) do
        if  piece and
            pressed ~= key and
            piece:getName() ~= "king" and
            piece:checkCoordinates(xf, yf) then
            piece:toBeCaptured(true)
            return piece
        elseif  piece and
                pressed ~= key and
                piece:getName() == "pawn" and
                pieces[pressed]:getName() == "pawn" and
                piece:getEnPassant() then
            piece:toBeCaptured(true)
            return piece
        end
    end
    return false
end


function Game:canPieceCapture(pressed, otherPiece, pieces)
    local movement = Move()
    local xo,yo = pieces[pressed]:getActualPos()
    local xf,yf = otherPiece:getActualPos()
    print("pos pressed")
    print(xo, yo)
    print("pos captured")
    print(xf, yf)
    movement:startMove(xo, yo, pieces[pressed]:getName())
    movement:endMove(xf, yf)
    if self:checkMovement(pieces, pieces[pressed]:getColor(), movement, pressed) then
        return true
    end
    return false
end

function Game:resetCapturedFlags(pieces)
    for key, piece in pairs(pieces) do
        if  piece then
            piece:toBeCaptured(false)
            piece:setEnPassant(false)
            piece:setCanBeEnPassant(false)
        end
    end
end

function Game:showCurrentTurn(current)
    if current == "w" then
        love.graphics.print("Turn: White", 695, 50)
    else
        love.graphics.print("Turn: Black", 695, 50)
    end
end

function Game:isPawnPromotion(pieces, color)
    for key, piece in pairs(pieces) do
        local x,y = piece:getActualPos()
        if piece:getColor() == "w" and piece:getColor() == color 
        and y == 7 and piece:getName() == "pawn" then
            return piece
        elseif piece:getColor() == "b" and piece:getColor() == color
        and y == 0 and piece:getName() == "pawn" then
            return piece
        end
    end
    return false
end
