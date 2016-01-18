From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 18 Jan 2016 21:25:22 +0100
Subject: [Cocci] Documentation check for parallelisation support?
In-Reply-To: <alpine.DEB.2.10.1601181138430.2520@hadrien>
References: <alpine.DEB.2.02.1601170938000.2026@localhost6.localdomain6>
 <569CBA51.2040303@users.sourceforge.net>
 <alpine.DEB.2.10.1601181112390.2520@hadrien>
 <569CBEB7.1030509@users.sourceforge.net>
 <alpine.DEB.2.10.1601181138430.2520@hadrien>
Message-ID: <569D4A32.6030909@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Will this aspect need further considerations because of the evolving
>> parallelisation support?
>> https://github.com/coccinelle/coccinelle/issues/50
> 
> I believe that parallelism with -j only fails if there is a finalize.
> An initialize by itself should be OK.

Does the corresponding wording need another update in the SmPL manual?
https://github.com/coccinelle/coccinelle/blob/246fb87e74e448b46749601a25fa019925b07e43/docs/manual/spatch_options.tex#L678

Regards,
Markus
