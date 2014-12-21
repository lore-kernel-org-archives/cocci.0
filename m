From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 21 Dec 2014 11:51:16 +0100
Subject: [Cocci] how to debug missing match?
In-Reply-To: <alpine.DEB.2.02.1412211138100.2068@localhost6.localdomain6>
References: <20141221095337.GA1081@katana> <20141221102055.GB1081@katana>
 <alpine.DEB.2.02.1412211138100.2068@localhost6.localdomain6>
Message-ID: <20141221105116.GC1081@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, Dec 21, 2014 at 11:39:14AM +0100, Julia Lawall wrote:
> On Sun, 21 Dec 2014, Wolfram Sang wrote:
> 
> > 
> > > does not result in anything although three drivers should match IMO with
> > > the same pattern as the pmu driver above. Both use
> > > platform_driver_register() and both have the .owner field set.
> > > 
> > > drivers/macintosh/windfarm_pm112.c
> > > drivers/macintosh/windfarm_pm72.c
> > > drivers/macintosh/windfarm_rm31.c
> > > 
> > > How can I debug why the match does not occur?
> > 
> > So, I found "--verbose-parsing" to be helpful which gives me:
> > 
> > parse error 
> >  = File "drivers/macintosh/windfarm_pm112.c", line 685, column 4, charpos = 17702
> >     around = 'nr_cores', whole content = 		++nr_cores;
> > 
> > which basically means that it can't handle for_each_node_by_type()?
> > 
> > bad: 	for_each_node_by_type(cpu, "cpu")
> > BAD:!!!!! 		++nr_cores;
> > 
> > But neither "--include include/linux/of.h" nor "--recursive-includes"
> > does help the case for me?
> 
> It is not surprising that adding more includes doesn't help.  But I would 
> have thought that for_each_node_by_type, as it begins with for, would be 
> something that it would pick up on.  I will take a look.

How does coccinelle work with such constructs? I'd think that replacing
that #define with the actual for()-construct is much more reliable than
an assumption like "it starts with 'for' so it is probably...' :)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141221/81a1a83a/attachment.asc>
