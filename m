Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19E8D591AE
	for <cocci@archiver.kernel.org>; Mon, 18 Nov 2024 18:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+R1FnDR/d18PL0XgQdo7E8ddqqJsostStWXSKykuwSk=;
  b=oQNcnar/FStjSUDc+VxohOtNjfwpWnicO4+2i5K+E9rSNU4uVFVjwN24
   2Vh5kLfVU8ZcK+Ayy73Wpfm/Cvn9f5vTnkiCHgVyHdTQGosJZZfjcGjAS
   8ZWZ6YhcraMt7sonKejMjeAgAVB4U90zfpB9GRwq108dtn5KB0ypUfJng
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.12,164,1728943200"; 
   d="scan'208";a="194516789"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2024 19:54:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5419CE0D4B; Mon, 18 Nov 2024 19:54:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C7285E00B7
	for <cocci@sympa.inria.fr>; Mon, 18 Nov 2024 12:28:41 +0100 (CET)
IronPort-SDR: 673b24e7_LfZpHESXnHm8Q48HJI+6D7hWlzbHdXbQ7Or/ZvGoLtdHCnd
 o8gEeYIBqCz6zzYj6+TnZa7g2Tj2XoyGwT50Rgw==
X-IPAS-Result: =?us-ascii?q?A0H2AAAbJDtnjwtBr8ZaHgEBCxIMQIFIC4JEgVY0BAtIh?=
 =?us-ascii?q?FaIfIZRgiScQYFWgUA+DwEDAQ1BAQIEAQEDBIUAAopLAh4GBjAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQUOO4V7DYJiAYEkX?=
 =?us-ascii?q?gcJOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BHwEBAQMjBBkBATcBD?=
 =?us-ascii?q?wsOCgICJgICVgYBEoMBgmUDsQx/M4EBggwBAQaCaNsbCYEaLohMAYFsg307g?=
 =?us-ascii?q?0J6J4IogUqCdT6ECoQUgmmHVCWIf5oLCUl7HANZMgFVExcLBwWBKREQLAMib?=
 =?us-ascii?q?mlOf4E2gVEBQoJOLxshC1yBKX0dFAYVBIEOBTcKP4JKaUs3Ag0CNoIkJAFYg?=
 =?us-ascii?q?k+FF4ELg2FnLwMDAwODPIJQX1UdQAMLbT01Bg4boEtGgzQ9UYJAxl0LB4Qdo?=
 =?us-ascii?q?V0zqk4uh2SQZSKpBYFnOoFcMz2DN08DGQ+OIRmDYY8+AbZnRTICOQIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYkdNIFLAQE?=
IronPort-PHdr: A9a23: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
 iBmbigCTcnGGmJzjw44ZGECe5VGu0dyKg==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:6PeAuqgX0VbmCyhCewKFgDQGfHBQXjEji2hC6mlwRA09T+Wxi9
 2plu8KzAKcskdsZJjvo6H5BEDmewKsyXcV2/huAV7GZmLbUQSTXfpfBOfZslvd8mjFh5RgPM
 RbAttD4b/LfDxHZBbBkXaF+r8bqbHogcWVbKXlvgpQpGpRGsZdBmlCe3+m+wFNNXl7LKt8Pq
 CxouBAoD2tc2kWaMOUOlkpNtKoxuHjpdbNWzJDIwQoxjWvoFqThd7H+l+jr3QjujV0rdhSk1
 T4rw==
X-Talos-CUID: 9a23:KFeDXGPbRMLVeu5DBxhJ1REEIJ0eW3iAw3HLMUmJAl5FYejA
X-Talos-MUID: 9a23:IlM4eASVlDCDvRgIRXS8mW9ZKOdm3piyS25XqbkrssydFX1vbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,163,1728943200"; 
   d="scan'208";a="101914335"
X-MGA-submission: =?us-ascii?q?MDG4EZ4vxYmABEdSm+0hhWInqhVQdYgJnZe3Jx?=
 =?us-ascii?q?+aspAaa31hVEdsTCwUNOaVN/CLCorZdJl3YnARE27IzhfFPvBZg7ThBe?=
 =?us-ascii?q?vkBCcWgnJbK3SyDFQrIAzdD5kYPCHesxI76M8qMJiBYidYbmRHsegqI8?=
 =?us-ascii?q?1QIFk/U4y4ESZC8K0Qs9vxuw=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 12:28:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731929320; x=1763465320;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=eflO5BqcAdiHnObc19vuFxv1kFN4bcVh6FEadC6e/J0=;
  b=hAgAiBgKsqOB3u9hSSGY0r4Me8NhoCrbcjYVOu/vqW5Hgz0JqZ/6C7mz
   marbWbEYmtstF9UH7CveNb/79LnnEqQmK+KkZI1R652T76dv67In9PqOP
   XayZltiC3wzO/9lHvFmz+e3/eFfbdW7OTZ5z7UBnozQtr4YOcvpWuUggy
   hs6yblgrG3nCTERRVgFMnXz4jllKv+x3mWjgxjpYBl/YBf/GXB3vfZ+Tt
   OcuGyxE91RJDS0dACSTXw59dbQex1LNsafRHaPW31Q2dw0KcRl9jn2Y0S
   x9aBEbwNfraJFJ8Kz7qvXg8NRhme2oyb+rdXb+07BzsmX1HuxSQTweQ8j
   w==;
