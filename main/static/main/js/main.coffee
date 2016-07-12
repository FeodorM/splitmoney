out = exports ? this

out.addPerson = () ->
    input = document.getElementById('input')
    tags = (child for own key, child of input.childNodes when child.nodeName != '#text')[-3..]
    console.log tags
    [inName, inMoney, br] = (node.cloneNode() for node in tags)
    # inName.setAttribute('name', 'name' + (parseInt(inName.name[4..]) + 1))
    inName.name = 'name' + (parseInt(inName.name[4..]) + 1)
    inMoney.name = 'money' + (parseInt(inMoney.name[5..]) + 1)
    for node in [inName, inMoney, br]
        input.appendChild node
    # console.log inName, inMoney, br

# console.log 'addPerson created'
