Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C38EB64D9
	for <cocci@archiver.kernel.org>; Mon, 19 Jun 2023 14:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2U5u5lc8sZDEcF0mOG2hNwUm8SDTK+VQp12hYrrNjlY=;
  b=QIEawnMrBTBnrR6DcubP+UF8Hh40YlZzW0CrzY4t+6PUU4Mqbo8DmArD
   M+G7vru8AdJ7ap94Gfy+cN6RVvWI8lq/RjXoZEJCj867aLqV7nOp4lfHq
   zcpCidWOh1fqLkM0DEw1zaHPK+wmnZQg36bmFvtWSUEU+o2vJyLYOMRCD
   k=;
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
X-IronPort-AV: E=Sophos;i="6.00,254,1681164000"; 
   d="scan'208";a="113597192"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jun 2023 16:46:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1692FE0157; Mon, 19 Jun 2023 16:46:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E1BE2E0157
	for <cocci@sympa.inria.fr>; Mon, 19 Jun 2023 16:46:32 +0200 (CEST)
IronPort-SDR: 64906a47_zFbCGzYSWYL5kLB4VL+zm1G0JB5LZC+g8woFa4yo6rZizzp
 ASFOkie7vKFo4cyc/bEFLFRBkETdRDYETJIbE3A==
X-IPAS-Result: =?us-ascii?q?A0E/AABDaZBkh07ASNlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYIudQNTMAQLRwOET4gdiTeENo53hGiEBIFWgUA+DwEDA?=
 =?us-ascii?q?Q09BAECBAEBAwSBTIJtRgKGAAIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAUBAhABAQEjFwcOBQsnhWgNgjcpARFkgQgBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBARICDTo/AQICASMdAQERJgEECwsaAiYCAlcGAQwIAQGCe?=
 =?us-ascii?q?gGCJwEDDiMHDa5EgTKBAYIIAQEGnA4fLCJVgV8DBoEVLQGNLoM3eicPgVVEg?=
 =?us-ascii?q?TwMgng+gksXBBiBRoNbgmeLKw4MgmeDNIIxB4s5gShvgR6BInoCCQIRZ4EIC?=
 =?us-ascii?q?F+BckACDVULC2OBHFI6gUYCAhEnExQFTXgbAwcDgQUQLwcEMgkVCQYJGBgXJ?=
 =?us-ascii?q?QZRBy0kCRMVQQSDWAqBDD8VDhGCWiICBzY/G1GCASUEDgMZKx1AAgELcD01B?=
 =?us-ascii?q?gMLHwYmAR4CKYFXMFhwCiMkoA0DgxR8P4FFCJNAsUQ1B4IwgVuBXQyKE5UJB?=
 =?us-ascii?q?hMvg24BkyYOBpIvLoc6kDEgjTuaXYFjOoFcMxokgzZPAxkPjiAZhA6EYYooA?=
 =?us-ascii?q?T4/NAIBAQssAgcBCgEBAwmFRgEBhgABAQ?=
IronPort-PHdr: A9a23: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
 F7a8wY=
IronPort-Data: A9a23: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
 N0BgKbOx8kwsfSovCgQOOjeYzo=
IronPort-HdrOrdr: A9a23:ab4fV6iM3LV4tLfTGlUfZuRl93BQXg4ji2hC6mlwRA09TyVXrb
 HMoB1p726RtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykZsS+Q2njcLz9P+rm62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:1OJ4k27cbbM8oLY+gtss3msWEfoscVzn71iKMwibWXpxZ5bOYArF
X-Talos-MUID: 9a23:iDiftQiS2s8jMvc5wyL0n8MpK/1t0vSFLngxiZQ4q+vVGxNvMTqBg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,254,1681164000"; 
   d="scan'208";a="113597164"
X-MGA-submission: =?us-ascii?q?MDFa6IFAuiHc9wR/m4FDV6sZGvGEmdqMyOqaNu?=
 =?us-ascii?q?d5uSu9d0N1LrfJPbHCRoEcebQZDLt+j9rp0R+ChgcasnIdfq8kIkfoYx?=
 =?us-ascii?q?5zJkUrqrL7WnmFgdI9cz+NjmfEpvKOUptoPenoEcU/xcbL8JJEhHQU/O?=
 =?us-ascii?q?J7nYJwiYHAgtyL1dbcSZBMUA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 16:46:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687185985; x=1687790785; i=markus.elfring@web.de;
 bh=2U5u5lc8sZDEcF0mOG2hNwUm8SDTK+VQp12hYrrNjlY=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=otLBRhIAlvbL8AiJlmWHwx6a13ortA37ZGNjhIhNqLkGhRBrp3f/p0Mcc43ubPpBBp4U8Xp
 MVaBr5NM9dSC9eCcr/CBYXHjslGtWFijSGs/0BdsLoADmJb8NjKD3uXmOT9VRZ81FI5Sf7U6+
 mwmaWmpIYQboG+7DsNVEte4zrVGsLXcyyKpvGMcdPCVO/i5uYPyPH8tnMcGJVPd7S/UmD1DeN
 u5DojuYB23s491WO0HjLgOcyVvdP48Bi1DxjWQ/aHDkytverNVEw1Hx9uNwFkmGcGrGpk8gAw
 trqJXUGAyivgTXcDYIhs9PhE1awi1hkr9wZXcdRRysuv9UDiIC+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mv3Yg-1ptjIP1HIe-00r147; Mon, 19
 Jun 2023 16:46:25 +0200
