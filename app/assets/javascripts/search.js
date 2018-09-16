$().ready(
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
          listLocation: "item_categories",
          header: "<strong>Catégories d'objets</strong>",
        },
        {
          listLocation: "items",
          header: "<strong>Objets</strong>",
        },
        {
          listLocation: "generations",
          header: "<strong>Générations</strong>",
        },
        {
          listLocation: "attacks",
          header: "<strong>Attaques</strong>",
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
  
  })
);