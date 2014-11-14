From: joe@perches.com (Joe Perches)
Date: Fri, 14 Nov 2014 08:22:02 -0800
Subject: [Cocci] spatch for trivial pointer comparison style?
In-Reply-To: <alpine.DEB.2.10.1411140938400.2443@hadrien>
References: <1415908529.4223.11.camel@perches.com>
 <alpine.DEB.2.02.1411140700010.2035@localhost6.localdomain6>
 <1415945558.5912.10.camel@perches.com>
 <alpine.DEB.2.10.1411140938400.2443@hadrien>
Message-ID: <1415982122.5912.14.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2014-11-14 at 10:18 +0100, Julia Lawall wrote:
> On Thu, 13 Nov 2014, Joe Perches wrote:
[]
> > Yes, I agree with some of the things Al Viro said
> > there, but isn't 'type t; t *p;' a subset of
> > "expression *e"?

> No.  How would you expect it to be different.

[]

>   type t means that the type
> is known.  expression *e means that there is a * in the type.

I had thought "expression *" could be r-value and
"type t; t *p;" could be l-value.

But then I don't find (or maybe don't parse too well)
the coccinelle documentation that specifies these
type relationships.

cheers, Joe
