Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A5FC19776
	for <cocci@archiver.kernel.org>; Wed, 26 Feb 2025 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Jy5UzyKzocsSx5cSXomfjfFL//CTemBkcuebkephmC0=;
  b=S0KWtKS1XzyBEClOS+wx/o1qTqt1aMT+ELBerPgu1HrrbQMs4N7DvH2K
   FWeF1VfF31Jfj/bASgI1YWlABne+jXK5jjKWYHqaP7aiHBRNsJY6D1IiQ
   h+MUFGs3KMTb93jVcLyQf8lUHSGHPQZU2pdFS1tZmO/E6wM9qduULC+QH
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@suse.com
X-IronPort-AV: E=Sophos;i="6.13,316,1732575600"; 
   d="scan'208";a="210104181"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Feb 2025 09:59:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 96938E0D3E; Wed, 26 Feb 2025 09:59:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BFAD4E0D1E
	for <cocci@sympa.inria.fr>; Wed, 26 Feb 2025 08:29:01 +0100 (CET)
IronPort-SDR: 67bec2bc_W2H3V/ImcPQfdWTsi3XwjmoVX2E89bvKjUXPlufRBoEMOC7
 j8Th2ivnRydKi8sVuPTLwftarTUHbAuIF201xZQ==
X-IPAS-Result: =?us-ascii?q?A0EUAAA/wr5nfC7aVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVY0BAtIhFaIHYcygiEDi3OSIYINAQMBDUQEAQEDBIUAixQCH?=
 =?us-ascii?q?gcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEiGQcOE?=
 =?us-ascii?q?imFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQINfQEBAQECARIRBBkBATcBBAsLC?=
 =?us-ascii?q?w0CAiYCAiESAQUBHAYTIoUiIwOiVYEFQopEen8zgQGCDAEBBt4FCRSBBi4Bi?=
 =?us-ascii?q?E4BgWyDf0SDOXonG32BEIFKgQaBbz6CYQSBXhWDRoJpgjOBboM+p2smCR0DB?=
 =?us-ascii?q?wcODR5JDwUcA1ksAVUTFwsHBYEpSAECAYEOI4EjBTQKNzqCC2lJOgINAjWCH?=
 =?us-ascii?q?nyCK4IdgjeCGIIrRBgvAwMDA4MqhVKCEYFgAwMWDwGBboExdxyEf4QFHUADC?=
 =?us-ascii?q?2ILPTcUG0yhLTyDSlMZBwGBDYEngQJ6kkGDULAEhCWhYjOjEodDLodlkGqpH?=
 =?us-ascii?q?xEjgUQ6gVwzGggbFWwGgjBPAxkPiACGIQwWg1jLREUyPAIHAQoBAQMJkByBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 U7Keg==
IronPort-HdrOrdr: A9a23:jI1ZfakhlfNe9VwBMMDRVGkrcEjpDfLc3DAbv31ZSRFFG/FwWf
 re5sjzsiWE9Ar5OUtQ5OxoXZPrfZqyz+8T3WB8B8bHYOCighrMEGgA1/qA/9SDIVyGygc178
 4JGJSWSueAb2SS5vyKmDVQfexQu+WvweSGg/zBx2xhQQwvR6Zr9BdhFwqXe3cbeCB2QbQ8UL
 WR7tdavDa7EE5nCPiTNz0qW6zsqbTw+q4OoiRoO/fk0mSzZP+TiYIS2iL54isj
X-Talos-CUID: 9a23:58PDXmAXW/aY4Pv6EzY9pH4TK9wbSFCelV3PD3W8UWw2ZKLAHA==
X-Talos-MUID: 9a23:NhbiVAZQn0g49+BTngf+xwpdL9tTu5uFVBgGmIshgPmZHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,316,1732575600"; 
   d="scan'208";a="110074223"
X-MGA-submission: =?us-ascii?q?MDEgYI1kZ7oylwkTU4v9gsPACBjoqJl6wJ4lzc?=
 =?us-ascii?q?8O+XRjw3mNxTywY6l52TBsZ9dTmO14nPhJ2qhT3A2Ig0nDJkdTPgPA1H?=
 =?us-ascii?q?zjMxFKmLCr+IJ7DZCTi8SDrwBXf6fbh1qiVOTHvkCKpBTmHc/cDiV97o?=
 =?us-ascii?q?joe+mSHdNDPGC3GoHi926gHw=3D=3D?=
