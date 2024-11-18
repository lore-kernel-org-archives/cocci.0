Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2FDD591B0
	for <cocci@archiver.kernel.org>; Mon, 18 Nov 2024 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lP0Zntp+HRWENCbPjrc9G2lDoefH/1cMkwirwj5j8Pw=;
  b=CgCrDrOrK9EgWoocRFnpAOw0jsqi+T4+qgOW2n13ddMYhFY3GB9QJ54X
   de6A0H+wx/DeqOjvX8RUTd3YgXksk4OsCGZ7uaDHieYBbltORKeOJsHXl
   UUqGk4A8aWksXhSdMEJUoAYViz8P1+Qkp1XGpbE7F6b2eK6KUncMuoBLI
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.12,164,1728943200"; 
   d="scan'208";a="194516847"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2024 19:54:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6E292E0D1E; Mon, 18 Nov 2024 19:54:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EFB0BE00B7
	for <cocci@sympa.inria.fr>; Mon, 18 Nov 2024 19:07:30 +0100 (CET)
IronPort-SDR: 673b8262_6TPYyMAAyoIAzrwvtav+x7SVoIHiT0sm/Ue95OZj4hbbu+7
 XLSGQb/aPfDbLp1GbgVfbWHkCFhjvHt4Vh2tUuA==
X-IPAS-Result: =?us-ascii?q?A0FPAADugDtnhbaaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDfQZUMwcISIRWkW4DE4tgk2Q+DwEDAUYIAQIEAQEDBIUAAopQA?=
 =?us-ascii?q?h8GAQQzBg4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQFAS?=
 =?us-ascii?q?YV7DYJiAYEkUQ0DBz4BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAg1eAQEeAQEBAxESDwENAQE3AQ8LGAICJgICVgYTAgEBgn0BgmQDA?=
 =?us-ascii?q?wIMBJ5JAYdgAQECiyOBMoEBggwBAQbcH4FkAwaBGi4BiEsBhWkbhFwnG4FJR?=
 =?us-ascii?q?IE8CwOCdT6EWINGgmmCRYExg14lTYgymhJSexwDWSERAVUTFwsHBYEpISwDg?=
 =?us-ascii?q?kd/gTaBUQGDEEqDLoFeBTcKP4JKaUs3Ag0CNoIkfYEdgTKBJQQFg2mBC4NhZ?=
 =?us-ascii?q?y8DAwMDgzyEDx1AAgELbT01CQsbQ6AIAUaCQ4IsggIRDCuWOwGOdmmgF4Qkj?=
 =?us-ascii?q?BaVMgYPBC+XVJJ6LodkkGWFGohllVYdhQSCLiSBXEYHIxWDIk8DGQ+OIRmDY?=
 =?us-ascii?q?YQ+wggiNTsCBwEKAQEDCYVGAQGLcIFLAQE?=
