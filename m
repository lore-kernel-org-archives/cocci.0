From: jglisse@redhat.com (Jerome Glisse)
Date: Wed, 16 May 2018 16:24:31 -0400
Subject: [Cocci] [bug] exists do not work if file group is too big (>49)
In-Reply-To: <alpine.DEB.2.20.1805162216500.3296@hadrien>
References: <20180516191634.GB2994@redhat.com>
 <alpine.DEB.2.20.1805162132050.3296@hadrien>
 <20180516195417.GC2994@redhat.com>
 <alpine.DEB.2.20.1805162200020.3296@hadrien>
 <20180516201559.GD2994@redhat.com>
 <alpine.DEB.2.20.1805162216500.3296@hadrien>
Message-ID: <20180516202430.GE2994@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, May 16, 2018 at 10:20:05PM +0200, Julia Lawall wrote:
> 
> 
> On Wed, 16 May 2018, Jerome Glisse wrote:
> 
> > On Wed, May 16, 2018 at 10:02:08PM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Wed, 16 May 2018, Jerome Glisse wrote:
> > >
> > > > On Wed, May 16, 2018 at 09:37:39PM +0200, Julia Lawall wrote:
> > > > >
> > > > >
> > > > > On Wed, 16 May 2018, Jerome Glisse wrote:
> > > > >
> > > > > > When operating on too many files the exists keyword no longer work. For
> > > > > > instance:
> > > > > >
> > > > > > @exists@
> > > > > > expression E1;
> > > > > > @@
> > > > > > set_page_dirty(
> > > > > > +NULL,
> > > > > > E1)
> > > > > >
> > > > > > Using linux kernel as playground and looking at at fs/f2fs/gc.c where
> > > > > > there is set_page_dirty() calls in nested blocks.
> > > > > >
> > > > > > Works:
> > > > > >
> > > > > > spatch --no-includes --sp-file test.spatch arch/powerpc/kvm/book3s_64_mmu_radix.c arch/powerpc/kvm/e500_mmu.c arch/s390/kvm/interrupt.c arch/x86/kvm/svm.c block/bio.c drivers/block/zram/zram_drv.c drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c drivers/gpu/drm/drm_gem.c drivers/gpu/drm/exynos/exynos_drm_g2d.c drivers/gpu/drm/i915/i915_gem.c drivers/gpu/drm/i915/i915_gem_fence_reg.c drivers/gpu/drm/i915/i915_gem_userptr.c drivers/gpu/drm/radeon/radeon_ttm.c drivers/gpu/drm/ttm/ttm_tt.c drivers/infiniband/core/umem.c drivers/infiniband/core/umem_odp.c drivers/infiniband/hw/hfi1/user_pages.c drivers/infiniband/hw/qib/qib_user_pages.c drivers/infiniband/hw/usnic/usnic_uiom.c drivers/media/common/videobuf2/videobuf2-dma-contig.c drivers/media/common/videobuf2/videobuf2-dma-sg.c drivers/media/common/videobuf2/videobuf2-vmalloc.c drivers/misc/genwqe/card_utils.c drivers/misc/vmw_vmci/vmci_queue_pair.c drivers/mtd/devices/block2mtd.c drivers/platform/goldfish/goldfish_pipe.c drivers/sbus/c
>  har/
> > >  orad
> > > > >  ax.c drivers/staging/lustre/lustre/llite/rw26.c drivers/staging/lustre/lustre/llite/vvp_io.c drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c drivers/vhost/vhost.c drivers/video/fbdev/core/fb_defio.c fs/9p/vfs_addr.c fs/afs/dir.c fs/afs/file.c --include fs/afs/internal.h fs/afs/write.c fs/aio.c fs/block_dev.c fs/btrfs/disk-io.c fs/btrfs/extent_io.c fs/btrfs/file.c fs/btrfs/inode.c fs/btrfs/ioctl.c fs/btrfs/relocation.c fs/buffer.c fs/ceph/addr.c fs/f2fs/gc.c > toto
> > > > > >
> > > > > >
> > > > > > Don't works:
> > > > > >
> > > > > > spatch --no-includes --sp-file test.spatch arch/powerpc/kvm/book3s_64_mmu_radix.c arch/powerpc/kvm/e500_mmu.c arch/s390/kvm/interrupt.c arch/x86/kvm/svm.c block/bio.c drivers/block/zram/zram_drv.c drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c drivers/gpu/drm/drm_gem.c drivers/gpu/drm/exynos/exynos_drm_g2d.c drivers/gpu/drm/i915/i915_gem.c drivers/gpu/drm/i915/i915_gem_fence_reg.c drivers/gpu/drm/i915/i915_gem_userptr.c drivers/gpu/drm/radeon/radeon_ttm.c drivers/gpu/drm/ttm/ttm_tt.c drivers/infiniband/core/umem.c drivers/infiniband/core/umem_odp.c drivers/infiniband/hw/hfi1/user_pages.c drivers/infiniband/hw/qib/qib_user_pages.c drivers/infiniband/hw/usnic/usnic_uiom.c drivers/media/common/videobuf2/videobuf2-dma-contig.c drivers/media/common/videobuf2/videobuf2-dma-sg.c drivers/media/common/videobuf2/videobuf2-vmalloc.c drivers/misc/genwqe/card_utils.c drivers/misc/vmw_vmci/vmci_queue_pair.c drivers/mtd/devices/block2mtd.c drivers/platform/goldfish/goldfish_pipe.c drivers/sbus/c
>  har/
> > >  orad
> > > > >  ax.c drivers/staging/lustre/lustre/llite/rw26.c drivers/staging/lustre/lustre/llite/vvp_io.c drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c drivers/vhost/vhost.c drivers/video/fbdev/core/fb_defio.c fs/9p/vfs_addr.c fs/afs/dir.c fs/afs/file.c --include fs/afs/internal.h fs/afs/write.c fs/aio.c fs/block_dev.c fs/btrfs/disk-io.c fs/btrfs/extent_io.c fs/btrfs/file.c fs/btrfs/inode.c fs/btrfs/ioctl.c fs/btrfs/relocation.c fs/buffer.c fs/ceph/addr.c fs/cifs/cifssmb.c fs/f2fs/gc.c > toto
> > > > > >
> > > > > >
> > > > > > Exact same command line except the latter have 49 files before
> > > > > > fs/f2fs/gc.c while the former has 48 (and it works then). Note
> > > > > > that it seems that running the script multiple times even when
> > > > > > they are too many files will eventualy work.
> > > > >
> > > > > I'm surprised that the number of files would have an impact, unless by not
> > > > > working you mean that it runs out of memory or doesn't terminate.
> > > >
> > > > Don't work == only set_page_dirty in non nested block are modified,
> > > > set_page_dirty in nested block are not. So it runs and terminate and
> > > > all files are processed (ie it is not a command line size limitation
> > > > in the shell).
> > > >
> > > > >
> > > > > In general, you should only give one file name or one directory name to
> > > > > Coccinelle.  If you give multiple files, then they are all treated at
> > > > > once, ie their CFGs are all in memory at the same time.  If you give the
> > > > > name of a directory containing the files, then it will work on one file at
> > > > > a time, and you can give the option -j XXX to have it run XXX threads in
> > > > > parallel.  Giving multiple file names on the command line is only for the
> > > > > case where information collected from one file is needed for the treatment
> > > > > of another file.
> > > >
> > > > Saddly for modification i am doing i need to treat many files as one
> > > > as otherwise it does not work and even sadder for me is that this groups
> > > > can get pretty big.
> > > >
> > > > >
> > > > > If the set of files you want to work on doesn't correspond to the
> > > > > directory structure, you can make a file with the names of the files to
> > > > > treat one by one each separated by a blank line, and then give the command
> > > > > line argument --file-groups filename.
> > > >
> > > > This is _slower_ (by an order of magnitude) and also spit out a lot of
> > > > error messages (about trying to cd to directory and failing) than passing
> > > > all the files on the command line.
> > > >
> > > > >
> > > > > Actually, exists is not relevant to your rule, because it has no ...
> > > > > Exists means that there exists a path through the ... that matches the
> > > > > pattern.  Otherwise, all paths have to match the pattern.
> > > >
> > > > Oh i thought i would need it, nonetheless when there is too many files
> > > > the above snipet stop at first level blocks and never modify block with
> > > > deeper nesting.
> > > >
> > > > Thank you for all your feedback :)
> > >
> > > Sorry, but none of what you are saying makes any sense to me.  Coccinele
> > > works one function at a time.  There is no reason why its behavior on
> > > nested calls would be affected by the number of files.  And no reason why
> > > working on one file at a time would be slower than working on all of the
> > > files at once.  I'll have to try your command lines, but I probably can't
> > > do that until tomorrow afternoon...
> >
> > Yes this is weird bug i actually tested again and it only shows if
> > exists is use. If i remove exists like you adviced it seems to work
> > no matter how many files i pass as argument.
> >
> > When the rules has the exists modifier then it only modify inside
> > nested block if i pass 48 files or less. If i pass 49 files or more
> > then nested block are not modified but first level block is.
> >
> > My buest guess is some memory corruption somewhere or some variable
> > that is not reset properly.
> 
> Are you using the bytecode or the native code version of Coccinelle?
> 
> I think you can say make byte-only to get the bytecode version, from the
> sources on github.

Not sure what that is here is the output of spatch --version on fedora 27:

[glisse at localhost ~]$ spatch --version
spatch version 1.0.6 compiled with OCaml version 4.05.0
Flags passed to the configure script: --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu --program-prefix= --disable-dependency-tracking --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info --enable-release=yes --with-python=/usr/bin/python3 --with-menhir=/usr/bin/menhir
Python scripting support: yes
Syntax of regular expresssions: PCRE

Cheers,
J?r?me
