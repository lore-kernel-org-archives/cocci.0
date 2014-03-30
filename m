From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 30 Mar 2014 14:36:14 +0200 (CEST)
Subject: [Cocci] Improvements for source code analysis with inclusion of
 header files
In-Reply-To: <53380F07.9020500@users.sourceforge.net>
References: <5338004F.3090303@users.sourceforge.net>
 <alpine.DEB.2.10.1403301354280.2092@hadrien>
 <53380A7D.9060005@users.sourceforge.net>
 <alpine.DEB.2.10.1403301425110.2092@hadrien>
 <53380F07.9020500@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1403301434580.2092@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 30 Mar 2014, SF Markus Elfring wrote:

> > Not sure what more documentation one would want.
>
> I would find a clarification nice for details like the following.
>
> 1. Which "C files" are referenced here?

The ones Coccinelle was asked to work on.

> 2. File formats for the cache

Doesn't matter to the user.

> 3. Explanation for abstract syntax trees in this context

Likewise.

The cache is something that Coccinelle writes into and reads out of.  Only
Coccinelle cares what that format is.

julia
