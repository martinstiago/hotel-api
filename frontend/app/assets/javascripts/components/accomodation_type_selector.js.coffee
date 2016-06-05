@AccomodationTypeSelector = React.createClass
  loadCommentsFromServer: ->
    $.ajax
      url: 'http://localhost:3000/accomodation_types'
      contentType: 'application/json'
      dataType: 'json'
      cache: false
      success: ((data) ->
        @setState options: data
        return
      ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        return
      ).bind(this)
    return
  getInitialState: ->
    options: []
    name: @props.name
    value: @props.value
  componentDidMount: ->
    @loadCommentsFromServer()
  handleChange: (e) ->
    @props.onChange(e)
    @setState value: @value
  render: ->
    if @state.options?
      React.DOM.select
        name: @state.name
        value: @state.value
        onChange: @handleChange
        for type in @state.options
          React.DOM.option
            key: type.id,
            value: type.id, type.name
