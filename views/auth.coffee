coffeescript ->
  ((d) ->
    js = undefined
    id = "facebook-jssdk"
    ref = d.getElementsByTagName("script")[0]
    return  if d.getElementById(id)
    js = d.createElement("script")
    js.id = id
    js.async = true
    js.src = "//connect.facebook.net/en_US/all.js"
    ref.parentNode.insertBefore js, ref
  ) document

  window.fbAsyncInit = ->
    FB.init
      appId: "350109445062579"
      channelUrl: "//" + window.location.host + "/channel.txt"
      status: true
      cookie: true
      xfbml: true

    FB.Event.subscribe "auth.statusChange", (response) ->
      if response.authResponse
        FB.api "/me", (me) ->
          if me.name
            # alert(me.id);
            document.getElementById("auth-displayname").innerHTML = me.name
            $.ajax '/auth',
              type: 'POST'
              data:
                username: me.name
                userid: me.id
              dataType: 'html'
              error: (jqXHR, textStatus, errorThrown) ->
                $('body').append "AJAX Error: #{textStatus}"
              success: (data, textStatus, jqXHR) ->
                # alert 'ok'
                # window.location = '/'
                # $('body').append "Successful AJAX call: #{data}"

        document.getElementById("auth-loggedout").style.display = "none"
        document.getElementById("auth-loggedin").style.display = "block"
      else
        document.getElementById("auth-loggedout").style.display = "block"
        document.getElementById("auth-loggedin").style.display = "none"

    document.getElementById("auth-loginlink").addEventListener "click", ->
      FB.login()

    document.getElementById("auth-logoutlink").addEventListener "click", ->
      FB.logout()

h1 @title

div '#auth-status', ->
  div '#auth-loggedout', ->
    a '#auth-loginlink', href: '#', -> 'Login'

  div '#auth-loggedin', style: 'display:none', ->
    span id: 'auth-displayname'
    p -> a href: '/', -> 'Go to Lobby'
    p -> a '#auth-logoutlink', href: '#', -> 'Logout'
