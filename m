From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 09 May 2015 10:10:34 +0200
Subject: [Cocci] Source code analysis around "switch"
In-Reply-To: <20150509074740.GB9628@opentech.at>
References: <BAY181-W739E92CD2131317A21ED42B8DF0@phx.gbl>
 <20150509074740.GB9628@opentech.at>
Message-ID: <554DC0FA.4010904@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

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

I find such a SmPL approach incomplete.
Is the shown condition expression fragile and questionable?

Do you need to work more with position variables there
so that only really appropriate source code places
will be combined and then checked?

Regards,
Markus
