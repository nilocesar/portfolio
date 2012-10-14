class Thumb
	constructor:(@name) ->
	init: ->
		root.Main.tamPocentagemRezise = root.Main.tamPocentagem 
		root.Main.activeScroll = true
		createContainerThumb()
		typeThumb()
		window.setTimeout (->
		  motionInit()
		), 1000 * 1

	#--------------------------------------
	#  PLUBIC / EVENT
	#--------------------------------------
	callPage = ->
		root.Main.callPage()

	thumbResize: ->
		root.Main.thumb.init()
		#root.Main.activeScroll = true
		#resizeThumb()

	#--------------------------------------
	#  CREATE THUMB
	#--------------------------------------
	createContainerThumb = ->
		$("body").append "<div class=\"jScrollbar\"><div class=\"jScrollbar_mask\"></div></div>"
		$(".jScrollbar").append "<div class=\"jScrollbar_draggable\"><a href=\"#\" class=\"draggable\"></a></div>"
		$(".jScrollbar").append "<div id=\"clr\"></div>"
		$(".jScrollbar").css "opacity", 0
		$(".jScrollbar .jScrollbar_draggable a.draggable ").css "opacity", 0.4
	
	  	# SETA 
		window.setTimeout (->
			#Seta TOP
			$(".jScrollbar_draggable").append "<img id=\"seta_top\" src=\"include/img/seta_top.png\" width=\"9\" height=\"17\" alt=\"\" title=\"\" />"
			$(".jScrollbar_draggable #seta_top").css "position", "absolute"
			$(".jScrollbar_draggable #seta_top").css "z-index", -99

			#Seta BOTTON 
			$(".jScrollbar_draggable").append "<img id=\"seta_botton\" src=\"include/img/seta_botton.png\" width=\"9\" height=\"17\" alt=\"\" title=\"\" />"
			$(".jScrollbar_draggable #seta_botton").css "position", "absolute"
			$(".jScrollbar_draggable #seta_botton").css "z-index", -99

			#Seta TOP
			$(".jScrollbar_draggable #seta_top").css "top", 15
			$(".jScrollbar_draggable #seta_top").css "left",  3
			$(".jScrollbar_draggable #seta_top").css "opacity", 0
			$(".jScrollbar_draggable #seta_top").delay(0).animate
			  opacity: 1
			, 1000 * 1, "easeOutSine"

			#Seta BOTTON 
			$(".jScrollbar_draggable #seta_botton").css "top", ( parseFloat($(".jScrollbar").css("height")) - 32 )
			$(".jScrollbar_draggable #seta_botton").css "left",  3
			$(".jScrollbar_draggable #seta_botton").css "opacity", 0
			$(".jScrollbar_draggable #seta_botton").delay(0).animate
			  opacity: 1
			, 1000 * 1, "easeOutSine"
	  ), 1000 * 2

	#--------------------------------------
	#  TYPE THUMB
	#--------------------------------------
	typeThumb = ->
		if root.Main.type is 1 # HORIZONTE
			$(".jScrollbar").css "height", $(window).height()
			$(".jScrollbar").css "width", $(window).width() * (root.Main.tamPocentagem)
			$(".jScrollbar").css "left", root.Main.margemThumb
		if root.Main.type is 2 # HORIZONTE
			$(".jScrollbar").css "height", $(window).height()
			$(".jScrollbar").css "width", $(window).width() * (root.Main.tamPocentagem)
			$(".jScrollbar").css "left", $(window).width() * ( 1 - (root.Main.tamPocentagem) )
		if root.Main.type is 3 # VERTICAL
			$(".jScrollbar").css "height", $(window).height()  - parseFloat($(".info").css("height"))
			$(".jScrollbar").css "width", $(window).width()
			$(".jScrollbar").css "top", parseFloat($(".info").css("height"))
			root.Main.tamPocentagem = 1.1
		if root.Main.type is 4 # VERTICAL
			$(".jScrollbar").css "height", $(window).height() - parseFloat($(".info").css("height"))
			$(".jScrollbar").css "width", $(window).width()
			$(".jScrollbar").css "top", 0
			root.Main.tamPocentagem = 1.1
		 
		i = 0
		while i < (root.Main.ntotal)
			createThumb ( (root.Main.ntotal)- 1 ) - i
			thumbTamanho ( (root.Main.ntotal) - 1 ) - i
			i++

	#--------------------------------------
	#  MOTION THUMB
	#--------------------------------------
	motionInit = ->
		window.setTimeout (->
		    $(".jScrollbar").delay(0).animate
		      opacity: 1
		    , 2000, "easeOutSine"
		    
		    i = 0
		    while i < (root.Main.ntotal)
		      activeThumb ( (root.Main.ntotal) - 1 ) - i
		      i++
			), 1000 * 1.5
	  
		# SCROLL TECLADO
		ar = new Array(33, 34, 35, 36, 37, 38, 39, 40)
		$(".jScrollbar").focus()
		$(".jScrollbar").keydown (e) ->
			key = e.which

			return false  if $.inArray(key, ar) > -1
			true
	
	#--------------------------------------
	#  CREATE THUMB 
	#--------------------------------------
	createThumb = (id) ->
		$(".jScrollbar_mask").append "<div class=\"thumbClass\" id=\"containerHtml_thumb" + id + "\"></div>"
		$("#containerHtml_thumb" + id ).append "<div class=\"thumb\"></div>"
		$("#containerHtml_thumb" + id + " .thumb").append "<div class=\"thumbStrip\"></div>"
		$("#containerHtml_thumb" + id + " .thumb .thumbStrip").append "<img src=\"include/img/thumb.png\" width=\"571\" height=\"3901\" alt=\"\" title=\"\" />"
		$("#containerHtml_thumb" + id + " .thumb").append "<div class=\"thumbImagem\"></div>"
		$("#containerHtml_thumb" + id + " .thumb .thumbImagem").append "<img src=\"include/img/tumbID/" + id + ".jpg\" width=\"555\" height=\"81\" alt=\"\" title=\"\" />"
		$("#containerHtml_thumb" + id + " .thumb .thumbStrip").css "opacity", 0
		$("#containerHtml_thumb" + id + " .thumb .thumbImagem").css "opacity", 0
	
	thumbTamanho = ( id ) ->
		$("#containerHtml_thumb" + id + " .thumb").css "width", $(window).width() * ( root.Main.tamPocentagem )
		root.Main.ratio = (($(window).width() / $("#containerHtml_thumb" + id + " .thumb .thumbStrip img").width()) * ( root.Main.tamPocentagem ) )
		root.Main.ratio = 1  if root.Main.ratio  < 1

		$("#containerHtml_thumb" + id).css "top", (( root.Main.topThumb ) * ( root.Main.ratio )) * (((root.Main.ntotal) - 1) - id)
		$("#containerHtml_thumb" + id).css "left", -20  if root.Main.type is 3 or root.Main.type is 4 #/ VERTICAL
		heightThumb = parseFloat($("#containerHtml_thumb" + id + " .thumb").css("height"))
		$("#containerHtml_thumb" + id + " .thumb").css "height", heightThumb * ( root.Main.ratio )
		$("#containerHtml_thumb" + id + " .thumb .thumbStrip img").width ($(window).width()) * ( root.Main.tamPocentagem )
		$("#containerHtml_thumb" + id + " .thumb .thumbStrip img").height $("#containerHtml_thumb" + id + " .thumb .thumbStrip img").height() * ( root.Main.ratio )
		$("#containerHtml_thumb" + id + " .thumb .thumbImagem img").width $("#containerHtml_thumb" + id + " .thumb .thumbImagem img").width() * ( root.Main.ratio )
		$("#containerHtml_thumb" + id + " .thumb .thumbImagem img").height $("#containerHtml_thumb" + id + " .thumb .thumbImagem img").height() * ( root.Main.ratio )
		
		##
		$(".jScrollbar_mask").css "height", parseFloat($("#containerHtml_thumb" + id + " .thumb .thumbImagem img").css("height")) * (root.Main.ntotal) - (25)

		## Active Scroll
		if root.Main.activeScroll
			$(".jScrollbar").jScrollbar()
			root.Main.activeScroll = false

	#--------------------------------------
	# MOTION THUMB
	#--------------------------------------
	activeThumb = ( id ) ->
		window.setTimeout (->
			temp = 350
			animateArrows "#containerHtml_thumb" + id + " .thumb .thumbStrip", 126 * ( root.Main.ratio ), 29, id
			$("#containerHtml_thumb" + id + " .thumb .thumbStrip").delay(0).animate
			  opacity: 0.16
			, temp, "easeOutSine"
		), 1000 * (( (root.Main.ntotal) - 1 ) - id ) / 2

	#--------------------------------------
	# CLICK THUMB
	#--------------------------------------
	clickThumb = ( id ) ->
		filterId = new String( id ).split("_thumb")
		number = filterId[1]
		root.Main.pageCurrent = number
		callPage()


	#--------------------------------------
	# RESIZE THUMB
	#--------------------------------------

	resizeThumb = ->


	#--------------------------------------
	# ANIMATE FILM STRIP
	#--------------------------------------
	animateArrows = (target, amount, numFrames, _id) ->
	  moveImage = ->
	    newPos -= incr
	    $(target).css "marginTop", newPos


	    setTimeout moveImage, 30  if newPos > -(amount * numFrames)
	    

	    numCurrent++
	    if numFrames is numCurrent
	      _temp = 500
	      $("#containerHtml_thumb" + _id + " .thumb .thumbImagem").delay(0).animate
	        opacity: 0.25
	      , _temp, "easeOutSine", ->
	        $(this).on
	          click: ->
	            
	            #event.preventDefault();
	            clickThumb $(this).parent().parent().attr("id")

	          mouseover: ->
	            $(this).css "cursor", "pointer"
	            $(this).delay(0).animate
	              opacity: 0.6
	            , _temp, "easeOutSine"

	          mouseout: ->
	            $(this).delay(0).animate
	              opacity: 0.25
	            , _temp - 100, "easeInSine"


	  incr = amount
	  newPos = 0
	  numCurrent = 0
	  moveImage()