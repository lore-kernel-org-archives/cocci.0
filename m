Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857F9C77B7A
	for <cocci@archiver.kernel.org>; Mon, 17 Apr 2023 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GuuJYBoHnToYcZaYiXTEIKGvDG2RlMk2GTFvdn+h9jU=;
  b=fC7bHM9TkQk5jNBfPmWhDGtb/Tgt3DrAWjkd0LbCnGjrv3FTGcd84S3Z
   MIEWbh2LxyQtNoK/fTRwe/GcM/ijASeLAFyCIGYVIKVeVQfF7ieyzmPAs
   4uMdwFYOB5BZ4X1BDhJgPj8JcbWbDPR4nIUfgFKlF7qjBF6fJdUkWOp2K
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="5.99,204,1677538800"; 
   d="scan'208";a="103477093"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Apr 2023 19:07:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CDDE1E033B; Mon, 17 Apr 2023 19:07:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9FB8BE00A8
	for <cocci@sympa.inria.fr>; Mon, 17 Apr 2023 19:06:59 +0200 (CEST)
IronPort-SDR: 643d7cb2_6odt2p9h/MmzYp9e37tnRjznjthSq6wRPa/mILGDkXD/itf
 hjMNIQgAg0+MBiM6cvqCLs1uY+qijSIywRbqKFQ==
X-IPAS-Result: =?us-ascii?q?A0EpAABeez1khwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItdVYvBAtGhFODT4RPiGQxhDCObIhqgVaBQD4PAQMBDTEQAQIEA?=
 =?us-ascii?q?QEDAQM4hEcChTwCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBBwEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARICRz4DAyMEGQEBESYBDxkGBgImAgJXBgEMBgIBAYJ6AYInAQMxB?=
 =?us-ascii?q?61dfzOBAYIIAQEGgQaBXZkoHywiVIFeCYEULQGNCoM2eicPgVVEgTwMgkdvi?=
 =?us-ascii?q?B+CZ5pbgTR2gSAOgTyBBAIJAhFrgRAIa4F5QAINZAsOb4FJY0yBewQCFEQOH?=
 =?us-ascii?q?CUEDgMZKx1AAgELOzo9NQYDCx8GVmsCCSMREwUDCxUqRwQIOAYcNBECCA8SD?=
 =?us-ascii?q?yxEDEI3MxMGXAEpCw4RA02BRgSBC4EBBgEmJJ8ggQ6CKU3DPjQHgiuBVoFZD?=
 =?us-ascii?q?IoNlQAGEy+FUpE3DgaSJYgOiiuFPiCidoUJgWM6gVwzGiSDNglGAxkPjiAMD?=
 =?us-ascii?q?QkVg26FD4o5PzQ9AgcLAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
 g==
IronPort-Data: A9a23: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
 RzyNJE90thdD6yFndou28E=
IronPort-HdrOrdr: A9a23:oXRCla8NicWZ6DlQCCJuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOb+EYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3A2sLPGGrnYV0jz89nwKlKWRfmUe8sbSGFnTT6GVK?=
 =?us-ascii?q?5DnQqVY3WcwKzoJoxxg=3D=3D?=
X-Talos-MUID: 9a23:v4enzgvI32/sv5JAPs2ntApCFeBV3qmSNEUfvbkKhZCiOitBNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,204,1677538800"; 
   d="scan'208";a="53582351"
X-MGA-submission: =?us-ascii?q?MDGxtFO3kXnF7DgcWoY1S6YVJshcmSoZjlmHgq?=
 =?us-ascii?q?Rqb1oLg+FyNbdxtV0ReoIPYX6jq2arUr3sm8/kTliY8Qck/zpOlckA1x?=
 =?us-ascii?q?j3VZgz3/vE12uhDAHOA1JtFc4d6aeeSd0C42+vy9iKlMZIMKp9Fha94p?=
 =?us-ascii?q?8AIdETQLzUcOSRPvwUtRoPvw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 19:06:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681751217; i=markus.elfring@web.de;
	bh=QRMXUEcpcdKxqy+fU8UEYQJJAdvcFlXhlrnHWpsHcic=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=Uy4OpoiG18w3SCV9eeJR3pcgYg6U8Htqsboz0e3fwaQNt9e1YxdGRMKeURTSB0LY1
	 lL3D5zwKKLMjf8LwRq3YUjQ2QlwfMcWhZoGhfM8MxWVlpgC/U2A87taLxV0P0lCYpu
	 /Vl6g27EFxQHeph9rTa//tTyotQEgplfh4seIE3VYXbvO/gi75SwfVcS6zrUc6xGBV
	 rYDrBFS00P4weS/WaW56tra9utKp1OM3OEVFMwZSTLBFC6hv4RWdLXLQRR1WWbx6fD
	 HEf/fDbCAuD4MapKyW7Z//oSoT3nAaSH13iPDW2mfQRAUGp1Rq3iIxIYgOY1dRrHOw
	 AApd0uHR9CVkA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTOhc-1ptq7320IW-00Tl5l; Mon, 17
 Apr 2023 19:06:57 +0200
