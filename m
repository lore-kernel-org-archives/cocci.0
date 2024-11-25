Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7378BD58D6A
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 17:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hJ2A1Z01fXOAREhGkaCq4ezwrOUiUgKb10O1f3op9pU=;
  b=aFmOuYV8wNdkHOicj8P99v5378HjY+mklJUwYXzB28c4c0On8G8W7OK+
   xF54CHDHaFKPch2R1sLbXYf/a70EW/vdrICyc7Ek0dHsM+Q2apwyd39aa
   NTyUDtFjRfmTx/KI3sYnMRuqEeguHdbbStRYxRQ6h6OZ4IkZwvLi3EeLJ
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195727290"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 18:09:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E2999E0D21; Mon, 25 Nov 2024 18:09:02 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8F65EE00B6
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 18:09:00 +0100 (CET)
IronPort-SDR: 6744af2c_wiK8XjYqA08/MNGa0cDnIJwahqGESE2mVcWhrfBHpFArcsF
 WT7U9zVYoSyeoguzVoCMFcTZsAeYJm6lwoAmD/w==
X-IPAS-Result: =?us-ascii?q?A0EyAQCarkRneAMP49RaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDYiFUMwQLSIRWkUEwhDuHO4dWiHWDVA8BAwENQQECBAEBAwSEdgoCilsCH?=
 =?us-ascii?q?gcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAUMOCjGFe?=
 =?us-ascii?q?w2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnDwsaAiYCAlYGA?=
 =?us-ascii?q?RQBAYJ9gjABAw4jB7ArgTKBAYIMAQEG2lsfLCJXgWQJgRouAYVpgmIBhiSEP?=
 =?us-ascii?q?CcPgVVEgTyCUjE+hEODW4JpgkSFDyWIGGibOFJ7HANZMgFVExcLBwWBKSEsA?=
 =?us-ascii?q?4F5Tn+BNoFRAUKCTkqDLoFeBTdHgkppTTcCDQI2giQkWYJNgSUEBYNrgQuDX?=
 =?us-ascii?q?oRehgsdQAIBC209NwkLGwY9oVyEIimCPJNBswQ0B4I4gWWBYwyfWQYTL4NxA?=
 =?us-ascii?q?ZNRDgaSeph7IqkGgX0kgVwzGiSDNk8DGQ+OIYQtxx1CNTsCBwsBAQMJhUYBA?=
 =?us-ascii?q?YtygUsBAQ?=
