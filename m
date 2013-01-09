From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 9 Jan 2013 20:45:12 +0100
Subject: [Cocci] Matching outside of blocks
In-Reply-To: <alpine.DEB.2.02.1301091811250.2053@localhost6.localdomain6>
References: <20130109123454.GA29477@avionic-0098.adnet.avionic-design.de>
 <CA+MoWDpyz1+mWF-DCqgnY-b4ksgreyK9EMu0U21j95U9aKj7kA@mail.gmail.com>
 <alpine.DEB.2.02.1301091811250.2053@localhost6.localdomain6>
Message-ID: <20130109194512.GB11410@avionic-0098.adnet.avionic-design.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jan 09, 2013 at 06:23:23PM +0100, Julia Lawall wrote:
> > I made some changes for patch mode:
> > @@
> > expression e;
> > @@
> > 
> > e = devm_request_and_ioremap(...);
> > ...
> > if
> > -(e == NULL)
> > +(IS_ERR(e))
> 
> Actually, a slightly more defensive thing to do is
> 
> if (
> -   e == NULL
> +   IS_ERR(e)
>  || ...)
> 
> This will allow the null test to be anywhere in a toplevel ||, ie
> 
>    !e || x    x || !e   a || b || !e   a || !e || b

Okay, I'll roll that into the semantic patch. I haven't seen any
occurrence where the check is used in a composite condition, but you
never know.

> > {
> > <...
> > -       return ...;
> > +       return PTR_ERR(e);
> > ...>
> > }
> 
> I started typing a long explanation as to why this was not a good idea, 
> but now I realize that actually it is a good idea.  If you put
> 
> if (e == NULL) {
>   ...
>   return ...;
> }
> 
> then the ... above the return will jump over gotos.  For pattern matching 
> (ie report mode) this is probably what you want.  But for actual patching, 
> this is not what you want at all.  Functions that use devm functions often 
> use gotos for their error handling, so there is just one return at the end 
> of the function that is shared by everyone.  You certainly don't want to 
> turn this into a call to PTR_ERR.  By using <... ...> you stay within the 
> simple case where the return is right up between the braces of the if 
> header.
> 
> On the other hand there are probably a lot of cases that you could 
> transform automatically that you are missing.  The common thing to do is 
> say ret = -EXXX for some XXX, where ret is later returned.  Probably what 
> you would like to do is:
> 
> if (e == NULL) {  // fill in the modification on the test
>   ... when any
> - ret = E;
> + ret = PTR_ERR(e);
>   ...
>   return ret;
> }
> 
> This should be put in a separate rule after the one with the <... ...>.

I've currently only tested this on a few driver subdirectories to check
that it generally works, but yes, something like the above could be
useful to match more cases.

While we're at it, I was going to follow up with another semantic patch
to remove error messages in the devm_request_and_ioremap() errors paths
because the function outputs an error message itself already. In many
cases this results in an if block becoming a single line, so CodingStyle
requires the { } to be removed. Is there any way to do that
automatically?

> When any allows there to be any assignment before ret = E.  What you are 
> interested in is the last assignment, in particular the last assignment of 
> the value that is returned.  Not putting anything on the ... at the end 
> will give you this shortest path property.  If you are really worried 
> about gotos, you could also put when != goto l; where l is an identifier 
> metavariable on the first ...  But I think that the chance of a problem 
> there is minimal.

Thanks for explaining this. I had been wondering about "when any". I'm
very new to coccinelle so there's still a lot to learn.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130109/38be7c1d/attachment.asc>