Message-ID: <99064f46-7738-3bd1-6bca-5f61fb3b5810@web.de>
Date: Mon, 17 Apr 2023 19:06:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel-janitors@vger.kernel.org,
 linux-media@vger.kernel.org, Devin Heitmueller
 <dheitmueller@kernellabs.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <622ed461-059b-455f-8a7b-7200a834bdc4@web.de>
 <8153cc88-2cea-0528-9d54-bda72cbaac5b@xs4all.nl>
 <bd1878d9-7c10-084f-cf73-711b577af5eb@web.de>
In-Reply-To: <bd1878d9-7c10-084f-cf73-711b577af5eb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JikK+XIfgRDKkNU+aK7zETvDJ9pNlGB1r3qmUcBHwHvqTUoxVkg
 XmZJmPLGYpipPCrE/VhKfUQislljr/5gnvJDAjFsGLXQUgtcQrnRzMdZr7tGLVXwtiBxuSf
 ZpxA40gZtg4BVzn0iSimoX+nhBh7GXpsgS/zh+7OVWhbI2JclRVsaW4I0kZhFWUGuF+P3ZA
 3N9kbsqT6kH0lx791j2bw==
UI-OutboundReport: notjunk:1;M01:P0:G2Fqpg2PB7M=;+gQK2Qoh4Od2dFL6LW3iVocA4Yc
 W18nVi21fu7Qa8Cd1Djn03S/E4KKetiVPIByrrgIP8wBiXOAObjlj7aMzHEzMbES7QZvPkggA
 vnTJqQzsof2mvpqMuv2+2tqjYTwom/gBLsAPYNErxnJrZ6hg8bLutyUO4t05vS3LktW5MglHb
 mToqukLjQSBr4YYZean6C3zUXXaFohUaoPF4by8VTkcQpzgZipnY7tFELMjYZVoIJNZAHCmYi
 A2DjUNJO2onT0ufv4/ZR3Z2p7znGYpiotZbYHgTiduV9iVFVSpXK/wzpCriMC9mxLbRdlOfiT
 K6IbWoGTE30eIMrBCjSDmN1liib6Qwcl74l2JpiJbUnNSKLyxDN1epJhD059PF1DLJJEntQi0
 qj9Rkl4VJPXxkpRIVZTHzRwDb1+R+g8bJJo3E11kAyFRL5EPp8AmsjYaNO4iV68DAr5+jnXdF
 XZPuOD78NaPLlcvgaK3CMRA3dK3pVN1fQf3tMufXr9WKZi1nls6bdxUovLyHRko72fxkpjXrp
 i+b33R7kOl0qTpBXSvtNBJOv+Bn9TW/k9jp6Qm74jKHUJv2+8P2HMW5hqoueXTapqnxW0eCVA
 irVm93GpjFlMMikNWNfzNRwq7VIX09m5zMJFfL9275n7A4kzpOTLhxypDY1Z4lge3m4zx7+cf
 jXWvdzjhW1GEdz7SxkFqDOw1EFVJfE8PZ8fSWls2lsWngOWiZV0//2unEyoL9X1qmxgHBftLb
 fdQ+o+6DERrwwU2cVeG2vHIhkzvKmZOPfvPQICiHI4kQWVQpHV9wvmHA3GmuiloLN98J/0wou
 JLYo6fbFsnlJ1euPLsgQyEHhG2Az37cvE9tIOYNcCVdPTm/HnKkoUHc9Nn2cnpezZyOv/aM2J
 EgeTNPqZ38W6xUR53wDbquXvOrwyw/K0rJHjNOQxZbIDGIWcnXsPu1ddB
Subject: [cocci] [PATCH 4/5] media: au0828: Delete an unnecessary return
 statement in two functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1080
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/99064f46-7738-3bd1-6bca-5f61fb3b5810%40web.de>

Date: Mon, 17 Apr 2023 18:14:10 +0200

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected functions.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/usb/au0828/au0828-video.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/usb/au0828/au0828-video.c b/drivers/media/usb/a=
u0828/au0828-video.c
index 448cc296f0f7..ce8050186a4c 100644
=2D-- a/drivers/media/usb/au0828/au0828-video.c
+++ b/drivers/media/usb/au0828/au0828-video.c
@@ -405,8 +405,6 @@ static inline void get_next_buf(struct au0828_dmaqueue=
 *dma_q,
 	dma_q->pos =3D 0;
 	(*buf)->vb_buf =3D (*buf)->mem;
 	dev->isoc_ctl.buf =3D *buf;
-
-	return;
 }

 static void au0828_copy_vbi(struct au0828_dev *dev,
@@ -480,7 +478,6 @@ static inline void vbi_get_next_buf(struct au0828_dmaq=
ueue *dma_q,
 	dma_q->pos =3D 0;
 	(*buf)->vb_buf =3D (*buf)->mem;
 	dev->isoc_ctl.vbi_buf =3D *buf;
-	return;
 }

 /*
=2D-
2.40.0

