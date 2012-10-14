root = exports ? this
class root.Nav
	constructor:(@name) ->
	init: ->
		root.Main.interna = new Internas "Internas"
		root.Main.interna.init()

	callPageInternasDepelink = ->
		root.Main.callDeepLink()

	#--------------------------------------
	#  PLUBIC / EVENT
	#--------------------------------------
	callNav: ( nav ) ->
		if nav is "page"
			createInternas()
			createContainerSetas()  if root.Main.pageCurrent isnt "about" and root.Main.pageCurrent isnt "home"
		else
			activeAbout()
	
	#--------------------------------------
	#  CREATE INTERNAS
	#--------------------------------------
	createInternas = ->
		activeAbout()
		if root.Main.pageOld isnt "about" and  root.Main.pageOld isnt "home" and root.Main.pageCurrent is "about" # se vc estiver nas internas e ir para o About
		   root.Main.interna.callInterna false
		else
		   root.Main.interna.callInterna true

	#--------------------------------------
	#  ACTIVE ABOUT
	#--------------------------------------
	activeAbout = ->
		#
		callPageInternasDepelink()
		
		#
		root.Main.pageArray.push root.Main.pageCurrent
		root.Main.pageOld = root.Main.pageArray[ root.Main.pageArray.length - 2 ]  if root.Main.pageArray.length > 1
		if root.Main.pageCurrent is "about"
		    $(".info .btn_about").delay(0).animate
		      opacity: 0
		    , 1000, "easeOutSine", ->
		      $(this).css "display", "none"
		else
		    $(".info .btn_about").css "display", "block"
		    $(".info .btn_about").delay(0).animate
		      opacity: 1
		    , 1000, "easeOutSine"

	#--------------------------------------
	#  CREATE CONTAINER SETAS
	#--------------------------------------
	createContainerSetas = ->
	  ntotal = parseFloat root.Main.ntotal
	  nCurrent = parseFloat root.Main.pageCurrent
	
	  $(".interna").append "<div class=\"setaEsq\"></div>"
	  $(".interna").append "<div class=\"setaDir\"></div>"
	  if nCurrent is ( ntotal - 1)
	    activeSetas $(".setaEsq"), "desativar"
	  else activeSetas $(".setaDir"), "desativar"  if root.Main.pageCurrent is 0
	  
	  # 
	  $(".setaEsq,.setaDir").on
	    click: ->
	      navDirecao $(this).attr("class")
	    mouseover: ->
	      $(this).css "cursor", "pointer"
	    mouseout: ->

	  
	  # TECLADO  SETA
	  $(".jScrollbar").focus()
	  $(".jScrollbar").keydown (e) ->
	    e.preventDefault()
	    if e.which is 37
	      navDirecao "setaEsq"
	    else navDirecao "setaDir"  if e.which is 39
	    false


	#--------------------------------------
	#  NAV DIRECAO
	#--------------------------------------
	navDirecao = ( dir ) ->

		if root.Main.activeNav == true
		  if dir is "setaEsq"
		    if root.Main.pageCurrent < ( root.Main.ntotal - 1 )
		      root.Main.pageCurrent++
		      root.Main.interna.navControl()

		      #
		      if root.Main.pageCurrent is ( root.Main.ntotal - 1 )
		        activeSetas $(".setaEsq"), "desativar"
		      else
		        activeSetas $(".setaDir"), "ativar"
		  else
		    if root.Main.pageCurrent > 0
		      root.Main.pageCurrent--
		      root.Main.interna.navControl()
		      
		      if root.Main.pageCurrent is 0
		        activeSetas $(".setaDir"), "desativar"
		      else
		        activeSetas $(".setaEsq"), "ativar"

		  #
		  callPageInternasDepelink()
	  


	#--------------------------------------
	#  ACTIVAR SETAS
	#--------------------------------------
	activeSetas = (_this, _type) ->
	  if _type is "ativar"
	    _this.css "display", "block"
	    _this.delay(0).animate
	      opacity: 1
	    , 500, "easeOutSine", ->

	  else
	    _this.delay(0).animate
	      opacity: 0
	    , 500, "easeInSine", ->
	      $(this).css "display", "none"


	
