From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 16 Nov 2016 11:48:09 +0100
Subject: [Cocci] SmPL script construction with included files
In-Reply-To: <alpine.DEB.2.20.1611152248150.2060@hadrien>
References: <3c65eb92-8be0-be42-bf8e-893f3853df12@users.sourceforge.net>
 <alpine.DEB.2.20.1611152248150.2060@hadrien>
Message-ID: <32639cf9-b644-0230-02a6-88d66925340e@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I don't understand what it would mean for syntax to or not to matter.

I am checking if the mentioned SmPL statement could be used just for the
inclusion of a bit of code for a metavariable constraint within a script
template.


> The main issue seems to be that the includes can only appear before the normal
> SmPL rules.

I guess that this information means that I need to concatenate pieces by
tools which are external to the semantic patch language in my use case.

Regards,
Markus
