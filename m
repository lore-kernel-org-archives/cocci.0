Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BDBD68BEE
	for <cocci@archiver.kernel.org>; Sat, 16 Nov 2024 11:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=1GOO379j5kHelQgT13xeDCIW+pFPJCeiM7WSIuvag78=;
  b=j0t7mij8Lh471scHtLMbGz9Z/XWK+EjF3z+JwABIzvhSRKcYNGWhaFoS
   TEKer4XnPEMYk59g1i+LnrN3POfpX5CwnaT4GkKJtUifqjlKPGnc+n8Q0
   T+FiAxgGUbk7N0Xuqax/5qbhtmo6WGZt+C0FzYScYkopcwSwNtG3Ob/rI
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@wanadoo.fr
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="194204621"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2024 12:26:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 54AFAE0D68; Sat, 16 Nov 2024 12:26:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 627BAE0133
	for <cocci@sympa.inria.fr>; Sat, 16 Nov 2024 07:06:05 +0100 (CET)
IronPort-SDR: 6738364b_+hjFcN6BPyOCliTIp/3m6SuEdeca8TlRr59Wjrsnc8n/YD2
 BO2cUT2H1TAOmylUDjtn0z5aWLUhfWHYvFAcLkg==
X-IPAS-Result: =?us-ascii?q?A0GcAQCaNThngxLyDFBagQmBU4JEgVczBwhIhFaIfKcMF?=
 =?us-ascii?q?IEsPg8BAwENQgIEAQEDBIUAAopMIAYBBDAJDgECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBATkHDjuFew2CW4EsZQk4AQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEbAghjAR8CAQMjDwENAQE3AQ8LGgImAgJWGYMBgmUHsgCBMoEBggwBAQaBF?=
 =?us-ascii?q?tsJgWQJgRouhWqCYgGEeXCEdzaBVUSBFYE7gW8+hAaBCoMOgmmCRYUTJYUGg?=
 =?us-ascii?q?g6Ba5oVSAp7HANZMgFVEw0KCwcFgSkhLAOCSQV6K4ELgRc6AYF8gRNKgy6BX?=
 =?us-ascii?q?gU3Cj+CSmlLNwINAjaCJH2CT4UagQuDYWcvAwMDA4M8hAcdQAMLGA1IESw1F?=
 =?us-ascii?q?BsGPQFuB58ZRoM1gQ6ZMa9DNAcrgXOBf4FjDIkFlk9Nl0AMkwIuh2SQZakng?=
 =?us-ascii?q?Wc6gVx0gzNPAxkPjjqFH8RnQjU7AgcBCgEBAwmFRT6JD4FLAQE?=
