// Generated by CoffeeScript 1.10.0
(function() {
  var out,
    hasProp = {}.hasOwnProperty;

  out = typeof exports !== "undefined" && exports !== null ? exports : this;

  out.addPerson = function() {
    var br, child, i, inMoney, inName, input, key, len, node, ref, ref1, results, tags;
    input = document.getElementById('input');
    tags = ((function() {
      var ref, results;
      ref = input.childNodes;
      results = [];
      for (key in ref) {
        if (!hasProp.call(ref, key)) continue;
        child = ref[key];
        if (child.nodeName !== '#text') {
          results.push(child);
        }
      }
      return results;
    })()).slice(-3);
    console.log(tags);
    ref = (function() {
      var i, len, results;
      results = [];
      for (i = 0, len = tags.length; i < len; i++) {
        node = tags[i];
        results.push(node.cloneNode());
      }
      return results;
    })(), inName = ref[0], inMoney = ref[1], br = ref[2];
    inName.name = 'name' + (parseInt(inName.name.slice(4)) + 1);
    inMoney.name = 'money' + (parseInt(inMoney.name.slice(5)) + 1);
    ref1 = [inName, inMoney, br];
    results = [];
    for (i = 0, len = ref1.length; i < len; i++) {
      node = ref1[i];
      results.push(input.appendChild(node));
    }
    return results;
  };

}).call(this);