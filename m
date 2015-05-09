From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Sat, 9 May 2015 12:08:40 +0200
Subject: [Cocci] Question about the use of "...when !=" in SmPL
In-Reply-To: <alpine.DEB.2.02.1505091035380.2042@localhost6.localdomain6>
References: <BAY181-W739E92CD2131317A21ED42B8DF0@phx.gbl>
 <20150509074740.GB9628@opentech.at>
 <alpine.DEB.2.02.1505091035380.2042@localhost6.localdomain6>
Message-ID: <20150509100840.GB32695@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 09 May 2015, Julia Lawall wrote:

> 
> 
> On Sat, 9 May 2015, Nicholas Mc Guire wrote:
> 
> > On Thu, 07 May 2015, ZhouYuan wrote:
> > 
> > >    Hi,
> > >    I have met many problems when I try to use the clause of "when".
> > >    For example, I want to check whether there is an default statement in
> > >    switch, I wrote the Semantic Patch as following:
> > > 
> > >      @rule@
> > >      function F;
> > >      position p;
> > >      expression E, E1;
> > >      statement S, S1;
> > >      @@
> > >      F at p (...){
> > >      switch (E) {
> > >      ...when != default: S
> > >      }
> > >      }
> > >      @script: python@
> > >      p<<rule.p;
> > >      @@
> > >      print p[0].file, p[0].line
> > > 
> > >    and I got the result after running it:
> > > 
> > >      Fatal error: exception Failure("minus: parse error:
> > >       = File "ex7.cocci", line 9, column 0,  charpos = 93
> > >          around = '...', whole content = ...when != default: S
> > >      ")
> > > 
> > >    Also, another example can be witnessed here. I wrote another patch to
> > >    check whether there is an "else" after  "if" statement:
> > >
> > probably there is a simpler way - the "solution" I used was
> > 2 rules - one that scans for case statements in the switch 
> > and one that scans for default statements in a switch body
> > and then condition the python on hascase && !hasdefault
> > 
> > virtual report                                                                  
> > virtual org
> > 
> > @hascase@
> > position p;
> > @@
> > switch at p (...)
> > {
> >  case...:...
> > }
> > 
> > @hasdefault@
> > @@
> > switch (...)
> > {
> >  default:...
> > }
> > 
> > @script: python depends on hascase && !hasdefault@
> > p<<hascase.p;
> > @@
> > print "%s %s" % (p[0].file, p[0].line)
> > 
> > there likely is a simpler solution than this though.
> 
> No given the limitations on switch, I think that this is the only 
> solution.  When I tried something like this, it gave me all switched, 
> though.  Not sure why.

I still have spatch version 1.0.0-rc21 on this box - will check
if its behaving any different with a 1.0.

>
just ran this one on the entire kernel and it did find
some cases that were incorrectly handled like

drivers/tty/serial/ip22zilog.c 820 (linux-next 4.1-rc2)
        case CS8:
        default:
which was reported as having no default - but this is ugly code
anyway so its ok to report it.

checked a few others - and except for the above case (which does
pop up a few times) it looks ok (totally 2240 were reported in the 
entire kernel so only checked 25 or so)

thx!
hofrat
