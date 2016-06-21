From: ydroneaud@opteya.com (Yann Droneaud)
Date: Tue, 21 Jun 2016 13:14:41 +0200
Subject: [Cocci] [PATCH v2 1/3] coccinelle: also catch kzfree() issues
In-Reply-To: <57690C52.7080207@suse.com>
References: <cover.1464013817.git.ydroneaud@opteya.com>
 <d3466c47b1c5bbf9a7c4cb69a78d392327748669.1464013817.git.ydroneaud@opteya.com>
 <alpine.DEB.2.10.1605231717290.12010@hadrien> <5767EE79.5090402@suse.com>
 <alpine.DEB.2.02.1606202220520.2067@localhost6.localdomain6>
 <57690C52.7080207@suse.com>
Message-ID: <1466507681.30939.14.camel@opteya.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Le mardi 21 juin 2016 ? 11:43 +0200, Michal Marek a ?crit?:
> Dne 20.6.2016 v 22:21 Julia Lawall napsal(a):
> > On Mon, 20 Jun 2016, Michal Marek wrote:
> > On 2016-05-23 17:18, Julia Lawall wrote:
> > > > On Mon, 23 May 2016, Yann Droneaud wrote:
> > > > 
> > > > > Since commit 3ef0e5ba4673 ('slab: introduce kzfree()'),
> > > > > kfree() is no more the only function to be considered:
> > > > > kzfree() should be recognized too.
> > > > > 
> > > > > In particular, kzfree() must not be called on memory
> > > > > allocated through devm_*() functions.
> > > > > 
> > > > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > > > Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> > > > 
> > > > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> > > 
> > > Hi Julia,
> > > 
> > > does your ACK apply to the other two patches as well?
> > 
> > Sorry, I seem to have missed the other two.??I have reviewed them
> > now, and the ack applies to all three.??Thanks for checking on it.
> 

Back in February, those two other patches were already Acked-by:

http://lkml.kernel.org/r/alpine.DEB.2.10.1602161818100.2685 at hadrien
http://lkml.kernel.org/r/alpine.DEB.2.10.1602161819340.2685 at hadrien

I've (re)sent them with added Acked-by:, and thought it would not
require further Acked-by:.

Anyway, this one was new and required proper review. Thanks a lot.

> Np. Applied to kbuild.git#misc now.
> 

Thanks a lot.

--?
Yann Droneaud
OPTEYA
