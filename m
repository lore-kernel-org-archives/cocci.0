From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 19 Jun 2014 18:49:19 +0200 (CEST)
Subject: [Cocci] [PATCH] Coccinelle: Script to drop parenthesis in the
 return statements
In-Reply-To: <1403195662.7875.5.camel@joe-AO725>
References: <20140619162954.GA4698@himangi-Dell>
 <1403195662.7875.5.camel@joe-AO725>
Message-ID: <alpine.DEB.2.10.1406191848020.2078@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 19 Jun 2014, Joe Perches wrote:

> On Thu, 2014-06-19 at 21:59 +0530, Himangi Saraogi wrote:
> > This script detects the use of a parenthesis around return value ot the
> > return statements and removes them as they are unnecessary and against
> > the CodingStyle. A new directory called checkpatch is added for semantic
> > patches that just make patches for what checkpatch does. This will help
> > developers having checkpatch problems, to run the semantic patches in this
> > directory on their code and fix some of them automatically.
>
> checkpatch already has --fix and --fix-inplace options that
> do something similar.

OK.  Then it is not worth adding coccinelle scripts for simple changes
like this one.

I guess that some of the more complex changes, like choosing an
appropriate error message function, checkpatch does not do?

julia