IronPort-PHdr: A9a23:IF5w7hasGOZcPUv2GuVEU+n/LTF12YqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1waPBt2QsqoZw6qO6ua8AjRGuc7A+Fk5M7VyFDY9yv8q1zQ6B8CEDUCpZNXLVAcdW
 Pp4aVl+4nugOlJUEsutL3fbo3m18CJAUk6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uM
 Rm6twrcu8cLjYd4JKs91hTFrmZUd+lW2GhkIU6fkwvm6sq/8pNv7z5ct+49+8JFTK73Y7k2Q
 btEATspNGw4+NfluR7fQwWR+3ASSH8Wkh1GAwjE6BH1QJL8uTbku+R+xSeXI9T4Qag7Vjq+4
 ahrTgToiDocOD4i7G7XkM1wg7lFrx+nuhdy3pTbYICRNPp5Y6PdYdYXTndPU8pNSyBMBJ63Y
 pARBOQdI+lXs4j9p0MPrRSgAwmsGPjvwSJMinPvwKE2z/gtHQTA0Qc9HdwBrW7Uoc32OqkcX
 u+6wrfFwyjdYfNY2Tny6pTHfB86rPGQXr99a9bdxVUxGw7HiFibtIzrPymS1uQIq2WV4PBvV
 fmhimE9sQF6vzqhyd02ionIhoIa0ErE+j9/wI0oItC3VlR0Yd6+H5tKtiGaN5F5T9gmQ2Fpv
 iY617IHtYS+fCgL1Jsn3Rnfa+eAc4iG/hLvTvqeITB9hH98fr+0mhm9/1S6xOLmSsm0zEhFr
 jBDktTUqnwByhPd5tWER/Zy8UmtxSqC2gHT5OxHIk05mqjWJp4hzLIsi5cfrVnPEy/1lUjog
 6GbeUYp9/a15+j6frnrqJmRPJJ6hAH5N6QhgM2/AeIgPwcUXGiU4/6w1Lj4/UD/Xb5EjeU2n
 7HEvJ3UP8gWpKy0DxVI3osj5BuzFSqq3dcGkXUfLl9IdgiLg5X0N1zNOvz0E/iyjlS2nDt12
 fzLPLvsCYjTI3jHjbfhZqp95FBGyAQuzNBe5oxbB6kdLP/1R0T/rsbXDgUjPAyx2+vnCMty1
 ocZWW+XBq+ZMaXSsUKH5+41JumMZZMauCz6K/g+4P7ug2M5lUUBcqmu2JsbcHG4HvJ4LEWFe
 Xfgn9kMHX0Iswc8VuDmlV2PXDFJa3qvXK8w+Ck3CIe8AofCQoCtjqaB3CC+HpBOeG9JEFCMH
 m3yd4WFW/cDcjmfIstgkjwCSLigRJUt1RSvtADm0bpnKfHU+ioWtZL/ztR6++rTlRQq+TxyF
 MuSy3uNQH1snmMUWz8227hyrVJlxleZzad4m+BYFcBU5/5RVgc1L5DdwPZ+C9D2QQ/Af9aJS
 FO9TdW8Gz49VNMxw9kUY0Z8AdqulB7D3zCyD78Pi7OLHIA08r7b33XpO8l9zGrJ27Ugj1Q9W
 ctONWimhrZl+ATJBo7JlV+Zl6eweqgG0i7N7jTL8W3bmGxidz84eqXfXGsDYVPWoJyt7UPYT
 qSyDqwnP01FxNSFO/FiYcasllJeXv74JNnEYmv3kGC1U0Wm3LSJOafjYHoUxm39AVIFkwkJ9
 HDOYQU3Bi67omLXJDhvE0//JUbt+vN5s3S1Ugk/yATcPB4p7Ka85hNA3a/UcPgUxL9R/X558
 12cfX641tPSUZ+bohZ5Ob9bapU76UtG0mTQs0p8OIahJuZsnA1WaBx56mXp0Rg/EYBciY4yt
 np/wQNyILiZ0FppczKewIC2P7zcMG7p+x6zLaXR3wKWy86Yr58G8+9wsFD/pEesH0sm/W9g1
 oxY2nuV/JTKBSIWUJTsQgAy9hNgoKrdbDV77ITRhjV3KafhijbZwJoyAfc9jBate9AKKKSfC
 Ar7CNEXHeCqKeo3ix6sbxkeO/tV+rJyNMSjHxef8IisOuso3DevjGAdpZt4zlrJ7S13DOjBw
 5cCxficmAqBTTb1ylm74IjxnshfaDceE3Daq2CsDZNNZqB0YYcACHu/a8yxyNJkgpfxWnlev
 Fe9DlIC0cWtdFKcdVv4lQFX0E0WpzSgl07ah3R5mjEgtKuf1QTKwuL/ZFwCO2VRQ3Jlg0uqK
 o+xzpgbUEWucwk1hU69/0+posoT7K97LmTVXQJJZ32vdCc9De3p6+bEOp4Vu/ZK+W1NXe+xY
 E6XUOv4qhoeiWb4GndGgSo8fHess4n4mBpzjCScKmxypTzXY5IVp1+X6drCSPpWxjdDSjN/j
 GydC1G8NsOo/dy8k5bFr/D4UmOqTJpIdif3i4iHsWHogA8iSQ36hP21ltD9REI32C/yzdhqX
 A3MrRDhcs/u1q+gNvlgcFUuD1j5oZkfeMk2gs47g5ce3mIfj5Oe8C8ckGv9Bt5c3Lr3cHsHQ
 TNjL8f92AH+wwUjK3uIw9i8TXCB2o57YNL8ZGoK2yU75sQMCaGO7bUCkzEn6la/qAvQZ7B6k
 FJ/gbMj4X4TmeAJsSIpzyOAEvYXHEJCOjfrmQjO5Ne75Klaf2egd7Gs2VE2xIvnU+7E+1wAH
 i+pIN8rBkoSpo1nPUjJ0WHv542sY9TWYd8J91WVnxrGk+lJOcc0n/sOizBgPDG1tnkkxugny
 B12iMjh+tfYbTwwoOTgUkQLU1+9L9ke8Tzsk6tEy8Of3oT1W45kBi1ORpzjC/ShDDMVs/3jc
 QeICjw17HmBSt+9VUeS7llrq3XXHtWlLXaScTMUxNVrXhidLWRbgQYJTHM/n5UjERutytCne
 0B8rGN0hBawul5Xx+RkOgOqGGrWpA6yazc9YJyeKgdGqARD7F3SKsuQ8qR4GCQSrfjD5ESdb
 2ecYQpPF2QAXEeJUkviMreZ7t7F6+GEB+C6IqiGcfCUpOdZTfvN2YO3394s4WOXLsvWdCoHb
 bVzyg9ZUHt+AcichzgfV3ldiXfWd8DC7Bakpn8u9Ybgr7KyBV6pvNvVQ/5bNdElk/yvqZ+KL
 PXYxCNwKDICk4gJ2WeN0r8UmlgblyBpcTCpV7UGry/ECqzKyOdbCBsSaiU7M8Utjep0xg5WJ
 cvSkc/4zJZ8j/goGxFAVFf7ndqua9BMKGa4fF/KH0eEMr2aKCaDmpqxPvz6EOAMyrwE7VW5o
 lP5Wwf7My6GliX1WhznKuxKgCyBfVRftIy7bhdxGD3jQdbhOVWwNN56iyFzwKVh3yiMajFaa
 GUgNRod9O71j2sQmPh0Fm1f42AwKOCFn3zc9OzEMtMMtvAtBC1oluVc6XB8yr1P7SgCSuYm/
 Uma5tNovVyilfGCjzR9Vx8b4DtChIuRvEVrEaHY8IRQH3PF9wgK9mKeF1IBoN4vWbiN8+hAj
 8PCkq7+MmII69XP4c4VHNTZMuqDMXw8IVzsGTXOCxACQyLtPmbazR848rna5jieqZ40rYLpk
 ZwFR+pAVVA7IfgdD1xsAN0IJJokFiNhi7OQi9QEoGavtBSEDtsPpYjJD7jBZJenYCbcl7RPY
 AEEhK/1PZhGfJOuwFRsMxF7hNiYQhGWAo8L+3A9KFZk+g0I+Xx6BAXbNGrhawWw8DkWFPWum
 QUxhBc4auMopm6EC7YfIlvMuTt2lUg6g9L+hj6NNjX2KfXpNWmzIy71sVUhdJb6SBxydgq8g
 QpvMzKWH9ps
