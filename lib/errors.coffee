@Errors = new Mongo.Collection null

@notifyError = (message) ->
  Errors.insert
    message: message