IronPort-PHdr: A9a23:Lne8lBbtk4gqLItQryHmwTD/LTEi2oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1waPAdiQuqgMy7KP9fy7ASpYudfJmUtBWaIPfidGs/lepxYnDs+BBB+zB9/RRAt+I
 v5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vI
 BmsogjcuNQajZFtJ6sxxRfEpmVEcPlSyW90OF6fhRnx68ms8JJ57yhcp/ct/NNcXKvneKg1U
 bNXADM6Pm4v48HlqQfNRhaV6HsGVWUWnBtIAwzb4xz/Q5z8rCj0uPdj1SeDJcH5Qqw6Vjqk7
 6dwVR/nkzwHOCIj8GHWkcN/kqRWqw+8qhNlwo7UZIaVNOdifq7YYNgXS3ZNUtpXWidcGY63c
 ZcBAPQdMuZZt4n9pkUBrR2iBQm3GejjziZEimLq0aEm1ugsFxzN0g49ENIUqHnar9v7O6gcX
 u6o0qfIwzXNYPFK1jny84XIbgkhrOuQUb5sb8bcy08iHB7FgFWKrozlOiuY2OMXvGiB7OpgS
 PmvgHMopQF1rDiv3MYsio/GhokIzV3K8j92wJw2Jd2lU053e9GqEJ9etyGANot2RMwiTnpmu
 Skk0bIKo4O0czYTxZkh2hXQZOCJfZKS7RL/SOaePy14hHR9db++mRu/7VSsx+niW8S2zVpEo
 ShIn9rRun0P1BHf98iKRudy8Eu92TiB1w7e5vxZLU01m6TVJZAvzLAym5cNs0nOGDL9lkbuj
 KKOaEko5/ak5/75brn4pJKQLZJ4hwHkPqkggsCyBes1PhIAUmSG4+ix17zu8Vf9TbhKiPA9j
 7fUsJTHJcQAuq62HRVV3Jsi6xe+ETiryMgUkH8aJ1xfYh2HlZLmO1TWLfD4E/i/h1OsnS9ux
 /DBI73hHo/BL3bdn7j6Z7py9lBTxBIyzdBZ+Z1UFqkMLOzuVkPvrtDUEAE1Pg6uz+r6CNhxz
 I0TVXqKAqCDMaPStVGI5vgoI+mJfIIbvyzyK+Im5/7zln81g1ATfa2n3ZsNaXC4GPtmLl6XY
 HXymdgNC3oFsRQmQOzsk1KNSSRTaGqqX6Ig+jE7D5qrAZnbSoC3nLOBxDu7HoFRZm1eFl+MF
 mvneJmFW/oXcyKTIsphkiQeWrS7So8h0wuutA7gxLZ9IOrU4DUUtYj/29ht++3TiRYy+CRwD
 8uH3WCCVWV0nmcTSj433aB/pFdyyk2Z3qRigvxYE8ZT5/JTXQsgO57c1b8yN9eneB/Ff97Bb
 F+5S9GiSWUzU9YwypkKall0H9GKjxbZ3iPsDaVD0/SAA5c/84rd2WLwLoBz0SXozq4k2nwvW
 MhSLiWLgqBl9g7cT9rsml+air3sWKASxi/L+0+cwGDIsEwOA104arnMQX1KPhielt/+/E6XC
 ub2UdzPUyNEwM+Gce5Rb8HxyE5BXLHlMcjfZGS4nyGxAwyJz/WCdtmiYH0TiQPaDkVMiAUP5
 TCeLwFrIy67oH/FShFqG0juZUzE7uR07n+2HQcv1w/fV0R6zPKu/wINw/mVSvcdxLUB7QIos
 TZpBxCQ29zMCtyPjxVsduNQbIB1+09JgETesQE1JZm8N+Zii1oZJhxwpF/r3g5rB59olM83s
 DU1wQA0Ja/wPEppUTSe0NiwP7TWLjK35xWzc+vN3UmY1t+K+6AJ4fB+qlP5vQjvGFBwu3Ngm
 8JY1XeR/PCoREIbTI7xX0Ar9hN7u6CSYy8z4JnR3GFtNq/8uyHL2tYgDu8oghi6eNIXPKSBH
 Q70W8oUYqrmYMkjgVu0dVQpOO5I9ag7F9yrfb2K1e/jPeptmi6nkXUS+Jp0gQqH8ytxTPKN3
 o5QmajCmFHdCHGl0RH64aWV0cheaDofH3Sy033hDY9VPehpeJoTTHypO4uxz8l/gJjkXzhZ8
 kSiDhUIwpzMG1LaYlrj0AlXzUlSr2agnH7y6jVukCwy6Ieb0jbPxevKaxcNfGJGDjoH7x+kM
 c2vgtYWUVL9JS0gjhi4/gDXw6ZBpaJwB3beSwFEcmKlSgMqGrv1vb2EbclV7ZouuigCS+Wwb
 2eRTbvlqgcb2Sfud4dH7AgybCri+pDwnhghzXmYMG42t33BP8d52RbY4tXYA/9XxDsPAidi2
 3HbAV21Pt/h+tvx9d+Ll+mkVH+6ELBXfzPqy4yoqyaxo2FnSRGyhPG8nNT7HBNyi3ahkYMwC
 mOR8VCnKoDwn7y3K+dmYlVlCDqeo4JhF4dyn5FxzJAc1H4Gh4mEqH8OkGP9K9Jeiur1aHsAQ
 yJOwsaAulG/nhc5cTTQmsSiBRD/ioN7atK3Y30bwHc45sFOU+KP6aBc2DByuhy+pB7QZv50m
 nEcz+Ev4TgUmbJs2kJlwyODD7QVBUQdMzbrkkHCytmkr7hMIkurf6Kx0kVWgt2rSr2P6FI5O
 j6xatI5ECl8498qenfFyn7u8cfJfNfKbNQcngKZmVHMgqIGTfB53upPji1hN2XnuHQjwONul
 h1i06axu42fInls9qa0UVZIcyf4bMQJ9nTxnL5Ty4yIipu3EMwrSVBpFNP4COilGzUIubH7O
 haSRXci/2yDF+OXFF2a71p66W3CGdanOjmednwe0MknVBeaPlNWmgxSQzgw2JI0c2LijMWzd
 UBk+nUb4UP+oRYK1e9icRXyGm6NoQC1dnI/U5KCKBkQtwhE6x6TOsubi4A7VygK+5q8sEmGM
 WecfRwOVGgPVhXCDFfmdq+n4d2KmwSBLsy5KfaGIbCHqOgFEuyN2YrqyYx+uTCFKsSIOHBmS
 fw9wEtKG35jSYzfnH0URiobmjioDYbTrQqg+iBxssG08ej6EAPp64yVDrJOMNJpsxmoiKaHP
 uSUiW53MzFdnp8LwHbJzvAY0jtww2l2cCKxFL0bqSPXZKfXh7MREBMRLS9+dYNJ4686wghRK
 Jvbh9fyhdsaxrY+D1ZIU0Ckm9n8P5VQZTvnaxWeWQDQZ9HkbXXRzsr6YL2xU+hVheRQ7Firv
 CqDVlTkJnKFniXoUBamNadNijuaNVpQotLYEF4lBG79QdbhchD+PsVwiGh85LQuhW7Rc0MYP
 yJ9dUxlsbCaqy9VyKYaeSQJ/j9+IO+IljzMpfHfMYoTuOB3Dz5ckuVH/DIlxrET4CwOF5kX0
 GPC69VppV+hiOyGzDFqBQFPpjh8j4WOpUx+OK/d+/Gotl7b8RhL4WjCUnziRvNgDcDz/b9dw
 J7DmfCrQN+n283Z940QCpqMQP8=
