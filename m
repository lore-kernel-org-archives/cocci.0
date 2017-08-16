From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 Aug 2017 16:16:15 +0200 (CEST)
Subject: [Cocci] [PATCH v3] provide rule for finding refcounters
In-Reply-To: <1502884342-10702-1-git-send-email-elena.reshetova@intel.com>
References: <1502884342-10702-1-git-send-email-elena.reshetova@intel.com>
Message-ID: <alpine.DEB.2.20.1708161609050.3169@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

A few more small issues:

When you deleted the disjunction, you kept the surrounding parentheses.
you can drop them (lines 83 and 85).

I guess that the "del" regular expression is supposed to be matching
delete.  But it also matches delayed, eg

net/batman-adv/bridge_loop_avoidance.c:1495:8-27:
atomic_dec_and_test variation before object free at line 1507.

In the following result, the lines are at least quite far apart.  I don't
know if there is some way to consider this to be a false positive:

fs/btrfs/disk-io.c:708:14-33: atomic_dec_and_test
variation before object free at line 775.

julia

On Wed, 16 Aug 2017, Elena Reshetova wrote:

> changes in v3:
> Removed unnessesary rule 4 conditions pointed by Julia.
>
> changes in v2:
> Following the suggestion from Julia the first rule is split into
> 2. The output does not differ that much between these two versions,
> but rule became more precise.
>
> Elena Reshetova (1):
>   Coccinelle: add atomic_as_refcounter script
>
>  scripts/coccinelle/api/atomic_as_refcounter.cocci | 133 ++++++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 scripts/coccinelle/api/atomic_as_refcounter.cocci
>
> --
> 2.7.4
>
>
