From: joe@perches.com (Joe Perches)
Date: Wed, 20 Apr 2016 00:25:34 -0700
Subject: [Cocci] coccinelle: bool if (foo) return true; else return false;
In-Reply-To: <57172D78.707@redhat.com>
References: <1460828078-5224-1-git-send-email-dave@stgolabs.net>
 <1460833453.19090.79.camel@perches.com>
 <1460836099.19090.82.camel@perches.com>
 <alpine.DEB.2.02.1604170743060.2068@localhost6.localdomain6>
 <1460881671.19090.90.camel@perches.com>
 <alpine.DEB.2.02.1604171337450.2034@localhost6.localdomain6>
 <1460908959.19090.95.camel@perches.com>
 <alpine.DEB.2.02.1604171944500.2004@localhost6.localdomain6>
 <1460915801.19090.100.camel@perches.com>
 <alpine.DEB.2.02.1604172001410.2004@localhost6.localdomain6>
 <1461093152.1917.26.camel@perches.com>
 <alpine.DEB.2.02.1604192115300.2054@localhost6.localdomain6>
 <57172D78.707@redhat.com>
Message-ID: <1461137134.1917.48.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 2016-04-20 at 09:19 +0200, Michael Stefaniuc wrote:
> On 04/19/2016 09:15 PM, Julia Lawall wrote:
> > On Tue, 19 Apr 2016, Joe Perches wrote:
> > > There's ~150 of these in the kernel.
> > > 
> > > Maybe there's use for this conversion to be added
> > > to scripts/coccinelle/misc/boolreturn.cocci or in
> > > a separate file.
> > > 
> > > $ cat booltruefalse.cocci
> > > @@
> > > identifier fn;
> > > expression e;
> > > typedef bool;
> > > symbol true;
> > > symbol false;
> > > @@
> > > 
> > > bool fn ( ... )
> > > {
> > > <...
> > > -	if (e) return true; else return false;
> > > +	return e;
> Shouldn't that be:
> ????return !!e
> ?

No, it's not necessary.
The compiler does that because the return type is bool

6.3.1.2 Boolean type

When any scalar value is converted to _Bool, the result is 0 if the value compares equal
to 0; otherwise, the result is 1.
