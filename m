From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 18 Nov 2016 19:08:02 +0100 (CET)
Subject: [Cocci] Inclusion of script constraints in SmPL
In-Reply-To: <5da250c3-e80f-8842-7e85-481cdf6a6259@users.sourceforge.net>
References: <3c65eb92-8be0-be42-bf8e-893f3853df12@users.sourceforge.net>
 <alpine.DEB.2.20.1611152248150.2060@hadrien>
 <32639cf9-b644-0230-02a6-88d66925340e@users.sourceforge.net>
 <alpine.DEB.2.10.1611161152570.3153@hadrien>
 <6810eb15-839c-8aa5-6485-401d43ba1246@users.sourceforge.net>
 <alpine.DEB.2.10.1611161350550.3153@hadrien>
 <69c3643e-10b4-007a-f847-d0098f298e16@users.sourceforge.net>
 <alpine.DEB.2.10.1611161514250.3153@hadrien>
 <b90e8f82-aa00-0a11-1e38-53d8c4dfd9fd@users.sourceforge.net>
 <alpine.DEB.2.10.1611181842240.2963@hadrien>
 <5da250c3-e80f-8842-7e85-481cdf6a6259@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1611181901530.2963@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 18 Nov 2016, SF Markus Elfring wrote:

> >> * Would such an inclusion approach trigger special requirements on the
> >>   position for corresponding initialisation code?
> >
> > The constraint specification should be a single function call.
>
> Does the script constraint syntax allow more programming language code there?

For all practical purposes, no.  Concretely, the script constraint code is
initially parsed using a C parser, not a parser for the script language.
Function calls, of the form f(a,b,c) are in the intersection of C and the
supported scripting languages.

> > You can set up your @initialize:python@ code to import whatever you want.
>
> I would prefer to keep initialisation code for the implementation of the
> predicate function closely together with the call of the included
> metavariable.

You are most welcome to implement in ocaml the lexer and parser for the
scripting language of your choice.

julia
