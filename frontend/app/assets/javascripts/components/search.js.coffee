@Search = React.createClass
  getInitialState: ->
    text: ''

  handleChange: (e) ->
    @props.onChange(e)
    @setState text: e.target.value

  render: ->
    React.DOM.input
      className: 'form-control search-box'
      value: @state.text
      placeholder: 'Search for name or address'
      onChange: @handleChange
