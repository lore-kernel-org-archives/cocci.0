From: knut.omang@oracle.com (Knut Omang)
Date: Mon, 18 Dec 2017 18:05:33 +0100
Subject: [Cocci] [PATCH v2 2/5] Documentation: Add doc for runchecks
In-Reply-To: <9102c188-847a-6a59-5fce-85dfa01ad280@users.sourceforge.net>
References: <7bd67f980fdf33031c54955f7e04b435c267886e.1513430008.git-series.knut.omang@oracle.com>
 <4be59ef0-50a9-83f5-2cf1-f5a34e5810a7@users.sourceforge.net>
 <1513441576.31439.33.camel@oracle.com>
 <9102c188-847a-6a59-5fce-85dfa01ad280@users.sourceforge.net>
Message-ID: <1513616733.31439.188.camel@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 2017-12-18 at 17:23 +0100, SF Markus Elfring wrote:
> > I'll take these in for v3 as well and carefully review myself 
> > for any further errors of the same sorts..
> 
> I suggest to consider a few additional wording adjustments.
> 
> 
> > +``runchecks``. You can for instance use::
> 
> +``runchecks``. You can use for instance::

Will fix.

> * Do you care for the handling of orphaned words in paragraphs?

Will look over it, thanks.

> * Was any consensus achieved already for corresponding names?
> 
>   x Could a longer variable name like ?CHECKING_FLAGS? be easier to remember
>     than the proposed ?CF??

I kept CF as is already established as the flag to use for parameters with C= 

>   x Will the naming style matter (if you compare the approaches ?checkpatch?
>     and ?get_maintainer?)?

No consensus made on the naming, just that I tried using verbatim names from sparse, eg
lowercase-dash vs UPPERCASE_UNDERSCORE as in checkpatch and found the runchecks.cfg and
reporting lines more easy to read using the uppercase variants, and that it looks more
nice to have a uniform output across checkers.

I think that the visual output of a test is important, as even we developers tend to be
more happy with (and willing to execute) programs that produce nice output vs ones with
ugly, cluttery, inconsistent output :-)

Thanks,
Knut

> 
> 
> Regards,
> Markus
