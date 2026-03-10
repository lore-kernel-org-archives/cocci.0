Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692CBEB1058
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 14:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=765ZgLXaPzReFoXtpkbv3MYN7L9J6JKDHvE8MxWus3k=;
  b=fUPBQyaTqGWm6OAGKl3zkEKQieoRaAtd9MpKyJ385au7oF3nayAE4IQc
   X3ZcRhVOb6xU7F9ArrbBgZMHPtm+Au6D+5tlrvx6FVNn/Bqa4yDJhfPWw
   I+ipmUCr9rPmW8xCcQCPHbZYjEC+TNKr7Gj2wGSNgRgHdJtF41AyJSMuL
   M=;
X-CSE-ConnectionGUID: xO5ZHRDPSbW01QqCJifxfw==
X-CSE-MsgGUID: /W4Hk4CPRSO3hFmfxvMMAw==
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
   d="scan'208";a="267117219"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 15:25:23 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E5BF3839A2; Tue, 10 Mar 2026 15:25:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1B37883899
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 14:56:03 +0100 (CET)
X-CSE-ConnectionGUID: Ar8n2BsOT5qrQe1LvsjCbw==
X-CSE-MsgGUID: JR4LSFYLRsiPrpLMNu8Nlg==
IronPort-SDR: 69b022f1_QXbTPfcrmklktHB8fJ3fZjNDdHgIpJXUfMe8Q1Esks9aN0D
 Unr9WnvMDDx4V1WFyIYfiFH4eQ0EEWjCQ1TW+9w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FBAQAyIrBpjsm3RtlagQmBUIJBgWU0BwhJhFiQMAaBQ?=
 =?us-ascii?q?YtkEJBRgVWBfw8BAwENUQQBAYUHAo0hAh8GAQQyBw4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAQEBATkFSYZcgmIBhAABAQEDIwRSE?=
 =?us-ascii?q?AsOCgICJgICIDYGARKDAoI7AzYHrTN/M4EBhH3YRg2CXhQBgQouiDUfAYFwg?=
 =?us-ascii?q?XeBcxo7hD8nG32BEIEVgyo+gh+Ff4JpBIIigQ6JCooWCUl4HANZLAFVExcLB?=
 =?us-ascii?q?wWBIxAzAyAKLy0CFA0QEg8EFgUtHXAMJxIPHRcUH1gbBwUSISqBSXiBZhsPh?=
 =?us-ascii?q?mp5Ay5eGg4iAigSA1lKPgtaBYI/AwttPTcGDhsEjyc+gjMBAYENgikXlnqvL?=
 =?us-ascii?q?3GEJptchhYzqmsuh2WQcyKRcJcvgW8EL4FcMxoIJgqDIk8DGQ+OLQ0Jkxu5d?=
 =?us-ascii?q?kUyPAIHAQoBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
 EP4KBManukF2A==
