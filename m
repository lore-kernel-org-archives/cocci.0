From: elena.reshetova@intel.com (Reshetova, Elena)
Date: Tue, 29 Aug 2017 10:57:07 +0000
Subject: [Cocci] [PATCH v3] provide rule for finding refcounters
In-Reply-To: <alpine.DEB.2.20.1708291121480.2398@hadrien>
References: <1502884342-10702-1-git-send-email-elena.reshetova@intel.com>
 <alpine.DEB.2.20.1708161609050.3169@hadrien>
 <2236FBA76BA1254E88B949DDB74E612B6FF5F9AD@IRSMSX102.ger.corp.intel.com>
 <alpine.DEB.2.20.1708291121480.2398@hadrien>
Message-ID: <2236FBA76BA1254E88B949DDB74E612B6FF5FA49@IRSMSX102.ger.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> On Tue, 29 Aug 2017, Reshetova, Elena wrote:
> 
> > Hi, I am very sorry for the delayed reply. Finally unrigging my inbox :(
> >
> > > A few more small issues:
> > >
> > > When you deleted the disjunction, you kept the surrounding parentheses.
> > > you can drop them (lines 83 and 85).
> > >
> > > I guess that the "del" regular expression is supposed to be matching
> > > delete.  But it also matches delayed, eg
> > >
> > > net/batman-adv/bridge_loop_avoidance.c:1495:8-27:
> > > atomic_dec_and_test variation before object free at line 1507.
> >
> > Actually the idea is to match them both :) "delete" because it is obvious,
> > "delay", exactly because "queue_delayed_work" (in addition to "queue_work") is a
> common way some
> > structure destruction might be scheduled. It might give false positives, since
> > the queued work might not be related to freeing the object, but at least
> > we don't miss such cases. The issue also that you do want to have "del" pattern
> > since I think some functions are of kind xyz_del() also and I want to catch them as
> well.
> > Of course del then might catch some other non-queue related "delay", but I
> haven't seen that many
> > to consider it a problem.
> >
> > >
> > > In the following result, the lines are at least quite far apart.  I don't
> > > know if there is some way to consider this to be a false positive:
> > >
> > > fs/btrfs/disk-io.c:708:14-33: atomic_dec_and_test
> > > variation before object free at line 775.
> >
> > I actually think this is a valid result. Yes, there are a lot of things happening
> > in between the dec_and_test and actual free on the buffer, but kernel structures
> > can be so complicated that it might legitimately (like in this case) take that long
> > for it to cleanup before the real free can be done.
> 
> OK, if you are happy with the results of the regexps, I think that the
> only remaining improvement was an extra pair of () where there was no
> longer a disjuction.  If you want to send it back, then I can ack it.

Sure, I will fix that extra pair of brackets and resend. Thank you very much!

Best Regards,
Elena.
> 
> julia
> 
> >
> > Best Regards,
> > Elena.
> >
> > >
> > > julia
> > >
> > > On Wed, 16 Aug 2017, Elena Reshetova wrote:
> > >
> > > > changes in v3:
> > > > Removed unnessesary rule 4 conditions pointed by Julia.
> > > >
> > > > changes in v2:
> > > > Following the suggestion from Julia the first rule is split into
> > > > 2. The output does not differ that much between these two versions,
> > > > but rule became more precise.
> > > >
> > > > Elena Reshetova (1):
> > > >   Coccinelle: add atomic_as_refcounter script
> > > >
> > > >  scripts/coccinelle/api/atomic_as_refcounter.cocci | 133
> > > ++++++++++++++++++++++
> > > >  1 file changed, 133 insertions(+)
> > > >  create mode 100644 scripts/coccinelle/api/atomic_as_refcounter.cocci
> > > >
> > > > --
> > > > 2.7.4
> > > >
> > > >
> >
