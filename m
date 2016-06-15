From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 15 Jun 2016 18:02:24 +0200
Subject: [Cocci] [PATCH 2/4] scripts: add reqs python library
In-Reply-To: <576108B3.30008@suse.com>
References: <1465942217-14452-1-git-send-email-mcgrof@kernel.org>
 <1465942217-14452-3-git-send-email-mcgrof@kernel.org>
 <576108B3.30008@suse.com>
Message-ID: <20160615160224.GP11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jun 15, 2016 at 09:50:11AM +0200, Michal Marek wrote:
> On 2016-06-15 00:10, Luis R. Rodriguez wrote:
> > +        weight = (int(rel_specs['VERSION'])    << 32) + \
> > +                 (int(rel_specs['PATCHLEVEL']) << 16) + \
> > +                 (sublevel   		       << 8 ) + \
> > +                 (extra * 60) + (relmod * 2)
> 
> This is going to silently break as soon as we have a version number with
> e.g. a time stamp embedded. 

Well this is adhering to a linux_version_cmp type, surely we can adjust
it with alternatives. It just happens that with the common stuff this
suffices.

Do you have a specific string in mind I can use to test against?

> And there is actually no need to convert the
> version string to an integer. You can convert them to arrays of
> components and compare the components one by one.

You can, however weight is used to as a generic formula to determine
in one shot if you have a release >= than what is required. Its inspired
by how KERNEL_VERSION() is used:

#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))

  Luis
