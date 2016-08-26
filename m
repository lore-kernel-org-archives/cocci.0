From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 25 Aug 2016 20:54:08 -0400 (EDT)
Subject: [Cocci] Coccinelle issues with Linux kernel 4.8-rc1
In-Reply-To: <2821164A880A16429BC851319A6EBBC5741D522D@ORSMSX111.amr.corp.intel.com>
References: <2821164A880A16429BC851319A6EBBC5741D0619@ORSMSX111.amr.corp.intel.com>
 <alpine.DEB.2.10.1608172229040.3281@hadrien>
 <2821164A880A16429BC851319A6EBBC5741D522D@ORSMSX111.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.10.1608252052570.9878@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 26 Aug 2016, Chegondi, Harish wrote:

> Hi Julia,
>
> When I turned on the verbose mode, I see that "--very-quiet" argument is already being passed to spatch. I tried to find more debug information by turning on the verbose mode. What I found is that not all .cocci files are causing the ?coccicheck failed? error. In verbose mode, when I get the ?coccicheck failed? error, I took the command and ran it individually. I found that the spatch command for the following .cocci files resulted in fatal errors. I see that the fatal errors are of two types - "Directory <> used for temporary files already exists and should be removed." And "<>: No such file or directory." I am not sure what caused these fata errors for these .cocci files. But when I ran the below commands without the "--jobs 16 --chunksize 1" arguments, I didn't see the fatal errors. When I deleted the .cocci files mentioned in the commands below and ran coccicheck in report mode, I didn't see any ?coccicheck failed? errors. Can you please let me know if you !
 have any ideas on why these fatal errors are showing up for these .cocci files?

I think you are in an unpleasant state and should clean up and start over.
Look around and see if you have any directories that have the names of
semantic patches and remove them.

Otherwise, it looks like you are not running these commands from the root
of the kernel directory?  Because it is not finding any of the .cocci
files.

julia

>
> Thank You
> Harish.
>
>
> -bash-4.2$ /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/api/alloc/kzalloc-simple.cocci --no-includes --include-headers --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 2 files match
> Fatal error: exception Failure("Directory kzalloc-simple used for temporary files already exists and should be removed.")
>
> -bash-4.2$ /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci --no-includes --include-headers --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 0 files match
> Fatal error: exception Sys_error("pool_zalloc-simple: No such file or directory")
>
> -bash-4.2$ /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/api/d_find_alias.cocci --include-headers --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 0 files match
> Fatal error: exception Sys_error("d_find_alias: No such file or directory")
>
> -bash-4.2$ /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci --no-includes --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 0 files match
> Fatal error: exception Sys_error("debugfs_simple_attr: No such file or directory")
>
> -bash-4.2$ /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/api/memdup.cocci --no-includes --include-headers --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 0 files match
> Fatal error: exception Sys_error("memdup: No such file or directory")
>
> -bash-4.2$  /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/api/platform_no_drv_owner.cocci --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 0 files match
> Fatal error: exception Sys_error("platform_no_drv_owner: No such file or directory")
>
> -bash-4.2$ /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/api/pm_runtime.cocci --include-headers --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 0 files match
> Fatal error: exception Sys_error("pm_runtime: No such file or directory")
>
> -bash-4.2$ /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/api/setup_timer.cocci --no-includes --include-headers --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 0 files match
> Fatal error: exception Sys_error("setup_timer: No such file or directory")
>
> -bash-4.2$  /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/free/clk_put.cocci --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 0 files match
> Fatal error: exception Sys_error("clk_put: No such file or directory")
>
> -bash-4.2$ /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/free/devm_free.cocci --no-includes --include-headers --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 0 files match
> Fatal error: exception Sys_error("devm_free: No such file or directory")
>
> -bash-4.2$  /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/iterators/device_node_continue.cocci --no-includes --include-headers --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 0 files match
> Fatal error: exception Sys_error("device_node_continue: No such file or directory")
>
> -bash-4.2$ /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/iterators/list_entry_update.cocci --no-includes --include-headers --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 4 files match
> Fatal error: exception Failure("Directory list_entry_update used for temporary files already exists and should be removed.")
>
> -bash-4.2$ /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/misc/badty.cocci --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 25 files match
> Fatal error: exception Failure("Directory badty used for temporary files already exists and should be removed.")
>
> -bash-4.2$ /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/misc/boolreturn.cocci --no-includes --include-headers --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 13 files match
> Fatal error: exception Failure("Directory boolreturn used for temporary files already exists and should be removed.")
>
> -bash-4.2$ /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/misc/bugon.cocci --no-includes --include-headers --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 0 files match
> Fatal error: exception Sys_error("bugon: No such file or directory")
>
> -bash-4.2$ /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/misc/cstptr.cocci --no-includes --include-headers --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 3 files match
> Fatal error: exception Failure("Directory cstptr used for temporary files already exists and should be removed.")
> -bash-4.2$
>
> -bash-4.2$ /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/misc/doubleinit.cocci --no-includes --include-headers --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> Fatal error: exception Failure("Directory doubleinit used for temporary files already exists and should be removed.")
>
> -bash-4.2$ /usr/local/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scripts/coccinelle/misc/of_table.cocci --include-headers --patch . --dir drivers/infiniband/hw/hfi1/ -I ./arch/x86/include -I ./arch/x86/include/generated/uapi -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 0 files match
> Fatal error: exception Sys_error("of_table: No such file or directory")
>
>
>
>
>
> -----Original Message-----
> From: Julia Lawall [mailto:julia.lawall at lip6.fr]
> Sent: Wednesday, August 17, 2016 7:32 PM
> To: Chegondi, Harish <harish.chegondi@intel.com>
> Cc: 'cocci at systeme.lip6.fr' <cocci@systeme.lip6.fr>; Dalessandro, Dennis <dennis.dalessandro@intel.com>
> Subject: Re: [Cocci] Coccinelle issues with Linux kernel 4.8-rc1
>
>
>
> On Thu, 18 Aug 2016, Chegondi, Harish wrote:
>
> >
> > Hello,
> >
> > ?
> >
> > With the 4.8-rc1 kernel, when I run Coccinelle check using the command
> > ?make coccicheck MODE=report M=<path to directory>?, I get ?coccicheck failed?
> > message. I get the same failure message even with ?MODE=patch? in the
> > command. I didn?t see this error message with 4.7 kernel.
> >
> > ?
> >
> > However, with the 4.8-rc1 kernel, if I turn off parallelization with
> > J=1 option, I don?t see the error message. The check seem to be
> > running successfully, even though it takes longer to run. I tried J=2,
> > J=4,?? and I got error messages. So there seem to be a problem with J not equal to 1.
>
> OK, I think it is related to the treatment of standard output and standard error.  I think that standard error is simply discarded with J=1.  Could you try giving the argument --very-quiet to Coccinelle with J > 1?
>
> thanks,
> julia
>
>
> >
> > ?
> >
> > Below I have mentioned the spatch version and ocaml version.
> >
> > ?
> >
> > -bash-4.2$ spatch --version
> >
> > spatch version 1.0.4 with Python support and with PCRE support
> >
> > ?
> >
> > -bash-4.2$ ocaml
> >
> > ??????? OCaml version 4.02.3
> >
> > ?
> >
> > ?
> >
> > ?
> >
> > Can you please let me know how can I resolve the ?coccicheck failed?
> > message?
> >
> > ?
> >
> > Thank You
> >
> > Harish.
> >
> >
> >
>
