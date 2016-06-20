From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 20 Jun 2016 22:21:34 +0200 (CEST)
Subject: [Cocci] [PATCH v2 1/3] coccinelle: also catch kzfree() issues
In-Reply-To: <5767EE79.5090402@suse.com>
References: <cover.1464013817.git.ydroneaud@opteya.com>
 <d3466c47b1c5bbf9a7c4cb69a78d392327748669.1464013817.git.ydroneaud@opteya.com>
 <alpine.DEB.2.10.1605231717290.12010@hadrien> <5767EE79.5090402@suse.com>
Message-ID: <alpine.DEB.2.02.1606202220520.2067@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 20 Jun 2016, Michal Marek wrote:

> On 2016-05-23 17:18, Julia Lawall wrote:
> > 
> > 
> > On Mon, 23 May 2016, Yann Droneaud wrote:
> > 
> >> Since commit 3ef0e5ba4673 ('slab: introduce kzfree()'),
> >> kfree() is no more the only function to be considered:
> >> kzfree() should be recognized too.
> >>
> >> In particular, kzfree() must not be called on memory
> >> allocated through devm_*() functions.
> >>
> >> Cc: Johannes Weiner <hannes@cmpxchg.org>
> >> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> > 
> > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> 
> Hi Julia,
> 
> does your ACK apply to the other two patches as well?

Sorry, I seem to have missed the other two.  I have reviewed them now, and 
the ack applies to all three.  Thanks for checking on it.

julia
