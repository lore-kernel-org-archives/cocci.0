From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Sep 2015 12:08:02 +0200 (CEST)
Subject: [Cocci] coccinelle problems with kernel code
In-Reply-To: <20150909055721.GD27133@Sligo.logfs.org>
References: <20150908180759.GA27133@Sligo.logfs.org>
 <alpine.DEB.2.02.1509082316550.2050@localhost6.localdomain6>
 <20150908214536.GC27133@Sligo.logfs.org>
 <alpine.DEB.2.02.1509090717080.2047@localhost6.localdomain6>
 <20150909055721.GD27133@Sligo.logfs.org>
Message-ID: <alpine.DEB.2.10.1509091206380.3224@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 8 Sep 2015, J?rn Engel wrote:

> On Wed, Sep 09, 2015 at 07:24:42AM +0200, Julia Lawall wrote:
> >
> > Including header files with C files is only useful for acquiring type
> > information.  You don't care about that for your rules, so you would be
> > better off with --no-includes.  On the oter hand if your patterns occur in
> > header files you want them to be processed.  For that, add the command
> > line --include-headers.
>
> Ack.  --include-headers does the trick for me.
>
> > The point is that including header files can drastically increase the code
> > size, and header files can be difficult to parse, due to
> > #ifdefs etc, so overall including more than necessary can increase the
> > running time a lot.
>
> On that note, it might make sense to add multithreading or
> multiprocessing.  My kernel tree has roughly 35000 files, so splitting
> the work shouldn't be much of a problem.  And given the processing
> times, it appears as if a 6-fold speed up should be possible on my aging
> notebook - more on bigger machines.

This is available is you have Coccinelle version 1.0.2.  Just give -j X
where X is the number of cores that you want to use.

Will check the rest later.

julia

> real    0m35.226s
> user    0m19.320s
> sys     0m2.736s
>
> I have done similar stuff to grep.  tgrep is a python wrapper around
> regular grep and can give a 48x speedup on a beefy machine we have.
> Of course if ocaml has multithreading support, that is likely a nicer
> solution than a python wrapper.
>
> > > arch/mips/mm/fault.c seems to have a problem with one of the
> > > conditionals.  I could reduce things to the following testcase:
> > >
> > > void foo(unsigned long address)
> > > {
> > > 	down_read(&mm->mmap_sem);
> > > 	vma = find_vma(current->mm, address);
> > > 	if (!vma)
> > > 		goto bad_area;
> > > 	if (vma->vm_start <= address)
> > > 		goto good_area;
> > > 	if (!(vma->vm_flags & VM_GROWSDOWN))
> > > 		goto bad_area;
> > > 	if (expand_stack(vma, address))
> > > 		goto bad_area;
> > > bad_area:
> > > 	up_read(&mm->mmap_sem);
> > > }
> > >
> > > Remove the "!(vma->vm_flags & VM_GROWSDOWN)" condition and it works.
> > > Leave the condition and spatch fails silently.
> >
> > There is probably a parsing problem.  By default Coccinelle doesn't report
> > these, because there are likely many of them, and most of them are likely
> > not relevant to the code you want to process.  You can see the parsing
> > problems by running spatch --parse-c file.c.  There may be quite a lot of
> > output.  At the end you will see a summary of how successful the parsing
> > was.  If it was somewhat not successful, you can look up fpr the line
> > beginning with BAD to see where the problem is.  The lines beginning with
> > bad show the lines that were skipped due to the problem.
>
> I tried that and didn't see anything helpful.  Full output below.
>
> init_defs_builtins: /usr/share/coccinelle/standard.h
> init_defs: coccinelle.h
>
> PARSING: arch/mips/mm/fault.c
> (ONCE) CPP-commenting a #if 0 or #if LINUX_VERSION or __cplusplus
> (ONCE) CPP-MACRO: found known macro = asmlinkage
> (ONCE) CPP-MACRO: found known macro = __kprobes
> (ONCE) CPP-MACRO: found known macro = __user
> (ONCE) CPP-MACRO: found known macro = KERN_ALERT
> passed:asmlinkage __kprobes
> passed:#if 0
> passed:printk ( "Cpu%d[%s:%d:%0*lx:%ld:%0*lx]\n" , raw_smp_processor_id ( ) ,
> passed:current -> comm , current -> pid , field , address , write ,
> passed:field , regs -> cp0_epc ) ;
> passed:#endif
> passed:#if 0
> passed:pr_notice ( "Cpu%d[%s:%d:%0*lx:%ld:%0*lx] XI violation\n" ,
> passed:raw_smp_processor_id ( ) ,
> passed:current -> comm , current -> pid ,
> passed:field , address , write ,
> passed:field , regs -> cp0_epc ) ;
> passed:#endif
> passed:#if 0
> passed:pr_notice ( "Cpu%d[%s:%d:%0*lx:%ld:%0*lx] RI violation\n" ,
> passed:raw_smp_processor_id ( ) ,
> passed:current -> comm , current -> pid ,
> passed:field , address , write ,
> passed:field , regs -> cp0_epc ) ;
> passed:#endif
> passed:#if 0
> passed:printk ( "do_page_fault() #2: sending SIGSEGV to %s for "
> passed:"invalid %s\n%0*lx (epc == %0*lx, ra == %0*lx)\n" ,
> passed:tsk -> comm ,
> passed:write ? "write access to" : "read access from" ,
> passed:field , address ,
> passed:field , ( unsigned long ) regs -> cp0_epc ,
> passed:field , ( unsigned long ) regs -> regs [ 31 ] ) ;
> passed:#endif
> passed:__user
> passed:#if 0
> passed:printk ( "do_page_fault() #3: sending SIGBUS to %s for "
> passed:"invalid %s\n%0*lx (epc == %0*lx, ra == %0*lx)\n" ,
> passed:tsk -> comm ,
> passed:write ? "write access to" : "read access from" ,
> passed:field , address ,
> passed:field , ( unsigned long ) regs -> cp0_epc ,
> passed:field , ( unsigned long ) regs -> regs [ 31 ] ) ;
> passed:#endif
> passed:__user
> -----------------------------------------------------------------------
> maybe 10 most problematic tokens
> -----------------------------------------------------------------------
> -----------------------------------------------------------------------
> NB total files = 1; perfect = 1; pbs = 0; timeout = 0; =========> 100%
> nb good = 313,  nb passed = 40 =========> 11.33% passed
> nb good = 313,  nb bad = 0 =========> 100.00% good or passed
>
> J?rn
>
> --
> When people work hard for you for a pat on the back, you've got
> to give them that pat.
> -- Robert Heinlein
>
