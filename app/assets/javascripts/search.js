window.addEventListener("load", function() {

  $input = $('[data-behavior="autocomplete"]')

  var options = {
    getValue: "name",
    url: function(phrase) {
      return "/search.json?q=" + phrase;
    },
    categories: [
      {
        listLocation: "pokemons",
        header: "<strong>Pokemons</strong>",
      },
      {
        listLocation: "items",
        header: "<strong>Items</strong>",
      },
      {
        listLocation: "generations",
        header: "<strong>Generations</strong>",
      }
    ],
    list: {
      onChooseEvent: function() {
        var url = $input.getSelectedItemData().url
        $input.val("")
        window.location = (url)
      }
    }
}

  $input.easyAutocomplete(options)

});