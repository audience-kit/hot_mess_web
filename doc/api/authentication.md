# Authentication

Authentication for API usage is handled by the standard HTTP Authorization header value.

An authorization token for the header is generated form the `/session/token.json` route which maps to the `SessionsController#token` action.

This url takes authorization form Facebook and returns a value that can be used to communicate with the service.