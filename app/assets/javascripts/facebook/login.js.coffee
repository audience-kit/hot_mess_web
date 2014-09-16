#= require jquery

FacebookAuthentication =

  _on_session_create: []
  _on_session_delete: []

  login: ->
    FB.getLoginStatus (response) ->
      if (response.status == 'connected')
        $.ajax('/session', {
          type: 'POST',
          beforeSend: (xhr) ->
            xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'),
          complete: FacebookAuthentication._session_create_callback,
          data: response
        })
      else
        FB.login this.login, {
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


$(document).ready () ->
  $('.facebook_login').click () ->
    FacebookAuthentication.login()

  $('.facebook_logout').click () ->
    FacebookAuthentication.logout()