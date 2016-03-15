From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 15 Mar 2016 06:54:42 +0100 (CET)
Subject: [Cocci] coccinelle: generalized removal of unnecessary pointer
	casts?
In-Reply-To: <1457994238.11972.138.camel@perches.com>
References: <1457981670.11972.114.camel@perches.com>
 <alpine.DEB.2.02.1603142136490.2040@localhost6.localdomain6>
 <1457994238.11972.138.camel@perches.com>
Message-ID: <alpine.DEB.2.02.1603150653100.2071@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 14 Mar 2016, Joe Perches wrote:

> On Mon, 2016-03-14 at 21:43 +0100, Julia Lawall wrote:
> > On Mon, 14 Mar 2016, Joe Perches wrote:
> > > I wrote a little cocci script to remove unnecessary
> > > casts for memset and memcpy (below) and tested it on
> > > linux kernel's drivers/staging/ directory.
> > >?
> > > For instance, when dst and src are already pointers:
> > >?
> > > -?????memcpy((u8 *)dst, (u8 *)src, r8712_get_wlan_bssid_ex_sz(src));
> > > +?????memcpy(dst, src, r8712_get_wlan_bssid_ex_sz(src));
> > >?
> > > It works ok, (it doesn't remove unnecessary parentheses
> > > around the pointers) but it makes me wonder if there's a
> > > generalized spatch mechanism to remove casts when an
> > > arbitrary function takes a void * in any argument
> > > position and a call to that function uses a cast of a
> > > pointer to any pointer type for that argument.
> > >?
> > > $ cat remove_mem_casts.cocci?
> > > @@
> > > type t;
> > > t *p;
> > > type v;
> > > expression e1;
> > > expression e2;
> > > @@
> > >?
> > > -?????memset((v*)p, e1, e2)
> > > +?????memset(p, e1, e2)
> > >?
> > > @@
> > > type t;
> > > t *p;
> > > type v;
> > > expression e1;
> > > expression e2;
> > > @@
> > >?
> > > -?????memcpy((v*)p, e1, e2)
> > > +?????memcpy(p, e1, e2)
> > >?
> > > @@
> > > type t;
> > > t *p;
> > > type v;
> > > expression e1;
> > > expression e2;
> > > @@
> > >?
> > > -?????memcpy(e1, (v*)p, e2)
> > > +?????memcpy(e1, p, e2)
> > >?
> > > @@
> > > type t1;
> > > type t2;
> > > t1 *p1;
> > > t2 *p2;
> > > type v1;
> > > type v2;
> > > expression e1;
> > > @@
> > >?
> > > -?????memcpy((v1*)p1, (v2*)p2, e1)
> > > +?????memcpy(p1, p2, e1)
> > 
> > This should do everything:
> > 
> > @@
> > identifier f;
> > expression *e;
> > type T;
> > @@
> > 
> > f(...,
> > - (T *)(
> > ? e
> > - )
> > ? ,...)
> > 
> > @@
> > identifier f;
> > expression *e;
> > type T;
> > @@
> > 
> > f(...,
> > - (T *)
> > ? e
> > ? ,...)
> > 
> > julia
> 
> Hi Julia,
> 
> I think your proposed script is not correct.
> The function must take a void * argument.
> There's no validation of that here.

OK, that could be added, but I wonder why it is necessary?  Isn't one 
pointer type just as good as any other, since the value will just get 
casted to the pointer type of the parameter in the end anyway?

julia
