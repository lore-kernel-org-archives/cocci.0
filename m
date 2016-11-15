From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 Nov 2016 22:50:34 +0100 (CET)
Subject: [Cocci] SmPL script construction with several initialisation
 parts
In-Reply-To: <4633253e-3d59-edef-5778-b6f235fb9340@users.sourceforge.net>
References: <4633253e-3d59-edef-5778-b6f235fb9340@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1611152250050.2060@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 15 Nov 2016, SF Markus Elfring wrote:

> Hello,
>
> The semantic patch language supports also extra data processing by
> initialisation scripts.
> http://coccinelle.lip6.fr/docs/main_grammar003.html
>
> Can such initialisation code be constructed by the specification of several
> script parts there?

I don't understand the question.  If the script language supports
includes, then you can put includes in the script code.

julia
