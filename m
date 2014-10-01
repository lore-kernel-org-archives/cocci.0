From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 1 Oct 2014 15:26:07 +0200 (CEST)
Subject: [Cocci] string parameter concatenation
In-Reply-To: <542BFFEA.4020309@users.sourceforge.net>
References: <20141001130215.GB4701@rei.suse.cz>
 <alpine.DEB.2.10.1410011504340.2489@hadrien>
 <542BFFEA.4020309@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1410011525570.2489@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 1 Oct 2014, SF Markus Elfring wrote:

> > String made up of multiple concatenated strings are perhaps not so well supported.
> > I don't think that automatic concatenation would be a good idea,
> > because some users might not want it.
>
> Does the semantic patch language support to find source code places where values
> are constructed out of several substrings?

No.

julia

> How much do other string layouts matter in coding styles?
>
> Regards,
> Markus
>
