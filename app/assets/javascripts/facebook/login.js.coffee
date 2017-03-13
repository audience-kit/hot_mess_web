#= require jquery

FacebookAuthentication =

  _on_session_create: []
  _on_session_delete: []

  login: ->
    FB.getLoginStatus (response) ->
      FacebookAuthentication.facebook_login_callback response

  facebook_login_callback: (response) ->
    if (response.status == 'connected')
      $.ajax('/session', {
        type: 'POST',
        beforeSend: (xhr) ->
          xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'),
        complete: FacebookAuthentication._session_create_callback,
        data: response
      })
    else
      FB.login FacebookAuthentication.facebook_login_callback, {
        scope: "email,public_profile,user_friends,user_events",
        return_scopes: true
      }

  logout: ->
    $.ajax('/session', {
        type: 'POST',
        complete: FacebookAuthentication._session_delete_callback
        data: { '_method': 'DELETE' }
      })

  _session_create_callback: ->
    callback() for callback in FacebookAuthentication._on_session_create
    window.location.reload()

  _session_delete_callback: ->
    callback() for callback in FacebookAuthentication._on_session_delete
    window.location.reload()

  on_session_create: (callback) ->
    FacebookAuthentication._on_session_create += callback

  on_session_delete: (callback) ->
    FacebookAuthentication._on_session_delete += callback

  setup: ->
    $(document).ready () ->

      window.fbAsyncInit = ->
        FB.init({
          appId      : $("meta[name='fb-app']").attr('content'),
          xfbml      : true,
          version    : 'v2.5',
          cookie     : true
        })

      $('.facebook_login').click () ->
        options = { scope: 'public_profile,email,user_friends' }
        FacebookAuthentication.login(FacebookAuthentication.facebook_login_callback, options)

      $('.facebook_logout').click () ->
        FacebookAuthentication.logout()

FacebookAuthentication.setup()