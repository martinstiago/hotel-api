  @Hotel = React.createClass
    render: ->
      React.DOM.tr null,
        React.DOM.td null, @props.hotel.id
        React.DOM.td null, @props.hotel.name
        React.DOM.td null, @props.hotel.address
        React.DOM.td null, @props.hotel.star_rating
        React.DOM.td null, @props.hotel.accomodation_type
