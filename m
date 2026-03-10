Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1604EB1070
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 15:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ViIdeWt5br4rBsrGxHUMEkJDkD/ERSvSv/UV5SzvttY=;
  b=vd0je7m4d5yTE6nAdi1bOLAn5KLgAnobJipUOv8uWKyDPfR62o9fr9cL
   mvU1gpempJRGEE1fF8ID/+wGJagjdNMCJ7ve1GmuHja8Ir4RIpfKg+rxY
   h6+vUWCDXFvby7hQOSStGKwA1cNhlCRVFELQRkfr2Q/XDLhOVbp9RQUEX
   s=;
X-CSE-ConnectionGUID: /Mj3FdIHQOe6y5fCdZVveA==
X-CSE-MsgGUID: oIaahNezQHKWFq0XgDFDWw==
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
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267139160"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 16:42:11 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3536D83A90; Tue, 10 Mar 2026 16:42:11 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 38A47839D4
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 16:42:09 +0100 (CET)
X-CSE-ConnectionGUID: MgQxHOWqS165LrdKUhU3Cg==
X-CSE-MsgGUID: Yci79XobT96fcLeVQqAV8g==
IronPort-SDR: 69b03bd0_HvLkvR93Wd+cY4zpfHBzmOpqCFaSD5VOmIh6pZ9UWE9QboH
 Y9uDCmvUqtFNQnf445Hq4kQuBuLFTBrmNy1v6Bw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EhBQD0OrBpgwsR49RaHQEBAQEJARIBBQUBQIFQgkGBZ?=
 =?us-ascii?q?TQEC0mEWGiOa4IkhDuHPJBOg1ICDwEDAQ1OAQIEAQEDBIUAAo0hAh4HAQQ0E?=
 =?us-ascii?q?wECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBOgcOCjGGT?=
 =?us-ascii?q?w2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmAQQLCw4MAhgOA?=
 =?us-ascii?q?gJWBgEUAQGCfoIjAQYQAQMPJweuAIEygQGCDAEBBtpkHywiWYFnCRWBCi6Fb?=
 =?us-ascii?q?4JlAYVaGjuDRXonD4FVRIEVJ4MDPoRDg1uCaYImgQ6HPgaLXFJ4HANZLAFVE?=
 =?us-ascii?q?xcLBwWBIxAzAyovLSNLBS0dcAwnEg8dFxQfWBsHBRIhKoFJeIIBD4ZqeQMuX?=
 =?us-ascii?q?hoOIgI6XEo+CgFaBYI/AgELbT03BgMLGwQ9jmo+gi0IWIMAHsY9NAeCOIFng?=
 =?us-ascii?q?WQMn20GEy+XUg6TCy6HZZBzIqkfgX8jgVwzGiSDNk8DGQ+OIQwNCYQRyGlFM?=
 =?us-ascii?q?jwCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Z/4SQ6jwKc4SfITawJrsbG+cvHBQX1p13DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03IwerwQ5VpQRvnhP1ICPoqTM2ftWjdySCVxeRZgbcKrAeQfBEWmtQ96U
 4kSdkHNDSSNykxsS+Z2njfLz9I+rDun86VbKXlvg5QpGpRGsNdBnJCe2Km+zpNNWx77PQCdK
 a0145inX6NaH4XZsO0Cj0uRO7YveDGk5rgfFovGwMnwBPmt0Ll1JfKVzyjmjsOWTJGxrkvtU
 LflRbi26mlu/anjjfBym7o6YhMkteJ8KoNOCXMsLlaFtzfsHfpWG1TYczAgNnzmpDs1L8eqq
 iMn/7nBbU315qeRBDwnfKn4Xic7N9n0Q6f9bbfuwqvnSWxfkNEN+NRwY1eaRfX8EwmoZV117
 9KxXuQs95NAQrHhzmV3am/a/jErDvGnZMOq59ms5Vka/poVJZB6YgEuE9FGpYJGyz3rIghDe
 l1FcnZoPJba0mTYXzVtnRmhIXEZAV6Ij6WBkwZ/sCF2Tlfm350i0Me2cwEh38FsJYwUYNN6e
 jIOrlh0LtOUsgVZ6RgA/ppe7r/NkXdBRbXdG6CK1XuE68Kf3rLtp7s+b0woPqnfZQZpaFC7a
 gpkGkox1LaV3ieefFmhqc7jCwlaF/NLAjQ9g==
