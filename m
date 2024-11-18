Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C162D591A9
	for <cocci@archiver.kernel.org>; Mon, 18 Nov 2024 18:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Q4K7ZFgLQYJQlGAzpq8RK54g3EqKOomWWOR+yhsr1qw=;
  b=ZDgOweko/QkEo8SDA2L/Mz0rpm1EYOQG3FCSKZE+mbZejoW5pGctV10J
   2bgqAu86picCAF+PJocTqYzJ1cGFCeEDZaDlh7da5kOJL3DrjzWv/9/Mg
   mDiD3v18IUjtHIzwvuuqxAPffVXikL2ZKcOvjJi1v9GmKR5GfWK7Y4sgQ
   E=;
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
X-IronPort-AV: E=Sophos;i="6.12,164,1728943200"; 
   d="scan'208";a="194516768"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2024 19:54:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 24F7CE0D1E; Mon, 18 Nov 2024 19:54:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C4E39E00B7
	for <cocci@sympa.inria.fr>; Mon, 18 Nov 2024 12:06:43 +0100 (CET)
IronPort-SDR: 673b1fc3_LKXu0Q1Qhf6MAbMj95A0fjrxnAvqDsVDi9mA2xMpqO6oZAq
 fNpQuf/SirpAf6MhcdKRHFX+O6opiCPL4BaP1vQ==
X-IPAS-Result: =?us-ascii?q?A0EUBwBXHjtnfCndVdEWBT+BCYFTAoJCfVozBFOUI4IEI?=
 =?us-ascii?q?J4XgUA+DwEDAQsBATkJAgQBAQMEhQACiksCHgcBBDAJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEQAQEFAQEBAgEBAgQGAQIQAQEiGQcOEimFew2CYgGBJFENAwc+AQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQINXgEfAQEBAxIgA?=
 =?us-ascii?q?Q0BATcBDwsYHBIQIwEFARwGExsHgmCCZAMEDQSPJJRBgQVCizyBNIEBggwBA?=
 =?us-ascii?q?QbcH4FkAwYJAQqBNAGISwGFaYR3JxuBSUSBSoFzgQI+iweBFIExeYMgdiWIF?=
 =?us-ascii?q?2iRbIgfUnscA1khEQFVExcLBwWBKSEsA4JHf4E2gVEBgxBKgy6BXgU3Cj+CS?=
 =?us-ascii?q?mlLNwINAjaCJH2CT4UXgQuDYWcvAwMDA4M8hAQdQAMLbT01FBugSgFGgzSBD?=
 =?us-ascii?q?yuBfXqTIIJuAY9foBeEJIwWlXqXQJMOLodkkGWFGohllVaFKAIKBwYRI4FEO?=
 =?us-ascii?q?oFcMxoIGxWDIk8DGQ+OLRaDWIQ+wWhCNTsCBwEKAQEDCYVIgQCIUYFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:FWryNq817hKcfA+9F+xuk+AgI+orL9Y04lQ7vn2ZKCYlCfBx9a
 iV8MjzsCWatN9/YgBCpTntAtjjfZqYz+8T3WBzB8bbYOCFghrNEGgK1+KLqFeMek3DH6xmpM
 FdmsNFeaTN5C1B/LjHCX6DYqkdKbe8gcWVrNab52txTA1sdqFr5xp0B0KmCEFsLTM2eabRbK
 Dsm/av8ADQA0g/X4CDIkhAZfHKo7Tw5ePbiME9aSIa1A==
X-Talos-CUID: =?us-ascii?q?9a23=3AmWJ5z2lIEqW+JaL+jTCyB8KrBgfXOXeF9FPMGkG?=
 =?us-ascii?q?8MF1CV+KrFHCM17I0ufM7zg=3D=3D?=
X-Talos-MUID: 9a23:7XFfOwXCWuDYJvDq/DLox2h6CoRP2vinS11Ty9YFsJTdcgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,163,1728943200"; 
   d="scan'208";a="194411337"
X-MGA-submission: =?us-ascii?q?MDGjBtAwAJCZuvtkVsZGAaVvCqRhWU8ND5yBVQ?=
 =?us-ascii?q?968LZaEH1WguOhlFZQDBN7X2Yiqdu+kdA86htaLN3EX+fDUvQVnCCDdC?=
 =?us-ascii?q?fqAj6KtnDOyghj2ahlnBdwjoCqdLyuCrQ/NBR/7rWuAMDOAIxjAxLfgw?=
 =?us-ascii?q?yJz6D714mPUuRfr2Bntz7pvw=3D=3D?=