IronPort-Data: A9a23:gG2qB6uOHYgrav6jSg4DOr/R4ufnVEtaMUV32f8akzHdYApBsoF/q
 tZmKW3SbP+DYzGhc98lb4Xg9EkAvsDRyIBjGVRl+X03RC0UgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOhTrOCY2YpGFIMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMTdJ4RYtWo4vw/zF8kgHUMja4mtC4ARlPKgT5TcyqlFMZH4hDfHpR5fHatIMdgKKb
 76r5K20+Grf4yAsBruN+p7nclcHS6LlJgOHjHxbQcCK2nCucQRvukqTHKN0hXZ/011lrfgpo
 Dl+ncDYpTMSA0H5sL91vy+0vM1JFfYuFLfveRBTuCEIpqHMWyOEL/5GVCnaMWCEkwre7K4nG
 fEwcVgwgh6/a+2e6ajrTLNGneMfcdDxBY5Gnm97zxrTEqNzKXzDa/2iCd5wxjo0j9EeWPqYY
 sMYbXxgZRLMYltJN0t/5JAWxr73wCanNWQI8xTP/fNfD2v7lGSd1JDtOdbYYceiRcxZk12D4
 GTL4wwVBzlDaITOkmDdqC3EaunnvxmnfLk8JZmC7f9SmkW340oOWDsSWg7uyRW+ohTvA40Dd
 hR8FjAVhaM1/0eqZsLsWgWx5n+CpB8VHdRKe9DW8ymXx67d8lbcCi4BRz9FLtMvssM3Azony
 jdlgu8FGxRGqu2TE1iG0YvJtCmLNHExM3QATiUbGF5tD8bYnG0lsv7YZvhZeJNZY/XvFDX50
 mDPoG47jrQXy8EC0am6u1bKn1pAR6QlrCZqt207vUr/tmuVgbJJgaT0uTA3Ct4cce6koqGp5
 iRspiRnxLlm4WuxeNOxrBUlRuDxuKrYaFUwcHZgFp8t9ny28mXLQL28FApWfR8zWu5dIGeBS
 BaK6Wt5usUPVFP0NvUfS9zqVKwXIV3ISY6Nugb8MoAWOsAZmc7u1H0GWHN8KEi0zxFzyfxmZ
 MvEGStuZF5DYZlaIPONb791+dcWKuoWnAs/nLiqn0714qnUf3OPV7YOPX2Ha+1zvuvOoxzY/
 5wbf4GGwglWGr+2KCTG058hHXZTJ1gCBLfyt5N2cMyHKVFYA20PMaLa7o4gXI1HpJ5rsNn00
 EuzYWJm7WbupGbmLFyKY09zabm0UpdYq2k6DBMWPl2p+iYCZ6Sr5ogxKrwcJLoD8bVjxMFrU
 stfVdiyLfdSQDH5oxUccpjPg4hwfzu7hQ+1HnSEYRpuW7VCVgD26tvfUQ+3zxY3Dw2zrtkbj
 4y78xHyGL4vZl1FIp7NSfSNy1iRgyAsqNhqVRGVHugJKVTezod6DgfQ0Nk1GpgoAjfezGK40
 w22P08pldPVqdVozOiT1LG2lKb3Ie5QBUEAInL664yxPizk/maO549MfeKLXDLFXlPP56SQS
 rRJ/s74LcE4sg5Gg6hkH5Zv6JAO1d/lirtZ7wZjRVHgTVCgDJF+KXing+hLkIBwxYFihAjnY
 XLXp+FmOoiINvj1T38XBg4uNdqY2d8uxzL90PUSIWfB3hFRwoapa0toAkSzuHRvF4ctaIIB6
 sU9ifES8D2620YLMM7ZryV69FasD30nUocgh64gBISwrxchz28aQJ3DCx3Z5IOERMVMP3ILf
 B6VpvvmrJZNynXSd0EcESD24tNcopAVqTZ2zFMmDHaYqOrv3/MY8kVYzmUqc15z0B5C7dNWB
 kFqEE9EfYO14DZigZl4bVCGQg1uKkWQxR3s9gEvimbcckiPU17NJk0bPcKm3hgQ00BYTwhh0
 ICo8kTXehe0Q5ipxQo3Y1BvlNL7R98o9gHiptGuL/7YI7YEOwjako2cTktWjSD4APEBplzN/
 shr2+dSVZfVFwAtp48DNo3L8ohIFT6lIjRZTOBD7ZE5OzjWWAuP1AikL2GzfcJwJML2z3KoN
 vw2Ju9yU0WR6SXfiBEaGq8GHJFsltEL+tcpW+3mNEwGgZSlvxtrt5PZ2Qb9tl8NUfFrzMIxA
 aLKVje4CmfLr2Blq2zMi8hlO2SDftgPYjPn7t216OkkE5EisvlmVEMPjouPoHSeNTV48yKuv
 A/sY7Hcy8pgw99Om7TAP7piBQLuD//OT8WNrR6OtupRYeP1Mcvhsx0frn/lNV90OZoTQ9FGq
 qSfguXo3U/qvKcEbE6BosOvT5J23MSVWPZbFunVL3MAxCuLZ5LK0is5omu9LcRErcNZ6syZX
 DCHUcqXd+MOetJj1XZQOjl/EREcNvzNVZ3ehxiB9taCNhtM9jb8DoKXxSe8JyUTPCoFIIb3B
 QLIqu6jrIIQ5phFABgfQepqGdlkKVvkQrErbMD1qSLeNGSzn1eeofH3oHLMM90Q5qWsS64WI
 K4pRyQSsDyotaXB3YEcv8p3txwTSnl0h+UxOEQQ57aaThikWXUeI7113YouU/lpfu7ajfkUp
 w0hqEMiACnwRi8CdxjgiDgmdhnKHfQAY78VORRwl355qE6K6EeoALJt+zx7pXF7ZlMPCQ1hx
 c42ohXNA/R6/n2lqSv/KBB2bSeLC842Hk41xH0=
IronPort-HdrOrdr: A9a23:ENazUqz8KzAFVDBSY5OpKrPw7L1zdoMgy1knxilNoNJuHPBw8P
 re+cjztCWE6gr5N0tApTntAsW9qDbnlaKdgrNhWotKPjONhILAFugLhrcKgQeQeBEWndQx6U
 4PScdD4ZHLfDxHpPe/zi6UV/wp3MOKmZrY/Nv2/jNCaiwvUal76m5Ce2CmO3wzai5qQaAyEo
 GRj/A33AaISDA4Sen+PGQMQuSrnayyqK7b