IronPort-Data: A9a23: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
 gSR3g==
IronPort-HdrOrdr: A9a23:OHElEqihtOIHNCRwMQ8xml2dSHBQXuoji2hC6mlwRA09TyVXra
 CTdYcgpHjJYVEqKQkdcLG7SdC9qRG1z/RICOwqUItKMzOIhILFFvAH0WKm+UyHJ8SczIBgPM
 VbH5SWYeeYZTNHZITBkWyF+r0bsbq6Gc6T9IXjJjtWLD1XVw==
X-Talos-CUID: 9a23:QFicjmDB9oN2fxj6E3db+xUvNuk9SVLY5V3UIBO5TjtsEaLAHA==
X-Talos-MUID: 9a23:oBMmcwr10spWRU8sAy8ezzB7ZNgzyuf3MXwqkM4h5JfHCgVcIB7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,164,1728943200"; 
   d="scan'208";a="194512102"
X-MGA-submission: =?us-ascii?q?MDFr/dX8rEQmOJoRly9Ux94GTGeQjQks/uto4d?=
 =?us-ascii?q?tktGOug4bgvm3zleM+BWxKNvPZ4eKybi/cxKzAUmk0jD8C1YGOnXm1Y3?=
 =?us-ascii?q?EkvdktHzRj55fcCsMdFaUe3xpkjAu2N0sCF0/Vo34oojMYrQsc6YftU3?=
 =?us-ascii?q?EGbVYhiozVuXo7PBKgPa0UoQ=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 18 Nov 2024 19:07:30 +0100
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3DD17206BCF9;
	Mon, 18 Nov 2024 10:07:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3DD17206BCF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731953247;
	bh=lP0Zntp+HRWENCbPjrc9G2lDoefH/1cMkwirwj5j8Pw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=U8YJ5MEB+lC4gUMBqZ4Gz30eL5pByQSSZkvP1DxkMnTP1qlIes9QjQ3oHvl0/spjY
	 zaV4G+9kqg2wB6l6cY05sRrhV/1+2NwT0Di3E3r4OqgFDSinGSRYQd2YjZAhmOdf7k
	 pgtoi2CJWleSz5F2PF0YMgIK9D4gDdAFvwZB2ktQ=
