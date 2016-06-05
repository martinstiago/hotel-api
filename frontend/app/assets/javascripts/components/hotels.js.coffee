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

  render: ->
    React.DOM.div
      className: 'hotels'
      React.DOM.h2
        className: 'title'
        'Hotels'
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Id'
            React.DOM.th null, 'Name'
            React.DOM.th null, 'Address'
            React.DOM.th null, 'StarRating'
            React.DOM.th null, 'AccomodationType'
        React.DOM.tbody null,
          if @state.hotels?
            for hotel in @state.hotels
              React.createElement IndexHotel,
                key: hotel.id
                hotel: hotel