Received: from mail-ej1-f46.google.com ([209.85.218.46])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 08:29:01 +0100
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so445856166b.3
        for <cocci@inria.fr>; Tue, 25 Feb 2025 23:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740554939; x=1741159739; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jy5UzyKzocsSx5cSXomfjfFL//CTemBkcuebkephmC0=;
        b=D8EmkxqJDjht9hQZU7gxmYKwCUQoqtofyAXdBAGzS+QpB2ui2hZRl4wYOYD+j/wukQ
         cHuqeMR72/GJWdIB3Fk1a/iouDt9dKueIciHkccOV2CKz0fXrmgmlJ2N1IvXrvxJPBpp
         EHE6Yu+F/FuzMy0/z+1G/mKlxfqq8ra0GjqE97L4ZaPT8eGp3guwO3br11A3JGgE/bLR
         lA62UYbdpulytSuni8bj+GQRfDL0Sf4XPDNmOAgDd5PNa2KT4X8vGNF93PNsyReX6V8N
         s0fjLoqKUliCe+IsU6v2hnTVqG0jWMBdRuaw7hjQuge2qgCVMfULiGk/FbF7UoZc9LFL
         9HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740554939; x=1741159739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jy5UzyKzocsSx5cSXomfjfFL//CTemBkcuebkephmC0=;
        b=TVZwaYHxjan51+a43cRiWS+95Q8xCaj937Yc82jUdMdbQG/4/jKITck8geC3bGWFvi
         vt/Nyy0rZgA3SZRWFkow1o+7Mp2P+pCbF4ouf8287MAsFcHAqgokpmaYVy2QJTI6wDdA
         ObSs3ShGlYlnkepbgyoYteLz66me84d8PHFTlKbT0Uyp7kMTqwLqzSo5JTxq56amvf/4
         bGRQPtyw7i/qJEOIvIfvTZdm8pdmFXGMC5EBIPVlGHWErUaP1LX1szFPVDRjsDY5Urci
         dmv6iOeBRC7h34T/N5JHJxoHJ5uhURjDrBpvn694uYQi3tF3tRt001XjD1gaXQBzx9nR
         I3FA==
X-Forwarded-Encrypted: i=1; AJvYcCU8JzKMFU9tfom6+YAwZLSYez+oTBKXtpmtYtidtzI7hBHMm55qREVBiOiBU+R0rLywustRJA==@inria.fr
X-Gm-Message-State: AOJu0YyTK1ZsAEr7JGbyMhUvxVjBtq3LJ3VN7enbCi1Pd+isltl58kix
	Io6atoou7Jo32eN74YCibWuFPreDioQP7MJ+XdSiGzeL1bUwIyK9hmiz5hqZ8bYyEWMj7VB7M+J
	oiFCUx3YuKismx6CBAPoajLLJX5PfkN6EwYvoug==
X-Gm-Gg: ASbGncvSWd29ALlJcROz9cCy9D6fQOdR7jxOobge9Aqys+ETH7FMmgl2FOkgewqC231
	yDlrckfnhCjns1E7VKpf4AWeUrnRwmbQKuNtfWt3TKgGBrVDygtveMxj7CcZLaBDt/erUHmJ6qT
	SR5W4wxg==
X-Google-Smtp-Source: AGHT+IFYP8Tba+z3P6zhrfLVohTtXs/BwRHQBKKRVXu59ZSzqEPbWtjoPmnK2n59Ee5Tugvqu0RIdPnu12lt6iEjWaU=
X-Received: by 2002:a17:906:18b1:b0:ab6:ed8a:601f with SMTP id
 a640c23a62f3a-abeeed1123amr202024966b.12.1740554939189; Tue, 25 Feb 2025
 23:28:59 -0800 (PST)
MIME-Version: 1.0
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88@linux.microsoft.com>
 <e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr>
In-Reply-To: <e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 26 Feb 2025 08:28:48 +0100
X-Gm-Features: AQ5f1JpekOKemtGu2BHsnbGs6fr563e7jHjxxRB5HZ2bESNce9YNZRbPCIKk9Cc
Message-ID: <CAPjX3Fcr+BoMRgZGbqqgpF+w-sHU+SqGT8QJ3QCp8uvJbnaFsQ@mail.gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>, Frank.Li@nxp.com, 
	James.Bottomley@hansenpartnership.com, Julia.Lawall@inria.fr, 
	Shyam-sundar.S-k@amd.com, akpm@linux-foundation.org, axboe@kernel.dk, 
	broonie@kernel.org, cassel@kernel.org, cem@kernel.org, 
	ceph-devel@vger.kernel.org, clm@fb.com, cocci@inria.fr, 
	dick.kennedy@broadcom.com, djwong@kernel.org, dlemoal@kernel.org, 
	dongsheng.yang@easystack.cn, dri-devel@lists.freedesktop.org, 
	dsterba@suse.com, festevam@gmail.com, hch@lst.de, hdegoede@redhat.com, 
	hmh@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, idryomov@gmail.com, 
	ilpo.jarvinen@linux.intel.com, imx@lists.linux.dev, james.smart@broadcom.com, 
	jgg@ziepe.ca, josef@toxicpanda.com, kalesh-anakkur.purayil@broadcom.com, 
	kbusch@kernel.org, kernel@pengutronix.de, leon@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org, 
	martin.petersen@oracle.com, nicolas.palix@imag.fr, ogabbay@kernel.org, 
	perex@perex.cz, platform-driver-x86@vger.kernel.org, s.hauer@pengutronix.de, 
	sagi@grimberg.me, selvin.xavier@broadcom.com, shawnguo@kernel.org, 
	sre@kernel.org, tiwai@suse.com, xiubli@redhat.com, yaron.avizrat@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 06/16] rbd: convert timeouts to
 secs_to_jiffies()
