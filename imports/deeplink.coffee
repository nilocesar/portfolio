class Deeplink
	
	@doc : undefined
	@deppInit : undefined
	constructor:(@name) ->
	init: ->
		deeplinkInit()
		

	#--------------------------------------
	#  PLUBIC / EVENT
	#--------------------------------------
	callDeeplink :  ( _page ) ->
		$.address.state "#!/"
		$.address.value _page


	#--------------------------------------
	#  DEEPLINK
	#--------------------------------------
	deeplinkInit = ->
		@doc = defineDocument()
		@deppInit = getHashFunc() 
		callPageInit()
	

	getHashFunc = ->
  		@doc.location.hash

	defineDocument = ->
	  try
	    return (if top.document isnt `undefined` then top else window)
	  catch a
	    return window

	callPageInit = ->
		hashTag = @deppInit
		hashTag = hashTag.replace("#/", "")
		hashTag = hashTag.replace("#!/", "")
		hashTag = hashTag.replace("#!", "")
		hashTag = hashTag.replace("/", "")
		hashTag = hashTag.replace("/", "")

		if hashTag != "home" and hashTag != ""
			$( ".info .logo .logoStrip" ).css "marginTop", -( 72 * 14 )
			root.Main.callPageDeeplink( hashTag )
	
	