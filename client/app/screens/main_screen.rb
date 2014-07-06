class MainScreen < PM::Screen
  def will_appear
    set_attributes self.view, background_color: UIColor.whiteColor
  end

  def on_appear
    add_connect_button
    add_label
    init_socket
    true
  end

  def init_socket
    #@url = NSURL.URLWithString("ws://localhost:3000/")
    @url =  NSURL.URLWithString("ws://warm-caverns-6253.herokuapp.com/")
    @request = NSURLRequest.requestWithURL(@url)
    @socket = SRWebSocket.alloc.initWithURLRequest(@request)
    @socket.delegate = self
  end

  def add_connect_button
    @connect_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @connect_button.geometry 10, 495, 300, 50
    @connect_button.setTitle("connect", forState: UIControlStateNormal)

    @connect_button.when(UIControlEventTouchUpInside) do
      @socket.open
    end

    add @connect_button
  end

  def add_label
    @message_label = label(20, 0, 280, UIScreen.mainScreen.bounds.size.height, text: "messages will show up here", font_size: 14)
    @message_label.textAlignment = NSTextAlignmentCenter
    add @message_label
  end

  def webSocketDidOpen(newWebSocket)
    NSLog("opened!")
  end
  
  def webSocket(webSocket, didFailWithError: error)
    NSLog("failed! #{error.localizedDescription}")
  end

  def webSocket(webSocket, didCloseWithCode: code, reason: reason, wasClean: wasClean)
    NSLog("closed! #{code} #{reason}")
  end

  def webSocket(webSocket, didReceiveMessage: message)
    @message_label.text = message
    NSLog("received! #{message}")
  end

  def label x, y, width, height, options = { }
    label = UILabel.alloc.initWithFrame(CGRectMake(x, y, width, height))

    options = {
      :text => "",
      :number_of_lines => 10,
      :font_size => 14
    }.merge options
    
    set_attributes label, {
      text: options[:text],
      number_of_lines: options[:number_of_lines],
      line_break_mode: UILineBreakModeWordWrap,
    }

    label
  end
end
