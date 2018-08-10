$( document ).on('turbolinks:load ready', function() {
  $('.move-button').click(function(event) {
    App.game.move(this.value);
  });
});
