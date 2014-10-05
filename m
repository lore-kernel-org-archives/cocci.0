From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 5 Oct 2014 19:01:28 +0200 (CEST)
Subject: [Cocci] Searching for pass-through functions
In-Reply-To: <5431781F.8040807@users.sourceforge.net>
References: <54303340.3090901@users.sourceforge.net>
 <alpine.DEB.2.02.1410042116320.2079@localhost6.localdomain6>
 <54305719.1050304@users.sourceforge.net>
 <alpine.DEB.2.02.1410042331240.2079@localhost6.localdomain6>
 <54312F70.3080809@users.sourceforge.net>
 <alpine.DEB.2.02.1410051347570.2229@localhost6.localdomain6>
 <54313662.8000402@users.sourceforge.net>
 <alpine.DEB.2.02.1410051729480.2022@localhost6.localdomain6>
 <54317410.6040605@users.sourceforge.net>
 <alpine.DEB.2.02.1410051842280.2022@localhost6.localdomain6>
 <5431781F.8040807@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1410051900090.2022@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 5 Oct 2014, SF Markus Elfring wrote:

> >> Can the five issues on which I stumbled during the source code analysis be fixed
> >> anyhow (eventually without the addtion of "--no-?" command options)?
> > 
> > For the timeouts, no they cannot.
> 
> I am surprised by this answer.
> - How many processing hours will the desired analysis need for completion with
> these "special" three source files?

Who knows.  At least the first one has a lot of nested loops and 
conditionals.  This is a case that Coccinelle does not handle well.

> - Can the software situation be improved for the other two issues?

Probably for the lexer.  Perhaps not for the case of inconsistent paths.  
Again that relates to a particular kind of code structure.

julia