IronPort-Data: A9a23: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
 TBdeF2oi31XhaI8/QiMtpKV9NwkUOvT8ggV
IronPort-HdrOrdr: A9a23:e9flY64leqxxfpOTMgPXwNnXdLJyesId70hD6qkRc20zTiX2ra
 6TdZggtCMc6wxhPE3I++rwWpVoKEm0nfUejeYs1NGZPDUO01HYSb2Kg7GSoAEIxBeSytJg
X-Talos-CUID: 9a23:9hzikWzBR4F5en4s2HH0BgU3IOcCLlPvzE3WMn6XV2psT7iNSm+PrfY=
X-Talos-MUID: 9a23:3ggZ2QWqHwppv+Dq/DzU1AlIc55P2Jy/GREd1tI5gtnVbAUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="102593965"
X-MGA-submission: =?us-ascii?q?MDEG62dUWiYDQKTV0GxT/DUiIF7ytH9IBeEW2H?=
 =?us-ascii?q?IqsimmVfE8bRN1hTvHh8IiyMhKUTsVfpNYcU2w8A4XHS+73feVBHJE94?=
 =?us-ascii?q?gkkvAgl7DM/EWzSwW20TjHJDQShoQtbfL5oqW0Gcp8TtzV20tnn4CP8y?=
 =?us-ascii?q?bshJySA5l1bppn2mvLZakNYw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 18:09:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732554539; x=1733159339; i=markus.elfring@web.de;
	bh=hJ2A1Z01fXOAREhGkaCq4ezwrOUiUgKb10O1f3op9pU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AaG/58GwL+Ii5CRdyLbuBooP8Ijw7bU5vFvA48YJd+L2ooGhC3Oe71xKLZZx1xI6
	 JNhH5NAad+8bVRV3hQWhfrnzQrafF+CGVpa7Ox8nQUhkah5L6SqX/em6INpf3+ZVd
	 6sTIoURJ7zJHGsIMRHrPkJ/uVftvEdog4g6YFnwuxj+g2VhXARSyEUfrxWa9YEk90
	 Ho6kn4CGmdQANHfPCbp/xIk4bxgXFJRQQQyasrATjCRCzOtMLCf6aJ3m++ViKQ41w
	 VpRjdsI1svi6+SWL+OCdXFVnT21cgMz/zaZ9XnoI5MxZVXjbkA7P0M0s5QGWVkc+J
	 rWKLCGoPUul/juSmkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrft2-1u0lAN0yaC-00l3NY; Mon, 25
 Nov 2024 18:08:59 +0100
