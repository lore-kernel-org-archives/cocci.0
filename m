From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 5 Mar 2013 11:28:30 +0100 (CET)
Subject: [Cocci] Addition of source code documentation generation to the
 build system?
In-Reply-To: <5135C74D.8000602@users.sourceforge.net>
References: <5133B0BF.8000608@users.sourceforge.net>
 <alpine.DEB.2.02.1303041106480.1984@hadrien>
 <5134918E.7090304@users.sourceforge.net>
 <alpine.DEB.2.02.1303041338350.1984@hadrien>
 <5135B8DB.30307@users.sourceforge.net>
 <alpine.DEB.2.02.1303051028450.1954@hadrien>
 <5135C125.6070707@users.sourceforge.net>
 <alpine.DEB.2.02.1303051104310.1954@hadrien>
 <5135C74D.8000602@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1303051126520.1954@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > But if you need everything to get any documentation, then I guess you would need
> > the external libraries as well.
>
> I guess that I will need a technique to determine include paths for the
> referenced modules consistently.

I think you could grep for them in the makefile.

> > I'm not sure why ocamldoc can't just use the -I paths to find the things
> > it needs.  That is you should be able to give just one file, and it should
> > be able to find the information for any dependencies.
>
> Do you expect that more "intelligence" or "convenience" should be provided by
> this tool?

I don't know anything about this tool, but I would expect that it would
follow the same strategy as the rest of the ocaml tools for respolving
dependencies.

julia
