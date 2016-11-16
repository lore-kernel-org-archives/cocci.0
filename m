From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 16 Nov 2016 15:30:23 +0100
Subject: [Cocci] SmPL script construction with included files
In-Reply-To: <alpine.DEB.2.10.1611161514250.3153@hadrien>
References: <3c65eb92-8be0-be42-bf8e-893f3853df12@users.sourceforge.net>
 <alpine.DEB.2.20.1611152248150.2060@hadrien>
 <32639cf9-b644-0230-02a6-88d66925340e@users.sourceforge.net>
 <alpine.DEB.2.10.1611161152570.3153@hadrien>
 <6810eb15-839c-8aa5-6485-401d43ba1246@users.sourceforge.net>
 <alpine.DEB.2.10.1611161350550.3153@hadrien>
 <69c3643e-10b4-007a-f847-d0098f298e16@users.sourceforge.net>
 <alpine.DEB.2.10.1611161514250.3153@hadrien>
Message-ID: <c602b832-7f8c-cf18-6b13-35167b5cb152@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>
> The idea with the script constraints on metavariables feature is that the
> script code there should only contain a function call.  The actual
> function definition should be elsewhere; probably in an initialize rule.

This information can be reasonable to some degree.

How will the software situation evolve if each script constraint will
need another bit of initialisation code?
Can it become an interesting software development challenge then if the
constraint specification approach should be switchable for a few of them
by a corresponding make script?

Regards,
Markus
