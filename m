From: mmarek@suse.com (Michal Marek)
Date: Thu, 7 Jan 2016 15:37:13 +0100
Subject: [Cocci] [PATCH v7] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <alpine.DEB.2.10.1601071235020.2515@hadrien>
References: <alpine.DEB.2.10.1601051512010.2521@hadrien>
 <1452159411-3216-1-git-send-email-a.hajda@samsung.com>
 <alpine.DEB.2.10.1601071235020.2515@hadrien>
Message-ID: <20160107143713.GA7411@sepie.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Jan 07, 2016 at 12:35:34PM +0100, Julia Lawall wrote:
> 
> On Thu, 7 Jan 2016, Andrzej Hajda wrote:
> 
> > Unsigned expressions cannot be lesser than zero. Presence of comparisons
> > 'unsigned (<|<=|>|>=) 0' often indicates a bug, usually wrong type of variable.
> > The patch beside finding such comparisons tries to eliminate false positives,
> > mainly by bypassing range checks.
> >
> > gcc can detect such comparisons also using -Wtype-limits switch, but it warns
> > also in correct cases, making too much noise.
> >
> > Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> 
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Thanks to both of you, applied to kbuild.git#misc now.

Michal
