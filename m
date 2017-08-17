From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 17 Aug 2017 19:06:38 +0200 (CEST)
Subject: [Cocci] spatch / semantic patch missing some conversions?
In-Reply-To: <CAA9_cmee9PYMg-v+GE4r_92EWWzmRgPN8ABJA4vExfKJhSXQ=A@mail.gmail.com>
References: <CAA9_cmee9PYMg-v+GE4r_92EWWzmRgPN8ABJA4vExfKJhSXQ=A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1708171900460.3748@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The updated semantic patch is below.  It makes one pass to collect the
function names and then another pass to transform the functions, whereever
they are defined.

I have attached the output I get on today's linux-next.  If you want to
run it your self, I suggest first running

~/coccinelle/scripts/idutils_index.sh

in your kernel tree and then using the following command line:

spatch.opt mmap.cocci --use-idutils --no-includes --include-headers --in-place /run/shm/linux-next -j X --very-quiet

where X is the number of core you have available.

Let me know if there are any problems.

julia

virtual after_start

@initialize:ocaml@
@@

let tbl = Hashtbl.create(100)

let add_if_not_present fn =
  if not(Hashtbl.mem tbl fn) then Hashtbl.add tbl fn ()

@ a @
identifier fn;
identifier ops;
@@

struct file_operations ops = { ..., .mmap = fn, ...};

@script:ocaml@
fn << a.fn;
@@

add_if_not_present fn

@finalize:ocaml depends on !after_start@
tbls << merge.tbl;
@@

List.iter (fun t -> Hashtbl.iter (fun f _ -> add_if_not_present f) t) tbls;
Hashtbl.iter
    (fun f _ ->
      let it = new iteration() in
      it#add_virtual_rule After_start;
      it#add_virtual_identifier Fn f;
      it#register())
    tbl

@depends on after_start@
identifier virtual.fn;
identifier x, y;
@@

int fn(struct file *x,
        struct vm_area_struct *y
-       )
+       , unsigned long map_flags)
{
...
}

@depends on after_start@
identifier virtual.fn;
identifier x, y;
@@

int fn(struct file *x,
        struct vm_area_struct *y
-       );
+       , unsigned long map_flags);

@depends on after_start@
identifier virtual.fn;
@@

int fn(struct file *,
        struct vm_area_struct *
-       );
+       , unsigned long);
-------------- next part --------------
diff -u -p a/sound/core/compress_offload.c b/sound/core/compress_offload.c
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -391,7 +391,8 @@ out:
 	return retval;
 }
 
-static int snd_compr_mmap(struct file *f, struct vm_area_struct *vma)
+static int snd_compr_mmap(struct file *f, struct vm_area_struct *vma,
+			  unsigned long map_flags)
 {
 	return -ENXIO;
 }
diff -u -p a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -444,7 +444,8 @@ static const struct vm_operations_struct
 	.page_mkwrite = sel_mmap_policy_fault,
 };
 
