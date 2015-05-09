From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 9 May 2015 10:36:28 +0200 (CEST)
Subject: [Cocci] Question about the use of "...when !=" in SmPL
In-Reply-To: <20150509074740.GB9628@opentech.at>
References: <BAY181-W739E92CD2131317A21ED42B8DF0@phx.gbl>
 <20150509074740.GB9628@opentech.at>
Message-ID: <alpine.DEB.2.02.1505091035380.2042@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 9 May 2015, Nicholas Mc Guire wrote:

> On Thu, 07 May 2015, ZhouYuan wrote:
> 
> >    Hi,
> >    I have met many problems when I try to use the clause of "when".
> >    For example, I want to check whether there is an default statement in
> >    switch, I wrote the Semantic Patch as following:
> > 
> >      @rule@
> >      function F;
> >      position p;
> >      expression E, E1;
> >      statement S, S1;
> >      @@
> >      F at p (...){
> >      switch (E) {
> >      ...when != default: S
> >      }
> >      }
> >      @script: python@
> >      p<<rule.p;
> >      @@
> >      print p[0].file, p[0].line
> > 
> >    and I got the result after running it:
> > 
> >      Fatal error: exception Failure("minus: parse error:
> >       = File "ex7.cocci", line 9, column 0,  charpos = 93
> >          around = '...', whole content = ...when != default: S
> >      ")
> > 
> >    Also, another example can be witnessed here. I wrote another patch to
> >    check whether there is an "else" after  "if" statement:
> >
> probably there is a simpler way - the "solution" I used was
> 2 rules - one that scans for case statements in the switch 
> and one that scans for default statements in a switch body
> and then condition the python on hascase && !hasdefault
> 
> virtual report                                                                  
> virtual org
> 
> @hascase@
> position p;
> @@
> switch at p (...)
> {
>  case...:...
> }
> 
> @hasdefault@
> @@
> switch (...)
> {
>  default:...
> }
> 
> @script: python depends on hascase && !hasdefault@
> p<<hascase.p;
> @@
> print "%s %s" % (p[0].file, p[0].line)
> 
> there likely is a simpler solution than this though.

No given the limitations on switch, I think that this is the only 
solution.  When I tried something like this, it gave me all switched, 
though.  Not sure why.

julia
