render = ReactDOM.render

{div, button, form, input, br} = React.DOM


### Нагугленная херня, которая должна была ~привести к равновесию~ заставить работать POST запросы, но не смогла

getCookie = (name) ->
  cookieValue = null
  if document.cookie and document.cookie != ''
    cookies = document.cookie.split(';')
    i = 0
    while i < cookies.length
      cookie = jQuery.trim(cookies[i])
      # Does this cookie string begin with the name we want?
      if cookie.substring(0, name.length + 1) == name + '='
        cookieValue = decodeURIComponent(cookie.substring(name.length + 1))
        break
      i++
  cookieValue

csrftoken = getCookie('csrftoken')

csrfSafeMethod = (method) ->
  # these HTTP methods do not require CSRF protection
  /^(GET|HEAD|OPTIONS|TRACE)$/.test method

$.ajaxSetup beforeSend: (xhr, settings) ->
  if !csrfSafeMethod(settings.type) and !@crossDomain
    xhr.setRequestHeader 'X-CSRFToken', csrftoken
  return

###

class InputList extends React.Component
    constructor: (props) ->
        super props
        @state =
            users: [
                {
                    name: ''
                    money: ''
                    num: 0
                }
            ]

    addInput: (e) =>
        e.preventDefault()
        users = @state.users
        newUsers = users.concat [
            {
                name: ''
                money: ''
                num: users.length
            }
        ]
        @setState
            users: newUsers

    isInt: (value) =>
        if parseFloat(value) == parseInt(value) and not isNaN(value)
            true
        else
            false


    usersAreValid: (users) =>
        for user in users
            return false unless user.name.length and @isInt user.money
        true

    # TODO: ajax
    handleSubmit: (e) =>
        e.preventDefault()
        users = @state.users
        unless @usersAreValid users
            alert 'Wrong Data.'
        else
            $.ajax
                url: '/ajax/'
                method: 'GET'
                dataType: 'json'
                contentType: 'application/json; charset=utf-8'
                data: JSON.stringify users
                success: (data, textStatus, jqXHR) ->
                    # code...
                error: (jqXHR, textStatus, errorThrown) ->
                    alert 'Something went wrong!'
                    console.log 'Something went wrong!'

    valueChanged: (value, name, num) =>
        users = @state.users
        users[num][name] = value
        @setState
            users: users

    createInput: (user) =>
        Input
            num: user.num
            key: user.num
            valueChanged: @valueChanged

    render: ->
        inputs = @state.users.map @createInput
        form { className: 'InputList', onSubmit: @handleSubmit }, inputs.concat [
            Button { text: '+', type: 'button', onClick: @addInput }
            br {}
            Button { text: 'Split Money', type: 'submit'}
        ]
InputList = React.createFactory InputList


class Input extends React.Component
    constructor: (props) ->
        super props
        @state =
            name: ''
            money: ''

    handleNameChange: (e) =>
        value = e.target.value
        @props.valueChanged value, 'name', @props.num
        @setState
            name: value

    handleMoneyChange: (e) =>
        value = e.target.value
        @props.valueChanged value, 'money', @props.num
        @setState
            money: value

    render: ->
        div { className: 'Input' }, [
            # br {}
            input
                type: 'text'
                placeholder: 'Ivan Ivanov'
                value: @state.name
                onChange: @handleNameChange
            input
                type: 'text'
                placeholder: '1488'
                value: @state.money
                onChange: @handleMoneyChange
        ]
Input = React.createFactory Input


class Button extends React.Component
    render: ->
        button
            className: 'Button'
            type: @props.type ? 'button'
            onClick: @props.onClick ? () ->,
            @props.text
Button = React.createFactory Button


render(
    Button
        onClick: () ->
            render(
                InputList {}
                $('#main')[0]
            )
        text: 'Start',
    $('#main')[0]
)




# some old code:

# out = exports ? this
#
# out.addPerson = () ->
#     input = document.getElementById('input')
#     tags = (child for own key, child of input.childNodes when child.nodeName != '#text')[-3..]
#     # console.log tags
#     [inName, inMoney, br] = (node.cloneNode() for node in tags)
#
#     # inName.setAttribute('name', 'name' + (parseInt(inName.name[4..]) + 1))
#     inName.name = 'name' + (parseInt(inName.name[4..]) + 1)
#     inMoney.name = 'money' + (parseInt(inMoney.name[5..]) + 1)
#
#     for node in [inName, inMoney, br]
#         input.appendChild node
#     # console.log inName, inMoney, br

# console.log 'addPerson created'
