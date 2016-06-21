From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 21 Jun 2016 22:13:31 +0200 (CEST)
Subject: [Cocci] [PATCH v3 0/8] coccicheck: modernize
In-Reply-To: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
Message-ID: <alpine.DEB.2.02.1606212211210.2040@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 21 Jun 2016, Luis R. Rodriguez wrote:

> This v3 series addresses the feedback from the last v2 series
> on the coccicheck enhancements [0], namely:
> 
> o it drops the indexing heuristics in favor for a .cocciconfig use
> o drops glimpse support as its simply not well maintained, recommends
>   idutils instead.
> o adds a Linux .cocciconfig -- the assumption is you'd run spatch when
>   you're at the top level of the kernel. This has not only the side effect
>   of picking up .cocciconfig, but also that the coccicheck use of the
>   make variables passed on are assumed to be correct given the base
>   directory as the current directory.

I don't understand this point.  Coccinelle picks up the .cocciconfig, if 
any, of the directory on which you want to work, not of the current one.

julia

> o makes SPFLAGS more useful by ensuring it is always at the end of options
> o rebases on top of Deepa Dinamani's patch
>   "coccicheck: Allow for overriding spatch flags", under the assumption this
>   is already merged. I don't see it on linux-next but I do think Michal
>   has merged already onto his tree. This is also rebased on to linux-next
>   next-20160621
> 
> These changes are also visible on kernel.org, on a branch based on linux-next
> next-20160621 with Deepa's commit merged first.
> 
> [0] http://lkml.kernel.org/r/1466116292-21843-1-git-send-email-mcgrof at kernel.org
> [1] https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux-next.git/log/?h=20160621-cocciconfig-v3
> 
> Luis R. Rodriguez (8):
>   coccicheck: move spatch binary check up
>   coccicheck: make SPFLAGS more useful
>   coccicheck: enable parmap support
>   coccicheck: replace --very-quiet with --quit when debugging
>   scripts: add Linux .cocciconfig for coccinelle
>   coccicheck: add support for requring a coccinelle version
>   coccicheck: refer to coccicheck bottest wiki for documentation
>   scripts/coccinelle: require coccinelle >= 1.0.4 on
>     device_node_continue.cocci
> 
>  .cocciconfig                                       |  3 +
>  .gitignore                                         |  1 +
>  scripts/coccicheck                                 | 98 ++++++++++++++++++++--
>  .../iterators/device_node_continue.cocci           |  3 +
>  4 files changed, 96 insertions(+), 9 deletions(-)
>  create mode 100644 .cocciconfig
> 
> -- 
> 2.8.2
> 
> 
