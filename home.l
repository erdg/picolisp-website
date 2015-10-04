(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l")

(setq *Css 
  (list
    "css/utils.css" 
    "css/ungrid.css" 
    "css/container.css"
    "https://fonts.googleapis.com/css?family=Inconsolata"
    "css/forms.css"
    "css/buttons.css"
    "css/main-page.css") )


########
# colors
(setq pico-blue*  "#6067af")
(setq pico-green* "#6dc066")
(setq pico-red*   "#f05658")
(setq light-grey* "#333333")
(setq dark-grey*  "#2b2b2b")


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
(de large-icon ()
  (<img> "img/icon/PicoLisp_Icon_large.png" "icon") )


###########
# main page
(de home ()
  (app)
  (action 
    (html 0 "PicoLisp" *Css NIL
      (nav)
      (header)
      (try-it)
      (stripe)
      (features) ) ) )

(de go ()
  (server 8080 "!home") )


############
# navigation
(de <nav> (Attr . Prg)
  (tag 'nav Attr 2 Prg) )

(de nav ()
  (<nav> '("pt-l pb-l" (style . "background: black;"))
    (nav-links) ) )

(de nav-links ()
  (<ul> "container row ta-c mb-s"
    (small-icon)
    (<li> "col" (<href> "Download" "#"))
    (<li> "col" (<href> "Documentation" "#"))
    (<li> "col" (<href> "Community" "#")) ) )


########
# header 
(de <header> (Attr . Prg)
  (tag 'header Attr 2 Prg) )

(de header ()
  (<header> '("pt-l pb-l" (style . "background: black;"))
    (<h1> "ta-c fw-b"
      "PicoLisp" )
    (header-icon)
    (<h3> "ta-c"
      "programming simplified" ) ) )

(de header-icon ()
  (<style> "rwd-img d-b ml-a mr-a"
    (large-icon) ) )


########
# try it
(de try-it ()
  (<div> '(style . `(pack "background: " dark-grey*))
    (<div> "container row pt-s pb-xl" 
      (<div> "col pl-xxl pr-l"
        (<h1> '(style . `(pack "color: " pico-green*))
          "Try it" )
        (<h3> '(style . "color: #d3d3d3")
          "Type PicoLisp expressions here" )
        (try-it-repl) )
      (<div> "col pl-l pr-xxl"
        (<h1> '(style . `(pack "color: " pico-red*))
          "Got 5 minutes?" )
        (<h3> '(style . "color: #d3d3d3")
          "Type help to start the tutorial" ) ) ) ) )

(de try-it-repl ()
   (form '("row" (style . `(pack "color: " pico-green*)))
      (<style> '(style . `(pack "background: " light-grey*))
        (gui 'line '(+Style +TextField) "try-it-line ml-a mr-a" 42) )
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
      (<style> '("mb-s" (style . `(pack "background: " dark-grey*)))
        (gui 'view '(+Style +FileField) "try-it-view pt-s ml-a mr-a" '(tmp "repl") 48 4) ) ) )


###################
# propaganda stripe 
(de stripe ()
  (<div> "stripe pt-l pb-l"
    (<h1> "ta-c"
      "An interpreted"
      (<span> 'blue " lisp ")
      "built atop a simple, stable virtual machine" ) ) )


######################
# highlighted features
(de features ()
  (<div> "features container"
    (<div> "row" 
      (Simple)
      (Stable) ) 
    (<div> "row"
      (Fun)
      (Flexible) )
    (<div> "row"
      (DownrightDynamic)
      (Dangerous) ) ) )
    

(de Simple ()
  (<div> "col pl-xxl pr-xl"
    (<h1> '(style . `(pack "color: " dark-grey*))
      "Simple" )
    (<p> NIL
      "PicoLisp, the language, runs on the PicoLisp virtual machine. The \
      virtual machine architecture was designed to be as simple as possible;\
      only a single data structure is used internally. Blah blah blah." ) ) )

(de Stable ()
  (<div> "col pl-xl pr-xxl"
    (<h1> '(style . `(pack "color: " dark-grey*))
      "Stable" )
    (<p> NIL
      "PicoLisp is really stable. Blah blah blah." ) ) )

(de Fun ()
  (<div> "col pl-xxl pr-xl"
    (<h1> '(style . `(pack "color: " dark-grey*))
      "Fun" )
    (<p> NIL
      "PicoLisp is really Fun. Blah blah blah." ) ) )

(de Flexible ()
  (<div> "col pl-xl pr-xxl"
    (<h1> '(style . `(pack "color: " dark-grey*))
      "Flexible" )
    (<p> NIL
      "PicoLisp is really Flexible. Blah blah blah." ) ) )

(de DownrightDynamic ()
  (<div> "col pl-xxl pr-xl"
    (<h1> '(style . `(pack "color: " dark-grey*))
      "Downright Dynamic" )
    (<p> NIL
      "PicoLisp is downright dynamic. Blah blah blah." ) ) )

(de Dangerous ()
  (<div> "col pl-xl pr-xxl"
    (<h1> '(style . `(pack "color: " dark-grey*))
      "Dangerous" )
    (<p> NIL
      "PicoLisp is really dangerous. Blah blah blah." ) ) )

