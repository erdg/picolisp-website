(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l")

(setq *Css 
  (list
    #"css/normalize.css"
    "css/utils.css" 
    "css/responsive-utils.css"
    "css/ungrid.css" 
    "css/container.css"
    "css/typography.css"
    "https://fonts.googleapis.com/css?family=Exo:700,500,300"
    "css/forms.css"
    "css/buttons.css"
    "css/nav.css"
    "css/header.css"
    "css/main-page.css") )


#######
# logos
(de small-logo () # include a '#' to make '<img>' a link 
  (<img> "img/logo/PicoLisp_Logo_white_small.png" "PicoLisp" "#") ) 

(de medium-logo ()
  (<img> "img/logo/PicoLisp_Logo_white_medium.png" "PicoLisp") )

(de large-logo ()
  (<img> "img/logo/PicoLisp_Logo_white_large.png" "PicoLisp") )


#######
# icons
(de small-icon ()
  (<img> "img/icon/PicoLisp_Icon_small.png" "icon" "#") ) # link

(de medium-icon ()
  (<img> "img/icon/PicoLisp_Icon_medium.png" "icon") )

(de large-icon ()
  (<img> "img/icon/PicoLisp_Icon_large.png" "icon") )


# disable autocomplete for try-it repl
(patch <field> 
  '(prin "<input type=\"text\" ")
  '(prin "<input type=\"text\" autocomplete=\"off\" ") )


###########
# main page
(de home ()
  (app)
  (action 
    (html 0 "PicoLisp" *Css "blurry-bg"
      (<div> "container"
        (to-nav)
        (header)
        (try-it)
        (stripe)
        (features)
        (nav)
        (footer) ) ) ) )

(de go ()
  (server 8080 "!home") )


############
# navigation
(de <nav> (Attr . Prg)
  (tag 'nav Attr 2 Prg) )

(de nav ()
  (<nav> '("pl-s pr-s pt-s pb-s" (id . "primary-nav"))
    (<style> "rwd-img pb-s d-b"
      (small-icon) )
    (<style> "d-b pb-s tt-u"
      (<li> NIL (<href> "Download" "#"))        
      (<li> NIL (<href> "Documentation" "#"))  
      (<li> NIL  (<href> "Community" "#")) ) ) )

# link to primary nav, at the bottom on mobile.
# hidden on larger screens
(de to-nav ()
  (<style> "to-nav black-grey-bg light-grey mt-s pl-s pt-s pr-s pb-s"
    (<href> "menu" "#primary-nav") ) )


########
# header 
(de <header> (Attr . Prg)
  (tag 'header Attr 2 Prg) )

(de header ()
  (<header> "banner black-bg mt-l mb-l pt-l pb-l pl-s pr-s"
    (<h1> "white ta-c fw-b tab-pt-xl"
      "PicoLisp" )
    (header-icon)
    (<h3> "white ta-c tab-pb-xl"
      "programming simplified" ) ) )

(de header-icon ()
  (<style> "rwd-img d-b ml-a mr-a"
    (medium-icon) ) )


########
# try it
(de try-it ()
  (<div> "try-it dark-grey-bg pl-s pt-s pr-s pb-m"
    (<div> "row"
      (<div> '("col" (style . "width: 11%")) NIL) # spacer column, hidden for mobile.
      (<div> "col"
        (<h4> "green mt-0 mb-0 fw-300"
          "Try it" )
        (<p> "lighter-grey"
          "Type PicoLisp expressions here. Hit enter to evaluate." )
        (try-it-repl) )
      (<div> '("col" (style . "width: 8%")) NIL)  # spacer column
      (<div> "col"
        (<h4> "red mb-0 fw-300"
          "Got 5 minutes?" )
        (<p> "lighter-grey"
          "Type help to start the tutorial." ) )
      (<div> '("col" (style . "width: 11%")) NIL) ) ) )

(de try-it-repl ()
   (form '(style . `(pack "color: " pico-green*))
      (gui 'line '(+Style +TextField) "row dark-grey-bg" 24)
      (gui '(+Style +JS +Button) "vh" "eval"  # visually hidden
        '(prog                                # but need button so we can press enter to eval
          (clr> (: home view))
          (let Str (val> (: home line))
            (out (pack "+" (tmp "repl"))
              (prinl ": " Str)
              (catch '(NIL)
                  (let Res (in "/dev/null" (eval (any Str)))
                    (prin "-> ")
                    (println Res) ) )
              (when *Msg (prinl @) (off *Msg)) )
            (clr> (: home line)) ) ) )
      (--)
      (gui 'view '(+Style +FileField) "try-it-view row darker-grey-bg" '(tmp "repl") 24 3) ) )


###################
# propaganda stripe 
(de stripe ()
  (<div> "stripe mt-l mb-l pt-s pb-s pl-s pr-s"
    (<h4> "ta-c"
      "An interpreted"
      (<span> "blue" 
        " lisp ")
      "built atop a simple, stable virtual machine" ) ) )


######################
# highlighted features

# too much <div> bullshit. need to finish responsive utils.
(de features ()
  (<div> "features 
          mt-l mb-l
          pt-s pb-s pl-s pr-s
          fw-300
          white-bg"
    (<div> "row tab-pt-xl"
      (<div> '("col" (style . "width: 11%")) NIL)
      (Simple)
      (<div> '("col" (style . "width: 8%")) NIL)
      (Stable)
      (<div> '("col" (style . "width: 11%")) NIL) )
    (<div> "row" 
      (<div> '("col" (style . "width: 11%")) NIL)
      (Fun)
      (<div> '("col" (style . "width: 8%")) NIL)
      (Flexible)
      (<div> '("col" (style . "width: 11%")) NIL) )
    (<div> "row" 
      (<div> '("col" (style . "width: 11%")) NIL)
      (DownrightDynamic)
      (<div> '("col" (style . "width: 8%")) NIL)
      (Dangerous)
      (<div> '("col" (style . "width: 11%")) NIL) ) ) )


(de Simple ()
  (<div> "col mb-l"
    (<h4> "black mt-0 mb-0"
      "Simple" )
    (<p> "fw-300"
      "PicoLisp, the language, runs on the PicoLisp virtual machine. The \
      virtual machine architecture was designed to be as simple as possible;\
      only a single data structure is used internally. Blah blah blah." ) ) )

(de Stable ()
  (<div> "col mb-l"
    (<h4> "black mt-0 mb-0"
      "Stable" )
    (<p> "fw-300 mb-s"
      "PicoLisp is really stable. Blah blah blah." ) ) )

(de Fun ()
  (<div> "col mb-l"
    (<h4> "black mt-0 mb-0"
      "Fun" )
    (<p> NIL
      "PicoLisp is really Fun. Blah blah blah." ) ) )

(de Flexible ()
  (<div> "col mb-l"
    (<h4> "black mt-0 mb-0"
      "Flexible" )
    (<p> NIL
      "PicoLisp is really Flexible. Blah blah blah." ) ) )

(de DownrightDynamic ()
  (<div> "col mb-l"
    (<h4> "black mt-0 mb-0"
      "Downright Dynamic" )
    (<p> NIL
      "PicoLisp is downright dynamic. Blah blah blah." ) ) )

(de Dangerous ()
  (<div> "col mb-l"
    (<h4> "black mt-0 mb-0"
      "Dangerous" )
    (<p> NIL
      "PicoLisp is for programmers who want to control their environment, at
       all level, from the application domain down to the bare metal, who 
       want to use a transparent and simple - yet universal - programming 
       model, and who want to know exactly what is going on." )
    (<p> NIL
      "It does not pretend to be easy to learn. There are plenty of languages
       that do. It is not for people who don't care what's under the hood, who 
       just want to get their application running. They might be better served 
       with some standard, \"safe\" black-box, which may be easier to learn, 
       and which allegedly better protects them from their own mistakes." ) ) )

########
# footer

(de <footer> (Attr . Prg)
  (tag 'footer Attr 2 Prg) )

(de footer ()
  (<footer> "black-bg mt-s mb-l pt-s pb-s pl-s pr-s"
    (pico-powered) ) )

(de pico-powered ()
  (<img> 
    "img/powered-by/PicoLisp_PoweredBy_white_small.png" 
    "Powerd by PicoLisp") )
    
