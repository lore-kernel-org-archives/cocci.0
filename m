Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3690EE77175
	for <cocci@archiver.kernel.org>; Wed,  4 Dec 2024 22:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0Nxf6CkGK3NslY+JLgqPcTLt32q1OCumzkrHYUKQkbE=;
  b=lbaDu8yYR79NrpJhrOn9Sxj4JYAJvIY2wwKIoEjBt3nSCgljV250BUyY
   KFSsFNZNwfjJBoHK4FvHudvRxqMLGrtc7hgI47sN2NTMeWOQ5410lHNXK
   RbWEVZ03mcC3F+PwXykuG8hzyu4pkueZ1JKzMT1AlxnkKPIDwHl0BeuQs
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.12,208,1728943200"; 
   d="scan'208";a="197421305"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2024 23:28:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DCBB3E013D; Wed,  4 Dec 2024 23:28:31 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E1999E00B6
	for <cocci@sympa.inria.fr>; Thu, 28 Nov 2024 13:29:15 +0100 (CET)
IronPort-SDR: 6748621b_PXHTaibdvANLjWWBgoqV5oE/WpvjucYaL5jLIDZFfWAY6nS
 SdR1p2hWhoXJHsD+faXkj8wXUBaNDMN2MzqnV9A==
X-IPAS-Result: =?us-ascii?q?A0EoAADbYEhnfnyFCqpaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDggoEC0iEVogdhzCCJJ4XgX4PAQMBCwEBRAQBAQMEhQACimMCHgcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4SKYV7DYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg1+AQEBAxIRBBkBATcBDwsLAwoCA?=
 =?us-ascii?q?iYCAiESAQUBHAYTIoVEA6QlAW6BBUKKQwEBAXh/M4EBggwBAQbcH4FkCRSBB?=
 =?us-ascii?q?i4BiEsBgWyDfYN9eicbgUlEgUqBBoFvPoFSgjgcHRWDRoJpgkSFDyWFNoNKm?=
 =?us-ascii?q?3ImCR0DBwcODR5JDwUcA1khEQFVExcLBwWBKSEsAQIBgkZ/gTaBUQGDEEqDL?=
 =?us-ascii?q?oFeBTcKPYJKaUs3Ag0CNoIkfYJNhRmBC4EVgklMGS8DAwMDgzyGMEQdQAMLY?=
 =?us-ascii?q?gs9NxQbTKFJRoNMgQ4cmRUBr3mEJKFeM6pRLodkkGmpAAIKBwYRI4FEOoFcM?=
 =?us-ascii?q?xoIGxVsBoIwTwMZD44hg3rIbEE1PAIHAQoBAQMJkGsBJwyBSwEB?=
IronPort-PHdr: A9a23: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
 Nw/NUGTUhJ3pIY=
IronPort-Data: A9a23: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
 mHE3kXSz3hp5KycNHN6BOnJF19MvqowMgz0
IronPort-HdrOrdr: A9a23:y4sCuK70zeEj2QV3OQPXwHXXdLJyesId70hD6qm+c20rTiX+rb
 HdoB17726GtN91YhodcL+7SdK9qB/nhOZICMwqTM6ftWrdyQyVxeNZnPHfKlTbckWVmdK1l5
 0QFZSWY+eAcGSS4/yKnDWQIpIOxsKY+Lukieqb43BmVhFydq1shj0ZNi+rVmNzACdJbKBJd6
 Z0JfAmm9NjQxoqhwiAdxw4t0WpnbD2vaOjRR4DCxQu8hTLqRyDrJbVPVy5834lPw9n8PMH8W
 zImQTi++GGnNv+8yT7/Svywv1t6arcIlwpPr39tiDAQQ+c9DpArb4ROczngAwI
X-Talos-CUID: 9a23:bxHL+mBWQWHgXrb6E3l5815XCs90S3PY7Ubbc27mCmdKEoTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3ARNQnag3+GFJljn/d2wQmdqdbQDUjz/+zN2MruLw?=
 =?us-ascii?q?9uu6GcnZLFyybkAqte9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,192,1728943200"; 
   d="scan'208";a="196288616"
X-MGA-submission: =?us-ascii?q?MDHlqPJAtEiKe0z0TCFbDBRS+DCNAdko3OgO9m?=
 =?us-ascii?q?T/SUzwTgWZHBfRHM//D3Ox44qV+8nfpVTGC3CCKOjnkEMEm/GDaFDVkH?=
 =?us-ascii?q?Q+aZTuKU+EbV1F0RcVvc75jU7qe9P1fkTqjlgLtcmoii230YB9cL5Cx6?=
 =?us-ascii?q?duNyab3lbbabAzkG+7HHxxHw=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 13:29:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732796954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Nxf6CkGK3NslY+JLgqPcTLt32q1OCumzkrHYUKQkbE=;
	b=NF86R7YPaO4OmYapdN/YmkctK36hyatOwgFnMmypDgOYs+5hDSzw9VI6kPrX1Sfwh9Y/oh
	pkRUEbh4+BmMaTxCAagWRlwi7lwQxDFd7HAWNdry//JprUXWVkYB37Tpxs4gq9uxDC5E3q
	Hb7mXLh0aj/aMRbdo2tBNwPWG0P55Bs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-UbwhqYjpOnSkRsEVnvjXoA-1; Thu, 28 Nov 2024 07:29:13 -0500
