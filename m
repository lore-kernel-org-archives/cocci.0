From: knut.omang@oracle.com (Knut Omang)
Date: Thu, 04 Jan 2018 19:55:25 +0100
Subject: [Cocci] [v3] runchecks: Generalize make C={1,
 2} to support multiple checkers
In-Reply-To: <e585c25f-3488-2177-241b-a0a7815544f4@users.sourceforge.net>
References: <5f292b7effba0efcf4855bff83b7b9313ac45895.1515072782.git-series.knut.omang@oracle.com>
 <e585c25f-3488-2177-241b-a0a7815544f4@users.sourceforge.net>
Message-ID: <1515092125.31439.597.camel@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2018-01-04 at 16:56 +0100, SF Markus Elfring wrote:
> > +Supported syntax of ?
> 
> Did you change the mind since your response ?Good idea, will do? on 2017-12-23?
> https://github.com/torvalds/linux/commit/7bd67f980fdf33031c54955f7e04b435c267886e#r26449
> 420

Sorry - I did consider it but changed my mind when I read through - I do think 
the work "Supported" makes sense here.

> > +The ``line_len`` directive defines the upper bound of characters per line
> > +tolerated in this directory. Currently only ``checkpatch`` supports this
> > +command. ?
> 
> Should such a description be adjusted after you became aware of additional
> documentation details?
> 
> Can it be that any of (my) previous questions and review comments are still
> ?unanswered? with this third documentation approach?

As I commented to you, some of it is a bit more in the class of good enhancements 
so whatever I haven't changed now that resonated with me, I'll pick up later
if the general idea is accepted.

Sorry if this was confusing.

Thanks for all the careful comments and suggestions!

Regards,
Knut

> Regards,
> Markus
