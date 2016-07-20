// Generated by CoffeeScript 1.10.0
(function() {
  var Button, Input, InputList, br, button, div, form, input, ref, render,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  render = ReactDOM.render;

  ref = React.DOM, div = ref.div, button = ref.button, form = ref.form, input = ref.input, br = ref.br;

  InputList = (function(superClass) {
    extend(InputList, superClass);

    function InputList(props) {
      this.createInput = bind(this.createInput, this);
      this.valueChanged = bind(this.valueChanged, this);
      this.handleSubmit = bind(this.handleSubmit, this);
      this.addInput = bind(this.addInput, this);
      InputList.__super__.constructor.call(this, props);
      this.state = {
        users: [
          {
            name: '',
            money: '',
            num: 0
          }
        ]
      };
    }

    InputList.prototype.addInput = function(e) {
      var newUsers, users;
      e.preventDefault();
      users = this.state.users;
      newUsers = users.concat([
        {
          name: '',
          money: '',
          num: users.length
        }
      ]);
      return this.setState({
        users: newUsers
      });
    };

    InputList.prototype.handleSubmit = function(e) {
      e.preventDefault();
      return console.log(this.state.users);
    };

    InputList.prototype.valueChanged = function(value, name, num) {
      var users;
      users = this.state.users;
      users[num][name] = value;
      return this.setState({
        users: users
      });
    };

    InputList.prototype.createInput = function(user) {
      return Input({
        num: user.num,
        key: user.num,
        valueChanged: this.valueChanged
      });
    };

    InputList.prototype.render = function() {
      var inputs;
      inputs = this.state.users.map(this.createInput);
      return form({
        className: 'InputList',
        onSubmit: this.handleSubmit
      }, inputs.concat([
        Button({
          text: '+',
          type: 'button',
          onClick: this.addInput
        }), br({}), Button({
          text: 'Split Money',
          type: 'submit'
        })
      ]));
    };

    return InputList;

  })(React.Component);

  InputList = React.createFactory(InputList);

  Input = (function(superClass) {
    extend(Input, superClass);

    function Input(props) {
      this.handleMoneyChange = bind(this.handleMoneyChange, this);
      this.handleNameChange = bind(this.handleNameChange, this);
      Input.__super__.constructor.call(this, props);
      this.state = {
        name: '',
        money: ''
      };
    }

    Input.prototype.handleNameChange = function(e) {
      var value;
      value = e.target.value;
      this.props.valueChanged(value, 'name', this.props.num);
      return this.setState({
        name: value
      });
    };

    Input.prototype.handleMoneyChange = function(e) {
      var value;
      value = e.target.value;
      this.props.valueChanged(value, 'money', this.props.num);
      return this.setState({
        money: value
      });
    };

    Input.prototype.render = function() {
      return div({
        className: 'Input'
      }, [
        input({
          type: 'text',
          placeholder: 'Ivan Ivanov',
          value: this.state.name,
          onChange: this.handleNameChange
        }), input({
          type: 'text',
          placeholder: '1488',
          value: this.state.money,
          onChange: this.handleMoneyChange
        })
      ]);
    };

    return Input;

  })(React.Component);

  Input = React.createFactory(Input);

  Button = (function(superClass) {
    extend(Button, superClass);

    function Button() {
      return Button.__super__.constructor.apply(this, arguments);
    }

    Button.prototype.render = function() {
      var ref1, ref2;
      return button({
        className: 'Button',
        type: (ref1 = this.props.type) != null ? ref1 : 'button',
        onClick: (ref2 = this.props.onClick) != null ? ref2 : function() {}
      }, this.props.text);
    };

    return Button;

  })(React.Component);

  Button = React.createFactory(Button);

  render(Button({
    onClick: function() {
      return render(InputList({}), $('#main')[0]);
    },
    text: 'Start'
  }), $('#main')[0]);

}).call(this);