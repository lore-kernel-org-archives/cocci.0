From: malat@debian.org (Mathieu Malaterre)
Date: Thu, 1 Feb 2018 17:29:42 +0100
Subject: [Cocci] cocci script for detecting alloc_apertures mem leak
Message-ID: <CA+7wUsz+Ud6+LFVdVs7-pPMSJmW-7opXCqs2NuYP3=enYxoD4A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi cocci gurus,

I am wondering if coccinelle can handle detection of kzalloc mem leak
(within alloc_apertures call) ? Typically:

$ cat drivers/video/fbdev/vesafb.c
static int vesafb_probe(struct platform_device *dev)
[...]
  info->apertures = alloc_apertures(1);

but then:

static void vesafb_destroy(struct fb_info *info)
{
  struct vesafb_par *par = info->par;

  fb_dealloc_cmap(&info->cmap);
  arch_phys_wc_del(par->wc_cookie);
  if (info->screen_base)
    iounmap(info->screen_base);
  release_mem_region(info->apertures->ranges[0].base,
info->apertures->ranges[0].size);
}

For reference:

$ cat include/linux/fb.h
static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
  struct apertures_struct *a = kzalloc(sizeof(struct apertures_struct)
    + max_num * sizeof(struct aperture), GFP_KERNEL);


Thanks for comments,