IronPort-PHdr: A9a23:S+r7VhX6DzIxwATI0kykY32oyU/V8Kz2XDF92vMcY1JmTK2v8tzYM
 VDF4r011RmVBtydsa8P27ue8/i5HzBbudDZ6DFKWacPfiFGoP1VpTBoONSCB0z/IayiRA0BN
 +MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBke3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55I
 AmroQnLucQbj5ZuJrwvxhbJrXdFeOBbzn5sKV6Pghrw/Mi98ZB//yhKp/4t68tMWrjmcqolS
 rBVEDspP2cp6cPxshXNURWB7WYGXGUMlRpIDQnF7BXkUZr0ryD3qOlz1jSEMMPvVbw7Viis4
 KltSB/zlScILCU5/33Nisxxl61UvhSsrAFizoHOYYGVMP1+fr7Bfd4fWGFMUNpdWzBHD4iha
 YYEEugPMvtCr4Tlp1UAswWzCxSiCu3szTFHhHH20qIm3OouCgzGwA8tEsgSvHnOsNn4NqEfW
 v21wqnSyjXDautb1Cn96IjScxAhuu2MXbVoccrR10YkCgfLg0mTp4LjOT2b2foDuHWc4uV8V
 eKvkW8nqxptojio3scsipfGipgXyl/e9CV5xII1KsOkSENgb9+rCp1QuDuHOItxRcMuWW9ou
 Dwjx7AApJW0czQExo49yB7Dd/yIbZKI4hT7WeifITp1h31odrKiixu87EWtzvHxW8e03lhEr
 iRIlsfAu3QN2hHR9sWKTuZx8lq91TuR1Q3e9/9JLEIomafVK5MsxKM7mJkLsUnbHSL6hF/6g
 LKIekk+5OSl5Prrbq/7qpKfL4N5jh3yPr4zlsCiG+g0LwYDU3aB9emz27Du+1DyTatOjv0ri
 anZrI7VJd4GqK64Ag5azJ4u5wq5Ajy7ytoXh2MHI0hAeB+fj4jmJVXOIPfgAPekhlSsjC9ry
 +rdPr3kHpXNNn/DkKr9fbpn7E5c0hA8zdZQ551KEL0BLujzVlfwtNzeEBA5LxS5zuX7BNlny
 48SR3iDDrGWPa/Mq1OE++EiL/GJZIAPuTb9L/Yl5+TpjX88gVISYamp3YEWaHCjAvRmJF2ZY
 XryjdsbE2cFpAs+TOjuiFKcTT5efHizULg65j4hFY2mCoDDSpqjgLybxCu7GIZZaXhcCl+QC
 Xfoa5mEW/AUZS6MOsNhiCALVaC9S4890hGjrAv6xKBpL+XO/i0YsYnu1dl05+3Wjh4y7yZ7A
 96c02GLVWF0n3kHSyU43KBluUB90EuM0bBkg/xEEtxe/+9GUgAmOpHAzux3EMvyWwLEfteRU
 lmqWNSmATcrTtIw2dACeUh9G8/xxizEiiejA7YPlryCLJg19L/MmX3wLNx60HHIyO8qiFx1b
 NFIMDiNhrR+7BTUH47E22ewtoKOWJhUiCXN7maY0W2WvEweUgdxVaHIQVgAb03fodP+oE3YG
 ez9QY87OxdMnJbRYpBBbcfk2A0urJbLPd3fZzn0gGKsHVOTwavKaoP2emIb1SGbCU4ekglV8
 2zVfRMmCHKHpGTTRCdrCUqpe1nlpOJ+snKgUkgszwzMbURg07645jYKjPqVR/QUmLwe6286s
 zshJF+mxJrNDsaY4Q9ofaFSe9Q4tVxHz2PCqwtlPpHmLaljgloTbyxotkXn2xJwTItawoAxt
 H1/9ANpMuqD1U9ZMTOV2ZelIrrMNmz75wyicYbN303Gls2T5r8I9eh+rE/qug6kUEQ4m5l++
 /9S1XbUppDDDQ5JFIn0Tl5y7B9i4bfTfig64YrQk3xqK6i99DHYiZovA6M+xxCscs06UuvMH
 RLuE8AcG8mlKfA701mvYBUeOelO9akyd8q4fvqC0aSvMa5uhjWjxWhA5Yl81AqL+U8eAqbD3
 4wE2O2fxguKETX1jVOlv9zfholCbD0VGSyx02msBYJcYLFzYZdeEX2ncKjVjp11g5/gXWId9
 Ub2VwtAgZXvI0bIKQWtjmgynQwNrHeqmDW11WlxmjAt9e+E2TDWhv/lbFwBM3JKQ29riRHtJ
 5K1hpYURhvNDUBhmR276EL936Ueqr54KjyZSkdSfjPqKHliX+2yv7uGZ8NTwIwhtyxbV+P6b
 0rQGduf61MKljjuGWdT3mVxfDGwu47lmAR6hSSfJXd3qHfFUd55wx7T49uaS+QbjV9kDGFoz
 DLQAFa7Jdyg+96ZwozCvu6JXGWkTpRPcCPvwOtsrQOD7HZxSV26lvG3wZj8FBQilDT8z59sX
 DnJqxD1Zs/q0b67OKRpZBsgCFj54st8UoZw9+l4zJoQw3kBmpKN/XdBk27yNdFWxYrhZXwES
 TkMhdDPqATow0xsKHuVypmxBi3bm5EnPYXgJDpGkismiqICQL+Z9rlFgTd4rhKjoATdbOI81
 jYRxP0y6WIL1uQAuQ4j1CKYUfgZGUhVOzCplgzdv4j49f8RPjr1N+Hghy8c1Zi7AbqPox9RQ
 iP8c5YmRmpr69lndUnLyDv1453lf9/ZaZQSsAeVmlHOlbswStp5m/wUiC5gIW+4s2cizrtxh
 hx03Iqmu5CHJiNv9aO9BhNEHiL8Ycof/Targ7wUzaP0l8i/W45sHDkGRs6iRvKyESkOsuznO
 kCMGTw4rnqHMaXWGwaT70AgoWiFQPXJfzmHYXIey9tlXhyUIkdS1RsVUDsNlZk8Dgm2xcblf
 RQx9nUL61X/sBcJ1vNwOky1TDLEvAnxIGRRKtDXPF9M4wpF/UuQLcGO8rc5AXRD5pP45A2Vd
 j7LP0IRVydTBhbCXxe5Y9zMrZHB67TKX7vlaaGTO/PU8qoED6fPn8Pn05M6rW/dbYPVYyMkV
 aZ9gBMdGishfqaR0zQXF35OxnmLNZPB4k3mvHUw9J33p/3vXEiHCZKnM7JJKp0v/hm3hfzGL
 OuMnGNiLi4e0JoQxHjOwbxZ3VgIiigoeSP/WbgHsCfMSurXlMo1R1YDbDhvMcJT868m9hJIJ
 dadkdbpzrllkrgyEV5DWlGnlNvhacERIm67PU/KHw7bbPLff3uRn5uxOPP0QKY17q0crxCqv
 DeHD0Lvdi+OkTXkTVHnMO1Bij2aIA0LuIy5dUUlAmziQdT6LxyjZY8vy2Rsh+do3DWTZT15U
 3A0aU5Go7yO4DkNh/x+HzcE9X95NayfnD7f6eDEK5EQuP8tAyJulusc7m5prtkdpCxCWvFxn
 zPf69B0pFTz2OKP0Dt8TB1WqjsNhouKuUFvJY3G/59JVXHDuhwXpzb1aVxCt55+B9vjtroFg
 MDIj772ISxe/sj85s4AH47PLd6fN2c9dx3zETjbAU0LV3T4UAOXz1wYm/aU+HqPq5E8oZW5g
 5sCRIhQU1ktH+8bAEBoT5QSZY16VTQ+nfuHndYFsDCg+QLJSpwQ7fWlHrqCRO/iIzGDgfxYa
 gsUlPnmeJ8LONSz2lQ+OAki2t2QXRCMB5YV5Xc8C2186ERVrConHzZ1gR+/LFn2piVLRbnuz
 1Y3klcsOLV2sm2xuRFtfRyQ/XV3yxFU+52tgCjNImegd+HqANsQUXCy7w9rb9usSgJxJ2Vaf
 GR/MSvcAalUk6NnaHwtjxXVv5RCX/BGH/QsiPo42viRbvkv1hJSsHf/raeozfTMD5Jukwxsf
 4T+9hp9
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:qZr6S6whIh2Oh0lO9vbnKrPw4b1zdoMgy1knxilNoNJuA6+lfq
 eV7Y4mPH7P+U0ssRQb8+xoV5PwJE80maQV3WBVB8bFYOCEghrREGgB1/qH/9SIIUSXndK1l5
 0QCpSWY+eAb2SS4/yb3CCIV/INhPGa7aHAv4vj5kYoaS0vRql8425CZTqzIwlTaE1mCZ8+fa
 Dw2uN34x6NPVQvB/7UOpB8ZZmlm+H2
