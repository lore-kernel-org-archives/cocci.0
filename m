From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 30 Mar 2014 14:49:20 +0200 (CEST)
Subject: [Cocci] Improvements for source code analysis with inclusion of
 header files
In-Reply-To: <533811B2.4020109@users.sourceforge.net>
References: <5338004F.3090303@users.sourceforge.net>
 <alpine.DEB.2.10.1403301354280.2092@hadrien>
 <53380A7D.9060005@users.sourceforge.net>
 <alpine.DEB.2.10.1403301425110.2092@hadrien>
 <53380F07.9020500@users.sourceforge.net>
 <alpine.DEB.2.10.1403301434580.2092@hadrien>
 <533811B2.4020109@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1403301445260.2092@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 30 Mar 2014, SF Markus Elfring wrote:

> >> 1. Which "C files" are referenced here?
> >
> > The ones Coccinelle was asked to work on.
>
> Do you distinguish headers from source files in this use case?

No that I recall.

> >> 2. File formats for the cache
> >
> > Doesn't matter to the user.
>
> I guess that such information will become more interesting for other software
> developers, won't it?

I don't think so.  No more than any ordinary user is interested in the
format that a web browser uses for its cache.

In general, a cache has a short lifetime.  The software changes, or one
wants to use Coccinelle with other options, and then one would rather
start over with a new cache.  The cache is mostly useful when one does
iteration.  In that case, I usually limit the size of the cache as well,
because the format is not particularly concise.  This further implies that
it is not useful to anything other than the current run.

julia
