function Board() {
  this.board_arr = [null, null, null, null, null, null, null, null]

  Board.prototype.move = function(target_square) {
    if (this.board_arr[target_square] === null) {
      this.board_arr[target_square] = 'X'
      App.game.perform("make_move", this)
    }
  }

  Board.prototype.setPlayers = function(player1, player2) {
    this.currentPlayer = player1
    this.player_arr = [player1, player2]
  }

  Board.prototype.changePlayer = function() {
    var nextPlayer = this.player_arr.filter(player => player !== this.currentPlayer)
    this.currentPlayer = nextPlayer;
  }
}

(function() {
  this.App || (this.App = {});

  App.board = new Board();

}).call(this);
