From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 9 Feb 2016 13:55:30 +0100
Subject: [Cocci] coccinelle: add style check for assignment in if
In-Reply-To: <alpine.DEB.2.10.1602091016200.2578@hadrien>
References: <1454935571-4054-1-git-send-email-kborer@gmail.com>
 <56B9A2F6.4040109@users.sourceforge.net>
 <alpine.DEB.2.10.1602091016200.2578@hadrien>
Message-ID: <56B9E1C2.7070008@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Would you like to consider also the reuse of SmPL variables
>> like "org" and "report"?
> 
> I think that there is no point for these things, because checkpatch
> already gives warnings about this issue.

Can the check result display be more convenient from the semantic
patch script interface in comparison to the other tool?

Regards,
Markus
