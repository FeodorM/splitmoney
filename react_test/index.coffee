createView = (spec) ->
  React.createFactory(React.createClass(spec))

render = ReactDOM.render

{div, img, h1, span, button} = React.DOM

pictures = [
    'pictures/avacyn.jpg'
    'pictures/karn.jpg'
    'pictures/jace.jpg'
    'pictures/jace1.jpg'
    'pictures/chandra.jpg'
]

texts = [
    'Avacyn'
    'Karn'
    'Jace'
    'Jace, the living guildpack'
    'Chandra'
]


class Photo extends React.Component
    constructor: (props) ->
        super props
        @state =
            liked: false

    toggleLiked: =>
        @setState
            liked: !@state.liked

    render: ->
        buttonClass = if @state.liked then 'active' else ''
        div {className: 'photo'}, [
            img
                src: @props.src
            div {className: 'bar'}, [
                button
                    onClick: @toggleLiked
                    className: buttonClass,
                    '♥'
                span {}, @props.caption
            ]
        ]
Photo = React.createFactory Photo


class PhotoGallery extends React.Component
    render: ->
        photos = @props.photos.map (photo) ->
            Photo
                src: photo.url
                caption: photo.caption
                key: photo.id
        div {className: 'photo-gallery'}, photos
PhotoGallery = React.createFactory PhotoGallery


this.data = for i in [0..pictures.length - 1]
    {
        url: pictures[i]
        caption: texts[i]
    }

render(
    PhotoGallery
        photos: data
    document.body
    # document.getElementById 'div'
)
