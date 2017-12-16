From: joe@perches.com (Joe Perches)
Date: Sat, 16 Dec 2017 10:02:33 -0800
Subject: [Cocci] [PATCH v2 0/5] Support for generalized use of make C={1,
 2} via a wrapper program
In-Reply-To: <20171216094745.5e41ac51@xeon-e3>
References: <cover.630ac8faeeda67bf7a778c158174422042942d08.1513430008.git-series.knut.omang@oracle.com>
 <20171216094745.5e41ac51@xeon-e3>
Message-ID: <1513447353.4647.39.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 2017-12-16 at 09:47 -0800, Stephen Hemminger wrote:
> On Sat, 16 Dec 2017 15:42:25 +0100
> Knut Omang <knut.omang@oracle.com> wrote:
> 
> > This patch series implements features to make it easier to run checkers on the
> > entire kernel as part of automatic and developer testing.
> > 
> > This is done by replacing the sparse specific setup for the C={1,2} variable
> > in the makefiles with setup for running scripts/runchecks, a new program that
> > can run any number of different "checkers". The behaviour of runchecks is
> > defined by simple "global" configuration in scripts/runchecks.cfg which can be
> > extended by local configuration applying to individual files, directories or
> > subtrees in the source.
[]
> I like the ability to add more checkers and keep then in the main
> upstream tree. But adding overrides for specific subsystems goes against
> the policy that all subsystems should be treated equally.
> 
> There was discussion at Kernel Summit about how the different
> subsystems already have different rules. This appears to be a
> way to make that worse.

I think that's OK and somewhat reasonable.

What is perhaps unreasonable is requiring subsystems with
a local specific style to change to some universal style.

see comments like:

https://lkml.org/lkml/2017/12/11/689