X-CSE-ConnectionGUID: TbP1GcBLTMqHTl4y3xuf5g==
X-CSE-MsgGUID: PZGmi0hRRHKqmgVsawLawA==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="42396234"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="42396234"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 03:28:31 -0800
X-CSE-ConnectionGUID: rRdUd/MrRkyoZEJD1Sac1Q==
X-CSE-MsgGUID: apTDPmdSTQ+3Y3NYJwg9xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="89329614"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO [10.245.246.149]) ([10.245.246.149])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 03:28:08 -0800
Message-ID: <62c1e9e941cec75cf8771761fb9981879fefcce5.camel@linux.intel.com>
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,  Nicolas Palix
 <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang
 <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Ofir
 Bitton <obitton@habana.ai>, Oded Gabbay <ogabbay@kernel.org>, Lucas De
 Marchi <lucas.demarchi@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 James Smart <james.smart@broadcom.com>, Dick Kennedy
 <dick.kennedy@broadcom.com>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Roger Pau =?ISO-8859-1?Q?Monn=E9?=
 <roger.pau@citrix.com>, Jens Axboe <axboe@kernel.dk>, Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Jack
 Wang <jinpu.wang@cloud.ionos.com>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Xiubo
 Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,  Josh Poimboeuf
 <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes
 <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Joe Lawrence
 <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Lucas Stach <l.stach@pengutronix.de>, Russell King
 <linux+etnaviv@armlinux.org.uk>,  Christian Gmeiner
 <christian.gmeiner@gmail.com>, Louis Peens <louis.peens@corigine.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, cocci@inria.fr, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org, 
 linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, linux-mm@kvack.org,
 linux-bluetooth@vger.kernel.org,  linux-staging@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org,  ceph-devel@vger.kernel.org,
 live-patching@vger.kernel.org,  linux-sound@vger.kernel.org,
 etnaviv@lists.freedesktop.org,  oss-drivers@corigine.com,
 linuxppc-dev@lists.ozlabs.org, Anna-Maria Behnsen <anna-maria@linutronix.de>
Date: Mon, 18 Nov 2024 12:27:53 +0100
In-Reply-To: <20241115-converge-secs-to-jiffies-v1-8-19aadc34941b@linux.microsoft.com>
References: 
	<20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
	 <20241115-converge-secs-to-jiffies-v1-8-19aadc34941b@linux.microsoft.com>
Autocrypt: addr=thomas.hellstrom@linux.intel.com; prefer-encrypt=mutual;
 keydata=mDMEZaWU6xYJKwYBBAHaRw8BAQdAj/We1UBCIrAm9H5t5Z7+elYJowdlhiYE8zUXgxcFz360SFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCBMaW51eCBlbWFpbCkgPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPoiTBBMWCgA7FiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQuBaTVQrGBr/yQAD/Z1B+Kzy2JTuIy9LsKfC9FJmt1K/4qgaVeZMIKCAxf2UBAJhmZ5jmkDIf6YghfINZlYq6ixyWnOkWMuSLmELwOsgPuDgEZaWU6xIKKwYBBAGXVQEFAQEHQF9v/LNGegctctMWGHvmV/6oKOWWf/vd4MeqoSYTxVBTAwEIB4h4BBgWCgAgFiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwwACgkQuBaTVQrGBr/P2QD9Gts6Ee91w3SzOelNjsus/DcCTBb3fRugJoqcfxjKU0gBAKIFVMvVUGbhlEi6EFTZmBZ0QIZEIzOOVfkaIgWelFEH
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-3.fc39) 
MIME-Version: 1.0
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 08/22] drm/xe: Convert timeout to
 secs_to_jiffies()
Reply-To: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2081
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/62c1e9e941cec75cf8771761fb9981879fefcce5.camel%40linux.intel.com>

On Fri, 2024-11-15 at 21:22 +0000, Easwar Hariharan wrote:
> Changes made with the following Coccinelle rules:
>=20
> @@ constant C; @@
>=20
> - msecs_to_jiffies(C * 1000)
> + secs_to_jiffies(C)
>=20
> @@ constant C; @@
>=20
> - msecs_to_jiffies(C * MSEC_PER_SEC)
> + secs_to_jiffies(C)
>=20
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

<
> ---
> =C2=A0drivers/gpu/drm/xe/xe_device.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_device.c
> b/drivers/gpu/drm/xe/xe_device.c
> index
> a1987b554a8d2aa42b29301f2853edddfda7fda5..bb3338ef4191e76128611eeb953
> 1c9d2089db85a 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -502,7 +502,7 @@ static int wait_for_lmem_ready(struct xe_device
> *xe)
> =C2=A0	drm_dbg(&xe->drm, "Waiting for lmem initialization\n");
> =C2=A0
> =C2=A0	start =3D jiffies;
> -	timeout =3D start + msecs_to_jiffies(60 * 1000); /* 60 sec! */
> +	timeout =3D start + secs_to_jiffies(60); /* 60 sec! */
> =C2=A0
> =C2=A0	do {
> =C2=A0		if (signal_pending(current))
>=20

