From: wagi@monom.org (Daniel Wagner)
Date: Fri, 26 Feb 2016 11:40:51 +0100
Subject: [Cocci] Filter out field names
In-Reply-To: <alpine.DEB.2.10.1601211138470.2530@hadrien>
References: <56A0A94A.9070702@monom.org>
 <alpine.DEB.2.10.1601211138470.2530@hadrien>
Message-ID: <56D02BB3.1060501@monom.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

Sorry for the long delay. Got distracted again.

On 01/21/2016 12:02 PM, Julia Lawall wrote:
> An issue that remains is that you assume that the lock field has type
> lock.  A quick grep in the Linux kernel shows that this is not always the
> case.  You can make a virtual identifier for the lock field as well.  A
> more complicated approach would be to have Coccinelle figure out the type
> from the structure type definition.
> 
> A final issue is that my quick grep in the Linux kernel also shows that not
> all locks are in structures.  But then it is less obvious how to connect
> the locks to the protected references.
> 
> And thinking on, it is not always the case that because a structure has a
> lock, that every field has to be accessed under a lock.  So in the end, it
> may be necessary to do something even more clever.  For example,
> if a field is somewhere referenced under a lock, and not referenced under a
> lock in some other place, then perhaps that is more likely to be a real
> problem.  But even that is not 100% certain, because there can be eg an
> initialization phase that is not done concurrently, so no locks are
> actually needed at that point, even though locks are needed elsewhere.

Your analysis is absolutely correct. Automatically annotating is not
really feasibly. At least without a lot of additional hand work.
Especially the more interesting data structure do no have a simple
locking pattern. Instead all access is heavily optimized which makes
writing  generic cocci rules really difficult (impossible?).

I think my idea isn't that simple as I hoped. Well, at least I have
learned something.

thanks a lot for your help,
daniel