X-Talos-CUID: 9a23:8ksJbW/uECZxe70B/pyVv1E7QtouVFSM9VTvLxCeGG82b6G8RlDFrQ==
X-Talos-MUID: 9a23:E1qZkwUicIM/Bybq/Dm1mSFdButS2L+rVGpVspErtczdLDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,159,1728943200"; 
   d="scan'208";a="101782039"
X-MGA-submission: =?us-ascii?q?MDHCeVAIg6MaNKFNTlN2twK1bD2HpAmwkhT9Ki?=
 =?us-ascii?q?5yexz9Zp4w04s6m6a/wsHnxZprZxL8qxYgVYNoJlYtxZA2Y5+0NaHZ6n?=
 =?us-ascii?q?Pha7f8BUHTC5zm5BiGJxqlMjYbLxuKkBhQ4797pLoDFLH7I7Z1lHPK7P?=
 =?us-ascii?q?em7WnndT6zTh4tNv8KNRBybA=3D=3D?=
Received: from smtp-18.smtpout.orange.fr (HELO smtp.smtpout.orange.fr) ([80.12.242.18])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 07:06:03 +0100
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id CBwItlkEVyQmhCBwItrt0n; Sat, 16 Nov 2024 07:06:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731737162;
	bh=1GOO379j5kHelQgT13xeDCIW+pFPJCeiM7WSIuvag78=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mL98MjzVZSShtzisX9zbjDjIb7KE72buAzIx9jorkgCEIlxacBGBiKDqnznYupede
	 vEhaEvssP8Otw+abSwd4UipThVl5qw3v6w8RixuAXgrl/p9FBRiYmldRfZZljgK0OD
	 FX0UB9px2S9OjhfpAHnQggpK1elWNH8UBNVIvO5x+AsAiYtyf4oGwInz8jFtqh7DDu
	 OMNwG4GURPpChqfcVzLVhpacwz+NEqWf9xIvmwF/gxmCGy7nRrRkaf4TeGrlu6c0Ll
	 o9NHONgP90fIf7c6ZsyFFLJ/v2i9NFywx5+jxHfxBiA3eBfpU5DKAu5obNXbrUQywu
	 rI95zY+eQlUcg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 Nov 2024 07:06:02 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: eahariha@linux.microsoft.com