X-MC-Unique: UbwhqYjpOnSkRsEVnvjXoA-1
X-Mimecast-MFC-AGG-ID: UbwhqYjpOnSkRsEVnvjXoA
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa51a52a5a5so41791266b.2
        for <cocci@inria.fr>; Thu, 28 Nov 2024 04:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732796952; x=1733401752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Nxf6CkGK3NslY+JLgqPcTLt32q1OCumzkrHYUKQkbE=;
        b=LzT9KASAYbQv06dv4fooezCxrzhvXJ/7Ioct1hMRE/p7x+xqpvtTMQe+lpDuGMS6CF
         TzfaxMm73kDGUNteIkrzhOvlEQ08BGmkYA7dqakryqkv1A0byg3O9/l30l0Y19rZArmI
         Pwmu4cwAsE8tI+VEeaWWS93Dtr8soaOEH7B3Zmo+nNbkEcr5dSELulOLXSRdBtoUZ0v7
         zg0nhxnl6MSEl8yAkWLXFRm1caJ/DOsVs5U6AqIcrvd1aOlCw8xz7mcymvs+ghHqYNnN
         GaGmDNhGtb47UAq9VnvABuJz38LoOhlg0LYM5BVMJGcB6gMMCof9EtxTtec4GSHnOPuP
         cClA==
X-Forwarded-Encrypted: i=1; AJvYcCVUQ4sAM+rZGq4LqTWshdVhacbXnRYpcQdftl3Eu3UCXiHagwmVdjonZlfrozkksLTOJja7Vw==@inria.fr
X-Gm-Message-State: AOJu0YwH29G5XD+hQ5lqPYXQkjZJBDiElxRLce89jF9yBDHpGz13LZqH
	VsW8taOaoMauYpM7OIJx74Q9A4xA+VN/jUZfTX6gppzt2QRBKbKaCQiSGX+KcfxO5B2qPFHL6Xt
	gP2KNHU4fF1yRPJ3ihSBTTtu+vMevibUyoeXHNw09HqnQafj2QsBk/uk5mQON5Rbnmu4+sASTdd
	QWl/Akq+woxtad1SDqLg==
X-Gm-Gg: ASbGncs7t/xKVRJIh8t2f/fc5NnGjsZh8z24+i/6xxhjmbQ0Hae5B0AFOzV2BwA2Vh/
	nENu5FMptehc4zeoMClWB/RQtmLb1R38=
X-Received: by 2002:a05:6402:5243:b0:5cf:e26b:9797 with SMTP id 4fb4d7f45d1cf-5d080c604fcmr5605165a12.29.1732796951977;
        Thu, 28 Nov 2024 04:29:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuE0zkJ6zJza+fGet7qX+06h7Jmet7/bu0xRwgqC9A06SMAgod8PaoQJd1k5pY7KRDfw0cJAGqmNIglvOyUZo=
X-Received: by 2002:a05:6402:5243:b0:5cf:e26b:9797 with SMTP id
 4fb4d7f45d1cf-5d080c604fcmr5605060a12.29.1732796951475; Thu, 28 Nov 2024
 04:29:11 -0800 (PST)
MIME-Version: 1.0
References: <20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v1-18-19aadc34941b@linux.microsoft.com>
In-Reply-To: <20241115-converge-secs-to-jiffies-v1-18-19aadc34941b@linux.microsoft.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 28 Nov 2024 14:29:00 +0200
Message-ID: <CAO8a2SjKS2nWWVkAcqXkZhR+Q1TocULkwRk09ABf8XQjjzwJPQ@mail.gmail.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>, 
	Oded Gabbay <ogabbay@kernel.org>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
	Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	Christian Gmeiner <christian.gmeiner@gmail.com>, Louis Peens <louis.peens@corigine.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cocci@inria.fr, linux-arm-kernel@lists.infradead.org, 
	linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-scsi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-block@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	linux-mm@kvack.org, linux-bluetooth@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-rpi-kernel@lists.infradead.org, 
	ceph-devel@vger.kernel.org, live-patching@vger.kernel.org, 
	linux-sound@vger.kernel.org, etnaviv@lists.freedesktop.org, 
	oss-drivers@corigine.com, linuxppc-dev@lists.ozlabs.org, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RZWqKh-NTSNIXOwfn7ZbamS_IVMA-DNAz0LZgaIdOWI_1732796952
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 18/22] ceph: Convert timeouts to
 secs_to_jiffies()
Reply-To: Alex Markuze <amarkuze@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 2150
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/CAO8a2SjKS2nWWVkAcqXkZhR%2BQ1TocULkwRk09ABf8XQjjzwJPQ%40mail.gmail.com>

looks good

On Fri, Nov 15, 2024 at 11:35=E2=80=AFPM Easwar Hariharan
<eahariha@linux.microsoft.com> wrote:
>
> Changes made with the following Coccinelle rules:
>
> @@ constant C; @@
>
> - msecs_to_jiffies(C * 1000)
> + secs_to_jiffies(C)
>
> @@ constant C; @@
>
> - msecs_to_jiffies(C * MSEC_PER_SEC)
> + secs_to_jiffies(C)
>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  fs/ceph/quota.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 06ee397e0c3a6172592e62dba95cd267cfff0db1..d90eda19bcc4618f98bfed833=
c10a6071cf2e2ac 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -166,7 +166,7 @@ static struct inode *lookup_quotarealm_inode(struct c=
eph_mds_client *mdsc,
>         if (IS_ERR(in)) {
>                 doutc(cl, "Can't lookup inode %llx (err: %ld)\n", realm->=
ino,
>                       PTR_ERR(in));
> -               qri->timeout =3D jiffies + msecs_to_jiffies(60 * 1000); /=
* XXX */
> +               qri->timeout =3D jiffies + secs_to_jiffies(60); /* XXX */
>         } else {
>                 qri->timeout =3D 0;
>                 qri->inode =3D in;
>
> --
> 2.34.1
>
>

