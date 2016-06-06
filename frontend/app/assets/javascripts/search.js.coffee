$('.search-box').select2
  ajax:
    url: 'http://localhost:3000/hotels'
    dataType: 'json'
    delay: 250
    data: (term) ->
      q: term
      limit: 16
    processResults: (data) ->
      results: $.map(data, (item) ->
        text: item.name
        id: item.id
      )
    cache: true
