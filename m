From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Sat, 9 May 2015 10:28:04 +0200
Subject: [Cocci] Source code analysis around "switch"
In-Reply-To: <554DC0FA.4010904@users.sourceforge.net>
References: <BAY181-W739E92CD2131317A21ED42B8DF0@phx.gbl>
 <20150509074740.GB9628@opentech.at> <554DC0FA.4010904@users.sourceforge.net>
Message-ID: <20150509082804.GA13329@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 09 May 2015, SF Markus Elfring wrote:

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
> I find such a SmPL approach incomplete.

What is the incompleteness - or what case do you think is unhandled ?

> Is the shown condition expression fragile and questionable?
> 
> Do you need to work more with position variables there
> so that only really appropriate source code places
> will be combined and then checked?
>
why ? hascase has a position variable in it and only if
that rule applied is the python script executed - and if there
was a default then hasdefault matched and so the python script
will not be executed when hasdefault matched => only switch
statements with no default are reported. Atleast it sems to work
for me - but as noted there well may be a better solution and
maybe its even incomplete - but I do not see that its a missing
positional variable here.

thx!
hofrat 