Message-ID: <88e811f9-d1b0-49ab-bd89-b3d5beabfb21@web.de>
Date: Mon, 25 Nov 2024 18:08:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <434d257c-f0a5-483d-9fcb-3303301ad867@web.de>
 <9e8d6626-f8a2-19a7-33d3-b0cc48d2fa68@inria.fr>
 <100663c2-6281-49cb-bb9f-55656dff80ca@web.de>
 <d05cde6b-6189-4c2-a452-a0851430dcb@inria.fr>
 <71494b2c-d690-4b58-ada0-59233e10c7a4@web.de>
 <a65c8579-de4b-c6f-f882-b62d667a839@inria.fr>
 <84112e0f-d7f3-4868-ac64-9b82a1925880@web.de>
 <558e241f-c4b9-9046-9e86-5ddf723ff5e@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <558e241f-c4b9-9046-9e86-5ddf723ff5e@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+OYy7p1uiO1U9+W50+EoE7LbJDfJxPYju8u561m/pFinWKdetP/
 HYZKj3AVBGKLSdvWj4hcX3Op43VhoXv2jpt6Fi+TBjvguB6a0XQqr0JnH5am3vRM4WcUi99
 sgjnccreuRqC5AcPm2r0LTHIqvrfiYf1Elur8FubQ1VCNV2sht1JXTrR3r+edDmBPT+Lml3
 /7O1Q1nVVkd4k2aHo+/eg==
UI-OutboundReport: notjunk:1;M01:P0:/YrnlxpY1dc=;c4Y3eTUOCsufWHslryz+E46s3Tj
 FERrmjCe9Ew1r0q4P3Wc8+Y+7t6XWz19cbbwK8PT1f2amLweTBlZmhQN5Ya40xsfL1tly5qoC
 tPeTmtSAN+29tzp/c8W8rO/zPPCtFYcN661q/5nNtTwPOe1jnHVvHo2eaoVBUJXptajIN/+Wn
 pjCcrEurpHSk0B8IEmHF/cgc2fpAL0kuykLneRp/xXfMl81HY+yhtoIDQ1jz9uk4eAHRfIm/f
 z6/wVES3dUkwMrMmyXPYhDBjd6lSvBJdZ/QISZa0CtDTxm/dXWMGaHR/aca8XVQsZVJ8OhHAT
 qTi1MnpcI+Vp4zNx3rq76v4C5XMSHaGqreQz7xQIcqOsgIS1sNmebPPXGl41+6SN23m3g/AF4
 aDgQZwwX+ParWUwki6K8tWSqt0g0oS0/DACXEy5GwRniez50x6Uje5oIaqg62A7Atb3FwUF4/
 Ute4lKc1+sR8zhiSTGa/b1B/MihPs+iy6BcmSoYXjmZ6V2d7csf3HVTV9FJOmby6J3lfqjx5t
 m02a/uqPCg/9gl56CiOw1Ha5DOZaIeGncbs3S2OjkUy48yeNozdHKa6uC2RzcfZYIB5kQNZFd
 QDCVVGkLk9Hzu6asJDZhei+KVK6+EIVWQ2rvPBlJpo8GulMDhbwEYXwxjw0aPdU9vVVMHjEFv
 xZWR7R9fLmlC+2pjUjZe3dELLT69HGtWxV39VEVPtVHPHKkN8BM6DctJTYV4lBBJACNzZF52W
 rt4mcWwgCKnRRcDYAfqOaMo0xAt/V2LKgXM5wQJjAPO8VvHZmH/nBDexSa6DJTg9Jqlz7v0ma
 4D0a9PDF/yCUqe1d7JikLjYTSAUGgscpbZVI4T9aJUFOanL+ssjAyh7dZVLSMQyX0ztWwmDRk
 al/YwGYFHHkEokPMYWhN+XXtByjLBhZ/og+F6v4ePrJBKoqX8wM/Wkjsx4P6cPykpwFwsVFzC
 S34b3aGWRtlTXpJj+mTtJ+qU42qQD3gCgsoFyS/4B+577rBX3QvaCLnApYTDurDYnxeV5nUCV
 LjUdok8Mz9XImiY1HRXKIjF6WGFJABlSjQoSUgx45Ekw2j7hCLkdBglt8uAVGz33HWhcx4F5Q
 /AlKXbluE=
Subject: Re: [cocci] Advanced handling of logical operator chains (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2123
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/88e811f9-d1b0-49ab-bd89-b3d5beabfb21%40web.de>

>> I am looking for ways to express by the means of the semantic patch lan=
guage
>> that such a detailed expression should contain at least two operands
>> which would all be connected with a logical OR.
>
> Maybe you just want to disable the isomorphism?
An isomorphism deactivation does probably not influence the handling of re=
quired
expression parts (>=3D 2 operands).

Regards,
Markus
