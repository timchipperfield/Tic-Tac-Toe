function Board() {
  this.board_arr = [null, null, null, null, null, null, null, null]

  Board.prototype.move = function(target_square) {
    console.log(target_square);
    if (this.board_arr[target_square] === null) {
      this.board_arr[target_square] = 'X'
    }
  }
}

(function() {
  this.App || (this.App = {});

  App.board = new Board();

}).call(this);
