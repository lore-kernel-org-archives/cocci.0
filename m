From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 17 Nov 2016 08:50:12 +0100
Subject: [Cocci] Further developments around function callbacks for SmPL
 metavariables?
In-Reply-To: <alpine.DEB.2.10.1611161514250.3153@hadrien>
References: <3c65eb92-8be0-be42-bf8e-893f3853df12@users.sourceforge.net>
 <alpine.DEB.2.20.1611152248150.2060@hadrien>
 <32639cf9-b644-0230-02a6-88d66925340e@users.sourceforge.net>
 <alpine.DEB.2.10.1611161152570.3153@hadrien>
 <6810eb15-839c-8aa5-6485-401d43ba1246@users.sourceforge.net>
 <alpine.DEB.2.10.1611161350550.3153@hadrien>
 <69c3643e-10b4-007a-f847-d0098f298e16@users.sourceforge.net>
 <alpine.DEB.2.10.1611161514250.3153@hadrien>
Message-ID: <f7af5d71-eaa9-dda1-33a1-bd00d9e1b75c@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The idea with the script constraints on metavariables feature is that the
> script code there should only contain a function call.

I would like to add another view to this software evolution for
further considerations.
The purpose of such a function call can be interpreted in different ways,
can't it?

1. I get the impression from the word ?constraint? that something should
   be restricted. Does this aspect mean that the functionality is finally
   mapped to a predicate?

2. Can it be also used as a data generator or content provider for any other
   non-boolean value?

Regards,
Markus
