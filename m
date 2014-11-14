From: joe@perches.com (Joe Perches)
Date: Thu, 13 Nov 2014 22:12:38 -0800
Subject: [Cocci] spatch for trivial pointer comparison style?
In-Reply-To: <alpine.DEB.2.02.1411140700010.2035@localhost6.localdomain6>
References: <1415908529.4223.11.camel@perches.com>
 <alpine.DEB.2.02.1411140700010.2035@localhost6.localdomain6>
Message-ID: <1415945558.5912.10.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2014-11-14 at 07:06 +0100, Julia Lawall wrote:
> On Thu, 13 Nov 2014, Joe Perches wrote:
> 
> > I added a checkpatch entry for this.
> > Maybe some cocci test like this would be useful?
> > 
> > @@
> > type t;
> > t *p;
> > @@
> > -	p == NULL
> > +	!p
> > 
> > @@
> > type t;
> > t *p;
> > @@
> > -	p != NULL
> > +	p
> > 
> > @@
> > type t;
> > t *p;
> > @@
> > -	NULL == p
> > +	!p
> > 
> > @@
> > type t;
> > t *p;
> > @@
> > -	NULL != p
> > +	p
> 
> This was discussed many years ago.  I don't think that the change is 
> desirable in all cases.  There are functions like kmalloc where NULL means 
> failure and !p seems like the reasonable choice.  But there maybe other 
> cases where NULL is somehow a meaningful value.  
> 
> Here is a link to the part of the discussion:
> 
> https://lkml.org/lkml/2007/7/27/103

Yes, I agree with some of the things Al Viro said
there, but isn't 'type t; t *p;' a subset of
"expression *e"?
