From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 Nov 2016 11:55:39 +0100 (CET)
Subject: [Cocci] SmPL script construction with included files
In-Reply-To: <32639cf9-b644-0230-02a6-88d66925340e@users.sourceforge.net>
References: <3c65eb92-8be0-be42-bf8e-893f3853df12@users.sourceforge.net>
 <alpine.DEB.2.20.1611152248150.2060@hadrien>
 <32639cf9-b644-0230-02a6-88d66925340e@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1611161152570.3153@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 16 Nov 2016, SF Markus Elfring wrote:

> > I don't understand what it would mean for syntax to or not to matter.
>
> I am checking if the mentioned SmPL statement could be used just for the
> inclusion of a bit of code for a metavariable constraint within a script
> template.

In a script rule, the metavariable declarations are interpreted by
Coccinelle, not the scripting language, so an include would not be allowed
there.

Script rules also don't have constraints on metavariables anyway, so I'm
not sure what you are asking about.

julia
