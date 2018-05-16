From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 May 2018 21:37:39 +0200 (CEST)
Subject: [Cocci] [bug] exists do not work if file group is too big (>49)
In-Reply-To: <20180516191634.GB2994@redhat.com>
References: <20180516191634.GB2994@redhat.com>
Message-ID: <alpine.DEB.2.20.1805162132050.3296@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 16 May 2018, Jerome Glisse wrote:

> When operating on too many files the exists keyword no longer work. For
> instance:
>
> @exists@
> expression E1;
> @@
> set_page_dirty(
> +NULL,
> E1)
>
> Using linux kernel as playground and looking at at fs/f2fs/gc.c where
> there is set_page_dirty() calls in nested blocks.
>
> Works:
>
> spatch --no-includes --sp-file test.spatch arch/powerpc/kvm/book3s_64_mmu_radix.c arch/powerpc/kvm/e500_mmu.c arch/s390/kvm/interrupt.c arch/x86/kvm/svm.c block/bio.c drivers/block/zram/zram_drv.c drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c drivers/gpu/drm/drm_gem.c drivers/gpu/drm/exynos/exynos_drm_g2d.c drivers/gpu/drm/i915/i915_gem.c drivers/gpu/drm/i915/i915_gem_fence_reg.c drivers/gpu/drm/i915/i915_gem_userptr.c drivers/gpu/drm/radeon/radeon_ttm.c drivers/gpu/drm/ttm/ttm_tt.c drivers/infiniband/core/umem.c drivers/infiniband/core/umem_odp.c drivers/infiniband/hw/hfi1/user_pages.c drivers/infiniband/hw/qib/qib_user_pages.c drivers/infiniband/hw/usnic/usnic_uiom.c drivers/media/common/videobuf2/videobuf2-dma-contig.c drivers/media/common/videobuf2/videobuf2-dma-sg.c drivers/media/common/videobuf2/videobuf2-vmalloc.c drivers/misc/genwqe/card_utils.c drivers/misc/vmw_vmci/vmci_queue_pair.c drivers/mtd/devices/block2mtd.c drivers/platform/goldfish/goldfish_pipe.c drivers/sbus/!
 char/oradax.c drivers/staging/lustre/lustre/llite/rw26.c drivers/staging/lustre/lustre/llite/vvp_io.c drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c drivers/vhost/vhost.c drivers/video/fbdev/core/fb_defio.c fs/9p/vfs_addr.c fs/afs/dir.c fs/afs/file.c --include fs/afs/internal.h fs/afs/write.c fs/aio.c fs/block_dev.c fs/btrfs/disk-io.c fs/btrfs/extent_io.c fs/btrfs/file.c fs/btrfs/inode.c fs/btrfs/ioctl.c fs/btrfs/relocation.c fs/buffer.c fs/ceph/addr.c fs/f2fs/gc.c > toto
>
>
> Don't works:
>
> spatch --no-includes --sp-file test.spatch arch/powerpc/kvm/book3s_64_mmu_radix.c arch/powerpc/kvm/e500_mmu.c arch/s390/kvm/interrupt.c arch/x86/kvm/svm.c block/bio.c drivers/block/zram/zram_drv.c drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c drivers/gpu/drm/drm_gem.c drivers/gpu/drm/exynos/exynos_drm_g2d.c drivers/gpu/drm/i915/i915_gem.c drivers/gpu/drm/i915/i915_gem_fence_reg.c drivers/gpu/drm/i915/i915_gem_userptr.c drivers/gpu/drm/radeon/radeon_ttm.c drivers/gpu/drm/ttm/ttm_tt.c drivers/infiniband/core/umem.c drivers/infiniband/core/umem_odp.c drivers/infiniband/hw/hfi1/user_pages.c drivers/infiniband/hw/qib/qib_user_pages.c drivers/infiniband/hw/usnic/usnic_uiom.c drivers/media/common/videobuf2/videobuf2-dma-contig.c drivers/media/common/videobuf2/videobuf2-dma-sg.c drivers/media/common/videobuf2/videobuf2-vmalloc.c drivers/misc/genwqe/card_utils.c drivers/misc/vmw_vmci/vmci_queue_pair.c drivers/mtd/devices/block2mtd.c drivers/platform/goldfish/goldfish_pipe.c drivers/sbus/!
 char/oradax.c drivers/staging/lustre/lustre/llite/rw26.c drivers/staging/lustre/lustre/llite/vvp_io.c drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c drivers/vhost/vhost.c drivers/video/fbdev/core/fb_defio.c fs/9p/vfs_addr.c fs/afs/dir.c fs/afs/file.c --include fs/afs/internal.h fs/afs/write.c fs/aio.c fs/block_dev.c fs/btrfs/disk-io.c fs/btrfs/extent_io.c fs/btrfs/file.c fs/btrfs/inode.c fs/btrfs/ioctl.c fs/btrfs/relocation.c fs/buffer.c fs/ceph/addr.c fs/cifs/cifssmb.c fs/f2fs/gc.c > toto
>
>
> Exact same command line except the latter have 49 files before
> fs/f2fs/gc.c while the former has 48 (and it works then). Note
> that it seems that running the script multiple times even when
> they are too many files will eventualy work.

I'm surprised that the number of files would have an impact, unless by not
working you mean that it runs out of memory or doesn't terminate.

In general, you should only give one file name or one directory name to
Coccinelle.  If you give multiple files, then they are all treated at
once, ie their CFGs are all in memory at the same time.  If you give the
name of a directory containing the files, then it will work on one file at
a time, and you can give the option -j XXX to have it run XXX threads in
parallel.  Giving multiple file names on the command line is only for the
case where information collected from one file is needed for the treatment
of another file.

If the set of files you want to work on doesn't correspond to the
directory structure, you can make a file with the names of the files to
treat one by one each separated by a blank line, and then give the command
line argument --file-groups filename.

Actually, exists is not relevant to your rule, because it has no ...
Exists means that there exists a path through the ... that matches the
pattern.  Otherwise, all paths have to match the pattern.

julia

>
> Cheers,
> J?r?me
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
