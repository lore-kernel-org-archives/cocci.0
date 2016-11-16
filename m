From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 16 Nov 2016 12:34:09 +0100
Subject: [Cocci] SmPL script construction with included files
In-Reply-To: <alpine.DEB.2.10.1611161152570.3153@hadrien>
References: <3c65eb92-8be0-be42-bf8e-893f3853df12@users.sourceforge.net>
 <alpine.DEB.2.20.1611152248150.2060@hadrien>
 <32639cf9-b644-0230-02a6-88d66925340e@users.sourceforge.net>
 <alpine.DEB.2.10.1611161152570.3153@hadrien>
Message-ID: <6810eb15-839c-8aa5-6485-401d43ba1246@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> In a script rule, the metavariable declarations are interpreted by Coccinelle,
> not the scripting language, so an include would not be allowed there.

This detail was clear for me in principle.


> Script rules also don't have constraints on metavariables anyway,

Can other SmPL rule types specify constraints in the code form of a
regular expression or a programming language script?


> so I'm not sure what you are asking about.

I am looking for ways to avoid source code duplication by inclusion of
other files.
Would it make sense to allow the use of an include statement within the
SmPL variable definition block of a rule?

Regards,
Markus