Reply-To: Daniel Vacek <neelx@suse.com>
X-Loop: cocci@inria.fr
X-Sequence: 2459
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/CAPjX3Fcr%2BBoMRgZGbqqgpF%2Bw-sHU%2BSqGT8QJ3QCp8uvJbnaFsQ%40mail.gmail.com>

On Tue, 25 Feb 2025 at 22:10, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 25/02/2025 =C3=A0 21:17, Easwar Hariharan a =C3=A9crit :
> > Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> > secs_to_jiffies().  As the value here is a multiple of 1000, use
> > secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplica=
tion
> >
> > This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci w=
ith
> > the following Coccinelle rules:
> >
> > @depends on patch@ expression E; @@
> >
> > -msecs_to_jiffies(E * 1000)
> > +secs_to_jiffies(E)
> >
> > @depends on patch@ expression E; @@
> >
> > -msecs_to_jiffies(E * MSEC_PER_SEC)
> > +secs_to_jiffies(E)
> >
> > While here, remove the no-longer necessary check for range since there'=
s
> > no multiplication involved.
>
> I'm not sure this is correct.
> Now you multiply by HZ and things can still overflow.

This does not deal with any additional multiplications. If there is an
overflow, it was already there before to begin with, IMO.

> Hoping I got casting right:

Maybe not exactly? See below...

> #define MSEC_PER_SEC    1000L
> #define HZ 100
>
>
> #define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)
>
> static inline unsigned long _msecs_to_jiffies(const unsigned int m)
> {
>         return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
> }
>
> int main() {
>
>         int n =3D INT_MAX - 5;
>
>         printf("res  =3D %ld\n", secs_to_jiffies(n));
>         printf("res  =3D %ld\n", _msecs_to_jiffies(1000 * n));

I think the format should actually be %lu giving the below results:

res  =3D 18446744073709551016
res  =3D 429496130

Which is still wrong nonetheless. But here, *both* results are wrong
as the expected output should be 214748364200 which you'll get with
the correct helper/macro.

But note another thing, the 1000 * (INT_MAX - 5) already overflows
even before calling _msecs_to_jiffies(). See?

Now, you'll get that mentioned correct result with:

#define secs_to_jiffies(_secs) ((unsigned long)(_secs) * HZ)

Still, why unsigned? What if you wanted to convert -5 seconds to jiffies?

>         return 0;
> }
>
>
> gives :
>
> res  =3D -600
> res  =3D 429496130
>
> with msec, the previous code would catch the overflow, now it overflows
> silently.

What compiler options are you using? I'm not getting any warnings.

> untested, but maybe:
>         if (result.uint_32 > INT_MAX / HZ)
>                 goto out_of_range;
>
> ?
>
> CJ
>
>
> >
> > Acked-by: Ilya Dryomov <idryomov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.or=
g>
> > Signed-off-by: Easwar Hariharan <eahariha-1pm0nblsJy7Jp67UH1NAhkEOCMrvL=
tNR@public.gmane.org>
> > ---
> >   drivers/block/rbd.c | 8 +++-----
> >   1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > index faafd7ff43d6ef53110ab3663cc7ac322214cc8c..41207133e21e9203192adf3=
b92390818e8fa5a58 100644
> > --- a/drivers/block/rbd.c
> > +++ b/drivers/block/rbd.c
> > @@ -108,7 +108,7 @@ static int atomic_dec_return_safe(atomic_t *v)
> >   #define RBD_OBJ_PREFIX_LEN_MAX      64
> >
> >   #define RBD_NOTIFY_TIMEOUT  5       /* seconds */
> > -#define RBD_RETRY_DELAY              msecs_to_jiffies(1000)
> > +#define RBD_RETRY_DELAY              secs_to_jiffies(1)
> >
> >   /* Feature bits */
> >
> > @@ -4162,7 +4162,7 @@ static void rbd_acquire_lock(struct work_struct *=
work)
> >               dout("%s rbd_dev %p requeuing lock_dwork\n", __func__,
> >                    rbd_dev);
> >               mod_delayed_work(rbd_dev->task_wq, &rbd_dev->lock_dwork,
> > -                 msecs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT * MSEC_PER_SE=
C));
> > +                 secs_to_jiffies(2 * RBD_NOTIFY_TIMEOUT));
> >       }
> >   }
> >
> > @@ -6283,9 +6283,7 @@ static int rbd_parse_param(struct fs_parameter *p=
aram,
> >               break;
> >       case Opt_lock_timeout:
> >               /* 0 is "wait forever" (i.e. infinite timeout) */
> > -             if (result.uint_32 > INT_MAX / 1000)
> > -                     goto out_of_range;
> > -             opt->lock_timeout =3D msecs_to_jiffies(result.uint_32 * 1=
000);
> > +             opt->lock_timeout =3D secs_to_jiffies(result.uint_32);
> >               break;
> >       case Opt_pool_ns:
> >               kfree(pctx->spec->pool_ns);
> >
>
>
