Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E236D1076361
	for <cocci@archiver.kernel.org>; Wed,  1 Apr 2026 05:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bsQUMaKNcW/XyGNGxOCVRKsIQt8mmEbpkh2Q3W4T4uE=;
  b=geVLKmrqo6uMTgsGgiDkuTWjR/SrStXcb1fIpz+NIVcBgdg3Xjb1hsrU
   j4MnKmj9DN6XTnk+Xak+d3h/ita7ZP1aas6P7eBBfIvlT41nwSBG88q7w
   kejbZvDla+Ar/esyF0AiZaJO18fvMhocG3E9y0zjr889ZmMbL5iWZ9ng+
   w=;
X-CSE-ConnectionGUID: Fo6mqyeaTRKk/roQ4bqBhA==
X-CSE-MsgGUID: 2leg6FDIRtKtN+wkvoLavw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.23,153,1770591600"; 
   d="scan'208";a="270450215"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Apr 2026 07:15:34 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B7C0E80586; Wed,  1 Apr 2026 07:15:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D6FE38052F
	for <cocci@sympa.inria.fr>; Wed,  1 Apr 2026 07:15:26 +0200 (CEST)
X-CSE-ConnectionGUID: RmCFsH2uRnSyNQtwr/1cNw==
X-CSE-MsgGUID: mSI3EkBWSzChfTMeLMwOyw==
IronPort-SDR: 69cca9ee_M6uYxKZa62w4CBqGA6e/o8LcFfcECZaBUgpVgnP8hQ2JQEr
 KYkf7YALLLZOtd6q/NJwUmAg7hyoWAa2DuIwQWQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FqBQBzqMxpgAMP49RagluCP2gfXjQEC0kIhFCPU4Zfj?=
 =?us-ascii?q?xGMSwIPAQMBDUoEAQIEAQEDAwGCDIJ0Ao0mAh4HAQQ1BQ0BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEFAQEBAgEBAgQGAQIQAQE7Bw47hk8NgluBLIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECR0QCAQMjH?=
 =?us-ascii?q?QEBEScPCxoCGA4CAlYbAQGCfgGCIgEGEAEDNgcNBrRzgTKBAYIMAQEGgmnXe?=
 =?us-ascii?q?x8sIlmBZwMGgR8vhXCCZgGKcCcPgVVEgTyCUjE+gmEBFoIYgw6CaYImgQ6Qa?=
 =?us-ascii?q?VJ4HANZLAFVExcLBwWBI0MDgQYjDzwFLR2BIyEdFxUfWBsHBRIhKm6FWHYuX?=
 =?us-ascii?q?hoOIgI5XIEGCgFSBYIFAoEgRQIBC209NwkLGwQ9jF8pgi6BQac1oUU0B4I4g?=
 =?us-ascii?q?WeBZAyKLpU/BhMvg3EBk2AOkwuZBo4JmziCACKBXDMaJIM2TwMZD5JUgQvDH?=
 =?us-ascii?q?kQyAgkyAgcCBw0DC4VEAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 jnnkaXuNHFd/tiS8cZOX6A8x+qYPXBnPRe7QVbp
IronPort-Data: A9a23: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
 T3TFrMc8/RxLlxUqT4v28GG
IronPort-HdrOrdr: A9a23:rJRd1KmDXKwaM1N7Y7dlfTPcfxbpDfLy3DAbv31ZSRFFG/Fw5P
 re+MjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNSftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:ITJxc2DfBD0Jz+v6ExNi32APOpo4SHvm3VHpP1CiTj9ibqLAHA==
X-Talos-MUID: 9a23:SpM9sATEofkkkIAcRXTpvxA5GcRC3J+8I0ADrbALn+ybEj1vbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,153,1770591600"; 
   d="scan'208";a="142901397"
X-MGA-submission: =?us-ascii?q?MDFu8PKjfu/6lNeGYXAontMPU86ili4asVg2Ky?=
 =?us-ascii?q?jlRKWdHBi6X2+0JOq3Lqxc7ds3d44b1+r8A7wjaA6l7ja9g3uTnIizBN?=
 =?us-ascii?q?IQ81No9MXYqlaDF3hgEkT84R9jsUsamUbasozeCdRkG3trLeVsuD78KF?=
 =?us-ascii?q?5U0TALXoZ8yIYmsEH0bXy2yg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 07:15:26 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Melaj-1vXe9o136D-00m6PU for
 <cocci@inria.fr>; Wed, 01 Apr 2026 07:15:25 +0200
Message-ID: <b3686b73-09a8-4b10-b860-5a49b9462b11@web.de>
Date: Wed, 1 Apr 2026 07:15:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <51b9e38a-7e91-4c39-86d1-25da2c6af376@web.de>
 <5c3257fb-1e91-46c0-ab00-f105ccb437d4@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <5c3257fb-1e91-46c0-ab00-f105ccb437d4@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:WsaLCAQ4W+vG95uvcrlhJ8XGsyhfVEgSPzxY6L7UjuD0JzzamdS
 AY2NQJ3wXFbzQgN4rSFmfpOIX7VKSz4hmhGwFco6LkawZkZXbbKMWmqaPP69WyhXGD8EPbi
 1wwDpsLJLyBJuaeCAY9PLaqZ1HyN7t2UnJfStWMNcza9ZWEUZwvNSjDuNv9pHhGRvZO9+Da
 gvnyMsB8MrXXzebhICQIA==
UI-OutboundReport: notjunk:1;M01:P0:JCVT7KIUpdg=;+ou9aOyFxjBvaloVgVDoj43Ro6h
 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
Subject: Re: [cocci] Logical consequences for applications of SmPL
 conjunctions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3469
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/xudCglR2qXQBq8qvyyUWfg>

Would you find SmPL code (like the following) not so useful in comparison to
indicated software functionality according to another published test case?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/03a1af0a3316ddfc2b54d827b8b9627a841c85c9/tests/andid.cocci


@duplicate_metavariable_type@
identifier x, y;
@@
(x
&y
)


Regards,
Markus
