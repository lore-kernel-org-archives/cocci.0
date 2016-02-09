From: joe@perches.com (Joe Perches)
Date: Tue, 09 Feb 2016 15:56:47 -0800
Subject: [Cocci] coccinelle: add style check for assignment in if
In-Reply-To: <56B9E1C2.7070008@users.sourceforge.net>
References: <1454935571-4054-1-git-send-email-kborer@gmail.com>
 <56B9A2F6.4040109@users.sourceforge.net>
 <alpine.DEB.2.10.1602091016200.2578@hadrien>
 <56B9E1C2.7070008@users.sourceforge.net>
Message-ID: <1455062207.3333.6.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 2016-02-09 at 13:55 +0100, SF Markus Elfring wrote:
> > > Would you like to consider also the reuse of SmPL variables
> > > like "org" and "report"?
> > 
> > I think that there is no point for these things, because checkpatch
> > already gives warnings about this issue.
> 
> Can the check result display be more convenient from the semantic
> patch script interface in comparison to the other tool?

-ENOPARSE. ?More detail please.
