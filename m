From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 Apr 2014 07:22:58 +0200 (CEST)
Subject: [Cocci] Road map after Coccinelle 1.0.0-rc21?
In-Reply-To: <534C10AD.1080806@users.sourceforge.net>
References: <alpine.DEB.2.10.1404141356250.2601@hadrien>
 <534BDDD6.9070407@users.sourceforge.net>
 <alpine.DEB.2.10.1404141525370.2572@hadrien>
 <534BE66B.8060907@users.sourceforge.net>
 <alpine.DEB.2.10.1404141622020.2591@hadrien>
 <534BF121.40607@users.sourceforge.net>
 <alpine.DEB.2.10.1404141634180.2591@hadrien>
 <534BF3B3.90007@users.sourceforge.net>
 <alpine.DEB.2.10.1404141725420.2572@hadrien>
 <534C10AD.1080806@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1404150721500.2083@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 14 Apr 2014, SF Markus Elfring wrote:

> >> Did you eventually reproduce exceptions from the handling of a bit smaller
> >> alternation in a SmPL constraint once more?
> >
> > Yes, I believe so.
>
> How are the chances to get the filter pattern to work which was created with an
> alternation of 893 function names?

I have already stated that this is not a priority.  First, it is not a
reasonable use of Cocinelle.  Second, the problem is likely not in
Coccinelle but in the regular expression library that is being used.  If
you want that fixed, you can contact the maintainers of that library.

> Would you like to reduce the corresponding list of 217 failure situations around
> the message 'EXN:Invalid_argument("equal: abstract value")'?

This I will try to address.

julia