Message-ID: <4a3e6cfe-35ef-4865-8b43-c002679455f3@linux.microsoft.com>
Date: Mon, 18 Nov 2024 10:07:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Russell King
 <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>,
 Oded Gabbay <ogabbay@kernel.org>, Lucas De Marchi
 <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Marcel Holtmann
 <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Xiubo Li <xiubli@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Louis Peens <louis.peens@corigine.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 eahariha@linux.microsoft.com,
 "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
 "coreteam@netfilter.org" <coreteam@netfilter.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "cocci@inria.fr" <cocci@inria.fr>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
 "linux-rpi-kernel@lists.infradead.org"
 <linux-rpi-kernel@lists.infradead.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
 "oss-drivers@corigine.com" <oss-drivers@corigine.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <fb97b58c-4d77-43d1-88a0-d838d5030d3e@cs-soprasteria.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <fb97b58c-4d77-43d1-88a0-d838d5030d3e@cs-soprasteria.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 00/21] Converge on using secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2083
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/4a3e6cfe-35ef-4865-8b43-c002679455f3%40linux.microsoft.com>

On 11/16/2024 2:23 AM, LEROY Christophe wrote:
> 
> 
> Le 15/11/2024 à 22:26, Easwar Hariharan a écrit :
>> [Vous ne recevez pas souvent de courriers de eahariha@linux.microsoft.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>>
>> This is a series that follows up on my previous series to introduce
>> secs_to_jiffies() and convert a few initial users.[1] In the review for
>> that series, Anna-Maria requested converting other users with
>> Coccinelle. This is part 1 that converts users of msecs_to_jiffies()
>> that use the multiply pattern of either of:
>> - msecs_to_jiffies(N*1000), or
>> - msecs_to_jiffies(N*MSEC_PER_SEC)
> 
> After applying this series on top of tip/timers/core tree, I still find
> a lot of candidates to the conversion:
> 

Thanks for looking, that pattern of seconds-denominated
msecs_to_jiffies() calls will be addressed in a later part. As mentioned
in my reply to Anna-Maria[1], I'm not super-familiar with Coccinelle. I
sent this out as part 1 as mentioned in the cover letter above to make
incremental progress as much as I could. Julia has sent me a message
with a rule that could possibly address the pattern you point out.

I also see there are some instances in the grep results that appear to
be expression * 1000 rather than constant * 1000. I'll address those in
one of the later parts as well.

Thanks,
Easwar
