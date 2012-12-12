if Meteor.isClient
	Template.file_form.events = 'change #upload': (event) ->
		console.log "fired upload"
		input = $("#upload")[0]
		console.log "input #{ input }"
		if input?
			console.log "image file has been chosen"
			filepicker.store input, {mimetype: 'image/*'} , ((FPFile) ->
				console.log "Store successful:", JSON.stringify(FPFile)
			), ((FPError) ->
				console.log FPError.toString()
			), (percentage) ->
				Session.set("percentageNow", percentage.toString())
				if Session.get("percentageNow") is "100"
					Session.set("upload_complete", true)
					Session.set("percentageNow", false)
				console.log "Loading: #{ percentage }%"
				console.log percentage
				console.log percentage.toString()
		
	Template.file_form.uploading_percentage = ->
		Session.get("percentageNow")
	
	Template.file_form.uploading_complete = ->
		Session.get("upload_complete")

	Template.file_form.rendered = ->
		filepicker.setKey('AMjxEmUjxTZKeGg7RZg9Zz')
		$('.fileupload').fileupload()

if Meteor.isServer
	console.log "Server Started"
