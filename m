Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C87FA374F
	for <cocci@archiver.kernel.org>; Fri, 13 Sep 2024 13:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8LFZzyCZ81TZMkUL3zNXl93k6bEo5DfK2Ms9KdHmW5o=;
  b=kWv+Zx4LrrNNDyjkK/hJMKf+ObvEVGzgnTDTMIvj/bxa3JsqUHW1oWgX
   FLI24bl4Zg1FgW+bvFAHRt/3w4641AFbZhpcY08A69LYs/VWklSG2+Nxb
   pE6a683jfp6/KurDkDTxQtm2pRnk7Ml8dyZkmbljT4Ig+Ruu/5kJj65Q0
   o=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.10,226,1719871200"; 
   d="scan'208";a="183032737"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Sep 2024 15:16:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5A800E0CCA; Fri, 13 Sep 2024 15:16:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 221A5E0131
	for <cocci@sympa.inria.fr>; Fri, 13 Sep 2024 15:16:39 +0200 (CEST)
IronPort-SDR: 66e43b36_9wzZJhyaUokZiQ9aIahqpz7DeHUqgwu7ocy1EXRHuoUFKzC
 K3bYE38BAfN+V5hnxZorgxs/aDVc295muqTNoTQ==
X-IPAS-Result: =?us-ascii?q?A0ELAACCOuRm/07ASNlaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYIbKAdbdTMEC0iEVogdhy+BdTCEO4c6h1OId?=
 =?us-ascii?q?oFWFIEsPg8BAwENQQECBAEBAwSCDIJ0Aol9Ah4HAQQwCQ4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBCAEBBQEBAQIBAQIEBgECgQoIC4UvRg2CYwEQgRSBJgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBARcCR0QBAQECASMdAQERJgEECwsaAiYCAlYGARQBAYJ9gjABA?=
 =?us-ascii?q?w4jB7AUgTKBAYIMAQEG2lofLCJXgWMJgRouAYhKAYYhg0B6Jw+BVUSBPAuCe?=
 =?us-ascii?q?D6ECTqDW4Jphl6LMYtuJYhqcI81UnscA1khEwFVExcLCQWJOQqCdgUhBCWBR?=
 =?us-ascii?q?SaBIIJ1CIErFYEGAoJXgWcJYYQ7gjxwYoENgT6BWQFGgRWBXS8bJAtegUOBB?=
 =?us-ascii?q?R0XBhUEgSUFOEmCU2tOPAINAjeCKSVuglqBLwQFglIdQAIBC209NQYDCxsGP?=
 =?us-ascii?q?a0jg0OBK8cuNAeCN4FjgWMMn1EGEy+EBZM5DgaSc4g1kEAigjSmR4FnPYFZM?=
 =?us-ascii?q?xokgzZSCw4PjiGBLgECgnzLCUE1OwIHAQoBAQMJhUYBAYZWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:MxiR4aDFMbmz0BVW/z7iw5YqxClBgxIJ4kV8jS/XYbTApDp0gWAHn
 DQeXWGDPveKMTT9f9pzPIzkpE1UupHcyoBlOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuGYDdJ5xYuajhIs/Pa80s01BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc5xD4SHfgnPtcNV4RE9A66uIuE3x3q
 MVNfVjhbjjb7w636Le8V/UqmckpasXmVG8dkis5kneGV7B/EMqFHPWiCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3ymkK2YC9wjPzUYxy3jr1wtM7aHQCoDYZ8eYX55rrHqGo
 X2TqgwVBTlfbrRz0wGt+XWnje7nhjL+QItUFbui9/csjkf7+4AIIBgRSEf9vvSzzEKzMz5CF
 3EpFuMVhfBa3CSWohPVBnVUDVbd1vLAc7K80tHW6T1hDoLR5BuFQHcJRHhNZbTKcSPwqSMCj
 je0cxHBXFSDc4F5jVqC+73SoT7a1e09MzoZfSFdJecay4CLnWzw5y4jiv58HaTzgtCd9fQcB
 dyVhHBWuoj/RvLnG0l2EZ4rTt5sSlX0otYJ2zjq
IronPort-HdrOrdr: A9a23:hJfivqCnsWpdZ4TlHel455DYdb4zR+YMi2TDGXoBKiC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eAaGSS4/yb3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AbJP+8GlMCbR7LsN4ynYukXtK6GTXOSDj93vcfEG?=
 =?us-ascii?q?KMHlOZuC3WVvJ6r5dzvM7zg=3D=3D?=
X-Talos-MUID: 9a23:RRS80wmXHGH9UJgmQoiKdnpyDNxv3pm3NXpXnIgdqdPfCx5MJTCC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,226,1719871200"; 
   d="scan'208";a="183032722"
