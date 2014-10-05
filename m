From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 05 Oct 2014 18:38:40 +0200
Subject: [Cocci] Searching for pass-through functions
In-Reply-To: <alpine.DEB.2.02.1410051729480.2022@localhost6.localdomain6>
References: <54303340.3090901@users.sourceforge.net>
 <alpine.DEB.2.02.1410042116320.2079@localhost6.localdomain6>
 <54305719.1050304@users.sourceforge.net>
 <alpine.DEB.2.02.1410042331240.2079@localhost6.localdomain6>
 <54312F70.3080809@users.sourceforge.net>
 <alpine.DEB.2.02.1410051347570.2229@localhost6.localdomain6>
 <54313662.8000402@users.sourceforge.net>
 <alpine.DEB.2.02.1410051729480.2022@localhost6.localdomain6>
Message-ID: <54317410.6040605@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I'm not sure what is the goal of your semantic patch.

The shown pattern should not be a patch at this time.   ;-)

I try to find functions by this approach that do not perform validation for a
specific input parameter usually because this parameter will be forwarded as the
return value.


> For example are you only interested in pointers?

No. - But I imagine that pointers will be specified more often in corresponding
function signatures than integral data types.


> Another thing that could be helpful is to check if there exists the 
> pattern you are looking for, before checking whether it is found on all 
> execution paths.  You can use the same rule you have, but with exists in 
> the header, and then have a second rule that checks all paths and depends 
> on the first one.

Would you like to show your fine-tuning suggestion in the affected SmPL script?


> Also, since you just want to find returns, but don't care about what 
> happens in between, you can use arguments like --no-loops and --no-gotos.

Will it matter if the relevant return statement will be executed within a loop
or is also marked with a jump label?


Can the five issues on which I stumbled during the source code analysis be fixed
anyhow (eventually without the addtion of "--no-?" command options)?

Regards,
Markus