Message-ID: <fef7b94d-0761-48c2-e169-af21d0054658@web.de>
Date: Mon, 19 Jun 2023 16:46:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Jai Luthra <j-luthra@ti.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Vaishnav Achath <vaishnav.a@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20230619114007.297393-3-tomi.valkeinen@ideasonboard.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230619114007.297393-3-tomi.valkeinen@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oBL4qwWkj9laxP/ZY+5JEgMkFddaJo2ROe4PrbJEwwzS8IFHdK5
 uZ1th6vcnr2rw4ABsWGG8nDFem7ncuKA23K2W8/rEAX2U4NwJnCwMKzCrrFF5yk3ub+GrG6
 HRxNjvb5RtOKe9oa+CAm/REuRYl1m2u5rWdHsSHPz0Af62afZNVRtxX9XAEisWUHNxJNpAl
 /bL/DkvqyMjK/Qp4SF74g==
UI-OutboundReport: notjunk:1;M01:P0:L8HFVjs9tX8=;4lXZ59Muq178iQNwIMPxi1ZtLyB
 +KuX2Ltn11aGUT2wE9djHUhS/ReA8Fu/qe1JH8aoQ/qqmZt8GgihsdMyHKy5ch1G7Alwc7h6+
 LKsIxHk5W/24cvWB2z+Es4pdM4SRuNr4R6H3xBZpqrAfyKIG5r98HjIsGPrhGtqhsFnKoHypo
 D5LwBJ9BQ+2/JYdhUdt8veWjkIq1Ja46C18N7fBWaVQJWa7bI+OWS6pfyy8guRF7FEN31qiqL
 GhTqFY+bmnzFwFmUkt9gJXkOScFcMoFeC6aKri6b6gWHCCOGD6KS12g96gS/dywoPG3A7UiMW
 Rxo+wTEftNeqYE2+zUmaOwR49DckIYlfi2YAsLGhZI9KujZoa/+IYPB6OTx3iAzq77RvM2nOA
 fBe4708ZE+1lHx6oQr1Ug2scyFqDkVlDE2Lyw82IkdZ/h/WH/S1RlqeiB7tHAKamA3PzNyyRq
 u0zXwPO/1kXuh1J7NIUrKKbk4tG+B/MxoX3Upl0Mtd2SoZw/xnp/TbZt8vO6anK8Eln4MaXG9
 alisa5JtRIGmbI+mOUeYbAPUHkufNxcfnr8OZTNCxSOdhJ2mHQYwOKuZyPwsoRVw944QWppZH
 HRsHCckjn8UgBv24PcaFeXZWhnM6wMk0YyRcJXOcTVcfhQkW9QgLOXwdUM2gdF79qicaMagdS
 Zz3x3wDP0R9kfWeiGXumYEe+YNCpHaHzXGVDJ5PhCEbz8svy5QvorpWVWyYQmQZmjNEbHVZD7
 7Zl9AFlqmBBP684TxkodhADAwDeeNp7MyitU99wvxVQnnVPyGm3Nofpv4/6WtBhsbjlyGNf40
 d2tfI7T9UiMW8dY5hach7M5kZvn0dFY4+iMCUhnVs8HLxi2R8y3GR8A4hRbTHEoFc0BXNDSG9
 RgV+NQ1pjQe1b4hx8gvZGIAQ7JDULYFoN24UH6fvDMUDIC4zUI/fhoagFGy4s7b+NiHaxd5Bi
 DvR9gBZgLejJUA/E1Dw/wYr/8Tw=
Subject: Re: [cocci] [PATCH v4 2/4] media: ti: cal: Fix
 cal_camerarx_create() error handling
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1196
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/fef7b94d-0761-48c2-e169-af21d0054658%40web.de>

> Fix these, and also switch the phy allcation from kzalloc to
> devm_kzalloc to simplify the code further.

Does such a wording really fit to the known requirement =E2=80=9CSolve onl=
y one problem per patch.=E2=80=9D?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.4-rc7#n81


Would you like to avoid a typo in such a change description?

Regards,
Markus
