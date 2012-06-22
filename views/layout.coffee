doctype 5
html ->
  head ->
    meta charset: 'utf-8'

    title "#{@title} | Type This" if @title?
    script src: '/javascripts/jquery-1.7.2.min.js'
    script src: '/socket.io/socket.io.js'
    script src: '//connect.facebook.net/en_US/all.js'
  body ->
    @body