Received: from mail-wr1-f41.google.com ([209.85.221.41])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 12:06:43 +0100
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-382423e1f7aso761726f8f.2
        for <cocci@inria.fr>; Mon, 18 Nov 2024 03:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731928002; x=1732532802; darn=inria.fr;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q4K7ZFgLQYJQlGAzpq8RK54g3EqKOomWWOR+yhsr1qw=;
        b=AbpEGZWNJl6s1MZrAauXvw1ykULz+X4bF+wBDcMY5SKxpIiN7rMzf3MOthx0Y+LWn3
         H/Sadb680/kg/VqTQTPUKRcQQZS1alKXvfQv585vxiHdbJ9xaioNdninWI4ryKFCbWF7
         7iYnGmQ1pz/ylAN5vZXTuzAKchZg7dz4G3Aj60ctVOpLQ5kY48CWn3DVNTidR5268+bn
         bkU//pqn/1rT9cXHWf3/5R62sugMrUMMX9NJH3LRtzhOA9eBSEvXV8dnBEyBTUXqwlwq
         UP2bR0GvfHJCgN/iV0r9SOyNZAfPSItOyU5Be9NOMK+ppF3EQQCkVTyIzGWHBGKw6TVg
         aqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731928002; x=1732532802;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4K7ZFgLQYJQlGAzpq8RK54g3EqKOomWWOR+yhsr1qw=;
        b=EyM5QkNfYvts62RjuZ8WddhVdIZtDICAgLZSyBZmtfYmh8SaHo4eAgIF68Bfkpjqn0
         ICOct+seGXJaCojI06zr7okF1kXrhiiH2NXTBTqDp5/+RtEPaWq5FHTv1if0euFoCxQO
         Xx1FPD/akVuHPd1Hd/hUn/6RWM9nIK5Nbyl9vy2rRgRqkrMFqeswLlvS3/K8oGLIsoh7
         YABdQuzQtV7SKgDiSrPLnTI+xJ378Ct635/e9wq7tnGNAfn2psqNdFdvvzueX43FERna
         kYI9tX0r21E9bc3N/tVbtj7RtO+L6s0BEtRD4aW2YBSg3y4cb0enIN68T6szG5hB4+eX
         rC5w==
X-Forwarded-Encrypted: i=1; AJvYcCX6l2B8VbRUEd/w4xBBNVuEBEsJhQxM6w3OJyCh5JgdOGRBPzm2qXrkO7YJnqxuUFIjvvj/Rw==@inria.fr
X-Gm-Message-State: AOJu0YyOkfah23JLdQLjZPoapc3W/Q129orL+IudiFv2DV7ooyeIt7lW
	r5qTLqtaLzhr0EoJK2AyxOofZgJflCGq+YPckjvfYoa/oWaremCKko4nlQFOOrA=
X-Google-Smtp-Source: AGHT+IEHvVmgRYFNhCs4UC7E5RjVk5JwGYVdnUZOYcUXsiEIWSohYFEZO8cTVp2lMrq4C8xPl0BQ1Q==
X-Received: by 2002:a05:6000:18af:b0:37d:4ef1:1820 with SMTP id ffacd0b85a97d-38225a91e80mr10392779f8f.40.1731928002298;
        Mon, 18 Nov 2024 03:06:42 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38242eef982sm4319340f8f.8.2024.11.18.03.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:06:41 -0800 (PST)
Date: Mon, 18 Nov 2024 12:06:34 +0100
From: Petr Mladek <pmladek@suse.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ofir Bitton <obitton@habana.ai>, Oded Gabbay <ogabbay@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	Louis Peens <louis.peens@corigine.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <Zzsfuuv3AVomkMxn@pathway.suse.cz>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <20241115-converge-secs-to-jiffies-v2-19-911fb7595e79@linux.microsoft.com>
 <718febc4-59ee-4701-ad62-8b7a8fa7a910@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <718febc4-59ee-4701-ad62-8b7a8fa7a910@csgroup.eu>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 19/21] livepatch: Convert timeouts to
 secs_to_jiffies()
Reply-To: Petr Mladek <pmladek@suse.com>
X-Loop: cocci@inria.fr
X-Sequence: 2080
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/Zzsfuuv3AVomkMxn%40pathway.suse.cz>

On Sat 2024-11-16 11:10:52, Christophe Leroy wrote:
> 
> 
> Le 15/11/2024 à 22:26, Easwar Hariharan a écrit :
> > [Vous ne recevez pas souvent de courriers de eahariha@linux.microsoft.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > Changes made with the following Coccinelle rules:
> > 
> > @@ constant C; @@
> > 
> > - msecs_to_jiffies(C * 1000)
> > + secs_to_jiffies(C)
> > 
> > @@ constant C; @@
> > 
> > - msecs_to_jiffies(C * MSEC_PER_SEC)
> > + secs_to_jiffies(C)
> > 
> > Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> > ---
> >   samples/livepatch/livepatch-callbacks-busymod.c |  2 +-
> >   samples/livepatch/livepatch-shadow-fix1.c       |  2 +-
> >   samples/livepatch/livepatch-shadow-mod.c        | 10 +++++-----
> >   3 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/samples/livepatch/livepatch-callbacks-busymod.c b/samples/livepatch/livepatch-callbacks-busymod.c
> > index 378e2d40271a9717d09eff51d3d3612c679736fc..d0fd801a7c21b7d7939c29d83f9d993badcc9aba 100644
> > --- a/samples/livepatch/livepatch-callbacks-busymod.c
> > +++ b/samples/livepatch/livepatch-callbacks-busymod.c
> > @@ -45,7 +45,7 @@ static int livepatch_callbacks_mod_init(void)
> >   {
> >          pr_info("%s\n", __func__);
> >          schedule_delayed_work(&work,
> > -               msecs_to_jiffies(1000 * 0));
> > +               secs_to_jiffies(0));
> 
> Using secs_to_jiffies() is pointless, 0 is universal, should become
> schedule_delayed_work(&work, 0);

Yes, schedule_delayed_work(&work, 0) looks like the right solution.

Or even better, it seems that the delayed work might get replaced by
a normal workqueue work.

Anyway, I am working on a patchset which would remove this sample
module. There is no need to put much effort into the clean up
of this particular module. Do whatever is easiest for you.

Best Regards,
Petr
