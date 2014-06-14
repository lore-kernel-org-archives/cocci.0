From: joe@perches.com (Joe Perches)
Date: Sat, 14 Jun 2014 10:01:54 -0700
Subject: [Cocci] [PATCH] Coccinelle : Script to detect cast after memory
 allocation
In-Reply-To: <alpine.DEB.2.02.1406141809050.1962@localhost6.localdomain6>
References: <20140614154541.GA4179@himangi-Dell>
 <1402761961.2756.12.camel@joe-AO725>
 <alpine.DEB.2.02.1406141809050.1962@localhost6.localdomain6>
Message-ID: <1402765314.2756.20.camel@joe-AO725>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 2014-06-14 at 18:11 +0200, Julia Lawall wrote:
> On Sat, 14 Jun 2014, Joe Perches wrote:
[]
> > Perhaps make this more generic for any void *?
> > 
> > Something like:
> > 
> > @@
> > void *t;
> > type other;
> > @@
> > 
> > -       (other *)t
> > +       t
[]
> Perhaps it would be reasonable to add this among the specific functions.  
> That is, t could be part of the disjunctions.

You do have to make sure that the
"casted to" type is not dereferenced.

ie: don't transform

void func(void *foo)
{
	unsigned long bar = *(unsigned long *)foo;
}

Also there may be some __user cast types and
such that may be necessary to exclude too.
