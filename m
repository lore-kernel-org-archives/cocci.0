From: himangi774@gmail.com (Himangi Saraogi)
Date: Sun, 15 Jun 2014 01:51:00 +0530
Subject: [Cocci] [PATCH] Coccinelle : Script to detect cast after memory
	allocation
In-Reply-To: <1402776217.2756.23.camel@joe-AO725>
References: <20140614154541.GA4179@himangi-Dell>
 <1402761961.2756.12.camel@joe-AO725>
 <alpine.DEB.2.02.1406141809050.1962@localhost6.localdomain6>
 <1402765314.2756.20.camel@joe-AO725>
 <CAB78YHwDpK988sKk5pzXWhuMszyyS=wtk5ETP-B-JBGdwRPxhw@mail.gmail.com>
 <1402776217.2756.23.camel@joe-AO725>
Message-ID: <CAB78YHx72nAQ8pm9OpONqZUVAUQ+82RSnMu8aWB3oa2AwzzVEw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 15 June 2014 01:33, Joe Perches <joe@perches.com> wrote:

> On Sun, 2014-06-15 at 01:03 +0530, Himangi Saraogi wrote:
> > Hi,
>
> Hi Himangi.
>
> > I have run the generic rule but it does not detect the cases of
> > cast where the k[mzc]alloc or the kmem functions are used. I have used
> > flags like recursive-includes, as suggested by Julia, but not any of the
> > cases covered by the original script are detected.
>
> Odd.
>
> When I tried it I got things like:
>
> Thanks for your feedback. Sorry, yes it does detect, I had already sent
patches for the files and hence my tree did not have the casts.

> $ cat void.cocci
> @@
> void *t;
> type other;
> @@
>
> -       (other *)t
> +       t
>
> $ spatch --version
> spatch version 1.0.0-rc14 without Python support and with PCRE support
>
> $ spatch --sp-file void.cocci --recursive-includes
> drivers/block/cciss_scsi.c
> drivers/block/cciss_scsi.c
> +++ /tmp/cocci-output-8427-7875f0-cciss_scsi.c
> @@ -704,8 +704,7 @@ cciss_scsi_setup(ctlr_info_t *h)
>         struct cciss_scsi_adapter_data_t * shba;
>
>         ccissscsi[h->ctlr].ndevices = 0;
> -       shba = (struct cciss_scsi_adapter_data_t *)
> -               kmalloc(sizeof(*shba), GFP_KERNEL);
> +       shba = kmalloc(sizeof(*shba), GFP_KERNEL);
>         if (shba == NULL)
>                 return;
>         shba->scsi_host = NULL;
>
>
>
I'll be extending the patch to handle generic cases.
Thanks
Himangi
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20140615/7d1a3777/attachment.html>
