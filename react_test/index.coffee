createView = (spec) ->
  React.createFactory(React.createClass(spec))

render = ReactDOM.render

{div, img, h1, h2, h3, span, button, form, input} = React.DOM

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


class Comment extends React.Component
    render: ->
        div { className: 'comment' }, [
            h2 { className: 'commentAuthor' }, @props.author
            @props.children
        ]
Comment = React.createFactory Comment


class CommentList extends React.Component
    render: ->
        commentNodes = @props.data.map (comment) ->
            Comment
                author: comment.author
                key: comment.id,
                comment.text

        div { className: 'commentList' }, commentNodes
CommentList = React.createFactory CommentList


class CommentForm extends React.Component
    constructor: (props) ->
        super props
        @state =
            author: ''
            text: ''

    handleAuthorChange: (e) =>
        @setState
            author: e.target.value

    handleTextChange: (e) =>
        @setState
            text: e.target.value

    handleSubmit: (e) =>
        e.preventDefault()
        author = @state.author.trim()
        text = @state.text.trim()
        if not text or not author
            return
        @props.onCommentSubmit
            author: author
            text: text
        @setState
            author: ''
            text: ''

    render: ->
        form { className: 'commentForm', onSubmit: @handleSubmit }, [
            input
                type: 'text'
                placeholder: 'Your name'
                value: @state.author
                onChange: @handleAuthorChange
            input
                type: 'text'
                placeholder: 'Say something'
                value: @state.text
                onChange: @handleTextChange
            input
                type: 'submit'
                value: 'Post'
        ]
CommentForm = React.createFactory CommentForm


class CommentBox extends React.Component
    constructor: (props) ->
        super props
        @state =
            data: []

    handleCommentSubmit: (comment) =>
        comments = @state.data
        comment.id = Date.now()
        newComments = comments.concat [comment]
        @setState
            data: newComments

    render: ->
        div { className: 'commentBox' }, [
            h1 {}, 'Comments'
            CommentList { data: @state.data }
            CommentForm { onCommentSubmit: @handleCommentSubmit }
        ]
CommentBox = React.createFactory CommentBox

dataPhotos = for i in [0..pictures.length - 1]
    {
        id: i + 100
        url: pictures[i]
        caption: texts[i]
    }

# dataBlog = [
#     {id: 1, author: "Pete Hunt", text: "This is one comment"}
#     {id: 2, author: "Jordan Walke", text: "This is *another* comment"}
#     {id: 3, author: 'Ivan I.', text: 'And another comment'}
# ]

render(
    CommentBox {}
        # data: dataBlog
    $('#comment')[0]
)

render(
    PhotoGallery
        photos: dataPhotos
    $('#gallery')[0]
)
