@Hotel = React.createClass
  loadCommentsFromServer: ->
    $.ajax
      url: @props.url
      contentType: 'application/json'
      dataType: 'json'
      cache: false
      success: ((data) ->
        @setState hotel: data
        return
      ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        return
      ).bind(this)
    return

  getInitialState: ->
    hotel: @props.data

  getDefaultProps: ->
    hotel: []

  componentDidMount: ->
    @loadCommentsFromServer()

  render: ->
    React.DOM.div
      className: 'hotels'
      if @state.hotel?
        React.DOM.div null,
          React.DOM.h2
            className: 'title'
            @state.hotel.name
          React.DOM.div null, @state.hotel.address
          React.DOM.div null, @state.hotel.star_rating
          React.DOM.div null, @state.hotel.accomodation_type
