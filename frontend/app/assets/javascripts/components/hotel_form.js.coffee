@HotelForm = React.createClass
  getInitialState: ->
    name: ''
    address: ''
    star_rating: ''
    accomodation_type_id: ''

  componentDidMount: ->
    if @props.path == 'update'
      $.ajax
        url: 'http://localhost:3000/hotels/' + @props.id
        contentType: 'application/json'
        dataType: 'json'
        cache: false
        success: ((data) ->
          @setState name: data.name
          @setState address: data.address
          @setState star_rating: data.star_rating
          @setState accomodation_type_id: data.accomodation_type.id
        ).bind(this)
        error: ((xhr, status, err) ->
          console.error @props.url, status, err.toString()
          return
        ).bind(this)

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  handleSubmit: (e) ->
    e.preventDefault()
    if @props.path == 'create'
      $.post
        url: 'http://localhost:3000/hotels/'
        contentType: 'application/json'
        dataType: 'json'
        data: JSON.stringify(
          hotel:
            name: @state.name,
            address: @state.address,
            star_rating: @state.star_rating,
            accomodation_type_id: @state.accomodation_type_id
        )
        error: (response) ->
          alert(response.responseText)
        success: ->
          alert('Hotel Created')
    else
      $.ajax
        method: 'PUT'
        url: 'http://localhost:3000/hotels/' + @props.id
        contentType: 'application/json'
        dataType: 'json'
        data: JSON.stringify(
          hotel:
            name: @state.name,
            address: @state.address,
            star_rating: @state.star_rating,
            accomodation_type_id: @state.accomodation_type_id
        )
        error: (response) ->
          alert(response.responseText)
        success: ->
          alert('Hotel Updated')

  render: ->
    React.DOM.div
      className: 'hotels'
      React.DOM.h2
        className: 'title'
        'New Hotel'
      React.DOM.form
        className: 'form-inline'
        onSubmit: @handleSubmit

        React.DOM.div
          className: 'form-group'
          React.DOM.input
            type: 'text'
            className: 'form-control'
            placeholder: 'Name'
            name: 'name'
            value: @state.name
            onChange: @handleChange

        React.DOM.div
          className: 'form-inline'
          React.DOM.input
            type: 'text'
            className: 'form-control'
            placeholder: 'Address'
            name: 'address'
            value: @state.address
            onChange: @handleChange

        React.DOM.div
          className: 'form-inline'
          React.DOM.input
            type: 'number'
            className: 'form-control'
            placeholder: 'Star Rating'
            name: 'star_rating'
            value: @state.star_rating
            onChange: @handleChange

        React.DOM.div
          className: 'form-inline'
          React.createElement AccomodationTypeSelector,
            name: 'accomodation_type_id'
            value: @state.accomodation_type_id
            onChange: @handleChange

        React.DOM.button
            type: 'submit'
            className: 'btn btn-primary'
            'Create hotel'
