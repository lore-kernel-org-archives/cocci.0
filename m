From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 Nov 2016 13:53:48 +0100 (CET)
Subject: [Cocci] SmPL script construction with included files
In-Reply-To: <6810eb15-839c-8aa5-6485-401d43ba1246@users.sourceforge.net>
References: <3c65eb92-8be0-be42-bf8e-893f3853df12@users.sourceforge.net>
 <alpine.DEB.2.20.1611152248150.2060@hadrien>
 <32639cf9-b644-0230-02a6-88d66925340e@users.sourceforge.net>
 <alpine.DEB.2.10.1611161152570.3153@hadrien>
 <6810eb15-839c-8aa5-6485-401d43ba1246@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1611161350550.3153@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 16 Nov 2016, SF Markus Elfring wrote:

> > In a script rule, the metavariable declarations are interpreted by Coccinelle,
> > not the scripting language, so an include would not be allowed there.
>
> This detail was clear for me in principle.
>
>
> > Script rules also don't have constraints on metavariables anyway,
>
> Can other SmPL rule types specify constraints in the code form of a
> regular expression or a programming language script?

At the moment, the specification of constraints is not very uniform across
the different metavariable types.  We are working on improving this.

> > so I'm not sure what you are asking about.
>
> I am looking for ways to avoid source code duplication by inclusion of
> other files.
> Would it make sense to allow the use of an include statement within the
> SmPL variable definition block of a rule?

I have the impression that what you want would be adequately implemented
by a virtual identifier that could be tested in the code or by a virtual
rule.  For example, the semantic patches in the Linux kernel provide
alternate implementations depending on whether one uses the arguments -D
patch, -D context, etc.

julia
