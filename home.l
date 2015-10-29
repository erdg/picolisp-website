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
    (html 0 "PicoLisp" *Css "pl-code-bg"
        (to-nav)
        (header)
        (try-it)
        (stripe)
      (features)
      (nav)
      (footer) ) ) )

(de go ()
  (server 8080 "!home") )


############
# navigation
(de <nav> (Attr . Prg)
  (tag 'nav Attr 2 Prg) )

(de nav ()
  (<nav> '("pl-s pr-s pt-m pb-m" (id . "primary-nav"))
    (<style> "rwd-img pb-s d-b"
      (small-icon) )
    (<style> "d-b tt-u"
      (<li> "pb-s" (<href> "Download" "#"))        
      (<li> "pb-s" (<href> "Documentation" "#"))  
      (<li> NIL  (<href> "Community" "#")) ) ) )

# link to primary nav, at the bottom on mobile.
# hidden on larger screens
(de to-nav ()
  (<style> "to-nav"
    (<href> "" "#primary-nav") ) )


########
# header 
(de <header> (Attr . Prg)
  (tag 'header Attr 2 Prg) )

(de header ()
    (<div> "container"
      (<header> "mt-0 mb-0 
                 pt-l pb-l pl-s pr-s
                 big-pt-xl big-pb-xl"
        (<h1> "white ta-c fw-b
              mt-0 mb-l"
          "PicoLisp" )
        (header-icon)
        (<h3> "white ta-c fs-i
               mt-l mb-0"
          "programming simplified" ) ) ) )

(de header-icon ()
  (<style> "rwd-img d-b ml-a mr-a"
    (medium-icon) ) )


########
# try it
(de try-it ()
  (<div> "try-it dark-grey-bg pt-m pb-m big-pt-l big-pb-l"
    (<div> "container row"
      (<div> "col big-pl-xl big-pr-m"
        (<h4> "row green mt-0 mb-0 fw-500"
          "Try it" )
        (<p> "row lighter-grey"
          "Type PicoLisp expressions here. Hit enter to evaluate." )
        (try-it-repl) )
      (<div> '("col" (style . "width: 8%")) NIL)  # spacer column
      (<div> "col big-pl-m big-pr-xl"
        (<h4> "row red mb-0 fw-500"
          "Got 5 minutes?" )
        (<p> "row lighter-grey"
          "Type help to start the tutorial, or just start firing off PicoLisp one-liners." ) ) ) ) )

(de try-it-repl ()
   (form NIL 
      (gui 'line '(+Style +TextField) "try-it-line dark-grey-bg row pl-s pt-s pr-s pb-s" 24)
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
      (gui 'view '(+Style +FileField) "try-it-view darker-grey-bg row" '(tmp "repl") 24 3) ) )


###################
# propaganda stripe 
(de stripe ()
  (<div> "stripe fs-i
          mt-0 mb-0 
          pt-m pb-m pl-s pr-s
          big-pt-l big-pb-l"
    (<h4> "container mt-0 mb-0 ta-c"
      "An interpreted"
      (<span> "blue" 
        " lisp ")
      "built atop a simple, stable virtual machine" ) ) )


######################
# highlighted features
(de features ()
  (<div> "features
          mt-0 mb-0
          pt-m pb-m big-pt-xl big-pb-xl
          white-bg"
    (<div> "container row"
      (<div> "col big-pl-l big-pr-l"
        (Simple)
        (Fun) )
      (<div> '("col" (style . "width: 8%")) NIL)
      (<div> "col big-pl-l big-pr-l"
        (Stable)
        (Flexible)
        (UnabashedlyDynamic)
        (Dangerous) ) ) ) )
    

(de Simple ()
  (<div> "row mb-l"
    (<h4> "black fw-500 mt-0 mb-0"
      "Simple" )
    (<p> NIL
      "PicoLisp is a programming environment that prides itself on it's powerful
      simplicity. It gives the programmer the tools to create complex programs
      with simple code. Basically, it's super efficient." )
    (<p> NIL
      "First of all, PicoLisp is a virtual machine architecture, and then a 
      programming language. Its internal structures are simple enough, allowing
      the experienced programmer to fully understand what's going on under the
      hood. In fact, at the lowest level, the VM is built up from a 
      single data structure, " (<href> "the cell" "#") ". The high-level
      constructs of the programming language map directly to these cells, 
      making the whole system both understandable and predictable." )
    (<p> NIL
      "Relax into the PicoLisp mindset. All your thoughts and all your
      programs are simply a bunch of cells, making connections and sharing data
      amongst themselves." ) ) )

(de Stable ()
  (<div> "row mb-l"
    (<h4> "black fw-500 mt-0 mb-0"
      "Stable" )
    (<p> "mb-s"
      "PicoLisp has been under development since the late 80's. Both the 
      language and the virtual machine have stabilized in that time. You 
      can count on your programs running tomorrow and ten years from
      tomorrow." ) ) )

(de Fun ()
  (<div> "row mb-l"
    (<h4> "black fw-500 mt-0 mb-0"
      "Fun" )
    (<p> NIL
      "PicoLisp has a lot of features that really make it a pleasure to program.
      Check it!" )
    (<ul> "pl-m pr-m big-pl-l big-pr-l"
      (<style> "pb-m"
        (<li> NIL 
          (<href> "GUI Framework" "#")
          (<p> NIL
            "PicoLisp ships with all you need to get started writing
            web applications. Just add love and a bit of CSS." ) )
        (<li> NIL 
          (<href> "Integrated Database" "#")
          (<p> NIL 
            "Database functionality is built into the core of the language.
            PicoLisp " (<span> "fs-i" "is") " a database query and manipulation
            language. Build multi-user databases, distributed across many 
            machines or in a cloud, with a modest, lean technology stack." ) )
        (<li> NIL 
          (<href> "Native C calls" "#")
          (<p> NIL
            "Interface with almost any C library function, manipulate C data 
            structures in memory, and call lisp functions from your C code. All 
            this without writing any glue code or include files. Heck, you can 
            even call those C functions from the REPL." ) )
        (<li> NIL 
          (<href> "Java Interoperability" "#")
          (<p> NIL
            "This seems to be important for a lot of people these days. 
            Sure, why not? PicoLisp can interface directly to a running JVM,
            giving you dynamic access to all those libraries and classes or 
            whatever." ) ) ) ) ) )


(de Flexible ()
  (<div> "row mb-l"
    (<h4> "black fw-500 mt-0 mb-0"
      "Flexible" )
    (<p> NIL
      "It's lisp, afterall. It's a programming language best suited for
      reprogramming " (<span> "fs-i" "itself") ". Into functional programming? Rock on. OOP? PicoLisp
      has an elegant, unobtrusive, totally optional " (<href> "object system" "#") 
      ". Dreaming of a new DSL? Trivial. Explore a syntax of nested function calls, 
      bend the language to the task at hand, metaprogram yourself to the moon. 
      We'll help you build a rocket." ) ) )

(de UnabashedlyDynamic ()
  (<div> "row mb-l"
    (<h4> "black fw-500 mt-0 mb-0"
      "Unabashedly Dynamic" )
    (<p> NIL
      "PicoLisp doesn't give a fuck. It tries to be as dynamic as possible. 
      All decisions - matters like memory management, dynamic symbol binding,
      and late method binding - are delayed until runtime. Entire environments
      are first-class citizens. There is no compiler." )
    (<p> NIL
      "It's a breath of fresh air in this stagnant, statically typed world." ) ) )

(de Dangerous ()
  (<div> "row mb-l"
    (<h4> "black fw-500 mt-0 mb-0"
      "Dangerous" )
    (<p> NIL
      "PicoLisp is for programmers who want to understand their environment, at
       all levels, from the application domain down to the bare metal, who want 
       to use a transparent and simple - yet universal - programming model, and 
       who want to know exactly what is going on." )
    (<p> NIL
      "It does not pretend to be easy to learn, nor will it make any attempt 
      to protect you from yourself. You've been warned." ) ) )

########
# footer
(de <footer> (Attr . Prg)
  (tag 'footer Attr 2 Prg) )

(de footer ()
  (<footer> "black-bg mt-0 mb-0 pt-s pb-s pl-s pr-s"
    (pico-powered) ) )

(de pico-powered ()
  (<img> 
    "img/powered-by/PicoLisp_PoweredBy_white_small.png" 
    "Powerd by PicoLisp") )
    
