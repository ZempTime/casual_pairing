var ChatContainer = React.createClass({
  loadChatsFromServer: function() {
    $.ajax({
      url: this.props.chats_url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({chats: data["chats"] });
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.chats_url, status, err.toString());
        console.log(this.props.chats_url);
      }.bind(this)
    });
  },
  getInitialState: function() {
    return {chats: []};
  },
  componentDidMount: function() {
    this.loadChatsFromServer();
    setInterval(this.loadChatsFromServer, 3000);
  },
  render: function() {
    return(
      <div className="col-md-6">
        <h2>
          <span className="text-muted">Chat</span>
        </h2>
          <ChatDisplay chats={this.state.chats} />
          <ChatForm create_chat_url={this.props.create_chat_url}/>
      </div>
    );
  }
});

var ChatDisplay = React.createClass({
  componentWillUpdate: function() {
    var node = this.refs.messages.getDOMNode();
    this.shouldScrollBottom = node.scrollTop + node.offsetHeight === node.scrollHeight;
  },
  componentDidUpdate: function() {
    if (this.shouldScrollBottom) {
      var node = this.refs.messages.getDOMNode();
      node.scrollTop = node.scrollHeight
    }
  },
  render: function() {
    return (
      <div className="card card-block">
        <div id="chat-messages" ref="messages">
          { this.props.chats.map(function(chat) {
             return <Chat chat={chat} key={chat.id}/>;
          })}
        </div>
      </div>
    );
  }
});

var Chat = React.createClass({
  render: function() {
    return(
      <p><b> {this.props.chat.name} </b>: {this.props.chat.message}</p>
    );
  }
});

var ChatForm = React.createClass({
  handleSubmit: function(e) {
    e.preventDefault();
    console.log(this.props.create_chat_url);
    var form = this;
    var data = {
      chat: {
        message: this.refs.message.getDOMNode().value
      }
    }
    $.ajax({
      url: this.props.create_chat_url,
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      dataType: 'html',
      type: 'POST',
      data: data,
      success: function(data) {
        form.refs.message.getDOMNode().value = '';
      },
      error: function(xhr, status, err) {
        console.error(status, err.toString());
        console.log("errrorruuuu");
      }
    });
  },
  render: function() {
    return (
      <form id="new_chat" onSubmit={this.handleSubmit} data-type="json" data-remote="true" >
        <textarea ref="message" type="text" className="form-control" placeholder="Your message here" autofocus="autofocus" />

        <button type="submit" className="btn btn-default">Chat</button>
      </form>

    );
  }
});
