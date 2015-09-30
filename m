From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 30 Sep 2015 23:51:43 +0200 (CEST)
Subject: [Cocci] [PATCH v2] coccinelle: assign signed result to unsigned
 variable
In-Reply-To: <56092BBB.2060006@samsung.com>
References: <alpine.DEB.2.10.1509261106040.2737@hadrien>
 <1443437687-16559-1-git-send-email-a.hajda@samsung.com>
 <alpine.DEB.2.10.1509281332030.3165@hadrien> <56092BBB.2060006@samsung.com>
Message-ID: <alpine.DEB.2.02.1509302351250.1977@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 28 Sep 2015, Andrzej Hajda wrote:

> On 09/28/2015 01:32 PM, Julia Lawall wrote:
> >
> > On Mon, 28 Sep 2015, Andrzej Hajda wrote:
> >
> >> Assigning signed function result to unsigned variable can indicate error.
> >> To decrease number of false positives patch looks if after assignment
> >> there is also check for negative values of the result.
> >>
> >> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> >> ---
> >> Hi Julia,
> >>
> >> Thanks for the hint. Now it looks much better.
> >> Summarizing this patch has found 20 problems and has 22 false positives [1][2].
> > Do you have some examples of the false positives?
> ./drivers/acpi/acpica/nsarguments.c:130:1: WARNING: Assigning signed result to
> unsigned variable: required_param_count = METHOD_GET_ARG_COUNT(...)
> ./drivers/char/agp/intel-gtt.c:361:3: WARNING: Assigning signed result to
> unsigned variable: stolen_size = KB(...)
> ./drivers/char/agp/intel-gtt.c:364:3: WARNING: Assigning signed result to
> unsigned variable: stolen_size = MB(...)
> ./drivers/char/agp/intel-gtt.c:367:3: WARNING: Assigning signed result to
> unsigned variable: stolen_size = MB(...)
> ./drivers/char/agp/intel-gtt.c:382:3: WARNING: Assigning signed result to
> unsigned variable: stolen_size = MB(...)
> ./drivers/char/agp/intel-gtt.c:385:3: WARNING: Assigning signed result to
> unsigned variable: stolen_size = MB(...)
> ./drivers/char/agp/intel-gtt.c:388:3: WARNING: Assigning signed result to
> unsigned variable: stolen_size = MB(...)
> ./drivers/char/agp/intel-gtt.c:391:3: WARNING: Assigning signed result to
> unsigned variable: stolen_size = MB(...)
> ./drivers/char/agp/intel-gtt.c:394:3: WARNING: Assigning signed result to
> unsigned variable: stolen_size = MB(...)
> ./drivers/char/agp/intel-gtt.c:397:3: WARNING: Assigning signed result to
> unsigned variable: stolen_size = MB(...)
> ./drivers/char/agp/intel-gtt.c:400:3: WARNING: Assigning signed result to
> unsigned variable: stolen_size = MB(...)
> ./drivers/char/agp/intel-gtt.c:403:3: WARNING: Assigning signed result to
> unsigned variable: stolen_size = MB(...)
> ./drivers/char/agp/intel-gtt.c:406:3: WARNING: Assigning signed result to
> unsigned variable: stolen_size = MB(...)
> ./drivers/char/agp/intel-gtt.c:409:3: WARNING: Assigning signed result to
> unsigned variable: stolen_size = MB(...)
> ./drivers/char/agp/intel-gtt.c:412:3: WARNING: Assigning signed result to
> unsigned variable: stolen_size = MB(...)
> ./drivers/char/agp/intel-gtt.c:415:3: WARNING: Assigning signed result to
> unsigned variable: stolen_size = MB(...)
> ./drivers/char/agp/intel-gtt.c:418:3: WARNING: Assigning signed result to
> unsigned variable: stolen_size = MB(...)
> ./drivers/input/touchscreen/cyttsp4_core.c:967:1: WARNING: Assigning signed
> result to unsigned variable: num_cur_tch = GET_NUM_TOUCHES(...)
> ./drivers/pinctrl/freescale/pinctrl-imx.c:648:2: WARNING: Assigning signed
> result to unsigned variable: nfuncs = of_get_child_count(...)
> ./fs/btrfs/file.c:1572:2: WARNING: Assigning signed result to unsigned variable:
> copied = btrfs_copy_from_user(...)
> ./fs/xfs/libxfs/xfs_inode_fork.c:541:2: WARNING: Assigning signed result to
> unsigned variable: new_size = XFS_BMAP_BROOT_SPACE_CALC(...)
> 
> As you see most of them are macros, of_get_child_count and btrfs_copy_from_user
> return int but always non-negative.

OK, perhaps we could just live with them...

julia