-static int sel_mmap_policy(struct file *filp, struct vm_area_struct *vma)
+static int sel_mmap_policy(struct file *filp, struct vm_area_struct *vma,
+			   unsigned long map_flags)
 {
 	if (vma->vm_flags & VM_SHARED) {
 		/* do not allow mprotect to make mapping writable */
diff -u -p a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -109,7 +109,8 @@ extern int cifs_lock(struct file *, int,
 extern int cifs_fsync(struct file *, loff_t, loff_t, int);
 extern int cifs_strict_fsync(struct file *, loff_t, loff_t, int);
 extern int cifs_flush(struct file *, fl_owner_t id);
-extern int cifs_file_mmap(struct file * , struct vm_area_struct *);
+extern int cifs_file_mmap(struct file * , struct vm_area_struct *,
+			  unsigned long);
 extern int cifs_file_strict_mmap(struct file * , struct vm_area_struct *);
 extern const struct file_operations cifs_dir_ops;
 extern int cifs_dir_open(struct inode *inode, struct file *file);
diff -u -p a/fs/cifs/file.c b/fs/cifs/file.c
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3495,7 +3495,8 @@ int cifs_file_strict_mmap(struct file *f
 	return rc;
 }
 
-int cifs_file_mmap(struct file *file, struct vm_area_struct *vma)
+int cifs_file_mmap(struct file *file, struct vm_area_struct *vma,
+		   unsigned long map_flags)
 {
 	int rc, xid;
 
diff -u -p a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -255,7 +255,8 @@ static struct drm_ioctl_desc vgem_ioctls
 	DRM_IOCTL_DEF_DRV(VGEM_FENCE_SIGNAL, vgem_fence_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
-static int vgem_mmap(struct file *filp, struct vm_area_struct *vma)
+static int vgem_mmap(struct file *filp, struct vm_area_struct *vma,
+		     unsigned long map_flags)
 {
 	unsigned long flags = vma->vm_flags;
 	int ret;
diff -u -p a/fs/ncpfs/ncp_fs.h b/fs/ncpfs/ncp_fs.h
--- a/fs/ncpfs/ncp_fs.h
+++ b/fs/ncpfs/ncp_fs.h
@@ -92,7 +92,7 @@ extern const struct file_operations ncp_
 int ncp_make_open(struct inode *, int);
 
 /* linux/fs/ncpfs/mmap.c */
-int ncp_mmap(struct file *, struct vm_area_struct *);
+int ncp_mmap(struct file *, struct vm_area_struct *, unsigned long);
 
 /* linux/fs/ncpfs/ncplib_kernel.c */
 int ncp_make_closed(struct inode *);
diff -u -p a/fs/ncpfs/mmap.c b/fs/ncpfs/mmap.c
--- a/fs/ncpfs/mmap.c
+++ b/fs/ncpfs/mmap.c
@@ -100,7 +100,8 @@ static const struct vm_operations_struct
 
 
 /* This is used for a general mmap of a ncp file */
-int ncp_mmap(struct file *file, struct vm_area_struct *vma)
+int ncp_mmap(struct file *file, struct vm_area_struct *vma,
+	     unsigned long map_flags)
 {
 	struct inode *inode = file_inode(file);
 	
diff -u -p a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -59,7 +59,7 @@ static int qib_close(struct inode *, str
 static ssize_t qib_write(struct file *, const char __user *, size_t, loff_t *);
 static ssize_t qib_write_iter(struct kiocb *, struct iov_iter *);
 static unsigned int qib_poll(struct file *, struct poll_table_struct *);
-static int qib_mmapf(struct file *, struct vm_area_struct *);
+static int qib_mmapf(struct file *, struct vm_area_struct *, unsigned long);
 
 /*
  * This is really, really weird shit - write() and writev() here
@@ -993,7 +993,8 @@ bail:
  * buffers in the chip.  We have the open and close entries so we can bump
  * the ref count and keep the driver from being unloaded while still mapped.
  */
-static int qib_mmapf(struct file *fp, struct vm_area_struct *vma)
+static int qib_mmapf(struct file *fp, struct vm_area_struct *vma,
+		     unsigned long map_flags)
 {
 	struct qib_ctxtdata *rcd;
 	struct qib_devdata *dd;
diff -u -p a/arch/powerpc/kernel/proc_powerpc.c b/arch/powerpc/kernel/proc_powerpc.c
--- a/arch/powerpc/kernel/proc_powerpc.c
+++ b/arch/powerpc/kernel/proc_powerpc.c
@@ -41,7 +41,8 @@ static ssize_t page_map_read( struct fil
 			PDE_DATA(file_inode(file)), PAGE_SIZE);
 }
 
-static int page_map_mmap( struct file *file, struct vm_area_struct *vma )
+static int page_map_mmap( struct file *file, struct vm_area_struct *vma,
+			 unsigned long map_flags)
 {
 	if ((vma->vm_end - vma->vm_start) > PAGE_SIZE)
 		return -EINVAL;
diff -u -p a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -484,7 +484,8 @@ int v9fs_file_fsync_dotl(struct file *fi
 }
 
 static int
-v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
+v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma,
+	       unsigned long map_flags)
 {
 	int retval;
 
diff -u -p a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -995,7 +995,8 @@ EXPORT_SYMBOL(drm_gem_mmap_obj);
  * If the caller is not granted access to the buffer object, the mmap will fail
  * with EACCES. Please see the vma manager for more information.
  */
-int drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
+int drm_gem_mmap(struct file *filp, struct vm_area_struct *vma,
+		 unsigned long map_flags)
 {
 	struct drm_file *priv = filp->private_data;
 	struct drm_device *dev = priv->minor->dev;
diff -u -p a/include/drm/drm_gem.h b/include/drm/drm_gem.h
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -199,7 +199,8 @@ void drm_gem_vm_open(struct vm_area_stru
 void drm_gem_vm_close(struct vm_area_struct *vma);
 int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
 		     struct vm_area_struct *vma);
-int drm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
+int drm_gem_mmap(struct file *filp, struct vm_area_struct *vma,
+		 unsigned long map_flags);
 
 /**
  * drm_gem_object_get - acquire a GEM buffer object reference
diff -u -p a/drivers/xen/xenfs/xenstored.c b/drivers/xen/xenfs/xenstored.c
--- a/drivers/xen/xenfs/xenstored.c
+++ b/drivers/xen/xenfs/xenstored.c
@@ -30,7 +30,8 @@ static int xsd_kva_open(struct inode *in
 	return 0;
 }
 
-static int xsd_kva_mmap(struct file *file, struct vm_area_struct *vma)
+static int xsd_kva_mmap(struct file *file, struct vm_area_struct *vma,
+			unsigned long map_flags)
 {
 	size_t size = vma->vm_end - vma->vm_start;
 
diff -u -p a/sound/oss/soundcard.c b/sound/oss/soundcard.c
--- a/sound/oss/soundcard.c
+++ b/sound/oss/soundcard.c
@@ -420,7 +420,8 @@ static unsigned int sound_poll(struct fi
 	return 0;
 }
 
-static int sound_mmap(struct file *file, struct vm_area_struct *vma)
+static int sound_mmap(struct file *file, struct vm_area_struct *vma,
+		      unsigned long map_flags)
 {
 	int dev_class;
 	unsigned long size;
diff -u -p a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1168,7 +1168,7 @@ static const struct vm_operations_struct
 STATIC int
 xfs_file_mmap(
 	struct file	*filp,
-	struct vm_area_struct *vma)
+	struct vm_area_struct *vma, unsigned long map_flags)
 {
 	file_accessed(filp);
 	vma->vm_ops = &xfs_file_vm_ops;
diff -u -p a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -1083,7 +1083,8 @@ vop_query_offset(struct vop_vdev *vdev,
 /*
  * Maps the device page and virtio rings to user space for readonly access.
  */
-static int vop_mmap(struct file *f, struct vm_area_struct *vma)
+static int vop_mmap(struct file *f, struct vm_area_struct *vma,
+		    unsigned long map_flags)
 {
 	struct vop_vdev *vdev = f->private_data;
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
diff -u -p a/drivers/sbus/char/jsflash.c b/drivers/sbus/char/jsflash.c
--- a/drivers/sbus/char/jsflash.c
+++ b/drivers/sbus/char/jsflash.c
@@ -440,7 +440,8 @@ static long jsf_ioctl(struct file *f, un
 	return error;
 }
 
-static int jsf_mmap(struct file * file, struct vm_area_struct * vma)
+static int jsf_mmap(struct file * file, struct vm_area_struct * vma,
+		    unsigned long map_flags)
 {
 	return -ENXIO;
 }
diff -u -p a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -1059,7 +1059,8 @@ static const struct vm_operations_struct
 	.fault = spufs_signal1_mmap_fault,
 };
 
-static int spufs_signal1_mmap(struct file *file, struct vm_area_struct *vma)
+static int spufs_signal1_mmap(struct file *file, struct vm_area_struct *vma,
+			      unsigned long map_flags)
 {
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
diff -u -p a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1212,7 +1212,8 @@ static const struct vm_operations_struct
 	.fault	= msc_mmap_fault,
 };
 
-static int intel_th_msc_mmap(struct file *file, struct vm_area_struct *vma)
+static int intel_th_msc_mmap(struct file *file, struct vm_area_struct *vma,
+			     unsigned long map_flags)
 {
 	unsigned long size = vma->vm_end - vma->vm_start;
 	struct msc_iter *iter = vma->vm_file->private_data;
diff -u -p a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -818,7 +818,8 @@ static const struct vm_operations_struct
 	.fault = privcmd_fault
 };
 
-static int privcmd_mmap(struct file *file, struct vm_area_struct *vma)
+static int privcmd_mmap(struct file *file, struct vm_area_struct *vma,
+			unsigned long map_flags)
 {
 	/* DONTCOPY is essential for Xen because copy_page_range doesn't know
 	 * how to recreate these mappings */
diff -u -p a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/mgag200/mgag200_drv.h
--- a/drivers/gpu/drm/mgag200/mgag200_drv.h
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
@@ -296,7 +296,8 @@ int mgag200_bo_create(struct drm_device
 		      uint32_t flags, struct mgag200_bo **pastbo);
 int mgag200_mm_init(struct mga_device *mdev);
 void mgag200_mm_fini(struct mga_device *mdev);
-int mgag200_mmap(struct file *filp, struct vm_area_struct *vma);
+int mgag200_mmap(struct file *filp, struct vm_area_struct *vma,
+		 unsigned long map_flags);
 int mgag200_bo_pin(struct mgag200_bo *bo, u32 pl_flag, u64 *gpu_addr);
 int mgag200_bo_unpin(struct mgag200_bo *bo);
 int mgag200_bo_push_sysram(struct mgag200_bo *bo);
diff -u -p a/drivers/gpu/drm/mgag200/mgag200_ttm.c b/drivers/gpu/drm/mgag200/mgag200_ttm.c
--- a/drivers/gpu/drm/mgag200/mgag200_ttm.c
+++ b/drivers/gpu/drm/mgag200/mgag200_ttm.c
@@ -418,7 +418,8 @@ int mgag200_bo_push_sysram(struct mgag20
 	return 0;
 }
 
-int mgag200_mmap(struct file *filp, struct vm_area_struct *vma)
+int mgag200_mmap(struct file *filp, struct vm_area_struct *vma,
+		 unsigned long map_flags)
 {
 	struct drm_file *file_priv;
 	struct mga_device *mdev;
diff -u -p a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -2261,7 +2261,8 @@ static const struct vm_operations_struct
 	.close = mport_mm_close,
 };
 
-static int mport_cdev_mmap(struct file *filp, struct vm_area_struct *vma)
+static int mport_cdev_mmap(struct file *filp, struct vm_area_struct *vma,
+			   unsigned long map_flags)
 {
 	struct mport_cdev_priv *priv = filp->private_data;
 	struct mport_dev *md;
diff -u -p a/fs/coda/file.c b/fs/coda/file.c
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -61,7 +61,8 @@ coda_file_write_iter(struct kiocb *iocb,
 }
 
 static int
-coda_file_mmap(struct file *coda_file, struct vm_area_struct *vma)
+coda_file_mmap(struct file *coda_file, struct vm_area_struct *vma,
+	       unsigned long map_flags)
 {
 	struct coda_file_info *cfi;
 	struct coda_inode_info *cii;
diff -u -p a/drivers/char/mspec.c b/drivers/char/mspec.c
--- a/drivers/char/mspec.c
+++ b/drivers/char/mspec.c
@@ -299,7 +299,8 @@ cached_mmap(struct file *file, struct vm
 }
 
 static int
-uncached_mmap(struct file *file, struct vm_area_struct *vma)
+uncached_mmap(struct file *file, struct vm_area_struct *vma,
+	      unsigned long map_flags)
 {
 	return mspec_mmap(file, vma, MSPEC_UNCACHED);
 }
diff -u -p a/drivers/hsi/clients/cmt_speech.c b/drivers/hsi/clients/cmt_speech.c
--- a/drivers/hsi/clients/cmt_speech.c
+++ b/drivers/hsi/clients/cmt_speech.c
@@ -1270,7 +1270,8 @@ static long cs_char_ioctl(struct file *f
 	return r;
 }
 
-static int cs_char_mmap(struct file *file, struct vm_area_struct *vma)
+static int cs_char_mmap(struct file *file, struct vm_area_struct *vma,
+			unsigned long map_flags)
 {
 	if (vma->vm_end < vma->vm_start)
 		return -EINVAL;
diff -u -p a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -75,7 +75,8 @@ static int hfi1_file_open(struct inode *
 static int hfi1_file_close(struct inode *inode, struct file *fp);
 static ssize_t hfi1_write_iter(struct kiocb *kiocb, struct iov_iter *from);
 static unsigned int hfi1_poll(struct file *fp, struct poll_table_struct *pt);
-static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma);
+static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma,
+			  unsigned long map_flags);
 
 static u64 kvirt_to_phys(void *addr);
 static int assign_ctxt(struct hfi1_filedata *fd, struct hfi1_user_info *uinfo);
@@ -455,7 +456,8 @@ static ssize_t hfi1_write_iter(struct ki
 	return reqs;
 }
 
-static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
+static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma,
+			  unsigned long map_flags)
 {
 	struct hfi1_filedata *fd = fp->private_data;
 	struct hfi1_ctxtdata *uctxt = fd->uctxt;
diff -u -p a/drivers/android/binder.c b/drivers/android/binder.c
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4332,7 +4332,8 @@ static const struct vm_operations_struct
 	.fault = binder_vm_fault,
 };
 
-static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
+static int binder_mmap(struct file *filp, struct vm_area_struct *vma,
+		       unsigned long map_flags)
 {
 	int ret;
 	struct binder_proc *proc = filp->private_data;
diff -u -p a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -503,7 +503,8 @@ int vc4_get_hang_state_ioctl(struct drm_
 			     struct drm_file *file_priv);
 int vc4_label_bo_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *file_priv);
-int vc4_mmap(struct file *filp, struct vm_area_struct *vma);
+int vc4_mmap(struct file *filp, struct vm_area_struct *vma,
+	     unsigned long map_flags);
 struct reservation_object *vc4_prime_res_obj(struct drm_gem_object *obj);
 int vc4_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
 struct drm_gem_object *vc4_prime_import_sg_table(struct drm_device *dev,
diff -u -p a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -489,7 +489,8 @@ vc4_prime_export(struct drm_device *dev,
 	return drm_gem_prime_export(dev, obj, flags);
 }
 
-int vc4_mmap(struct file *filp, struct vm_area_struct *vma)
+int vc4_mmap(struct file *filp, struct vm_area_struct *vma,
+	     unsigned long map_flags)
 {
 	struct drm_gem_object *gem_obj;
 	struct vc4_bo *bo;
diff -u -p a/fs/proc/inode.c b/fs/proc/inode.c
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -277,7 +277,8 @@ static long proc_reg_compat_ioctl(struct
 }
 #endif
 
-static int proc_reg_mmap(struct file *file, struct vm_area_struct *vma)
+static int proc_reg_mmap(struct file *file, struct vm_area_struct *vma,
+			 unsigned long map_flags)
 {
 	struct proc_dir_entry *pde = PDE(file_inode(file));
 	int rv = -EIO;
diff -u -p a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2592,7 +2592,8 @@ int generic_file_mmap(struct file * file
 /*
  * This is for filesystems which do not implement ->writepage.
  */
-int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
+int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma,
+			       unsigned long map_flags)
 {
 	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
 		return -EINVAL;
@@ -2603,7 +2604,9 @@ int generic_file_mmap(struct file * file
 {
 	return -ENOSYS;
 }
-int generic_file_readonly_mmap(struct file * file, struct vm_area_struct * vma)
+int generic_file_readonly_mmap(struct file * file,
+			       struct vm_area_struct * vma,
+			       unsigned long map_flags)
 {
 	return -ENOSYS;
 }
diff -u -p a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2881,7 +2881,8 @@ extern int sb_set_blocksize(struct super
 extern int sb_min_blocksize(struct super_block *, int);
 
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
-extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
+extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *,
+				      unsigned long);
 extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
diff -u -p a/arch/powerpc/platforms/powernv/opal-prd.c b/arch/powerpc/platforms/powernv/opal-prd.c
--- a/arch/powerpc/platforms/powernv/opal-prd.c
+++ b/arch/powerpc/platforms/powernv/opal-prd.c
@@ -109,7 +109,8 @@ static int opal_prd_open(struct inode *i
  * @vma: VMA to map the registers into
  */
 
-static int opal_prd_mmap(struct file *file, struct vm_area_struct *vma)
+static int opal_prd_mmap(struct file *file, struct vm_area_struct *vma,
+			 unsigned long map_flags)
 {
 	size_t addr, size;
 	pgprot_t page_prot;
diff -u -p a/drivers/char/mspec.c b/drivers/char/mspec.c
--- a/drivers/char/mspec.c
+++ b/drivers/char/mspec.c
@@ -287,7 +287,8 @@ mspec_mmap(struct file *file, struct vm_
 }
 
 static int
-fetchop_mmap(struct file *file, struct vm_area_struct *vma)
+fetchop_mmap(struct file *file, struct vm_area_struct *vma,
+	     unsigned long map_flags)
 {
 	return mspec_mmap(file, vma, MSPEC_FETCHOP);
 }
diff -u -p a/sound/core/init.c b/sound/core/init.c
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -355,7 +355,8 @@ static long snd_disconnect_ioctl(struct
 	return -ENODEV;
 }
 
-static int snd_disconnect_mmap(struct file *file, struct vm_area_struct *vma)
+static int snd_disconnect_mmap(struct file *file, struct vm_area_struct *vma,
+			       unsigned long map_flags)
 {
 	return -ENODEV;
 }
diff -u -p a/arch/arc/kernel/arc_hostlink.c b/arch/arc/kernel/arc_hostlink.c
--- a/arch/arc/kernel/arc_hostlink.c
+++ b/arch/arc/kernel/arc_hostlink.c
@@ -18,7 +18,8 @@
 
 static unsigned char __HOSTLINK__[4 * PAGE_SIZE] __aligned(PAGE_SIZE);
 
-static int arc_hl_mmap(struct file *fp, struct vm_area_struct *vma)
+static int arc_hl_mmap(struct file *fp, struct vm_area_struct *vma,
+		       unsigned long map_flags)
 {
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
diff -u -p a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -194,7 +194,8 @@ void msm_gem_shrinker_cleanup(struct drm
 
 int msm_gem_mmap_obj(struct drm_gem_object *obj,
 			struct vm_area_struct *vma);
-int msm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
+int msm_gem_mmap(struct file *filp, struct vm_area_struct *vma,
+		 unsigned long map_flags);
 int msm_gem_fault(struct vm_fault *vmf);
 uint64_t msm_gem_mmap_offset(struct drm_gem_object *obj);
 int msm_gem_get_iova(struct drm_gem_object *obj,
diff -u -p a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -198,7 +198,8 @@ int msm_gem_mmap_obj(struct drm_gem_obje
 	return 0;
 }
 
-int msm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
+int msm_gem_mmap(struct file *filp, struct vm_area_struct *vma,
+		 unsigned long map_flags)
 {
 	int ret;
 
diff -u -p a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -479,7 +479,8 @@ pxa3xx_gcu_ioctl(struct file *file, unsi
 }
 
 static int
-pxa3xx_gcu_mmap(struct file *file, struct vm_area_struct *vma)
+pxa3xx_gcu_mmap(struct file *file, struct vm_area_struct *vma,
+		unsigned long map_flags)
 {
 	unsigned int size = vma->vm_end - vma->vm_start;
 	struct pxa3xx_gcu_priv *priv = to_pxa3xx_gcu_priv(file);
diff -u -p a/fs/ceph/super.h b/fs/ceph/super.h
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -942,7 +942,8 @@ extern void ceph_put_fmode(struct ceph_i
 
 /* addr.c */
 extern const struct address_space_operations ceph_aops;
-extern int ceph_mmap(struct file *file, struct vm_area_struct *vma);
+extern int ceph_mmap(struct file *file, struct vm_area_struct *vma,
+		     unsigned long map_flags);
 extern int ceph_uninline_data(struct file *filp, struct page *locked_page);
 extern int ceph_pool_perm_check(struct ceph_inode_info *ci, int need);
 extern void ceph_pool_perm_destroy(struct ceph_mds_client* mdsc);
diff -u -p a/fs/ceph/addr.c b/fs/ceph/addr.c
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1761,7 +1761,8 @@ static const struct vm_operations_struct
 	.page_mkwrite	= ceph_page_mkwrite,
 };
 
-int ceph_mmap(struct file *file, struct vm_area_struct *vma)
+int ceph_mmap(struct file *file, struct vm_area_struct *vma,
+	      unsigned long map_flags)
 {
 	struct address_space *mapping = file->f_mapping;
 
diff -u -p a/drivers/misc/sgi-gru/grufile.c b/drivers/misc/sgi-gru/grufile.c
--- a/drivers/misc/sgi-gru/grufile.c
+++ b/drivers/misc/sgi-gru/grufile.c
@@ -104,7 +104,8 @@ static void gru_vma_close(struct vm_area
  * and private data structure necessary to allocate, track, and free the
  * underlying pages.
  */
-static int gru_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int gru_file_mmap(struct file *file, struct vm_area_struct *vma,
+			 unsigned long map_flags)
 {
 	if ((vma->vm_flags & (VM_SHARED | VM_WRITE)) != (VM_SHARED | VM_WRITE))
 		return -EPERM;
diff -u -p a/fs/romfs/mmap-nommu.c b/fs/romfs/mmap-nommu.c
--- a/fs/romfs/mmap-nommu.c
+++ b/fs/romfs/mmap-nommu.c
@@ -65,7 +65,8 @@ static unsigned long romfs_get_unmapped_
  * permit a R/O mapping to be made directly through onto an MTD device if
  * possible
  */
-static int romfs_mmap(struct file *file, struct vm_area_struct *vma)
+static int romfs_mmap(struct file *file, struct vm_area_struct *vma,
+		      unsigned long map_flags)
 {
 	return vma->vm_flags & (VM_SHARED | VM_MAYSHARE) ? 0 : -ENOSYS;
 }
diff -u -p a/fs/ocfs2/mmap.h b/fs/ocfs2/mmap.h
--- a/fs/ocfs2/mmap.h
+++ b/fs/ocfs2/mmap.h
@@ -1,6 +1,7 @@
 #ifndef OCFS2_MMAP_H
 #define OCFS2_MMAP_H
 
-int ocfs2_mmap(struct file *file, struct vm_area_struct *vma);
+int ocfs2_mmap(struct file *file, struct vm_area_struct *vma,
+	       unsigned long map_flags);
 
 #endif  /* OCFS2_MMAP_H */
diff -u -p a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -179,7 +179,8 @@ static const struct vm_operations_struct
 	.page_mkwrite	= ocfs2_page_mkwrite,
 };
 
-int ocfs2_mmap(struct file *file, struct vm_area_struct *vma)
+int ocfs2_mmap(struct file *file, struct vm_area_struct *vma,
+	       unsigned long map_flags)
 {
 	int ret = 0, lock_level = 0;
 
diff -u -p a/include/drm/drm_legacy.h b/include/drm/drm_legacy.h
--- a/include/drm/drm_legacy.h
+++ b/include/drm/drm_legacy.h
@@ -161,7 +161,8 @@ int drm_legacy_rmmap_locked(struct drm_d
 void drm_legacy_master_rmmaps(struct drm_device *dev,
 			      struct drm_master *master);
 struct drm_local_map *drm_legacy_getsarea(struct drm_device *dev);
-int drm_legacy_mmap(struct file *filp, struct vm_area_struct *vma);
+int drm_legacy_mmap(struct file *filp, struct vm_area_struct *vma,
+		    unsigned long map_flags);
 
 int drm_legacy_addbufs_agp(struct drm_device *d, struct drm_buf_desc *req);
 int drm_legacy_addbufs_pci(struct drm_device *d, struct drm_buf_desc *req);
diff -u -p a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
--- a/drivers/gpu/drm/drm_vm.c
+++ b/drivers/gpu/drm/drm_vm.c
@@ -629,7 +629,8 @@ static int drm_mmap_locked(struct file *
 	return 0;
 }
 
-int drm_legacy_mmap(struct file *filp, struct vm_area_struct *vma)
+int drm_legacy_mmap(struct file *filp, struct vm_area_struct *vma,
+		    unsigned long map_flags)
 {
 	struct drm_file *priv = filp->private_data;
 	struct drm_device *dev = priv->minor->dev;
diff -u -p a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2578,7 +2578,8 @@ const struct vm_operations_struct generi
 
 /* This is used for a general mmap of a disk file */
 
-int generic_file_mmap(struct file * file, struct vm_area_struct * vma)
+int generic_file_mmap(struct file * file, struct vm_area_struct * vma,
+		      unsigned long map_flags)
 {
 	struct address_space *mapping = file->f_mapping;
 
@@ -2600,7 +2601,8 @@ int generic_file_readonly_mmap(struct fi
 	return generic_file_mmap(file, vma);
 }
 #else
-int generic_file_mmap(struct file * file, struct vm_area_struct * vma)
+int generic_file_mmap(struct file * file, struct vm_area_struct * vma,
+		      unsigned long map_flags)
 {
 	return -ENOSYS;
 }
diff -u -p a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2880,7 +2880,8 @@ extern int set_blocksize(struct block_de
 extern int sb_set_blocksize(struct super_block *, int);
 extern int sb_min_blocksize(struct super_block *, int);
 
-extern int generic_file_mmap(struct file *, struct vm_area_struct *);
+extern int generic_file_mmap(struct file *, struct vm_area_struct *,
+			     unsigned long);
 extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *,
 				      unsigned long);
 extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
diff -u -p a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -2185,7 +2185,8 @@ static const struct vm_operations_struct
 	.access = comedi_vm_access,
 };
 
-static int comedi_mmap(struct file *file, struct vm_area_struct *vma)
+static int comedi_mmap(struct file *file, struct vm_area_struct *vma,
+		       unsigned long map_flags)
 {
 	struct comedi_file *cfp = file->private_data;
 	struct comedi_device *dev = cfp->dev;
diff -u -p a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -169,7 +169,8 @@ out:
 	return rc;
 }
 
-static int ecryptfs_mmap(struct file *file, struct vm_area_struct *vma)
+static int ecryptfs_mmap(struct file *file, struct vm_area_struct *vma,
+			 unsigned long map_flags)
 {
 	struct file *lower_file = ecryptfs_file_to_lower(file);
 	/*
diff -u -p a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -388,7 +388,8 @@ static unsigned long v4l2_get_unmapped_a
 }
 #endif
 
-static int v4l2_mmap(struct file *filp, struct vm_area_struct *vm)
+static int v4l2_mmap(struct file *filp, struct vm_area_struct *vm,
+		     unsigned long map_flags)
 {
 	struct video_device *vdev = video_devdata(filp);
 	int ret = -ENODEV;
diff -u -p a/fs/fuse/file.c b/fs/fuse/file.c
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2073,7 +2073,8 @@ static int fuse_file_mmap(struct file *f
 	return 0;
 }
 
-static int fuse_direct_mmap(struct file *file, struct vm_area_struct *vma)
+static int fuse_direct_mmap(struct file *file, struct vm_area_struct *vma,
+			    unsigned long map_flags)
 {
 	/* Can't provide the coherency needed for MAP_SHARED */
 	if (vma->vm_flags & VM_MAYSHARE)
diff -u -p a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -1321,7 +1321,8 @@ static const struct vm_operations_struct
 /*
  * mmap support for problem state MFC DMA area [0x0000 - 0x0fff].
  */
-static int spufs_mss_mmap(struct file *file, struct vm_area_struct *vma)
+static int spufs_mss_mmap(struct file *file, struct vm_area_struct *vma,
+			  unsigned long map_flags)
 {
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
diff -u -p a/fs/gfs2/file.c b/fs/gfs2/file.c
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -506,7 +506,8 @@ static const struct vm_operations_struct
  * Returns: 0
  */
 
-static int gfs2_mmap(struct file *file, struct vm_area_struct *vma)
+static int gfs2_mmap(struct file *file, struct vm_area_struct *vma,
+		     unsigned long map_flags)
 {
 	struct gfs2_inode *ip = GFS2_I(file->f_mapping->host);
 
diff -u -p a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -291,7 +291,8 @@ static const struct vm_operations_struct
 	.access = spufs_mem_mmap_access,
 };
 
-static int spufs_mem_mmap(struct file *file, struct vm_area_struct *vma)
+static int spufs_mem_mmap(struct file *file, struct vm_area_struct *vma,
+			  unsigned long map_flags)
 {
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
diff -u -p a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -77,7 +77,8 @@ int amdgpu_fill_buffer(struct amdgpu_bo
 			struct reservation_object *resv,
 			struct dma_fence **fence);
 
-int amdgpu_mmap(struct file *filp, struct vm_area_struct *vma);
+int amdgpu_mmap(struct file *filp, struct vm_area_struct *vma,
+		unsigned long map_flags);
 bool amdgpu_ttm_is_bound(struct ttm_tt *ttm);
 int amdgpu_ttm_bind(struct ttm_buffer_object *bo, struct ttm_mem_reg *bo_mem);
 int amdgpu_ttm_recover_gart(struct amdgpu_device *adev);
diff -u -p a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1356,7 +1356,8 @@ void amdgpu_ttm_set_active_vram_size(str
 	man->size = size >> PAGE_SHIFT;
 }
 
-int amdgpu_mmap(struct file *filp, struct vm_area_struct *vma)
+int amdgpu_mmap(struct file *filp, struct vm_area_struct *vma,
+		unsigned long map_flags)
 {
 	struct drm_file *file_priv;
 	struct amdgpu_device *adev;
diff -u -p a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -215,7 +215,8 @@ static ssize_t sel_read_handle_status(st
 }
 
 static int sel_mmap_handle_status(struct file *filp,
-				  struct vm_area_struct *vma)
+				  struct vm_area_struct *vma,
+				  unsigned long map_flags)
 {
 	struct page    *status = filp->private_data;
 	unsigned long	size = vma->vm_end - vma->vm_start;
diff -u -p a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -375,7 +375,8 @@ static inline vm_flags_t calc_vm_may_fla
 	       _calc_vm_trans(prot, PROT_EXEC,  VM_MAYEXEC);
 }
 
-static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
+static int ashmem_mmap(struct file *file, struct vm_area_struct *vma,
+		       unsigned long map_flags)
 {
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
diff -u -p a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -339,7 +339,8 @@ struct drm_plane *virtio_gpu_plane_init(
 /* virtio_gpu_ttm.c */
 int virtio_gpu_ttm_init(struct virtio_gpu_device *vgdev);
 void virtio_gpu_ttm_fini(struct virtio_gpu_device *vgdev);
-int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma);
+int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma,
+		    unsigned long map_flags);
 
 /* virtio_gpu_fence.c */
 int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
diff -u -p a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
--- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
@@ -129,7 +129,8 @@ static int virtio_gpu_ttm_fault(struct v
 }
 #endif
 
-int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma)
+int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma,
+		    unsigned long map_flags)
 {
 	struct drm_file *file_priv;
 	struct virtio_gpu_device *vgdev;
diff -u -p a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -72,7 +72,8 @@ static inline void etnaviv_queue_work(st
 int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 		struct drm_file *file);
 
-int etnaviv_gem_mmap(struct file *filp, struct vm_area_struct *vma);
+int etnaviv_gem_mmap(struct file *filp, struct vm_area_struct *vma,
+		     unsigned long map_flags);
 int etnaviv_gem_fault(struct vm_fault *vmf);
 int etnaviv_gem_mmap_offset(struct drm_gem_object *obj, u64 *offset);
 struct sg_table *etnaviv_gem_prime_get_sg_table(struct drm_gem_object *obj);
diff -u -p a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -162,7 +162,8 @@ static int etnaviv_gem_mmap_obj(struct e
 	return 0;
 }
 
-int etnaviv_gem_mmap(struct file *filp, struct vm_area_struct *vma)
+int etnaviv_gem_mmap(struct file *filp, struct vm_area_struct *vma,
+		     unsigned long map_flags)
 {
 	struct etnaviv_gem_object *obj;
 	int ret;
diff -u -p a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -742,7 +742,8 @@ extern int vmw_fifo_flush(struct vmw_pri
 
 extern int vmw_ttm_global_init(struct vmw_private *dev_priv);
 extern void vmw_ttm_global_release(struct vmw_private *dev_priv);
-extern int vmw_mmap(struct file *filp, struct vm_area_struct *vma);
+extern int vmw_mmap(struct file *filp, struct vm_area_struct *vma,
+		    unsigned long map_flags);
 
 /**
  * TTM buffer object driver - vmwgfx_buffer.c
diff -u -p a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
@@ -28,7 +28,8 @@
 #include <drm/drmP.h>
 #include "vmwgfx_drv.h"
 
-int vmw_mmap(struct file *filp, struct vm_area_struct *vma)
+int vmw_mmap(struct file *filp, struct vm_area_struct *vma,
+	     unsigned long map_flags)
 {
 	struct drm_file *file_priv;
 	struct vmw_private *dev_priv;
diff -u -p a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -33,7 +33,8 @@ static struct {
 #define FLASH_MINOR	152
 
 static int
-flash_mmap(struct file *file, struct vm_area_struct *vma)
+flash_mmap(struct file *file, struct vm_area_struct *vma,
+	   unsigned long map_flags)
 {
 	unsigned long addr;
 	unsigned long size;
diff -u -p a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1677,7 +1677,9 @@ static ssize_t vfio_device_fops_write(st
 	return device->ops->write(device->device_data, buf, count, ppos);
 }
 
-static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
+static int vfio_device_fops_mmap(struct file *filep,
+				 struct vm_area_struct *vma,
+				 unsigned long map_flags)
 {
 	struct vfio_device *device = filep->private_data;
 
diff -u -p a/drivers/char/agp/frontend.c b/drivers/char/agp/frontend.c
--- a/drivers/char/agp/frontend.c
+++ b/drivers/char/agp/frontend.c
@@ -562,7 +562,8 @@ int agp_remove_client(pid_t id)
 
 /* File Operations */
 
-static int agp_mmap(struct file *file, struct vm_area_struct *vma)
+static int agp_mmap(struct file *file, struct vm_area_struct *vma,
+		    unsigned long map_flags)
 {
 	unsigned int size, current_size;
 	unsigned long offset;
diff -u -p a/drivers/char/hpet.c b/drivers/char/hpet.c
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -379,7 +379,8 @@ static __init int hpet_mmap_enable(char
 }
 __setup("hpet_mmap", hpet_mmap_enable);
 
-static int hpet_mmap(struct file *file, struct vm_area_struct *vma)
+static int hpet_mmap(struct file *file, struct vm_area_struct *vma,
+		     unsigned long map_flags)
 {
 	struct hpet_dev *devp;
 	unsigned long addr;
@@ -397,7 +398,8 @@ static int hpet_mmap(struct file *file,
 	return vm_iomap_memory(vma, addr, PAGE_SIZE);
 }
 #else
-static int hpet_mmap(struct file *file, struct vm_area_struct *vma)
+static int hpet_mmap(struct file *file, struct vm_area_struct *vma,
+		     unsigned long map_flags)
 {
 	return -ENOSYS;
 }
diff -u -p a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -1246,7 +1246,8 @@ static const struct vm_operations_struct
 	.fault =    mon_bin_vma_fault,
 };
 
-static int mon_bin_mmap(struct file *filp, struct vm_area_struct *vma)
+static int mon_bin_mmap(struct file *filp, struct vm_area_struct *vma,
+			unsigned long map_flags)
 {
 	/* don't do anything here: "fault" will set up page table entries */
 	vma->vm_ops = &mon_bin_vm_ops;
diff -u -p a/drivers/gpu/drm/nouveau/nouveau_ttm.h b/drivers/gpu/drm/nouveau/nouveau_ttm.h
--- a/drivers/gpu/drm/nouveau/nouveau_ttm.h
+++ b/drivers/gpu/drm/nouveau/nouveau_ttm.h
@@ -17,7 +17,7 @@ struct ttm_tt *nouveau_sgdma_create_ttm(
 
 int  nouveau_ttm_init(struct nouveau_drm *drm);
 void nouveau_ttm_fini(struct nouveau_drm *drm);
-int  nouveau_ttm_mmap(struct file *, struct vm_area_struct *);
+int  nouveau_ttm_mmap(struct file *, struct vm_area_struct *, unsigned long);
 
 int  nouveau_ttm_global_init(struct nouveau_drm *);
 void nouveau_ttm_global_release(struct nouveau_drm *);
diff -u -p a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
--- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
@@ -265,7 +265,8 @@ const struct ttm_mem_type_manager_func n
 };
 
 int
-nouveau_ttm_mmap(struct file *filp, struct vm_area_struct *vma)
+nouveau_ttm_mmap(struct file *filp, struct vm_area_struct *vma,
+		 unsigned long map_flags)
 {
 	struct drm_file *file_priv = filp->private_data;
 	struct nouveau_drm *drm = nouveau_drm(file_priv->minor->dev);
diff -u -p a/kernel/relay.c b/kernel/relay.c
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -906,7 +906,8 @@ static int relay_file_open(struct inode
  *
  *	Calls upon relay_mmap_buf() to map the file into user space.
  */
-static int relay_file_mmap(struct file *filp, struct vm_area_struct *vma)
+static int relay_file_mmap(struct file *filp, struct vm_area_struct *vma,
+			   unsigned long map_flags)
 {
 	struct rchan_buf *buf = filp->private_data;
 	return relay_mmap_buf(buf, vma);
diff -u -p a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2716,7 +2716,8 @@ static unsigned int snd_pcm_oss_poll(str
 	return mask;
 }
 
-static int snd_pcm_oss_mmap(struct file *file, struct vm_area_struct *area)
+static int snd_pcm_oss_mmap(struct file *file, struct vm_area_struct *area,
+			    unsigned long map_flags)
 {
 	struct snd_pcm_oss_file *pcm_oss_file;
 	struct snd_pcm_substream *substream = NULL;
diff -u -p a/fs/proc/vmcore.c b/fs/proc/vmcore.c
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -406,7 +406,8 @@ static int vmcore_remap_oldmem_pfn(struc
 		return remap_oldmem_pfn_range(vma, from, pfn, size, prot);
 }
 
-static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
+static int mmap_vmcore(struct file *file, struct vm_area_struct *vma,
+		       unsigned long map_flags)
 {
 	size_t size = vma->vm_end - vma->vm_start;
 	u64 start, end, len, tsz;
@@ -485,7 +486,8 @@ fail:
 	return -EAGAIN;
 }
 #else
-static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
+static int mmap_vmcore(struct file *file, struct vm_area_struct *vma,
+		       unsigned long map_flags)
 {
 	return -ENOSYS;
 }
diff -u -p a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
--- a/drivers/misc/aspeed-lpc-ctrl.c
+++ b/drivers/misc/aspeed-lpc-ctrl.c
@@ -38,7 +38,8 @@ static struct aspeed_lpc_ctrl *file_aspe
 			miscdev);
 }
 
-static int aspeed_lpc_ctrl_mmap(struct file *file, struct vm_area_struct *vma)
+static int aspeed_lpc_ctrl_mmap(struct file *file, struct vm_area_struct *vma,
+				unsigned long map_flags)
 {
 	struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
 	unsigned long vsize = vma->vm_end - vma->vm_start;
diff -u -p a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -1385,7 +1385,8 @@ static const struct vm_operations_struct
 /*
  * mmap support for full problem state area [0x00000 - 0x1ffff].
  */
-static int spufs_psmap_mmap(struct file *file, struct vm_area_struct *vma)
+static int spufs_psmap_mmap(struct file *file, struct vm_area_struct *vma,
+			    unsigned long map_flags)
 {
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
diff -u -p a/drivers/gpu/drm/cirrus/cirrus_drv.h b/drivers/gpu/drm/cirrus/cirrus_drv.h
--- a/drivers/gpu/drm/cirrus/cirrus_drv.h
+++ b/drivers/gpu/drm/cirrus/cirrus_drv.h
@@ -232,7 +232,8 @@ void cirrus_mm_fini(struct cirrus_device
 void cirrus_ttm_placement(struct cirrus_bo *bo, int domain);
 int cirrus_bo_create(struct drm_device *dev, int size, int align,
 		     uint32_t flags, struct cirrus_bo **pcirrusbo);
-int cirrus_mmap(struct file *filp, struct vm_area_struct *vma);
+int cirrus_mmap(struct file *filp, struct vm_area_struct *vma,
+		unsigned long map_flags);
 
 static inline int cirrus_bo_reserve(struct cirrus_bo *bo, bool no_wait)
 {
diff -u -p a/drivers/gpu/drm/cirrus/cirrus_ttm.c b/drivers/gpu/drm/cirrus/cirrus_ttm.c
--- a/drivers/gpu/drm/cirrus/cirrus_ttm.c
+++ b/drivers/gpu/drm/cirrus/cirrus_ttm.c
@@ -405,7 +405,8 @@ int cirrus_bo_push_sysram(struct cirrus_
 	return 0;
 }
 
-int cirrus_mmap(struct file *filp, struct vm_area_struct *vma)
+int cirrus_mmap(struct file *filp, struct vm_area_struct *vma,
+		unsigned long map_flags)
 {
 	struct drm_file *file_priv;
 	struct cirrus_device *cirrus;
diff -u -p a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
@@ -42,7 +42,8 @@ void *rockchip_gem_prime_vmap(struct drm
 void rockchip_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
 
 /* drm driver mmap file operations */
-int rockchip_gem_mmap(struct file *filp, struct vm_area_struct *vma);
+int rockchip_gem_mmap(struct file *filp, struct vm_area_struct *vma,
+		      unsigned long map_flags);
 
 /* mmap a gem object to userspace. */
 int rockchip_gem_mmap_buf(struct drm_gem_object *obj,
diff -u -p a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -288,7 +288,8 @@ int rockchip_gem_mmap_buf(struct drm_gem
 }
 
 /* drm driver mmap file operations */
-int rockchip_gem_mmap(struct file *filp, struct vm_area_struct *vma)
+int rockchip_gem_mmap(struct file *filp, struct vm_area_struct *vma,
+		      unsigned long map_flags)
 {
 	struct drm_gem_object *obj;
 	int ret;
diff -u -p a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -679,7 +679,8 @@ static ssize_t read_iter_zero(struct kio
 	return written;
 }
 
-static int mmap_zero(struct file *file, struct vm_area_struct *vma)
+static int mmap_zero(struct file *file, struct vm_area_struct *vma,
+		     unsigned long map_flags)
 {
 #ifndef CONFIG_MMU
 	return -ENOSYS;
diff -u -p a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -376,7 +376,8 @@ static int mmap_mem(struct file *file, s
 	return 0;
 }
 
-static int mmap_kmem(struct file *file, struct vm_area_struct *vma)
+static int mmap_kmem(struct file *file, struct vm_area_struct *vma,
+		     unsigned long map_flags)
 {
 	unsigned long pfn;
 
diff -u -p a/fs/f2fs/file.c b/fs/f2fs/file.c
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -436,7 +436,8 @@ static loff_t f2fs_llseek(struct file *f
 	return -EINVAL;
 }
 
-static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma,
+			  unsigned long map_flags)
 {
 	struct inode *inode = file_inode(file);
 	int err;
diff -u -p a/drivers/char/bsr.c b/drivers/char/bsr.c
--- a/drivers/char/bsr.c
+++ b/drivers/char/bsr.c
@@ -122,7 +122,8 @@ static struct attribute *bsr_dev_attrs[]
 };
 ATTRIBUTE_GROUPS(bsr_dev);
 
-static int bsr_mmap(struct file *filp, struct vm_area_struct *vma)
+static int bsr_mmap(struct file *filp, struct vm_area_struct *vma,
+		    unsigned long map_flags)
 {
 	unsigned long size   = vma->vm_end - vma->vm_start;
 	struct bsr_dev *dev = filp->private_data;
diff -u -p a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -215,7 +215,8 @@ static struct vm_operations_struct usbde
 	.close = usbdev_vm_close
 };
 
-static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
+static int usbdev_mmap(struct file *file, struct vm_area_struct *vma,
+		       unsigned long map_flags)
 {
 	struct usb_memory *usbm = NULL;
 	struct usb_dev_state *ps = file->private_data;
diff -u -p a/drivers/char/uv_mmtimer.c b/drivers/char/uv_mmtimer.c
--- a/drivers/char/uv_mmtimer.c
+++ b/drivers/char/uv_mmtimer.c
@@ -40,7 +40,8 @@ MODULE_LICENSE("GPL");
 
 static long uv_mmtimer_ioctl(struct file *file, unsigned int cmd,
 						unsigned long arg);
-static int uv_mmtimer_mmap(struct file *file, struct vm_area_struct *vma);
+static int uv_mmtimer_mmap(struct file *file, struct vm_area_struct *vma,
+			   unsigned long map_flags);
 
 /*
  * Period in femtoseconds (10^-15 s)
@@ -144,7 +145,8 @@ static long uv_mmtimer_ioctl(struct file
  * Calls remap_pfn_range() to map the clock's registers into
  * the calling process' address space.
  */
-static int uv_mmtimer_mmap(struct file *file, struct vm_area_struct *vma)
+static int uv_mmtimer_mmap(struct file *file, struct vm_area_struct *vma,
+			   unsigned long map_flags)
 {
 	unsigned long uv_mmtimer_addr;
 
diff -u -p a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1382,7 +1382,8 @@ static long fb_compat_ioctl(struct file
 #endif
 
 static int
-fb_mmap(struct file *file, struct vm_area_struct * vma)
+fb_mmap(struct file *file, struct vm_area_struct * vma,
+	unsigned long map_flags)
 {
 	struct fb_info *info = file_fb_info(file);
 	struct fb_ops *fb;
diff -u -p a/fs/ext2/file.c b/fs/ext2/file.c
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -118,7 +118,8 @@ static const struct vm_operations_struct
 	.pfn_mkwrite	= ext2_dax_fault,
 };
 
-static int ext2_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int ext2_file_mmap(struct file *file, struct vm_area_struct *vma,
+			  unsigned long map_flags)
 {
 	if (!IS_DAX(file_inode(file)))
 		return generic_file_mmap(file, vma);
diff -u -p a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2132,7 +2132,8 @@ out_nomem:
 	return retval;
 }
 
-static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
+static int shmem_mmap(struct file *file, struct vm_area_struct *vma,
+		      unsigned long map_flags)
 {
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
diff -u -p a/drivers/char/mbcs.h b/drivers/char/mbcs.h
--- a/drivers/char/mbcs.h
+++ b/drivers/char/mbcs.h
@@ -548,6 +548,7 @@ static ssize_t mbcs_sram_read(struct fil
 static ssize_t mbcs_sram_write(struct file *fp, const char __user *buf, size_t len,
 			       loff_t * off);
 static loff_t mbcs_sram_llseek(struct file *filp, loff_t off, int whence);
-static int mbcs_gscr_mmap(struct file *fp, struct vm_area_struct *vma);
+static int mbcs_gscr_mmap(struct file *fp, struct vm_area_struct *vma,
+			  unsigned long map_flags);
 
 #endif				// __MBCS_H__
diff -u -p a/drivers/char/mbcs.c b/drivers/char/mbcs.c
--- a/drivers/char/mbcs.c
+++ b/drivers/char/mbcs.c
@@ -475,7 +475,8 @@ static void mbcs_gscr_pioaddr_set(struct
 	soft->gscr_addr = mbcs_pioaddr(soft, MBCS_GSCR_START);
 }
 
-static int mbcs_gscr_mmap(struct file *fp, struct vm_area_struct *vma)
+static int mbcs_gscr_mmap(struct file *fp, struct vm_area_struct *vma,
+			  unsigned long map_flags)
 {
 	struct cx_dev *cx_dev = fp->private_data;
 	struct mbcs_soft *soft = cx_dev->soft;
diff -u -p a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -81,7 +81,9 @@ static int dma_buf_release(struct inode
 	return 0;
 }
 
-static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
+static int dma_buf_mmap_internal(struct file *file,
+				 struct vm_area_struct *vma,
+				 unsigned long map_flags)
 {
 	struct dma_buf *dmabuf;
 
diff -u -p a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -980,7 +980,8 @@ static long gntdev_ioctl(struct file *fl
 	return 0;
 }
 
-static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
+static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma,
+		       unsigned long map_flags)
 {
 	struct gntdev_priv *priv = flip->private_data;
 	int index = vma->vm_pgoff;
diff -u -p a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -133,7 +133,8 @@ int udl_gem_get_pages(struct udl_gem_obj
 void udl_gem_put_pages(struct udl_gem_object *obj);
 int udl_gem_vmap(struct udl_gem_object *obj);
 void udl_gem_vunmap(struct udl_gem_object *obj);
-int udl_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
+int udl_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma,
+		     unsigned long map_flags);
 int udl_gem_fault(struct vm_fault *vmf);
 
 int udl_handle_damage(struct udl_framebuffer *fb, int x, int y,
diff -u -p a/drivers/gpu/drm/udl/udl_gem.c b/drivers/gpu/drm/udl/udl_gem.c
--- a/drivers/gpu/drm/udl/udl_gem.c
+++ b/drivers/gpu/drm/udl/udl_gem.c
@@ -84,7 +84,8 @@ int udl_dumb_create(struct drm_file *fil
 			      args->size, &args->handle);
 }
 
-int udl_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
+int udl_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma,
+		     unsigned long map_flags)
 {
 	int ret;
 
diff -u -p a/drivers/gpu/drm/i810/i810_dma.c b/drivers/gpu/drm/i810/i810_dma.c
--- a/drivers/gpu/drm/i810/i810_dma.c
+++ b/drivers/gpu/drm/i810/i810_dma.c
@@ -84,7 +84,8 @@ static int i810_freelist_put(struct drm_
 	return 0;
 }
 
-static int i810_mmap_buffers(struct file *filp, struct vm_area_struct *vma)
+static int i810_mmap_buffers(struct file *filp, struct vm_area_struct *vma,
+			     unsigned long map_flags)
 {
 	struct drm_file *priv = filp->private_data;
 	struct drm_device *dev;
diff -u -p a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -519,7 +519,8 @@ static const struct vm_operations_struct
 	.close	= stm_mmap_close,
 };
 
-static int stm_char_mmap(struct file *file, struct vm_area_struct *vma)
+static int stm_char_mmap(struct file *file, struct vm_area_struct *vma,
+			 unsigned long map_flags)
 {
 	struct stm_file *stmf = file->private_data;
 	struct stm_device *stm = stmf->stm;
diff -u -p a/drivers/gpu/drm/tegra/gem.h b/drivers/gpu/drm/tegra/gem.h
--- a/drivers/gpu/drm/tegra/gem.h
+++ b/drivers/gpu/drm/tegra/gem.h
@@ -68,7 +68,8 @@ void tegra_bo_free_object(struct drm_gem
 int tegra_bo_dumb_create(struct drm_file *file, struct drm_device *drm,
 			 struct drm_mode_create_dumb *args);
 
-int tegra_drm_mmap(struct file *file, struct vm_area_struct *vma);
+int tegra_drm_mmap(struct file *file, struct vm_area_struct *vma,
+		   unsigned long map_flags);
 
 extern const struct vm_operations_struct tegra_bo_vm_ops;
 
diff -u -p a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -460,7 +460,8 @@ const struct vm_operations_struct tegra_
 	.close = drm_gem_vm_close,
 };
 
-int tegra_drm_mmap(struct file *file, struct vm_area_struct *vma)
+int tegra_drm_mmap(struct file *file, struct vm_area_struct *vma,
+		   unsigned long map_flags)
 {
 	struct drm_gem_object *gem;
 	struct tegra_bo *bo;
diff -u -p a/arch/um/drivers/mmapper_kern.c b/arch/um/drivers/mmapper_kern.c
--- a/arch/um/drivers/mmapper_kern.c
+++ b/arch/um/drivers/mmapper_kern.c
@@ -45,7 +45,8 @@ static long mmapper_ioctl(struct file *f
 	return -ENOIOCTLCMD;
 }
 
-static int mmapper_mmap(struct file *file, struct vm_area_struct *vma)
+static int mmapper_mmap(struct file *file, struct vm_area_struct *vma,
+			unsigned long map_flags)
 {
 	int ret = -EINVAL;
 	int size;
diff -u -p a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -498,7 +498,8 @@ v9fs_file_mmap(struct file *filp, struct
 }
 
 static int
-v9fs_mmap_file_mmap(struct file *filp, struct vm_area_struct *vma)
+v9fs_mmap_file_mmap(struct file *filp, struct vm_area_struct *vma,
+		    unsigned long map_flags)
 {
 	int retval;
 	struct inode *inode;
diff -u -p a/fs/ext4/file.c b/fs/ext4/file.c
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -346,7 +346,8 @@ static const struct vm_operations_struct
 	.page_mkwrite   = ext4_page_mkwrite,
 };
 
-static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma,
+			  unsigned long map_flags)
 {
 	struct inode *inode = file->f_mapping->host;
 
diff -u -p a/drivers/gpu/drm/mediatek/mtk_drm_gem.h b/drivers/gpu/drm/mediatek/mtk_drm_gem.h
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.h
@@ -46,7 +46,8 @@ struct mtk_drm_gem_obj *mtk_drm_gem_crea
 					   bool alloc_kmap);
 int mtk_drm_gem_dumb_create(struct drm_file *file_priv, struct drm_device *dev,
 			    struct drm_mode_create_dumb *args);
-int mtk_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
+int mtk_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma,
+		     unsigned long map_flags);
 int mtk_drm_gem_mmap_buf(struct drm_gem_object *obj,
 			 struct vm_area_struct *vma);
 struct sg_table *mtk_gem_prime_get_sg_table(struct drm_gem_object *obj);
diff -u -p a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -165,7 +165,8 @@ int mtk_drm_gem_mmap_buf(struct drm_gem_
 	return mtk_drm_gem_object_mmap(obj, vma);
 }
 
-int mtk_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
+int mtk_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma,
+		     unsigned long map_flags)
 {
 	struct drm_gem_object *obj;
 	int ret;
diff -u -p a/fs/btrfs/file.c b/fs/btrfs/file.c
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2269,7 +2269,9 @@ static const struct vm_operations_struct
 	.page_mkwrite	= btrfs_page_mkwrite,
 };
 
-static int btrfs_file_mmap(struct file	*filp, struct vm_area_struct *vma)
+static int btrfs_file_mmap(struct file	*filp,
+			   struct vm_area_struct *vma,
+			   unsigned long map_flags)
 {
 	struct address_space *mapping = filp->f_mapping;
 
diff -u -p a/drivers/gpu/drm/exynos/exynos_drm_gem.h b/drivers/gpu/drm/exynos/exynos_drm_gem.h
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.h
@@ -114,7 +114,8 @@ int exynos_drm_gem_dumb_create(struct dr
 int exynos_drm_gem_fault(struct vm_fault *vmf);
 
 /* set vm_flags and we can change the vm attribute to other one at here. */
-int exynos_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
+int exynos_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma,
+			unsigned long map_flags);
 
 /* low-level interface prime helpers */
 struct sg_table *exynos_drm_gem_prime_get_sg_table(struct drm_gem_object *obj);
diff -u -p a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -485,7 +485,8 @@ err_close_vm:
 	return ret;
 }
 
-int exynos_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
+int exynos_drm_gem_mmap(struct file *filp, struct vm_area_struct *vma,
+			unsigned long map_flags)
 {
 	struct drm_gem_object *obj;
 	int ret;
diff -u -p a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -1192,7 +1192,8 @@ static unsigned mtdchar_mmap_capabilitie
 /*
  * set up a mapping for shared memory segments
  */
-static int mtdchar_mmap(struct file *file, struct vm_area_struct *vma)
+static int mtdchar_mmap(struct file *file, struct vm_area_struct *vma,
+			unsigned long map_flags)
 {
 #ifdef CONFIG_MMU
 	struct mtd_file_info *mfi = file->private_data;
diff -u -p a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -997,7 +997,8 @@ static int radeon_ttm_fault(struct vm_fa
 	return r;
 }
 
-int radeon_mmap(struct file *filp, struct vm_area_struct *vma)
+int radeon_mmap(struct file *filp, struct vm_area_struct *vma,
+		unsigned long map_flags)
 {
 	struct drm_file *file_priv;
 	struct radeon_device *rdev;
diff -u -p a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -135,7 +135,8 @@ extern int radeon_get_crtc_scanoutpos(st
 extern bool radeon_is_px(struct drm_device *dev);
 extern const struct drm_ioctl_desc radeon_ioctls_kms[];
 extern int radeon_max_kms_ioctl;
-int radeon_mmap(struct file *filp, struct vm_area_struct *vma);
+int radeon_mmap(struct file *filp, struct vm_area_struct *vma,
+		unsigned long map_flags);
 int radeon_mode_dumb_mmap(struct drm_file *filp,
 			  struct drm_device *dev,
 			  uint32_t handle, uint64_t *offset_p);
diff -u -p a/drivers/misc/mic/scif/scif_fd.c b/drivers/misc/mic/scif/scif_fd.c
--- a/drivers/misc/mic/scif/scif_fd.c
+++ b/drivers/misc/mic/scif/scif_fd.c
@@ -34,7 +34,8 @@ static int scif_fdclose(struct inode *in
 	return scif_close(priv);
 }
 
-static int scif_fdmmap(struct file *f, struct vm_area_struct *vma)
+static int scif_fdmmap(struct file *f, struct vm_area_struct *vma,
+		       unsigned long map_flags)
 {
 	struct scif_endpt *priv = f->private_data;
 
diff -u -p a/fs/nfs/internal.h b/fs/nfs/internal.h
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -370,7 +370,7 @@ int nfs_rename(struct inode *, struct de
 int nfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
 loff_t nfs_file_llseek(struct file *, loff_t, int);
 ssize_t nfs_file_read(struct kiocb *, struct iov_iter *);
-int nfs_file_mmap(struct file *, struct vm_area_struct *);
+int nfs_file_mmap(struct file *, struct vm_area_struct *, unsigned long);
 ssize_t nfs_file_write(struct kiocb *, struct iov_iter *);
 int nfs_file_release(struct inode *, struct file *);
 int nfs_lock(struct file *, int, struct file_lock *);
diff -u -p a/fs/nfs/file.c b/fs/nfs/file.c
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -176,7 +176,8 @@ nfs_file_read(struct kiocb *iocb, struct
 EXPORT_SYMBOL_GPL(nfs_file_read);
 
 int
-nfs_file_mmap(struct file * file, struct vm_area_struct * vma)
+nfs_file_mmap(struct file * file, struct vm_area_struct * vma,
+	      unsigned long map_flags)
 {
 	struct inode *inode = file_inode(file);
 	int	status;
diff -u -p a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2397,7 +2397,8 @@ static const struct vm_operations_struct
 	.fault = kvm_vcpu_fault,
 };
 
-static int kvm_vcpu_mmap(struct file *file, struct vm_area_struct *vma)
+static int kvm_vcpu_mmap(struct file *file, struct vm_area_struct *vma,
+			 unsigned long map_flags)
 {
 	vma->vm_ops = &kvm_vcpu_vm_ops;
 	return 0;
diff -u -p a/drivers/xen/gntalloc.c b/drivers/xen/gntalloc.c
--- a/drivers/xen/gntalloc.c
+++ b/drivers/xen/gntalloc.c
@@ -502,7 +502,8 @@ static const struct vm_operations_struct
 	.close = gntalloc_vma_close,
 };
 
-static int gntalloc_mmap(struct file *filp, struct vm_area_struct *vma)
+static int gntalloc_mmap(struct file *filp, struct vm_area_struct *vma,
+			 unsigned long map_flags)
 {
 	struct gntalloc_file_private_data *priv = filp->private_data;
 	struct gntalloc_vma_private_data *vm_priv;
diff -u -p a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -380,7 +380,8 @@ static const struct vm_operations_struct
 /*
  * mmap support for problem state control area [0x4000 - 0x4fff].
  */
-static int spufs_cntl_mmap(struct file *file, struct vm_area_struct *vma)
+static int spufs_cntl_mmap(struct file *file, struct vm_area_struct *vma,
+			   unsigned long map_flags)
 {
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
diff -u -p a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -136,7 +136,8 @@ void bochs_hw_setbase(struct bochs_devic
 /* bochs_mm.c */
 int bochs_mm_init(struct bochs_device *bochs);
 void bochs_mm_fini(struct bochs_device *bochs);
-int bochs_mmap(struct file *filp, struct vm_area_struct *vma);
+int bochs_mmap(struct file *filp, struct vm_area_struct *vma,
+	       unsigned long map_flags);
 
 int bochs_gem_create(struct drm_device *dev, u32 size, bool iskernel,
 		     struct drm_gem_object **obj);
diff -u -p a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -327,7 +327,8 @@ int bochs_bo_unpin(struct bochs_bo *bo)
 	return 0;
 }
 
-int bochs_mmap(struct file *filp, struct vm_area_struct *vma)
+int bochs_mmap(struct file *filp, struct vm_area_struct *vma,
+	       unsigned long map_flags)
 {
 	struct drm_file *file_priv;
 	struct bochs_device *bochs;
diff -u -p a/drivers/staging/vme/devices/vme_user.c b/drivers/staging/vme/devices/vme_user.c
--- a/drivers/staging/vme/devices/vme_user.c
+++ b/drivers/staging/vme/devices/vme_user.c
@@ -484,7 +484,8 @@ static int vme_user_master_mmap(unsigned
 	return 0;
 }
 
-static int vme_user_mmap(struct file *file, struct vm_area_struct *vma)
+static int vme_user_mmap(struct file *file, struct vm_area_struct *vma,
+			 unsigned long map_flags)
 {
 	unsigned int minor = MINOR(file_inode(file)->i_rdev);
 
diff -u -p a/fs/aio.c b/fs/aio.c
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -353,7 +353,8 @@ static const struct vm_operations_struct
 #endif
 };
 
-static int aio_ring_mmap(struct file *file, struct vm_area_struct *vma)
+static int aio_ring_mmap(struct file *file, struct vm_area_struct *vma,
+			 unsigned long map_flags)
 {
 	vma->vm_flags |= VM_DONTEXPAND;
 	vma->vm_ops = &aio_ring_vm_ops;
diff -u -p a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -230,7 +230,8 @@ static long proc_bus_pci_ioctl(struct fi
 }
 
 #ifdef HAVE_PCI_MMAP
-static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
+static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma,
+			     unsigned long map_flags)
 {
 	struct pci_dev *dev = PDE_DATA(file_inode(file));
 	struct pci_filp_private *fpriv = file->private_data;
diff -u -p a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -422,7 +422,8 @@ int qxl_mode_dumb_mmap(struct drm_file *
 /* qxl ttm */
 int qxl_ttm_init(struct qxl_device *qdev);
 void qxl_ttm_fini(struct qxl_device *qdev);
-int qxl_mmap(struct file *filp, struct vm_area_struct *vma);
+int qxl_mmap(struct file *filp, struct vm_area_struct *vma,
+	     unsigned long map_flags);
 
 /* qxl image */
 
diff -u -p a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -117,7 +117,8 @@ static int qxl_ttm_fault(struct vm_fault
 	return r;
 }
 
-int qxl_mmap(struct file *filp, struct vm_area_struct *vma)
+int qxl_mmap(struct file *filp, struct vm_area_struct *vma,
+	     unsigned long map_flags)
 {
 	struct drm_file *file_priv;
 	struct qxl_device *qdev;
diff -u -p a/kernel/kcov.c b/kernel/kcov.c
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -132,7 +132,8 @@ void kcov_task_exit(struct task_struct *
 	kcov_put(kcov);
 }
 
-static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
+static int kcov_mmap(struct file *filep, struct vm_area_struct *vma,
+		     unsigned long map_flags)
 {
 	int res = 0;
 	void *area;
diff -u -p a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -107,7 +107,8 @@ int hibmc_dumb_create(struct drm_file *f
 		      struct drm_mode_create_dumb *args);
 int hibmc_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
 			   u32 handle, u64 *offset);
-int hibmc_mmap(struct file *filp, struct vm_area_struct *vma);
+int hibmc_mmap(struct file *filp, struct vm_area_struct *vma,
+	       unsigned long map_flags);
 
 extern const struct drm_mode_config_funcs hibmc_mode_funcs;
 
diff -u -p a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
@@ -389,7 +389,8 @@ int hibmc_bo_unpin(struct hibmc_bo *bo)
 	return 0;
 }
 
-int hibmc_mmap(struct file *filp, struct vm_area_struct *vma)
+int hibmc_mmap(struct file *filp, struct vm_area_struct *vma,
+	       unsigned long map_flags)
 {
 	struct drm_file *file_priv;
 	struct hibmc_drm_private *hibmc;
diff -u -p a/fs/orangefs/file.c b/fs/orangefs/file.c
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -584,7 +584,8 @@ static long orangefs_ioctl(struct file *
 /*
  * Memory map a region of a file.
  */
-static int orangefs_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int orangefs_file_mmap(struct file *file, struct vm_area_struct *vma,
+			      unsigned long map_flags)
 {
 	gossip_debug(GOSSIP_FILE_DEBUG,
 		     "orangefs_file_mmap: called on %s\n",
diff -u -p a/sound/core/info.c b/sound/core/info.c
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -232,7 +232,8 @@ static long snd_info_entry_ioctl(struct
 				   file, cmd, arg);
 }
 
-static int snd_info_entry_mmap(struct file *file, struct vm_area_struct *vma)
+static int snd_info_entry_mmap(struct file *file, struct vm_area_struct *vma,
+			       unsigned long map_flags)
 {
 	struct inode *inode = file_inode(file);
 	struct snd_info_private_data *data;
diff -u -p a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1667,7 +1667,8 @@ static long fw_device_op_compat_ioctl(st
 }
 #endif
 
-static int fw_device_op_mmap(struct file *file, struct vm_area_struct *vma)
+static int fw_device_op_mmap(struct file *file, struct vm_area_struct *vma,
+			     unsigned long map_flags)
 {
 	struct client *client = file->private_data;
 	unsigned long size;
diff -u -p a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -809,7 +809,8 @@ out:
 	return ret;
 }
 
-static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma)
+static int ib_uverbs_mmap(struct file *filp, struct vm_area_struct *vma,
+			  unsigned long map_flags)
 {
 	struct ib_uverbs_file *file = filp->private_data;
 	struct ib_device *ib_dev;
diff -u -p a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -39,7 +39,7 @@
 
 static long kfd_ioctl(struct file *, unsigned int, unsigned long);
 static int kfd_open(struct inode *, struct file *);
-static int kfd_mmap(struct file *, struct vm_area_struct *);
+static int kfd_mmap(struct file *, struct vm_area_struct *, unsigned long);
 
 static const char kfd_dev_name[] = "kfd";
 
@@ -991,7 +991,8 @@ err_i1:
 	return retcode;
 }
 
-static int kfd_mmap(struct file *filp, struct vm_area_struct *vma)
+static int kfd_mmap(struct file *filp, struct vm_area_struct *vma,
+		    unsigned long map_flags)
 {
 	struct kfd_process *process;
 
diff -u -p a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -390,7 +390,8 @@ static inline void ast_bo_unreserve(stru
 
 void ast_ttm_placement(struct ast_bo *bo, int domain);
 int ast_bo_push_sysram(struct ast_bo *bo);
-int ast_mmap(struct file *filp, struct vm_area_struct *vma);
+int ast_mmap(struct file *filp, struct vm_area_struct *vma,
+	     unsigned long map_flags);
 
 /* ast post */
 void ast_enable_vga(struct drm_device *dev);
diff -u -p a/drivers/gpu/drm/ast/ast_ttm.c b/drivers/gpu/drm/ast/ast_ttm.c
--- a/drivers/gpu/drm/ast/ast_ttm.c
+++ b/drivers/gpu/drm/ast/ast_ttm.c
@@ -417,7 +417,8 @@ int ast_bo_push_sysram(struct ast_bo *bo
 	return 0;
 }
 
-int ast_mmap(struct file *filp, struct vm_area_struct *vma)
+int ast_mmap(struct file *filp, struct vm_area_struct *vma,
+	     unsigned long map_flags)
 {
 	struct drm_file *file_priv;
 	struct ast_private *ast;
diff -u -p a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -118,7 +118,8 @@ static void huge_pagevec_release(struct
 	pagevec_reinit(pvec);
 }
 
-static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma,
+			       unsigned long map_flags)
 {
 	struct inode *inode = file_inode(file);
 	loff_t len, vma_len;
diff -u -p a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -1082,7 +1082,8 @@ int afu_allocate_irqs(struct cxl_context
 int afu_open(struct inode *inode, struct file *file);
 int afu_release(struct inode *inode, struct file *file);
 long afu_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
-int afu_mmap(struct file *file, struct vm_area_struct *vm);
+int afu_mmap(struct file *file, struct vm_area_struct *vm,
+	     unsigned long map_flags);
 unsigned int afu_poll(struct file *file, struct poll_table_struct *poll);
 ssize_t afu_read(struct file *file, char __user *buf, size_t count, loff_t *off);
 extern const struct file_operations afu_fops;
diff -u -p a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -303,7 +303,8 @@ static long afu_compat_ioctl(struct file
 	return afu_ioctl(file, cmd, arg);
 }
 
-int afu_mmap(struct file *file, struct vm_area_struct *vm)
+int afu_mmap(struct file *file, struct vm_area_struct *vm,
+	     unsigned long map_flags)
 {
 	struct cxl_context *ctx = file->private_data;
 
diff -u -p a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -32,7 +32,8 @@ static unsigned long ramfs_nommu_get_unm
 						   unsigned long len,
 						   unsigned long pgoff,
 						   unsigned long flags);
-static int ramfs_nommu_mmap(struct file *file, struct vm_area_struct *vma);
+static int ramfs_nommu_mmap(struct file *file, struct vm_area_struct *vma,
+			    unsigned long map_flags);
 
 static unsigned ramfs_mmap_capabilities(struct file *file)
 {
@@ -258,7 +259,8 @@ out:
 /*
  * set up a mapping for shared memory segments
  */
-static int ramfs_nommu_mmap(struct file *file, struct vm_area_struct *vma)
+static int ramfs_nommu_mmap(struct file *file, struct vm_area_struct *vma,
+			    unsigned long map_flags)
 {
 	if (!(vma->vm_flags & (VM_SHARED | VM_MAYSHARE)))
 		return -ENOSYS;
diff -u -p a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -168,7 +168,8 @@ int omap_gem_dumb_map_offset(struct drm_
 		uint32_t handle, uint64_t *offset);
 int omap_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 		struct drm_mode_create_dumb *args);
-int omap_gem_mmap(struct file *filp, struct vm_area_struct *vma);
+int omap_gem_mmap(struct file *filp, struct vm_area_struct *vma,
+		  unsigned long map_flags);
 int omap_gem_mmap_obj(struct drm_gem_object *obj,
 		struct vm_area_struct *vma);
 int omap_gem_fault(struct vm_fault *vmf);
diff -u -p a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -561,7 +561,8 @@ fail:
 }
 
 /** We override mainly to fix up some of the vm mapping flags.. */
-int omap_gem_mmap(struct file *filp, struct vm_area_struct *vma)
+int omap_gem_mmap(struct file *filp, struct vm_area_struct *vma,
+		  unsigned long map_flags)
 {
 	int ret;
 
diff -u -p a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -255,7 +255,8 @@ static const struct vm_operations_struct
 	.fault = kvm_spapr_tce_fault,
 };
 
-static int kvm_spapr_tce_mmap(struct file *file, struct vm_area_struct *vma)
+static int kvm_spapr_tce_mmap(struct file *file, struct vm_area_struct *vma,
+			      unsigned long map_flags)
 {
 	vma->vm_ops = &kvm_spapr_tce_vm_ops;
 	return 0;
diff -u -p a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -1200,7 +1200,8 @@ static const struct vm_operations_struct
 	.fault = spufs_signal2_mmap_fault,
 };
 
-static int spufs_signal2_mmap(struct file *file, struct vm_area_struct *vma)
+static int spufs_signal2_mmap(struct file *file, struct vm_area_struct *vma,
+			      unsigned long map_flags)
 {
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
diff -u -p a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -111,7 +111,8 @@ extern int cifs_strict_fsync(struct file
 extern int cifs_flush(struct file *, fl_owner_t id);
 extern int cifs_file_mmap(struct file * , struct vm_area_struct *,
 			  unsigned long);
-extern int cifs_file_strict_mmap(struct file * , struct vm_area_struct *);
+extern int cifs_file_strict_mmap(struct file * , struct vm_area_struct *,
+				 unsigned long);
 extern const struct file_operations cifs_dir_ops;
 extern int cifs_dir_open(struct inode *inode, struct file *file);
 extern int cifs_readdir(struct file *file, struct dir_context *ctx);
diff -u -p a/fs/cifs/file.c b/fs/cifs/file.c
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3475,7 +3475,8 @@ static const struct vm_operations_struct
 	.page_mkwrite = cifs_page_mkwrite,
 };
 
-int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma)
+int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma,
+			  unsigned long map_flags)
 {
 	int rc, xid;
 	struct inode *inode = file_inode(file);
diff -u -p a/drivers/dax/device.c b/drivers/dax/device.c
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -432,7 +432,8 @@ static const struct vm_operations_struct
 	.huge_fault = dev_dax_huge_fault,
 };
 
-static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
+static int dax_mmap(struct file *filp, struct vm_area_struct *vma,
+		    unsigned long map_flags)
 {
 	struct dev_dax *dev_dax = filp->private_data;
 	int rc, id;
diff -u -p a/fs/ubifs/file.c b/fs/ubifs/file.c
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1612,7 +1612,8 @@ static const struct vm_operations_struct
 	.page_mkwrite = ubifs_vm_page_mkwrite,
 };
 
-static int ubifs_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int ubifs_file_mmap(struct file *file, struct vm_area_struct *vma,
+			   unsigned long map_flags)
 {
 	int err;
 
diff -u -p a/drivers/staging/vboxvideo/vbox_drv.h b/drivers/staging/vboxvideo/vbox_drv.h
--- a/drivers/staging/vboxvideo/vbox_drv.h
+++ b/drivers/staging/vboxvideo/vbox_drv.h
@@ -261,7 +261,8 @@ static inline void vbox_bo_unreserve(str
 
 void vbox_ttm_placement(struct vbox_bo *bo, int domain);
 int vbox_bo_push_sysram(struct vbox_bo *bo);
-int vbox_mmap(struct file *filp, struct vm_area_struct *vma);
+int vbox_mmap(struct file *filp, struct vm_area_struct *vma,
+	      unsigned long map_flags);
 
 /* vbox_prime.c */
 int vbox_gem_prime_pin(struct drm_gem_object *obj);
diff -u -p a/drivers/staging/vboxvideo/vbox_ttm.c b/drivers/staging/vboxvideo/vbox_ttm.c
--- a/drivers/staging/vboxvideo/vbox_ttm.c
+++ b/drivers/staging/vboxvideo/vbox_ttm.c
@@ -457,7 +457,8 @@ int vbox_bo_push_sysram(struct vbox_bo *
 	return 0;
 }
 
-int vbox_mmap(struct file *filp, struct vm_area_struct *vma)
+int vbox_mmap(struct file *filp, struct vm_area_struct *vma,
+	      unsigned long map_flags)
 {
 	struct drm_file *file_priv;
 	struct vbox_private *vbox;
diff -u -p a/sound/core/hwdep.c b/sound/core/hwdep.c
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -260,7 +260,8 @@ static long snd_hwdep_ioctl(struct file
 	return -ENOTTY;
 }
 
-static int snd_hwdep_mmap(struct file * file, struct vm_area_struct * vma)
+static int snd_hwdep_mmap(struct file * file, struct vm_area_struct * vma,
+			  unsigned long map_flags)
 {
 	struct snd_hwdep *hw = file->private_data;
 	if (hw->ops.mmap)
diff -u -p a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -1160,7 +1160,8 @@ static const struct vm_operations_struct
  *
  * Return: 0 on success, -errno on failure
  */
-static int cxlflash_cxl_mmap(struct file *file, struct vm_area_struct *vma)
+static int cxlflash_cxl_mmap(struct file *file, struct vm_area_struct *vma,
+			     unsigned long map_flags)
 {
 	struct cxl_context *ctx = cxl_fops_get_context(file);
 	struct cxlflash_cfg *cfg = container_of(file->f_op, struct cxlflash_cfg,
diff -u -p a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -435,7 +435,8 @@ static const struct vm_operations_struct
  * plain buffer, we lookup our dma_mapping list to find the
  * corresponding DMA address for the associated user-space address.
  */
-static int genwqe_mmap(struct file *filp, struct vm_area_struct *vma)
+static int genwqe_mmap(struct file *filp, struct vm_area_struct *vma,
+		       unsigned long map_flags)
 {
 	int rc;
 	unsigned long pfn, vsize = vma->vm_end - vma->vm_start;
diff -u -p a/net/socket.c b/net/socket.c
--- a/net/socket.c
+++ b/net/socket.c
@@ -115,7 +115,8 @@ unsigned int sysctl_net_busy_poll __read
 
 static ssize_t sock_read_iter(struct kiocb *iocb, struct iov_iter *to);
 static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from);
-static int sock_mmap(struct file *file, struct vm_area_struct *vma);
+static int sock_mmap(struct file *file, struct vm_area_struct *vma,
+		     unsigned long map_flags);
 
 static int sock_close(struct inode *inode, struct file *file);
 static unsigned int sock_poll(struct file *file,
@@ -1114,7 +1115,8 @@ static unsigned int sock_poll(struct fil
 	return busy_flag | sock->ops->poll(file, sock, wait);
 }
 
-static int sock_mmap(struct file *file, struct vm_area_struct *vma)
+static int sock_mmap(struct file *file, struct vm_area_struct *vma,
+		     unsigned long map_flags)
 {
 	struct socket *sock = file->private_data;
 
diff -u -p a/fs/nilfs2/file.c b/fs/nilfs2/file.c
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -126,7 +126,8 @@ static const struct vm_operations_struct
 	.page_mkwrite	= nilfs_page_mkwrite,
 };
 
-static int nilfs_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int nilfs_file_mmap(struct file *file, struct vm_area_struct *vma,
+			   unsigned long map_flags)
 {
 	file_accessed(file);
 	vma->vm_ops = &nilfs_file_vm_ops;
diff -u -p a/drivers/staging/lustre/lustre/llite/llite_internal.h b/drivers/staging/lustre/lustre/llite/llite_internal.h
--- a/drivers/staging/lustre/lustre/llite/llite_internal.h
+++ b/drivers/staging/lustre/lustre/llite/llite_internal.h
@@ -912,7 +912,8 @@ static inline struct vvp_io_args *ll_env
 /* llite/llite_mmap.c */
 
 int ll_teardown_mmaps(struct address_space *mapping, __u64 first, __u64 last);
-int ll_file_mmap(struct file *file, struct vm_area_struct *vma);
+int ll_file_mmap(struct file *file, struct vm_area_struct *vma,
+		 unsigned long map_flags);
 void policy_from_vma(union ldlm_policy_data *policy, struct vm_area_struct *vma,
 		     unsigned long addr, size_t count);
 struct vm_area_struct *our_vma(struct mm_struct *mm, unsigned long addr,
diff -u -p a/drivers/staging/lustre/lustre/llite/llite_mmap.c b/drivers/staging/lustre/lustre/llite/llite_mmap.c
--- a/drivers/staging/lustre/lustre/llite/llite_mmap.c
+++ b/drivers/staging/lustre/lustre/llite/llite_mmap.c
@@ -455,7 +455,8 @@ static const struct vm_operations_struct
 	.close			= ll_vm_close,
 };
 
-int ll_file_mmap(struct file *file, struct vm_area_struct *vma)
+int ll_file_mmap(struct file *file, struct vm_area_struct *vma,
+		 unsigned long map_flags)
 {
 	struct inode *inode = file_inode(file);
 	int rc;
diff -u -p a/drivers/uio/uio.c b/drivers/uio/uio.c
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -674,7 +674,8 @@ static int uio_mmap_physical(struct vm_a
 			       vma->vm_page_prot);
 }
 
-static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
+static int uio_mmap(struct file *filep, struct vm_area_struct *vma,
+		    unsigned long map_flags)
 {
 	struct uio_listener *listener = filep->private_data;
 	struct uio_device *idev = listener->dev;
diff -u -p a/kernel/events/core.c b/kernel/events/core.c
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5247,7 +5247,8 @@ static const struct vm_operations_struct
 	.page_mkwrite	= perf_mmap_fault,
 };
 
-static int perf_mmap(struct file *file, struct vm_area_struct *vma)
+static int perf_mmap(struct file *file, struct vm_area_struct *vma,
+		     unsigned long map_flags)
 {
 	struct perf_event *event = file->private_data;
 	unsigned long user_locked, user_lock_limit;
diff -u -p a/fs/kernfs/file.c b/fs/kernfs/file.c
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -467,7 +467,8 @@ static const struct vm_operations_struct
 #endif
 };
 
-static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
+static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma,
+			   unsigned long map_flags)
 {
 	struct kernfs_open_file *of = kernfs_of(file);
 	const struct kernfs_ops *ops;
diff -u -p a/drivers/xen/xenbus/xenbus_dev_backend.c b/drivers/xen/xenbus/xenbus_dev_backend.c
--- a/drivers/xen/xenbus/xenbus_dev_backend.c
+++ b/drivers/xen/xenbus/xenbus_dev_backend.c
@@ -88,7 +88,8 @@ static long xenbus_backend_ioctl(struct
 	}
 }
 
-static int xenbus_backend_mmap(struct file *file, struct vm_area_struct *vma)
+static int xenbus_backend_mmap(struct file *file, struct vm_area_struct *vma,
+			       unsigned long map_flags)
 {
 	size_t size = vma->vm_end - vma->vm_start;
 
diff -u -p a/ipc/shm.c b/ipc/shm.c
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -411,7 +411,8 @@ static struct mempolicy *shm_get_policy(
 }
 #endif
 
-static int shm_mmap(struct file *file, struct vm_area_struct *vma)
+static int shm_mmap(struct file *file, struct vm_area_struct *vma,
+		    unsigned long map_flags)
 {
 	struct shm_file_data *sfd = shm_file_data(file);
 	int ret;
diff -u -p a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -1448,7 +1448,8 @@ static const struct vm_operations_struct
 /*
  * mmap support for problem state MFC DMA area [0x0000 - 0x0fff].
  */
-static int spufs_mfc_mmap(struct file *file, struct vm_area_struct *vma)
+static int spufs_mfc_mmap(struct file *file, struct vm_area_struct *vma,
+			  unsigned long map_flags)
 {
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
diff -u -p a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1256,7 +1256,8 @@ static ssize_t vfio_fops_write(struct fi
 	return ret;
 }
 
-static int vfio_fops_mmap(struct file *filep, struct vm_area_struct *vma)
+static int vfio_fops_mmap(struct file *filep, struct vm_area_struct *vma,
+			  unsigned long map_flags)
 {
 	struct vfio_container *container = filep->private_data;
 	struct vfio_iommu_driver *driver;
diff -u -p a/sound/oss/swarm_cs4297a.c b/sound/oss/swarm_cs4297a.c
--- a/sound/oss/swarm_cs4297a.c
+++ b/sound/oss/swarm_cs4297a.c
@@ -1962,7 +1962,8 @@ static unsigned int cs4297a_poll(struct
 }
 
 
-static int cs4297a_mmap(struct file *file, struct vm_area_struct *vma)
+static int cs4297a_mmap(struct file *file, struct vm_area_struct *vma,
+			unsigned long map_flags)
 {
         /* XXXKW currently no mmap support */
         return -EINVAL;
diff -u -p a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1227,7 +1227,8 @@ static const struct vm_operations_struct
 };
 
 static int
-sg_mmap(struct file *filp, struct vm_area_struct *vma)
+sg_mmap(struct file *filp, struct vm_area_struct *vma,
+	unsigned long map_flags)
 {
 	Sg_fd *sfp;
 	unsigned long req_sz, len, sa;
diff -u -p a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -337,7 +337,8 @@ static const struct vm_operations_struct
 #endif
 };
 
-static int mmap_mem(struct file *file, struct vm_area_struct *vma)
+static int mmap_mem(struct file *file, struct vm_area_struct *vma,
+		    unsigned long map_flags)
 {
 	size_t size = vma->vm_end - vma->vm_start;
 	phys_addr_t offset = (phys_addr_t)vma->vm_pgoff << PAGE_SHIFT;
diff -u -p a/drivers/char/mspec.c b/drivers/char/mspec.c
--- a/drivers/char/mspec.c
+++ b/drivers/char/mspec.c
@@ -294,7 +294,8 @@ fetchop_mmap(struct file *file, struct v
 }
 
 static int
-cached_mmap(struct file *file, struct vm_area_struct *vma)
+cached_mmap(struct file *file, struct vm_area_struct *vma,
+	    unsigned long map_flags)
 {
 	return mspec_mmap(file, vma, MSPEC_CACHED);
 }
diff -u -p a/fs/fuse/file.c b/fs/fuse/file.c
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2063,7 +2063,8 @@ static const struct vm_operations_struct
 	.page_mkwrite	= fuse_page_mkwrite,
 };
 
-static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma,
+			  unsigned long map_flags)
 {
 	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
 		fuse_link_write_file(file);
