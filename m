From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 09 May 2015 10:40:54 +0200
Subject: [Cocci] Source code analysis around "switch"
In-Reply-To: <20150509082804.GA13329@opentech.at>
References: <BAY181-W739E92CD2131317A21ED42B8DF0@phx.gbl>
 <20150509074740.GB9628@opentech.at> <554DC0FA.4010904@users.sourceforge.net>
 <20150509082804.GA13329@opentech.at>
Message-ID: <554DC816.5060107@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> hascase has a position variable in it and only if
> that rule applied is the python script executed - and if there
> was a default then hasdefault matched and so the python script
> will not be executed when hasdefault matched

Do the source code positions matter also for your second SmPL rule?


> => only switch statements with no default are reported.

Do the concrete statements fit really together?


> Atleast it sems to work for me

I guess that there are further reviews needed.


> - but as noted there well may be a better solution
> and maybe its even incomplete

That is usual.


> - but I do not see that its a missing positional variable here.

I suggest to reconsider this opinion.
Do you need to establish safer relationships for the desired checks?

Regards,
Markus
