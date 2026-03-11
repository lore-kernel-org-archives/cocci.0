Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E251125842
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 15:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=giiOm4nN20bJPCHKicALa9KbdO4HtuSxDT6eKFGA2mo=;
  b=K1blI1CUNT0Q9rbUhYbkZW0Mt8pxPsqvBP2y64hKpuX5Z7CsCmsbFJ5G
   P3BVRKcrTzloIZkQ9HUAt20D8Y6DTctbWTIBhfLKHA/94nyicigmMSjbM
   8Z52yHX9eeOSlagouKwNEWdj9Mpq/OlBLKUlnWf8UKJkM3s57hV/72JzX
   U=;
X-CSE-ConnectionGUID: Zl6yhf52T2iIfB61B4dqdA==
X-CSE-MsgGUID: JQIicvZnRyibeWttkA98IQ==
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
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267323556"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 16:13:41 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2229381A0B; Wed, 11 Mar 2026 16:13:41 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2CD5C819FF
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 16:13:39 +0100 (CET)
X-CSE-ConnectionGUID: tWS8uOvWSzyaDI4HmakY8g==
X-CSE-MsgGUID: bRcDrrViROSyzLX63sX8VA==
IronPort-SDR: 69b186a3_NKIAU/H9F5us+qRoKVBJLP+Pq2FHZZVpR7MhLE5P0T4sjan
 lgmVldXvhpx+NcjsyYaCAj+3BhLJbrQX1pNkzsg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GBAABEhbFpgAQP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBUIJBgQdeNAQLSYRYj1OGX48RiHmBaYEsPQIPAQMBDT0RAQIEAQEDB?=
 =?us-ascii?q?IIMgnQCjSMCHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABATsHDgoxhk8NgmIBgSRlCTgBAQEBAQEBAQEBAQEBAQEBAQEBFgI9C?=
 =?us-ascii?q?kQCAQMjHQEBESYBDwsODAIRBw4CAlYGARQBAYJ+AYIiAQYQAQM2Bw2wJIEyg?=
 =?us-ascii?q?QGCDAEBBtpkHywiWYFnAwYVgQouhW+CZQGFWho7g0V6Jw+BVUSBFSeDAz6CY?=
 =?us-ascii?q?QIDgRZHP4McgmmCJoEOi2uHOFJ4HANZLAFVExcLBwWBIxAzAyAKLy0CFA0iD?=
 =?us-ascii?q?xoFLR1wDCcSDx0XFB9YGwcFEiEqB4FBeIIBD4ZoeQMuXhoOIgI6A1mBBgoBW?=
 =?us-ascii?q?gWCLAIcAgELbT03BgMLGwQ9jms9gjMCUjE2yHo0B4I4gWeBZAyKLpU/BhMvl?=
 =?us-ascii?q?1IOkwsuh2WQcyKNZ5s4gX8jgVwzGiSDNk8DGQ+OIYQzhGDDWUUyPAIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 XE=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:zCF/bKrpAlaZU36n9uIqHqoaV5tqL9V00zEX/kB9WHVpmwKj9v
 xG+85rsyMc6QxhP03I/OrrBEDuex7hHPJOjbX5eI3SPzUPVgOTXf1fBMjZskDd8xSXzJ8j6U
 4YSdkBNDSoNykKsS+Z2mmF+qcbsb26GfuT9J7jJh5WJGkAV0gj1XYaNu/8KCJLrWJ9dP8E/f
 SniPavjgDQCkg/X4CUBmQlQ+OGgNvXlJ33JScCDwMp7hKL5AnYmILSIly33go+TzgK+rsr62
 7D+jaJnJmLgrWUygL8y2SW1JhdmMLgxtxfbfb88fQ9G3HDihuIeI8kYLGJvCk0rOazrH4mnc
 LBuQ1IBbUH11rhOk+0vDrw0E3b3DEi52SK8y7hvVLvrdblRDUzFspGgpgxSGqq13Yd
X-Talos-CUID: 9a23:Lx9eyW6d+eyZIAheFtss6HEvSt0CbELm3mbZD27kKWNgS4zFRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3APnPNIQzp/qHuFXa6/EgKcPV6a1CaqK6UA2wXi6s?=
 =?us-ascii?q?Hge6/JD5UC2nGlwTnfKZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267323539"
X-MGA-submission: =?us-ascii?q?MDGQfzYj1Q37mpZtCHObnZbky1fVdMRe7N9txC?=
 =?us-ascii?q?XFi9eMH2+n/uncH1nicYXce4/773ebev7A8OSXEA9rllmdI/eJpo+ELd?=
 =?us-ascii?q?rXFtQ8gIAiiOVH7bEvJ/oP3YKRZ/p+D4UWOnFKiCw4/kUpZWdL2fOI3M?=
 =?us-ascii?q?JuIHC2IthS+q7yy7pt8EkBPg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 16:13:39 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cHJ-1vWLef0wrt-00vzxd; Wed, 11
 Mar 2026 16:12:40 +0100
Message-ID: <e6145c17-64ce-494e-a41a-c847df3d999e@web.de>
Date: Wed, 11 Mar 2026 16:12:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Philipp Hahn <phahn-oss@avm.de>, cocci@inria.fr,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, dm-devel@lists.linux.dev,
 dri-devel@lists.freedesktop.org, gfs2@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
References: <20260310-b4-is_err_or_null-v1-1-bd63b656022d@avm.de>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-1-bd63b656022d@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8uNlJJTAs0E3eVrueF6w+kamgZld8V5k307BMa2qc/KwhoVrne3
 cPN5KceT1D2i5YOSNggwsPxOs655cWyte1CKlNlBLyuH93VGvstvy+ggV5GDmk4PUMu8Iwj
 lIBpLLqKBgo7uQxQM9uBZQLnvS5wa1t6ITQ23zK6Z5KinOA9Ud5Ss1etUILA/92IsKQJLWt
 MbIOhZYtTIg4ZGnA6bYYw==
UI-OutboundReport: notjunk:1;M01:P0:JCtAJ/zNjOI=;sDWY82KXUVoSud92r84ZXuFAtv9
 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
 tJ2F8GMFz7+S2uTh+G9X
Subject: Re: [cocci] [PATCH 01/61] Coccinelle: Prefer IS_ERR_OR_NULL over
 manual NULL check
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3417
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/cxOP0mRM7pAoavOpWXiRFQ>

=E2=80=A6
> +// Confidence: High

Some contributors presented discerning comments for this change approach.
Thus I became also curious how much they can eventually be taken better in=
to account
by the means of the semantic patch language (Coccinelle software).

=E2=80=A6
+@p1 depends on patch@
+expression E;
+@@
+(
> +-	E !=3D NULL && !IS_ERR(E)
> ++	!IS_ERR_OR_NULL(E)
> +|
> +-	E =3D=3D NULL || IS_ERR(E)
> ++	IS_ERR_OR_NULL(E)
> +|
> +-	!IS_ERR(E) && E !=3D NULL
> ++	!IS_ERR_OR_NULL(E)
> +|
> +-	IS_ERR(E) || E =3D=3D NULL
> ++	IS_ERR_OR_NULL(E)
> +)

Several detected expressions should refer to return values from function c=
alls.
https://en.wikipedia.org/wiki/Return_statement

* Do any development challenges hinder still the determination of correspo=
nding
  failure predicates?

* How will interests evolve to improve data processing any further for suc=
h
  use cases?


Regards,
Markus
