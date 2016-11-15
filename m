From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 Nov 2016 22:49:15 +0100 (CET)
Subject: [Cocci] SmPL script construction with included files
In-Reply-To: <3c65eb92-8be0-be42-bf8e-893f3853df12@users.sourceforge.net>
References: <3c65eb92-8be0-be42-bf8e-893f3853df12@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1611152248150.2060@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 15 Nov 2016, SF Markus Elfring wrote:

> Hello,
>
> The semantic patch language supports also the inclusion of external files.
> http://coccinelle.lip6.fr/docs/main_grammar001.html
>
> * Does syntax matter for this SmPL statement?
>
> * Can SmPL rules be constructed from smaller parts by it?

I don't understand what it would mean for syntax to or not to matter.  The
main issue seems to be that the includes can only appear before the normal
SmPL rules.

julia
