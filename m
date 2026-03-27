Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54ED210ED659
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2026 11:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kuUt8Zgd1KdSLSIndFK+l5jlSHlVaYEbsEFIyhEkW9g=;
  b=q8bG0CrpTF+AcMIan0U9julUr9BFEYndq3h1C7cfdQgZs/ZrQZ/mG+ql
   ijN2Fim7f5aByB8+eLZMc8NIKra8IGziThm3CVjLw0NrhxWTtNPAB1zTb
   PZS9m4Xh9Nen5tehQaH+xbtbuX9MLuLVR1AVw6caLrrKRqFg0J1qCCONP
   w=;
X-CSE-ConnectionGUID: HambbKmyRX6xq2ue7GjcMQ==
X-CSE-MsgGUID: BnHR5pPUQfeU6XMlOjBJtQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,144,1770591600"; 
   d="scan'208";a="269802677"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2026 12:50:48 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id D6C8981935; Fri, 27 Mar 2026 12:50:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0B215818EC
	for <cocci@sympa.inria.fr>; Fri, 27 Mar 2026 12:50:46 +0100 (CET)
X-CSE-ConnectionGUID: NqK8vizVQK2xejs8tUrLPg==
X-CSE-MsgGUID: Lwkoqt2gR2GphxxvwcyIPA==
IronPort-SDR: 69c66f15_o2UT6XvdOnJNjvmw30jc/eqmpGsbKcbF7PW9XHTs54xJORl
 zO8Nm2UoiqvzICkvbOia1MLhVcJGZGJJa0UzDpQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G0AwCzbsZpgAQP49RaHgEBCxIMggULgkFofTQEC0mEW?=
 =?us-ascii?q?I9Thl+HPIdViHmBVYF9Ag8BAwENTgECBAEBAwSCDIJ0Ao0mAh4HAQQwCQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPD?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAgEDIx0BAREmAQ8LGgIYDgICVgYBF?=
 =?us-ascii?q?AEBgn6CIwEGEAEDNge0FYEygQGCDAEBBtpkHywiWYFnCRWBCi6Fb4JmAYYwh?=
 =?us-ascii?q?D8nD4FVRIEVJ4MDPoRDg1uCaYImgQ6RXVJ4HANZLAFVExcLBwWBIxAzAyAKL?=
 =?us-ascii?q?y0CFA0iDxoFLR1wDCcSDx0XFR9YGwcFEiEqgQMPhmV5Ay5eGg4iAjkDWUo+C?=
 =?us-ascii?q?gFSBYITAoEgLgIBC209NwYDCxsEPY0/MYNCgimUIbJcNAeCOIFngWQMn20GE?=
 =?us-ascii?q?y+XUg6TCy6YWCKpH4FoOoFcMxokgzZPAxkPjiGEM8ULRTI9AgcCBw0DC4VEA?=
 =?us-ascii?q?QGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 RM8zAdzM7xFyQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:QIItgq0Fu1SRMT/FzJZ3GwqjBGYkLtp133Aq2lEZdPWaSL3+qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SODUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:hrsuY22ObJL0P4EnwQ8nybxfPNkGImPc3knpABWoBGRyGKGoU3uo9/Yx
X-Talos-MUID: 9a23:BkBqOwSMEUtBaENgRXTImzJlLdsy7J70J1gNgYUYpMKVFBRZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,144,1770591600"; 
   d="scan'208";a="142504362"
X-MGA-submission: =?us-ascii?q?MDGJfbtW+FS2mh1Ci9z5vUJclWsF8PWrVlG3Xd?=
 =?us-ascii?q?/1a0NrV6Cm/HNCs0o8qxJ0V/Fbf14RyHDuxWbo/0/U/Pt19mlz7EP5Hj?=
 =?us-ascii?q?oJzaucc06fQfATDyxpair62gkPtsStxdyW+lClgRBlk40ipSYNW5VdT8?=
 =?us-ascii?q?j9upqeeVuJEkMUCmz7tOl3CA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 12:50:45 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtyA4-1vGS232fgC-011h4O; Fri, 27
 Mar 2026 12:50:43 +0100
Message-ID: <e4c0b6a4-bde4-4c1f-ad56-aa05eb3229ac@web.de>
Date: Fri, 27 Mar 2026 12:50:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kees Cook <kees@kernel.org>, cocci@inria.fr,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
References: <20260320175113.work.016-kees@kernel.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <20260320175113.work.016-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aj1If+SBYjMhzC6j7vKZdGr6D0nwReT/33NgqhPlBFUiWAK54/i
 qvefk+wQUEBZevShdAvS4fWPSRS70vVJKvNk7KgAdrD9P0F4wJwftYdTfEbriKeICea/sfW
 vz+kH+8SZuqpp21S36E0P8sTERmKhQgk+ZPjXvuexf1TseeIdLnrV9NgK7B9vnMwOYKnUNE
 Hj5rMewp0OI1/H1Jw/pRQ==
UI-OutboundReport: notjunk:1;M01:P0:kEHwjVHNdsc=;UiUYcfDWMrULnGpAkJlkv3WTAvj
 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
Subject: Re: [cocci] [PATCH] coccinelle: kmalloc_obj: Remove default
 GFP_KERNEL arg
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3464
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/iu-7DEDF3M1KmCI0YjMPEw>

=E2=80=A6
> +++ b/scripts/coccinelle/api/kmalloc_objs.cocci
> @@ -122,3 +122,14 @@ fresh identifier ALLOC_OBJS =3D script:python(ALLOC=
_ARRAY) { alloc_array(ALLOC_ARR
>  -	ALLOC(struct_size_t(TYPE, FLEX, COUNT), GFP)
>  +	ALLOC_FLEX(TYPE, FLEX, COUNT, GFP)
>  )
> +
> +@drop_gfp_kernel depends on patch && !(file in "tools") && !(file in "s=
amples")@
> +identifier ALLOC =3D {kmalloc_obj,kmalloc_objs,kmalloc_flex,
> +		    kzalloc_obj,kzalloc_objs,kzalloc_flex,
> +		    kvmalloc_obj,kvmalloc_objs,kvmalloc_flex,
> +		    kvzalloc_obj,kvzalloc_objs,kvzalloc_flex};
> +@@
> +
> +	ALLOC(...
> +-		 , GFP_KERNEL
> +	     )

Would it become helpful to clarify the software run time characteristics a=
ny further
for the selection of mentioned identifiers?

* SmPL disjunction

* Regular expression


Regards,
Markus