X-Talos-CUID: =?us-ascii?q?9a23=3A8OtEF2jB+C1GIiKFJxm7kqQdCzJuV3Lk3Ff3HFa?=
 =?us-ascii?q?DUDg0bKeZamKQxfhPnJ87?=
X-Talos-MUID: 9a23:ARN1cQi3BVvZ89qy9PwmoMMpBcxpvPWeD0oxwMsIsO2JCxVpEgnNg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="140948556"
X-MGA-submission: =?us-ascii?q?MDHAjBY8Fuzmy0/YvGW/e5K+tYkvnUdffANwah?=
 =?us-ascii?q?NuSrnDbLU72EvxazLOzTweGXmEfRlnQ+DYHDEo2/kMNz+QbuJWbBddb1?=
 =?us-ascii?q?gRouXseoh3KAt7qKCMnTV0hEO+l/nkELbGgD/0neK9s498CnNi4rCJ81?=
 =?us-ascii?q?l43AzQcJFe1f6+d2A5KUQfQg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 16:42:08 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5lj7-1vYM6w3zfn-012TrV; Tue, 10
 Mar 2026 16:41:18 +0100
Message-ID: <924acf71-45df-4ea2-9bbd-b6f5ff262b2b@web.de>
Date: Tue, 10 Mar 2026 16:41:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Philipp Hahn <phahn-oss@avm.de>, cocci@inria.fr,
 Julia Lawall <Julia.Lawall@inria.fr>
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
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 nicolas.palix@imag.fr, ntfs3@lists.linux.dev,
 samba-technical@lists.samba.org, sched-ext@lists.linux.dev,
 target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 v9fs@lists.linux.dev
References: <20260310-b4-is_err_or_null-v1-1-bd63b656022d@avm.de>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-1-bd63b656022d@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I49ufsxpBKiFBze+2Qm04f+elx94DZSymOaZcQTAnyd9Dy18WSZ
 l5PlqGBdCeQJnqXYHB7LM8JEThQzWaqt46DhF3JOnbIEKCtwYJeZnzJMAXhMu3h78zedo+b
 2MDr9yfDF5xiOPbOsnoVg9HvEpZouoV7eAA1AasOX+/8mAaWp7eICgl3FZXuUGMMgTPEUmo
 9zEXJmftCILFnPJ5epBUQ==
UI-OutboundReport: notjunk:1;M01:P0:jCe8S3PVhmA=;jIHM+yewjYlED18bQxoGve5P1nn
 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
Subject: Re: [cocci] [PATCH 01/61] Coccinelle: Prefer IS_ERR_OR_NULL over
 manual NULL check
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3384
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/S7b-0EeloazAfrrlzvqkfA>

> Find and convert uses of IS_ERR() plus NULL check to IS_ERR_OR_NULL().
=E2=80=A6

Can this information trigger any more consequences on corresponding summar=
y phrases?


=E2=80=A6
> +++ b/scripts/coccinelle/api/is_err_or_null.cocci
> @@ -0,0 +1,125 @@
=E2=80=A6
> +virtual patch
> +virtual report
> +virtual org

How will interests evolve further for the support of the operation mode =
=E2=80=9Ccontext=E2=80=9D?


> +@p1 depends on patch@
> +expression E;
> +@@
> +(
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

Did you eventually check probabilities for the occurrence of mentioned cas=
e distinctions?


> +@p2 depends on patch@
=E2=80=A6

I suggest to reconsider =E2=80=9Cside effects=E2=80=9D according to the sp=
litting of these SmPL rules
once more.


=E2=80=A6
> +@r2 depends on report || org@
> +identifier I;
> +expression E;
> +position p;
> +@@
> +(
> +*	(I =3D E) !=3D NULL && ... && !IS_ERR@p(I)
> +|
> +*	(I =3D E) =3D=3D NULL || ... || IS_ERR@p(I)
> +)

I doubt that the usage of SmPL asterisks fits to these two operation modes=
.


=E2=80=A6
> +@p5 depends on patch disable unlikely @
> +expression E;
> +@@
> +-\( likely \| unlikely \)(
> +(
> + IS_ERR_OR_NULL(E)
> +|
> + !IS_ERR_OR_NULL(E)
> +)
> +-)

* Would it be nicer to move such SmPL code to the end of the patch rule li=
sting?

* Can this source code search pattern matter also for further operation mo=
des?


Regards,
Markus