X-MGA-submission: =?us-ascii?q?MDGvv15LUX4rc6VFy4c1B4yKb2rQckzwJ56fW2?=
 =?us-ascii?q?236jIlLnhFhV6Inl0YGv8x4K6MLUbhzoCPp7M7Rl9yfmqUhb87mMiDgB?=
 =?us-ascii?q?Nmd1nyfQEz8ZRVMOAeZ3aesKHG/XSK7xNlopgLVmNLAVJTyBT2N7F4Dv?=
 =?us-ascii?q?f4uNa9ll6t123uLF873ipmRw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 15:16:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726233381; x=1726838181; i=markus.elfring@web.de;
	bh=8LFZzyCZ81TZMkUL3zNXl93k6bEo5DfK2Ms9KdHmW5o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dQgqPPdb0UNlX80mTu0/7knW1GjbII001Q7PMngwMx8yVkzAAw2bxKemvdEVkmII
	 3tpR2vTs2lSThFuQoFKjUzG1LSjs8Ftqn8nyjALngNSAp8Gh+//vcT4D2cff1c226
	 arnM1Mh6YFoUiYnmDAKtDOgfTKEjsPJ6N5lZrLbhFC21Tf4I9sifJAWw9RmTSiqx8
	 7Z4ZZl7St/fKNKpHx0azBq7iSnu5J2hgr97xWhDR2VlObkMtAtStZ4CJw01hb6JJD
	 1FHPp4MR4yjy0fLbFzcPXiwBDoMXRS0olaeVM9SnqUg+Zr/hhq0okpGS7cxwnWaJb
	 cWIgpUaVaFOczXDw3g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MY5bT-1sUUEi1uhx-00JwqP; Fri, 13
 Sep 2024 15:16:21 +0200
Message-ID: <186de981-7a3c-4fdb-8911-8dfee597c759@web.de>
Date: Fri, 13 Sep 2024 15:16:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 cocci@inria.fr, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240825183116.102953-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240825183116.102953-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lSxIoQdC+s9CRKUItPCu1XcxxG4YbA4iSVgECTs4ptBWwKgy6yg
 3cBXw7xtPULueXwfcZJo+Jq+PBr6OmaCRiU/x4Yk8rlsidhuDvJbpTr0dstBpHsd8ysLR+E
 7yu59zCw63BverAZYGnwstXWXAYdGY+L88Mlg4kOiY2aF7bkm0LKrHdy86MCnf0rVrJjLf8
 CrSw63uxpFefauF1uqWjg==
UI-OutboundReport: notjunk:1;M01:P0:nWtRG0sGK6I=;wDB3ikrhfP6m2ODBCoYTUaGaS8H
 fMZzMZC4QJhtXwjyhKrTHseO+JjtqAyHDNMIewHvd2FbIgsPfeIomTB3sjGk6fd3HqAuTKWzL
 mKusbLgaBqRMSEKTCsFpVOE7WZg5qhnQMnFPakRrM+p2rgq1StJXOCWBnu177R1hBTgPZNs9x
 S4OJVWxip7Ko/8VT4ImOaTrKQ1L7l0xrKDftm14raSbd4XNbaK4kQosFmEK0V3sQK7KvED1Yg
 LXR7mvNc+C4x4+IteYYcJ8n9ahbC+YiGcAB425zBVHrwgXetXQRF3fgQwFKXqh3nA1HcgEiRJ
 Pc+t0kILVeIDFCSjFrAb6iLfIoyCAV25k7UhJ/iFD+csOksY90yzlCIJUZMnFsYSwlTDCWn1m
 OY+iBr8A/sT/CFxTTXvTbxERAe17IB+4WxFmPV6aM5vIJsegx+iFpEMW5TmypFOGXSGDbw5kR
 5TpzcozuMIRE9G5a90mPqo7OSHr97Q4n02uN6oYOi9v5+eCSNvc7J3sBW4HjyLpNgK+SVPXHa
 ZopbqrtRTuVgsLCyXKnuML+Twp4XCdLa5xJxSq18Ny2fQ9RwvAiJi126iddPJfZOoM/F6eumQ
 DUeQ++omb11+Uzv7H2IJ1rusQ6+C0A7JErFp5C4n2qeO6sJU6pFJpdbNCKBzb1gfxYlBXNu7C
 CLIZXE2U7Pw4ByU/ROmhQpa33eM2BXZcvsFI9CwSxEorv7TXAwcf5xPgM1LBl0+0Bk4tpcsau
 mhq+obtBjfz2y76y6idIOcuDaYfP9E5av4odxR/2dMGJLJ5xZeIa3nGK2DnzWJFYhtKql5j++
 /xs6aDc9FcgiZ3Kc+Zc+aPVg==
Subject: Re: [cocci] [PATCH] pmdomain: rockchip: Simplify dropping OF node
 reference
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1868
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/186de981-7a3c-4fdb-8911-8dfee597c759%40web.de>

> Drop OF node reference immediately after using it in
> syscon_node_to_regmap(), which is both simpler and typical/expected
> code pattern.

Dear Krzysztof,

I noticed also this contribution.
I found it easy to convert it also into the following small script variant
for the semantic patch language (Coccinelle software).


@adjustment@
expression e, x;
@@
+of_node_put(e);
 if (...)
 {
 <+... when !=3D e =3D x
-   of_node_put(e);
 ...+>
 }
-of_node_put(e);


58 patches were accordingly generated for source files of the software =E2=
=80=9CLinux next-20240913=E2=80=9D.
How would we like to tackle remaining update candidates according to simil=
ar transformation patterns?

Regards,
Markus