Cc: James.Bottomley@HansenPartnership.com,
	Julia.Lawall@inria.fr,
	agordeev@linux.ibm.com,
	airlied@gmail.com,
	akpm@linux-foundation.org,
	andrew+netdev@lunn.ch,
	anna-maria@linutronix.de,
	ath11k@lists.infradead.org,
	axboe@kernel.dk,
	bcm-kernel-feedback-list@broadcom.com,
	borntraeger@linux.ibm.com,
	catalin.marinas@arm.com,
	ceph-devel@vger.kernel.org,
	christian.gmeiner@gmail.com,
	christophe.leroy@csgroup.eu,
	cocci@inria.fr,
	coreteam@netfilter.org,
	daniel@zonque.org,
	davem@davemloft.net,
	dick.kennedy@broadcom.com,
	dri-devel@lists.freedesktop.org,
	edumazet@google.com,
	etnaviv@lists.freedesktop.org,
	florian.fainelli@broadcom.com,
	gor@linux.ibm.com,
	gregkh@linuxfoundation.org,
	haojian.zhuang@gmail.com,
	hca@linux.ibm.com,
	horms@kernel.org,
	idryomov@gmail.com,
	intel-xe@lists.freedesktop.org,
	james.smart@broadcom.com,
	jeroendb@google.com,
	jikos@kernel.org,
	jinpu.wang@cloud.ionos.com,
	jjohnson@kernel.org,
	joe.lawrence@redhat.com,
	johan.hedberg@gmail.com,
	jpoimboe@kernel.org,
	kadlec@netfilter.org,
	kuba@kernel.org,
	kvalo@kernel.org,
	l.stach@pengutronix.de,
	linux+etnaviv@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	linux@armlinux.org.uk,
	linuxppc-dev@lists.ozlabs.org,
	live-patching@vger.kernel.org,
	louis.peens@corigine.com,
	lucas.demarchi@intel.com,
	luiz.dentz@gmail.com,
	maarten.lankhorst@linux.intel.com,
	maddy@linux.ibm.com,
	marcel@holtmann.org,
	martin.petersen@oracle.com,
	mbenes@suse.cz,
	mpe@ellerman.id.au,
	mripard@kernel.org,
	naveen@kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	nicolas.palix@imag.fr,
	npiggin@gmail.com,
	obitton@habana.ai,
	ogabbay@kernel.org,
	oss-drivers@corigine.com,
	pabeni@redhat.com,
	pablo@netfilter.org,
	perex@perex.cz,
	pkaligineedi@google.com,
	pmladek@suse.com,
	rjui@broadcom.com,
	robert.jarzmik@free.fr,
	rodrigo.vivi@intel.com,
	roger.pau@citrix.com,
	sbranden@broadcom.com,
	shailend@google.com,
	simona@ffwll.ch,
	svens@linux.ibm.com,
	thomas.hellstrom@linux.intel.com,
	tiwai@suse.com,
	tzimmermann@suse.de,
	xen-devel@lists.xenproject.org,
	xiubli@redhat.com
Date: Sat, 16 Nov 2024 07:05:40 +0100
Message-ID: <20241116060541.5798-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-2-911fb7595e79@linux.microsoft.com>
References: <20241115-converge-secs-to-jiffies-v2-2-911fb7595e79@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 02/21] coccinelle: misc: Add secs_to_jiffies
 script
Reply-To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2062
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241116060541.5798-1-christophe.jaillet%40wanadoo.fr>

Le 15/11/2024 à 22:26, Easwar Hariharan a écrit :
> Suggested-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>   scripts/coccinelle/misc/secs_to_jiffies.cocci | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> new file mode 100644
> index 0000000000000000000000000000000000000000..af762b1c0aac8f044f21150bfaafd9efc834ee87
> --- /dev/null
> +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Find usages of:
> +/// - msecs_to_jiffies(value*1000)
> +/// - msecs_to_jiffies(value*MSEC_PER_SEC)
> +///
> +// Confidence: High
> +// Copyright: (C) 2024 Easwar Hariharan Microsoft
> +//
> +// Keywords: secs, seconds, jiffies
> +//
> +
> +@@ constant C; @@
> +
> +- msecs_to_jiffies(C * 1000)
> ++ secs_to_jiffies(C)
> +
> +@@ constant C; @@
> +
> +- msecs_to_jiffies(C * MSEC_PER_SEC)
> ++ secs_to_jiffies(C)
> 
Hi,

	@@ constant C =~ "000"; @@

	* msecs_to_jiffies(C)

also spots things like msecs_to_jiffies(1000)

I'm not sure that coccinelle is enable to capture part of the regex to automate the removal of the 000 when converting from ms to s.

Just my 2c,

CJ
