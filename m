From: knut.omang@oracle.com (Knut Omang)
Date: Sat, 16 Dec 2017 17:27:14 +0100
Subject: [Cocci] [PATCH v2 0/5] Support for generalized use of make C={1,
 2} via a wrapper program
In-Reply-To: <1513437684.4647.30.camel@perches.com>
References: <cover.630ac8faeeda67bf7a778c158174422042942d08.1513430008.git-series.knut.omang@oracle.com>
 <1513437684.4647.30.camel@perches.com>
Message-ID: <1513441634.31439.34.camel@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 2017-12-16 at 07:21 -0800, Joe Perches wrote:
> On Sat, 2017-12-16 at 15:42 +0100, Knut Omang wrote:
> > This patch series implements features to make it easier to run checkers on the
> > entire kernel as part of automatic and developer testing.
> 
> This seems like a useful and reasonable series, thanks.

thanks, appreciated,

> Do please take Julia's grammar updates.

will do,

> How is this series to be applied?

I am open for suggestions.

Let's leave patch #3 out for now.

It's safe to apply #1 (and #2) alone.

Patches #4 and #5 only have value once patch #1 is accepted,
and I included them in the set for documentation purposes.

They don't break anything by getting into the RDMA or RDS subsystem 
without patch #1, alternatively they can go together with the set of cleanup patches I
have prepared for each of RDMA and RDS after #1 is in.

Thanks,
Knut
