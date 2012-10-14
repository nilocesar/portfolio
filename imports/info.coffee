class Info
	constructor:(@name) ->

	init: ->
		createInfo()
		typeInfo()
		window.setTimeout (->
		  motionInit()
		), 1000 * 1


	#--------------------------------------
	#  PLUBIC / EVENT
	#--------------------------------------
	callPage = ->
		root.Main.callPage()
	  
	infoResize: ->
		typeInfo()
		

	#--------------------------------------
	#  CREATE INFO
	#--------------------------------------
	createInfo = ->
		$( "body" ).append "<div class=\"info\"></div>"
		$(".info").append "<div class=\"borda\"></div>"
		$(".info").append "<div class=\"logo\"></div>"
		$(".info").append "<div class=\"sobre\"></div>"
		$(".info").append "<div class=\"share\"></div>"
		$(".info").append "<div class=\"btn_about\">ABOUT</div>"
		$(".info .logo").append "<div class=\"logoStrip\"></div>"
		$(".info .logo .logoStrip").append "<img src=\"include/img/logo.png\" width=\"163\" height=\"2160\" alt=\"\" title=\"\" />"
		$(".info .logo").append "<div class=\"hit_logo\"></div>"
		$(".sobre").text " Desenvolvedor de Interatividade: JavaScript / ActionScript "
		$(".info .share").append "<img src=\"include/img/like_face.png\" width=\"72\" height=\"19\" alt=\"\" title=\"\" />"
		$(".info .share").append "<img src=\"include/img/like_tweet.png\" width=\"59\" height=\"17\" alt=\"\" title=\"\" />"
		$(".info .share").append "<img src=\"include/img/like_google.png\" width=\"73\" height=\"18\" alt=\"\" title=\"\" />"
		$(".info").css "opacity", 0
		$(".info .sobre").css "opacity", 0.8
		$(".info .share").css "opacity", 0.2
		$(".info .btn_about").css "opacity", 1
		$(".info .logo .hit_logo").css "opacity", 0
		$(".info .btn_about").on
		  click: ->
		    unless root.Main.pageCurrent is "about"
		      root.Main.pageCurrent = "about"
		      callPage()
		  mouseover: ->
		    $(this).css "cursor", "pointer"  unless root.Main.pageCurrent is "about"

		  mouseout: ->


	#--------------------------------------
	#  TYPE INFO
	#--------------------------------------
	typeInfo = ->
		$(".logo").css "left", 40
		$(".logo").css "top", 40
		$(".sobre").css "top", parseFloat($(".logo").css("top")) + 20
		
		if root.Main.type is 1 # HORIZONTAL
			$(".info").css "width", $(window).width() * (1 - (root.Main.tamPocentagem)) + 100
			$(".info").css "height", $(window).height()
			$(".info").css "left", $(window).width() * (root.Main.tamPocentagem) + root.Main.margemThumb
			$(".borda").css "height", $(window).height()
			$(".borda").css "width", 16
			$(".borda").css "background", "url(include/img/borda2.png)"
			$(".sobre").css "width", parseFloat($(".info").css("width")) - parseFloat($(".sobre").css("left")) - 100
			$(".info .share").css "left", parseFloat($(".borda").css("width")) - 2
			$(".info .share").css "top", $(window).height() - 100
			$(".info .btn_about").css "top", $(window).height() - 135
			$(".info .btn_about").css "left", 14
		if root.Main.type is 2 # HORIZONTAL
			$(".info").css "width", $(window).width() * (1 - (root.Main.tamPocentagem)) + 7
			$(".info").css "height", $(window).height()
			$(".info").css "left", 0
			$(".borda").css "height", $(window).height()
			$(".borda").css "width", 16
			$(".borda").css "left", parseFloat($(".info").css("width")) - 16
			$(".borda").css "background", "url(include/img/borda4.png)"
			$(".info .share").css "top", $(window).height() - 100
			$(".info .btn_about").css "top", $(window).height() - 135
		if root.Main.type is 3 # VERTICAL
			$(".info").css "width", $(window).width()
			$(".info").css "height", $(window).height() * (1 - (root.Main.tamPocentagem))
			$(".borda").css "height", 16
			$(".borda").css "width", $(window).width()
			$(".borda").css "top", parseFloat($(".info").css("height")) - 16
			$(".borda").css "background-image", "url(include/img/borda1.png)"
			$(".info .share").css "left", parseFloat($(".info").css("width")) - 305
			$(".info .share").css "top", parseFloat($(".info").css("height")) - 100
			$(".info .btn_about").css "padding-left", 5
			$(".info .btn_about").css "padding-right", 60
			$(".info .btn_about").css "left", parseFloat($(".info").css("width")) - 125
			$(".info .btn_about").css "top", parseFloat($(".info").css("height")) - 135
		if root.Main.type is 4 # VERTICAL
			$(".info").css "width", $(window).width()
			$(".info").css "height", $(window).height() * (1 - (root.Main.tamPocentagem))
			$(".info").css "top", $(window).height() - parseFloat($(".info").css("height"))
			$(".borda").css "height", 16
			$(".borda").css "width", $(window).width()
			$(".borda").css "background-image", "url(include/img/borda3.png)"
			$(".info .share").css "left", parseFloat($(".info").css("width")) - 305
			$(".info .share").css "top", parseFloat($(".info").css("height")) - 100
			$(".info .btn_about").css "padding-left", 5
			$(".info .btn_about").css "padding-right", 60
			$(".info .btn_about").css "left", parseFloat($(".info").css("width")) - 125
			$(".info .btn_about").css "top", parseFloat($(".info").css("height")) - 135


	#--------------------------------------
	#  MOTION INFO
	#--------------------------------------
	motionInit = ->
		$(".info").delay(200).animate
			opacity: 0.95
		, 1000, "easeOutSine"

		setTimeout (->
			
			if root.Main.pageCurrent == 'home' 
				animateArrows ".info .logo .logoStrip", 72, 14
			
			$(".info .logo").css "opacity", 0.5
		), 1000 * 1


	#--------------------------------------
	# ANIMATE FILM STRIP
	#--------------------------------------
	animateArrows = (target, amount, numFrames) ->
	  moveImage = ->
	    newPos -= incr
	    $(target).css "marginTop", newPos
	    setTimeout moveImage, 30  if newPos > -(amount * numFrames)
	  incr = amount
	  newPos = 0
	  moveImage()