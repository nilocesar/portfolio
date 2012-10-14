root = exports ? this
$(document).ready ->
	class root.Main
		#control
		@random: (min, max) -> min + Math.random() * (max - min)
		@pageCurrent : 'home'
		@pageOld : "home"
		@pageArray : []
		@ntotal : 16
		@topThumb : 80
		#@tamPocentagem : ( Math.round @random( 7,8 ) ) / 10 
		@tamPocentagem : ( Math.round @random( 7,7 ) ) / 10 
		@tamPocentagemRezise: 0
		#@type : Math.round @random 1, 4
		@type : Math.round @random 4, 4
		@margemThumb : -30
		@ratio : 0
		@contentPage : ""
		@activeX: true
		@activeScroll : true


		#class
		@raiz : undefined
		@info : undefined
		@thumb : undefined
		@nav : undefined
		@interna : undefined
		@deepLink : undefined

		constructor: (@name) ->
			
		init: ->
			@infoInit()
			@thumbInit()
			@navInit()
			@deepInit()
			@resizeEvent()

		$(window).load ->
			root.Main.raiz = new Raiz "Raiz" #js
			root.Main.raiz.init()

		infoInit: ->
			root.Main.info = new Info "Info"
			root.Main.info.init()

		thumbInit: ->
			root.Main.thumb = new Thumb "Thumb"
			root.Main.thumb.init()

		navInit: ->
			root.Main.nav = new Nav "Navegacao"
			root.Main.nav.init()

		@callPage: ( _page = "page" ) -> # call thumb.coffee
			root.Main.nav.callNav _page
			@callDeepLink()

		deepInit: -> 
			root.Main.deepLink = new Deeplink "Deeplink"
			root.Main.deepLink.init()
		
		@callDeepLink : ->
			root.Main.deepLink.callDeeplink @pageCurrent

		@callPageDeeplink : ( _page ) ->
			@pageCurrent = _page
			root.Main.nav.callNav  "page"

		resizeEvent: ->
			$(window).resize ->
				##
				if root.Main.pageCurrent == "home"
					$('.jScrollbar').remove()

				##
				completeResize (->
				 root.Main.info.infoResize()
				 
				 if root.Main.pageCurrent == "home"
				 	root.Main.thumb.thumbResize()
				 else
				 	root.Main.interna.internasResize()
				), 500
				
			
			completeResize = (->
			  timer = 0
			  (callback, ms) ->
			    clearTimeout timer
			    timer = setTimeout(callback, ms)
			)()

			

	######################
	# 	  CALL MAIN      #
	######################

	main = new root.Main()
	main.init()

