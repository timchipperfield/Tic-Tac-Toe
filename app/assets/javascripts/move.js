$( document ).on('turbolinks:load ready', function() {
  $('.move-button').click(function(event) {
    console.log("move initiated");
    console.log(this.value);

    App.game.move(this.value);
  });
});
