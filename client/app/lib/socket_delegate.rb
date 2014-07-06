class SocketDelegate
  def webSocketDidOpen(newWebSocket)
    NSLog("opened!")
  end
  
  def webSocket(webSocket, didFailWithError: error)
    NSLog("failed!")
  end

  def webSocket(webSocket, didCloseWithCode: code, reason: reason, wasClean: wasClean)
    NSLog("closed! #{code} #{reason}")
  end

  def webSocket(webSocket, didReceiveMessage: message)
    NSLog("received! #{message}")
  end
end

