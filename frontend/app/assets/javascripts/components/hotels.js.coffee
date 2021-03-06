@Hotels = React.createClass
  loadCommentsFromServer: ->
    $.ajax
      url: @props.url
      contentType: 'application/json'
      dataType: 'json'
      cache: false
      success: ((data) ->
        @setState hotels: data
        return
      ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        return
      ).bind(this)
    return

  getInitialState: ->
    hotels: @props.data

  getDefaultProps: ->
    hotels: []

  componentDidMount: ->
    @loadCommentsFromServer()

  deleteHotel: (hotel) ->
    hotels = @state.hotels.slice()
    index = hotels.indexOf hotel
    hotels.splice index, 1
    @replaceState hotels: hotels

  searchHotel: (e) ->
    $.ajax
      url: @props.url + "?search=#{e.target.value}"
      contentType: 'application/json'
      dataType: 'json'
      cache: false
      success: ((data) ->
        @setState hotels: data
        return
      ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        return
      ).bind(this)
    return

  render: ->
    React.DOM.div
      className: 'hotels'
      React.DOM.h2
        className: 'title'
        'Hotels'
      React.createElement Search,
        url: @props.url
        onChange: @searchHotel
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Id'
            React.DOM.th null, 'Name'
            React.DOM.th null, 'Address'
            React.DOM.th null, 'StarRating'
            React.DOM.th null, 'AccomodationType'
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
          if @state.hotels?
            for hotel in @state.hotels
              React.createElement IndexHotel,
                key: hotel.id
                hotel: hotel
                url: @props.url
                base_url: @props.base_url
                handleDeleteHotel: @deleteHotel
