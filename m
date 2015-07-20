From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Mon, 20 Jul 2015 15:30:45 -0700
Subject: [Cocci] [PATCH v2 1/2] patches: replace most of 0002-no_dmabuf with
	SmPL
In-Reply-To: <1437431446-32619-1-git-send-email-mcgrof@do-not-panic.com>
References: <1437431446-32619-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1437431446-32619-2-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The 0002-no_dmabuf patch series creates the largest delta for
backports, and it turns out we can generalize it thorugh SmPL.
There's just a few changes we can't get rid of as they relate
to other build things.

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.68              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.107             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.75             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.40             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.39             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.12             [  OK  ]
20  3.19.5              [  OK  ]
21  4.0.0               [  OK  ]
22  4.1-rc8             [  OK  ]

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../media/0002-no_dmabuf.cocci                     |  75 +++++
 .../media/0002-no_dmabuf/v4l2.patch                | 305 +--------------------
 2 files changed, 79 insertions(+), 301 deletions(-)
 create mode 100644 patches/collateral-evolutions/media/0002-no_dmabuf.cocci

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf.cocci b/patches/collateral-evolutions/media/0002-no_dmabuf.cocci
new file mode 100644
index 000000000000..edcfd1db91df
--- /dev/null
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf.cocci
@@ -0,0 +1,75 @@
+/* c5384048 */
+
+@ vb2_mem_ops @
+identifier s, dma_fn;
+identifier dma_op =~ "(get_dma|map_dma|unmap_dma|attach_dma|detach_dma)";
+@@
+
+ struct vb2_mem_ops s = {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.dma_op = dma_fn,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+};
+
+@ mod_dma_fn depends on vb2_mem_ops @
+identifier vb2_mem_ops.dma_fn;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ dma_fn(...)
+ {
+ 	...
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+
+@ v4l_ioctl_ops @
+identifier s, ioctl_fn;
+identifier ioctl_op =~ "(vidioc_expbuf)";
+@@
+struct v4l2_ioctl_ops s = {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+	.ioctl_op = ioctl_fn,
++#endif
+};
+
+@ mod_ioctl_fn depends on v4l_ioctl_ops @
+identifier v4l_ioctl_ops.ioctl_fn;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ ioctl_fn(...)
+ {
+ 	...
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+
+@ dma_buf_op_add_ifdef @
+identifier s, dma_fn;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ struct dma_buf_ops s = {
+ ...
+};
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+
+@ dma_buf_op @
+identifier s, dma_fn;
+identifier dma_op;
+@@
+
+ struct dma_buf_ops s = {
+	.dma_op = dma_fn,
+};
+
+@ modify_dma_fn depends on dma_buf_op @
+identifier dma_buf_op.dma_fn;
+@@
+
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ dma_fn(...)
+ {
+ 	...
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+
diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index efb66bbeef39..48c6956e81bd 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -225,53 +225,14 @@
  /*********************************************/
  /*         DMABUF ops for exporters          */
  /*********************************************/
-@@ -451,6 +454,7 @@ static struct dma_buf *vb2_dc_get_dmabuf
+@@ -424,6 +427,7 @@ static struct sg_table *vb2_dc_get_base_
  
- 	return dbuf;
+ 	return sgt;
  }
 +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  
- /*********************************************/
- /*       callbacks for USERPTR buffers       */
-@@ -633,6 +637,7 @@ fail_buf:
- 	return ERR_PTR(ret);
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- /*********************************************/
- /*       callbacks for DMABUF buffers        */
- /*********************************************/
-@@ -743,6 +748,7 @@ static void *vb2_dc_attach_dmabuf(void *
- 
- 	return buf;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- /*********************************************/
- /*       DMA CONTIG exported functions       */
-@@ -751,7 +757,9 @@ static void *vb2_dc_attach_dmabuf(void *
- const struct vb2_mem_ops vb2_dma_contig_memops = {
- 	.alloc		= vb2_dc_alloc,
- 	.put		= vb2_dc_put,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.get_dmabuf	= vb2_dc_get_dmabuf,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 	.cookie		= vb2_dc_cookie,
- 	.vaddr		= vb2_dc_vaddr,
- 	.mmap		= vb2_dc_mmap,
-@@ -759,10 +767,12 @@ const struct vb2_mem_ops vb2_dma_contig_
- 	.put_userptr	= vb2_dc_put_userptr,
- 	.prepare	= vb2_dc_prepare,
- 	.finish		= vb2_dc_finish,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.map_dmabuf	= vb2_dc_map_dmabuf,
- 	.unmap_dmabuf	= vb2_dc_unmap_dmabuf,
- 	.attach_dmabuf	= vb2_dc_attach_dmabuf,
- 	.detach_dmabuf	= vb2_dc_detach_dmabuf,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 	.num_users	= vb2_dc_num_users,
- };
- EXPORT_SYMBOL_GPL(vb2_dma_contig_memops);
+ static struct dma_buf *vb2_dc_get_dmabuf(void *buf_priv, unsigned long flags)
+ {
 --- a/drivers/media/v4l2-core/videobuf2-vmalloc.c
 +++ b/drivers/media/v4l2-core/videobuf2-vmalloc.c
 @@ -28,7 +28,9 @@ struct vb2_vmalloc_buf {
@@ -284,38 +245,6 @@
  };
  
  static void vb2_vmalloc_put(void *buf_priv);
-@@ -193,6 +195,7 @@ static int vb2_vmalloc_mmap(void *buf_pr
- 	return 0;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- #ifdef CONFIG_HAS_DMA
- /*********************************************/
- /*         DMABUF ops for exporters          */
-@@ -421,6 +424,7 @@ static void *vb2_vmalloc_attach_dmabuf(v
- 
- 	return buf;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- 
- const struct vb2_mem_ops vb2_vmalloc_memops = {
-@@ -428,6 +432,7 @@ const struct vb2_mem_ops vb2_vmalloc_mem
- 	.put		= vb2_vmalloc_put,
- 	.get_userptr	= vb2_vmalloc_get_userptr,
- 	.put_userptr	= vb2_vmalloc_put_userptr,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- #ifdef CONFIG_HAS_DMA
- 	.get_dmabuf	= vb2_vmalloc_get_dmabuf,
- #endif
-@@ -435,6 +440,7 @@ const struct vb2_mem_ops vb2_vmalloc_mem
- 	.unmap_dmabuf	= vb2_vmalloc_unmap_dmabuf,
- 	.attach_dmabuf	= vb2_vmalloc_attach_dmabuf,
- 	.detach_dmabuf	= vb2_vmalloc_detach_dmabuf,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 	.vaddr		= vb2_vmalloc_vaddr,
- 	.mmap		= vb2_vmalloc_mmap,
- 	.num_users	= vb2_vmalloc_num_users,
 --- a/include/media/v4l2-mem2mem.h
 +++ b/include/media/v4l2-mem2mem.h
 @@ -121,8 +121,10 @@ int v4l2_m2m_prepare_buf(struct file *fi
@@ -388,138 +317,6 @@
  
  /* struct v4l2_file_operations helpers */
  
---- a/drivers/media/platform/am437x/am437x-vpfe.c
-+++ b/drivers/media/platform/am437x/am437x-vpfe.c
-@@ -2257,7 +2257,9 @@ static const struct v4l2_ioctl_ops vpfe_
- 	.vidioc_querybuf		= vb2_ioctl_querybuf,
- 	.vidioc_qbuf			= vb2_ioctl_qbuf,
- 	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.vidioc_expbuf			= vb2_ioctl_expbuf,
-+#endif
- 	.vidioc_streamon		= vb2_ioctl_streamon,
- 	.vidioc_streamoff		= vb2_ioctl_streamoff,
- 
---- a/drivers/media/platform/coda/coda-common.c
-+++ b/drivers/media/platform/coda/coda-common.c
-@@ -859,7 +859,9 @@ static const struct v4l2_ioctl_ops coda_
- 	.vidioc_querybuf	= v4l2_m2m_ioctl_querybuf,
- 
- 	.vidioc_qbuf		= coda_qbuf,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
-+#endif
- 	.vidioc_dqbuf		= v4l2_m2m_ioctl_dqbuf,
- 	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
- 
---- a/drivers/media/platform/davinci/vpbe_display.c
-+++ b/drivers/media/platform/davinci/vpbe_display.c
-@@ -1244,7 +1244,9 @@ static const struct v4l2_ioctl_ops vpbe_
- 	.vidioc_dqbuf		 = vb2_ioctl_dqbuf,
- 	.vidioc_streamon	 = vb2_ioctl_streamon,
- 	.vidioc_streamoff	 = vb2_ioctl_streamoff,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.vidioc_expbuf		 = vb2_ioctl_expbuf,
-+#endif
- 
- 	.vidioc_cropcap		 = vpbe_display_cropcap,
- 	.vidioc_g_crop		 = vpbe_display_g_crop,
---- a/drivers/media/platform/davinci/vpif_capture.c
-+++ b/drivers/media/platform/davinci/vpif_capture.c
-@@ -1260,7 +1260,9 @@ static const struct v4l2_ioctl_ops vpif_
- 	.vidioc_querybuf		= vb2_ioctl_querybuf,
- 	.vidioc_qbuf			= vb2_ioctl_qbuf,
- 	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.vidioc_expbuf			= vb2_ioctl_expbuf,
-+#endif
- 	.vidioc_streamon		= vb2_ioctl_streamon,
- 	.vidioc_streamoff		= vb2_ioctl_streamoff,
- 
---- a/drivers/media/platform/davinci/vpif_display.c
-+++ b/drivers/media/platform/davinci/vpif_display.c
-@@ -1059,7 +1059,9 @@ static const struct v4l2_ioctl_ops vpif_
- 	.vidioc_querybuf		= vb2_ioctl_querybuf,
- 	.vidioc_qbuf			= vb2_ioctl_qbuf,
- 	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.vidioc_expbuf			= vb2_ioctl_expbuf,
-+#endif
- 	.vidioc_streamon		= vb2_ioctl_streamon,
- 	.vidioc_streamoff		= vb2_ioctl_streamoff,
- 
---- a/drivers/media/platform/exynos4-is/fimc-capture.c
-+++ b/drivers/media/platform/exynos4-is/fimc-capture.c
-@@ -1372,7 +1372,9 @@ static const struct v4l2_ioctl_ops fimc_
- 	.vidioc_querybuf		= vb2_ioctl_querybuf,
- 	.vidioc_qbuf			= vb2_ioctl_qbuf,
- 	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.vidioc_expbuf			= vb2_ioctl_expbuf,
-+#endif
- 	.vidioc_prepare_buf		= vb2_ioctl_prepare_buf,
- 	.vidioc_create_bufs		= vb2_ioctl_create_bufs,
- 
---- a/drivers/media/platform/exynos4-is/fimc-m2m.c
-+++ b/drivers/media/platform/exynos4-is/fimc-m2m.c
-@@ -538,7 +538,9 @@ static const struct v4l2_ioctl_ops fimc_
- 	.vidioc_querybuf		= v4l2_m2m_ioctl_querybuf,
- 	.vidioc_qbuf			= v4l2_m2m_ioctl_qbuf,
- 	.vidioc_dqbuf			= v4l2_m2m_ioctl_dqbuf,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.vidioc_expbuf			= v4l2_m2m_ioctl_expbuf,
-+#endif
- 	.vidioc_streamon		= v4l2_m2m_ioctl_streamon,
- 	.vidioc_streamoff		= v4l2_m2m_ioctl_streamoff,
- 	.vidioc_g_crop			= fimc_m2m_g_crop,
---- a/drivers/media/platform/vivid/vivid-core.c
-+++ b/drivers/media/platform/vivid/vivid-core.c
-@@ -584,7 +584,9 @@ static const struct v4l2_ioctl_ops vivid
- 	.vidioc_querybuf		= vb2_ioctl_querybuf,
- 	.vidioc_qbuf			= vb2_ioctl_qbuf,
- 	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.vidioc_expbuf			= vb2_ioctl_expbuf,
-+#endif
- 	.vidioc_streamon		= vb2_ioctl_streamon,
- 	.vidioc_streamoff		= vb2_ioctl_streamoff,
- 
---- a/drivers/media/platform/vim2m.c
-+++ b/drivers/media/platform/vim2m.c
-@@ -695,7 +695,9 @@ static const struct v4l2_ioctl_ops vim2m
- 	.vidioc_dqbuf		= v4l2_m2m_ioctl_dqbuf,
- 	.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
- 	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
-+#endif
- 
- 	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
- 	.vidioc_streamoff	= v4l2_m2m_ioctl_streamoff,
---- a/drivers/media/usb/au0828/au0828-video.c
-+++ b/drivers/media/usb/au0828/au0828-video.c
-@@ -1666,7 +1666,9 @@ static const struct v4l2_ioctl_ops video
- 	.vidioc_querybuf            = vb2_ioctl_querybuf,
- 	.vidioc_qbuf                = vb2_ioctl_qbuf,
- 	.vidioc_dqbuf               = vb2_ioctl_dqbuf,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.vidioc_expbuf               = vb2_ioctl_expbuf,
-+#endif
- 
- 	.vidioc_s_std               = vidioc_s_std,
- 	.vidioc_g_std               = vidioc_g_std,
---- a/drivers/media/usb/stk1160/stk1160-v4l.c
-+++ b/drivers/media/usb/stk1160/stk1160-v4l.c
-@@ -500,7 +500,9 @@ static const struct v4l2_ioctl_ops stk11
- 	.vidioc_dqbuf         = vb2_ioctl_dqbuf,
- 	.vidioc_streamon      = vb2_ioctl_streamon,
- 	.vidioc_streamoff     = vb2_ioctl_streamoff,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.vidioc_expbuf        = vb2_ioctl_expbuf,
-+#endif
- 
- 	.vidioc_log_status  = v4l2_ctrl_log_status,
- 	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
 --- a/drivers/media/usb/uvc/uvc_queue.c
 +++ b/drivers/media/usb/uvc/uvc_queue.c
 @@ -270,6 +270,7 @@ int uvc_queue_buffer(struct uvc_video_qu
@@ -538,34 +335,6 @@
  
  int uvc_dequeue_buffer(struct uvc_video_queue *queue, struct v4l2_buffer *buf,
  		       int nonblocking)
---- a/drivers/media/usb/uvc/uvc_v4l2.c
-+++ b/drivers/media/usb/uvc/uvc_v4l2.c
-@@ -720,6 +720,7 @@ static int uvc_ioctl_qbuf(struct file *f
- 	return uvc_queue_buffer(&stream->queue, buf);
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- static int uvc_ioctl_expbuf(struct file *file, void *fh,
- 			    struct v4l2_exportbuffer *exp)
- {
-@@ -731,6 +732,7 @@ static int uvc_ioctl_expbuf(struct file
- 
- 	return uvc_export_buffer(&stream->queue, exp);
- }
-+#endif
- 
- static int uvc_ioctl_dqbuf(struct file *file, void *fh, struct v4l2_buffer *buf)
- {
-@@ -1487,7 +1489,9 @@ const struct v4l2_ioctl_ops uvc_ioctl_op
- 	.vidioc_reqbufs = uvc_ioctl_reqbufs,
- 	.vidioc_querybuf = uvc_ioctl_querybuf,
- 	.vidioc_qbuf = uvc_ioctl_qbuf,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.vidioc_expbuf = uvc_ioctl_expbuf,
-+#endif
- 	.vidioc_dqbuf = uvc_ioctl_dqbuf,
- 	.vidioc_create_bufs = uvc_ioctl_create_bufs,
- 	.vidioc_streamon = uvc_ioctl_streamon,
 --- a/drivers/media/v4l2-core/videobuf2-dma-sg.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-sg.c
 @@ -316,9 +316,11 @@ static void *vb2_dma_sg_vaddr(void *buf_
@@ -580,69 +349,3 @@
  			buf->vaddr = vm_map_ram(buf->pages,
  					buf->num_pages, -1, PAGE_KERNEL);
  	}
-@@ -371,6 +373,7 @@ static int vb2_dma_sg_mmap(void *buf_pri
- 	return 0;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- /*********************************************/
- /*         DMABUF ops for exporters          */
- /*********************************************/
-@@ -644,6 +647,7 @@ static void *vb2_dma_sg_attach_dmabuf(vo
- 
- 	return buf;
- }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 
- static void *vb2_dma_sg_cookie(void *buf_priv)
- {
-@@ -662,11 +666,13 @@ const struct vb2_mem_ops vb2_dma_sg_memo
- 	.vaddr		= vb2_dma_sg_vaddr,
- 	.mmap		= vb2_dma_sg_mmap,
- 	.num_users	= vb2_dma_sg_num_users,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.get_dmabuf	= vb2_dma_sg_get_dmabuf,
- 	.map_dmabuf	= vb2_dma_sg_map_dmabuf,
- 	.unmap_dmabuf	= vb2_dma_sg_unmap_dmabuf,
- 	.attach_dmabuf	= vb2_dma_sg_attach_dmabuf,
- 	.detach_dmabuf	= vb2_dma_sg_detach_dmabuf,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
- 	.cookie		= vb2_dma_sg_cookie,
- };
- EXPORT_SYMBOL_GPL(vb2_dma_sg_memops);
---- a/drivers/media/platform/xilinx/xilinx-dma.c
-+++ b/drivers/media/platform/xilinx/xilinx-dma.c
-@@ -628,7 +628,9 @@ static const struct v4l2_ioctl_ops xvip_
- 	.vidioc_qbuf			= vb2_ioctl_qbuf,
- 	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
- 	.vidioc_create_bufs		= vb2_ioctl_create_bufs,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.vidioc_expbuf			= vb2_ioctl_expbuf,
-+#endif
- 	.vidioc_streamon		= vb2_ioctl_streamon,
- 	.vidioc_streamoff		= vb2_ioctl_streamoff,
- };
---- a/drivers/media/platform/marvell-ccic/mcam-core.c
-+++ b/drivers/media/platform/marvell-ccic/mcam-core.c
-@@ -1585,7 +1585,9 @@ static const struct v4l2_ioctl_ops mcam_
- 	.vidioc_querybuf	= vb2_ioctl_querybuf,
- 	.vidioc_qbuf		= vb2_ioctl_qbuf,
- 	.vidioc_dqbuf		= vb2_ioctl_dqbuf,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.vidioc_expbuf		= vb2_ioctl_expbuf,
-+#endif
- 	.vidioc_streamon	= vb2_ioctl_streamon,
- 	.vidioc_streamoff	= vb2_ioctl_streamoff,
- 	.vidioc_g_parm		= mcam_vidioc_g_parm,
---- a/drivers/media/pci/dt3155/dt3155.c
-+++ b/drivers/media/pci/dt3155/dt3155.c
-@@ -415,7 +415,9 @@ static const struct v4l2_ioctl_ops dt315
- 	.vidioc_reqbufs = vb2_ioctl_reqbufs,
- 	.vidioc_create_bufs = vb2_ioctl_create_bufs,
- 	.vidioc_querybuf = vb2_ioctl_querybuf,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
- 	.vidioc_expbuf = vb2_ioctl_expbuf,
-+#endif
- 	.vidioc_qbuf = vb2_ioctl_qbuf,
- 	.vidioc_dqbuf = vb2_ioctl_dqbuf,
- 	.vidioc_streamon = vb2_ioctl_streamon,
-- 
2.3.2.209.gd67f9d5.dirty