X-Talos-CUID: 9a23:crTej2D+42QJEaD6EwB9pEhOMNsCTiDE1k7demumEmRCQqLAHA==
X-Talos-MUID: 9a23:VPqoCAUcBKfJ0Irq/B3W2BVZGvZM2b+vMFoVtbAgppmiMSMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="140932027"
X-MGA-submission: =?us-ascii?q?MDF1fo7+yO27bu0cJkYHlcWPKIcZ/ejynZry6h?=
 =?us-ascii?q?tV2X+LJhehH+u3Jva/sLGYVgkEBzO512+N0LEuKgUal0g/sfDEtH1Llf?=
 =?us-ascii?q?ryJZAVAjJSqsTmpwF9Aib+iM7X8j2gfvWrcjew3kEUNKyk/TvIC7f435?=
 =?us-ascii?q?zrmlUQKk5QpAnW67FDTNUTVQ=3D=3D?=
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:56:02 +0100
Received: by mail.gandi.net (Postfix) with ESMTPSA id 539B3433BD;
	Tue, 10 Mar 2026 13:55:53 +0000 (UTC)
Message-ID: <375c7c30c184d331c199876e45920976030f3cbc.camel@hadess.net>
From: Bastien Nocera <hadess@hadess.net>
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
 	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, 	linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, 	linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, 	linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, 	linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, 	linux-media@vger.kernel.org,
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
 ntfs3@lists.linux.dev, 	samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, 	target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, 	v9fs@lists.linux.dev
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	 <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Mar 2026 14:55:52 +0100
In-Reply-To: <20260310-b4-is_err_or_null-v1-25-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	 <20260310-b4-is_err_or_null-v1-25-bd63b656022d@avm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepheefleeufeegfeefueffpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepheejpdhrtghpthhtohepphhhrghhnhdqohhsshesrghvmhdruggvpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvu
 ggvshhkthhophdrohhrghdprhgtphhtthhopegrphhprghrmhhorheslhhishhtshdruhgsuhhnthhurdgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghphhdquggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgttghisehinhhrihgrrdhfrh
X-GND-State: clean
X-GND-Score: -100
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 25/61] net/bluetooth: Prefer IS_ERR_OR_NULL over
 manual NULL check
Reply-To: Bastien Nocera <hadess@hadess.net>
X-Loop: cocci@inria.fr
X-Sequence: 3380
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/HuC7r5R9yjp3JCyH6dUCGw>

On Tue, 2026-03-10 at 12:48 +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>=20
> Change generated with coccinelle.
>=20
> To: Marcel Holtmann <marcel@holtmann.org>
> To: Johan Hedberg <johan.hedberg@gmail.com>
> To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> ---
> =C2=A0net/bluetooth/mgmt.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index
> a7238fd3b03bb54f39af1afee74dc1acd931c324..06d2da67bbe14e17ee478aa939d
> e26526c333d91 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -4169,7 +4169,7 @@ static void set_default_phy_complete(struct
> hci_dev *hdev, void *data, int err)
> =C2=A0		mgmt_phy_configuration_changed(hdev, cmd->sk);
> =C2=A0	}
> =C2=A0
> -	if (skb && !IS_ERR(skb))
> +	if (!IS_ERR_OR_NULL(skb))
> =C2=A0		kfree_skb(skb);
> =C2=A0
> =C2=A0	mgmt_pending_free(cmd);
> @@ -5730,7 +5730,7 @@ static void read_local_oob_data_complete(struct
> hci_dev *hdev, void *data,
> =C2=A0			=C2=A0 MGMT_STATUS_SUCCESS, &mgmt_rp, rp_size);
> =C2=A0
> =C2=A0remove:
> -	if (skb && !IS_ERR(skb))
> +	if (!IS_ERR_OR_NULL(skb))
> =C2=A0		kfree_skb(skb);
> =C2=A0
> =C2=A0	mgmt_pending_free(cmd);
> @@ -8277,7 +8277,7 @@ static void
> read_local_oob_ext_data_complete(struct hci_dev *hdev, void *data,
> =C2=A0				 mgmt_rp, sizeof(*mgmt_rp) +
> eir_len,
> =C2=A0				 HCI_MGMT_OOB_DATA_EVENTS, cmd->sk);
> =C2=A0done:
> -	if (skb && !IS_ERR(skb))
> +	if (!IS_ERR_OR_NULL(skb))
> =C2=A0		kfree_skb(skb);
> =C2=A0
> =C2=A0	kfree(mgmt_rp);
