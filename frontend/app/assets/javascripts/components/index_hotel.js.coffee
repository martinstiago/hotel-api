  @IndexHotel = React.createClass
    handleView: (e) ->
      e.preventDefault()
      window.location = "http://localhost:3001/hotels/#{ @props.hotel.id }"

    handleEdit: (e) ->
      e.preventDefault()
      window.location = "http://localhost:3001/hotels/#{ @props.hotel.id }/edit"

    handleDelete: (e) ->
      e.preventDefault()
      $.ajax
        method: 'DELETE'
        url: "http://localhost:3000/hotels/#{ @props.hotel.id }"
        contentType: 'application/json'
        dataType: 'json'
        success: () =>
          @props.handleDeleteHotel @props.hotel

    render: ->
      React.DOM.tr null,
        React.DOM.td null, @props.hotel.id
        React.DOM.td null, @props.hotel.name
        React.DOM.td null, @props.hotel.address
        React.DOM.td null, @props.hotel.star_rating
        React.DOM.td null, @props.hotel.accomodation_type
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default'
            onClick: @handleView
            'View'
          React.DOM.a
            className: 'btn btn-primary'
            onClick: @handleEdit
            'Edit'
          React.DOM.a
            className: 'btn btn-danger'
            onClick: @handleDelete
            'Delete'
