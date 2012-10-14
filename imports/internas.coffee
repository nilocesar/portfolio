class Internas
	constructor:(@name) ->

	init: ->

	#--------------------------------------
	#  PLUBIC / EVENT
	#--------------------------------------
	callInterna: ( _x_ ) ->
		createInternas( _x_ )

	navControl: ->
		createNavControl()

	returnHomeEvent = ->
		root.Main.callPage( "home" )

	internasResize: ->
		resizeInternas()
		
	

	#--------------------------------------
	#  CREATE INTERNAS
	#--------------------------------------
	createInternas = ( _x_ ) ->  
		root.Main.activeX = _x_
		$(".interna").remove()  unless root.Main.activeX
		typeInterna()
		motionInternas()
		internaAjax()

	#--------------------------------------
	#  CREATE NAVCONTROLL
	#--------------------------------------
	createNavControl = ->
	  $(".content").remove()
	  internaAjax()

	#--------------------------------------
	#  TYPE INTERNA
	#--------------------------------------
	typeInterna = ->
	  $("body").append "<div class=\"interna\"></div>"
	  $( ".interna" ).append '<div class="loader"></div>'

	  $(".interna").css "opacity", 0
	  if root.Main.type is 1 # HORIZONTE
	    $(".interna").css "height", $(window).height()
	    $(".interna").css "width", parseFloat($(".jScrollbar").css("width"))
	    $(".interna").css "left", parseFloat($(".jScrollbar").css("left"))
	  if root.Main.type is 2 # HORIZONTE
	    $(".interna").css "height", $(window).height()
	    $(".interna").css "width", parseFloat($(".jScrollbar").css("width"))
	    $(".interna").css "left", parseFloat($(".jScrollbar").css("left")) + 6
	  if root.Main.type is 3 # VERTICAL
	    $(".interna").css "height", parseFloat($(".jScrollbar").css("height")) + 2
	    $(".interna").css "width", $(window).width()
	    $(".interna").css "top", parseFloat($(".info").css("height"))
	  if root.Main.type is 4 # VERTICAL
	    $(".interna").css "height", parseFloat($(".jScrollbar").css("height")) + 2
	    $(".interna").css "width", $(window).width()
	    $(".interna").css "top", 0

	#--------------------------------------
	#  MOTION INTERNAS
	#--------------------------------------
	motionInternas = ->
	  _temp = 400
	  #Remover Contanier Scroll
	  $(".jScrollbar").delay(0).animate
	    opacity: 0
	  , _temp, "easeInSine", ->
	    $(this).css "display", "none"

	  #ADD INternas
	  $(".interna").delay( _temp ).animate
	    opacity: 0.95
	  , _temp, "easeOutSine", ->

	  
	  #Logo
	  if root.Main.activeX
	    animateArrows ".info .logo .logoStrip", 72, 15
	    $(".info .logo .logoStrip").delay(_temp).animate
	      left: -45
	    , _temp / 1.5, "easeOutSine", ->

	    $(".info .logo .hit_logo").css "width", 50
	  
	  # _X_ return Home
	  $(".info .logo .hit_logo").on
	    click: ->
	      unless root.Main.pageCurrent is "home"
	        root.Main.pageCurrent = "home"
	        motionReturnHome()
	    mouseover: ->
	      unless root.Main.pageCurrent is "home"
	        $(this).css "cursor", "pointer"
	      else
	        $(this).css "cursor", "default"
	    mouseout: ->


	#--------------------------------------
	#  MOTION RETURN HOME
	#--------------------------------------
	motionReturnHome = ->
	  _temp = 400
	
	  animateArrows ".info .logo .logoStrip", 72, 15
	  $(".info .logo .logoStrip").delay(0).animate
	    left: 0
	  , _temp / 1.5, "easeOutSine"
	  
	  #Remover Internas
	  $(".interna").delay(_temp).animate
	    opacity: 0
	  , _temp, "easeInSine", ->
	    
	    #
	    $(this).remove()
	    
	    #Add Contanier Scroll
	    $(".jScrollbar").css "display", "block"
	    $(".jScrollbar").css "opacity", 0
	    $(".jScrollbar").focus()
	    $(".jScrollbar").delay(100).animate
	      opacity: 1
	    , _temp, "easeOutSine"

	  
	  #
	  returnHomeEvent()

	#--------------------------------------
	# AJAX
	#--------------------------------------
	internaAjax = ->
	  activeLoader()
	  pagelink = "include/internas/" + root.Main.pageCurrent.toString() + ".php"
	  $.ajax
	    url: pagelink
	    cache: false
	    success: ( page ) ->
	      root.Main.contentPage = page
	    error: ->
	      alert "error"
	    complete: ->
	      temp = 0.2
	      window.setTimeout (->
	        addContentPage()
	      ), 1000 * temp

	addContentPage = ->
	  if root.Main.pageCurrent is "about"
	    contentAbout()
	  else
	    contentInterna()

	#--------------------------------------
	# ABOUT
	#--------------------------------------
	contentAbout = ->
	  $(".interna").append root.Main.contentPage
	  $(".about-content").css "position",  "absolute"
	  $(".about-content").css "top",  "25%"
	  desactiveLoader()

	#--------------------------------------
	# INTERNAS
	#--------------------------------------
	contentInterna = ->
	  desactiveLoader()

	  ##
	  $(".interna").append "<div class=\"content\"></div>"
	  $(".content").append root.Main.contentPage
	  $(".content").css "opacity", 0
	  $(".content").delay(0).animate
	    opacity: 1
	  , 1000, "easeOutSine", ->
	  if root.Main.type is 1 or root.Main.type is 2 # HORIZONTE
	   $(".content").css "width", 400
	   $(".content").css "margin-left", -(parseFloat($(".content").css("width")) / 2)

	  if root.Main.type is 3 or root.Main.type is 4 # VERTICAL
	   $(".content").css "margin-left", -(parseFloat($(".content").css("width")) / 2) + 50
	   $(".coluna1").css "width", 370
	   $(".coluna1 .titulo").css "width", 350
	   $(".coluna1 .descricao").css "width", 350


	#--------------------------------------
	# ACTIVE LOADER
	#--------------------------------------
	activeLoader = ->
		$( ".loader" ).css "display", "block"
		root.Main.activeNav = false

	#--------------------------------------
	# DESACTIVE LOADER
	#--------------------------------------
	desactiveLoader = ->
		$( ".loader" ).css "display", "none"
		root.Main.activeNav = true



	#--------------------------------------
	# RESIZE INTERNA
	#--------------------------------------
	resizeInternas = ->
	  if root.Main.type is 1 # HORIZONTE
	    $(".interna").css "height", $(window).height()
	    $(".interna").css "width", $(window).width() * (root.Main.tamPocentagemRezise)
	    $(".interna").css "left", root.Main.margemThumb
	  if root.Main.type is 2 # HORIZONTE
	    $(".interna").css "height", $(window).height()
	    $(".interna").css "width", $(window).width() * (root.Main.tamPocentagemRezise)
	    $(".interna").css "left", $(window).width() * ( 1 - (root.Main.tamPocentagemRezise ) ) + 6
	  if root.Main.type is 3 # VERTICAL
	    $(".interna").css "height", $(window).height() * ( root.Main.tamPocentagemRezise ) + 2
	    $(".interna").css "width", $(window).width()
	    $(".interna").css "top", parseFloat($(".info").css("height"))
	  if root.Main.type is 4 # VERTICAL
	    $(".interna").css "height",  $(window).height() - ( parseFloat($(".info").css("height")) )  
	    $(".interna").css "width", $(window).width()
	    $(".interna").css "top", 0



	#--------------------------------------
	# ANIMATE FILM STRIP
	#--------------------------------------
	animateArrows = (target, amount, numFrames) ->
	  incr = amount
	  newPos = 0
	  margin_top = parseFloat($(target).css("marginTop"))
	  unless root.Main.pageCurrent is "home"
	    moveImage = ->
	      newPos -= incr
	      $(target).css "marginTop", margin_top + newPos
	      setTimeout moveImage, 30  if newPos > -(amount * numFrames)
	    moveImage()
	  else
	    moveImageReturn = ->
	      newPos -= incr
	      $(target).css "marginTop", margin_top - newPos
	      setTimeout moveImageReturn, 30  if newPos > -(amount * numFrames)
	    moveImageReturn()

