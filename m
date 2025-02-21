Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AEAC021AA
	for <cocci@archiver.kernel.org>; Fri, 21 Feb 2025 13:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=85ZqJ2WnsK+xsV2MUlzgduJL4PyG/D51U/cS63JS8II=;
  b=XHWtnWL9AZ9EwsSQN6yXHCjcc+XEOuoYwXFTG+z274erbf7YIPWRJSP/
   G3KsvbWqOgiSaOEYho5IVakTwYbU0qK9DwS08dT/7BqNKJDWCTpfLp3N7
   +rE/sgMhWfGmtZ24BzeZuSe3pDOYLquxhutotKjAcAp/os7rNjR2eomtV
   c=;
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
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; 
   d="scan'208";a="209393837"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Feb 2025 14:02:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6F386E0D23; Fri, 21 Feb 2025 14:02:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 26EE8E0260
	for <cocci@sympa.inria.fr>; Fri, 21 Feb 2025 14:02:19 +0100 (CET)
IronPort-SDR: 67b8795a_kvYTQ47AloXYZxvrFMewOH2ZhYzfawDOBtgDEzILGQQv1KI
 u6XZ8JaQnqZ0hRq6QIP6q/PozVQdc4SceC1oC/Q==
X-IPAS-Result: =?us-ascii?q?A0EmAgCreLhngQsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAQGCQn1aMwQLSIRWiB2HMoF0hGuPDoh1gVaBfg8BAwENPQQBAgQBA?=
 =?us-ascii?q?QMEhQACiw8CHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQE7Bw4JATGFew1JARABggcBgSSBJgEBAQEBAQEBAQEBAR0CDTpEAgEDI?=
 =?us-ascii?q?wQZAQERJgEPCw4MAiYCAlYGARQBAYJ+AYIvAQMxBw2vG38zgQGCDAEBBtpcH?=
 =?us-ascii?q?ywiV4FlAwaBGi4BhWuCYwGFazuDQnonD4FVRIE8gwM+gkoXBBiBRoNbgmmCM?=
 =?us-ascii?q?4NCgQNniGaRKoxaUnscA1ksAVUTFwsHBYEpEDgDIAo0FB0CFA0QDwYQBGoFN?=
 =?us-ascii?q?Ao3OoILaUk6Ag0CNYIeJFiCK2oEBYEqgjmEQ4RHgj9RgkKCEXFsAwMWDwGCM?=
 =?us-ascii?q?G93HINOgS2CaB1AAgELbT03BgMLGwY9oFw9g36BLycYgj2WS69QNAeCOIFmg?=
 =?us-ascii?q?WMMiimVNQYTL5dEDgaSfS6IC5BEIo1jlWiFQ4FnOoFcMxokgzZPAxkPjiGEL?=
 =?us-ascii?q?YRgiioBt31CNQIBATgCBwEKAQEDCYVGAQGIYYIFgUsBAQ?=
IronPort-PHdr: A9a23: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
 lgphwE4bel/rF8EBn8oK1CMqCZiyCEM
IronPort-Data: A9a23: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
 IT7qa2ogK12dKIpLftdRg==
IronPort-HdrOrdr: A9a23:fBqoDK9zGFGj5lgWpF9uk+DBI+orL9Y04lQ7vn2ZLiYlEfBw9v
 rPoB1173TJYVoqMk3I+urgBEDjexzhHPdOiOEs1JiZMTUO01HHEGgN1+ff/wE=
X-Talos-CUID: =?us-ascii?q?9a23=3AauLabmtjQSUQ+EdsTFOZUrg06Is1dnr871r6LnW?=
 =?us-ascii?q?JBF1gb7LMd3+ioLJdxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3APoMNZAwWXC/QdXP7gJVysJApJW+aqLyLGnozuJ8?=
 =?us-ascii?q?DgpKjbB1VHCuRrW6ObYByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; 
   d="scan'208";a="209393828"
X-MGA-submission: =?us-ascii?q?MDHaJ74aejNRB9yM5q6HlWOuezdcGpSCmHNltN?=
 =?us-ascii?q?aNjBqIzpXQ1m4vdB23Hutv01g9utLMBDIRcPQUxIHE5ImRLjfDXw/fvI?=
 =?us-ascii?q?/+Moz0Z7BWdd3TplrCkzhA+vp51QyXS7g+O4Lw8sHXh/C29670/+XbMT?=
 =?us-ascii?q?+eDfASefShj+kdl/OW7B3XQg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 14:02:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740142904; x=1740747704; i=markus.elfring@web.de;
	bh=85ZqJ2WnsK+xsV2MUlzgduJL4PyG/D51U/cS63JS8II=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CHM9auL9al+K6GjKDD9yPsDUZ30bsleiNs194UHYjwOkZeppGJSTjbSyICdbk4mt
	 6n/bSgc7pdEy5DoaeW4v7hfmjVzrg5u621R/f5KbhckewRCI0Uy5LCXeNZuRQ3cDP
	 Z89fDER8yZCxRjiOe7yAOUYj4Ef1/RfvhBKvRx8HhfrrIvgtgyEDjjGThPFWLnAC1
	 2mVoassSLDqSFsZKVTUDVPs2pVf/ykStv3v1MqtdMbpxx2nhu0OXsdMH9g0eu+v7w
	 ifli+1r8PNErCOP26Kdm/72hlraPt+35NtYgZC3oDdqcX8e62NCufXmOlOs3kv4w+
	 1sVi4uOc6Y1cfdNyjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.4]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjBVv-1t9MYH25ll-00hNJl; Fri, 21
 Feb 2025 14:01:44 +0100
Message-ID: <b8e127d4-0a8b-437f-a856-3f75d4680045@web.de>
Date: Fri, 21 Feb 2025 14:01:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hans Verkuil <hverkuil@xs4all.nl>, Ricardo Ribalda
 <ribalda@chromium.org>, linux-media@vger.kernel.org, cocci@inria.fr,
 Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 openbmc@lists.ozlabs.org, Marvin Lin <milkfafa@gmail.com>
References: <df5693d0-7747-4423-809e-ae081c9aae92@xs4all.nl>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <df5693d0-7747-4423-809e-ae081c9aae92@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iFsHkTyzJQla9LP+6t/K5VjRFy7phUQNDh4Men40wXmfAgHQZAO
 BAFszW1jSronbk2zcvpuTTav61LBTyccqcQFDQORsyQlfDVVirQI5PnSCEtZeEWRd5xFMMA
 mzxy11KaOa6hDDfV4QWj6lsTIxYtHnDaIFW9MZPJdAb7XriUShYvkx6cMp/Qble1RJqD40N
 UebwF5jr4cGJTiemgi9rA==
UI-OutboundReport: notjunk:1;M01:P0:vKbg0xmAZbE=;scMx0Cag00azSe+gAuLGqt+F6My
 f/00eXJv0UI9rH73lTmQZneILMNCVkl7/NkGixj3YPhDGBeB5MY8B9ij1KLkhCquguXB6nGAc
 KcGmezzVSap5tgJEh2kX9aqgBH75GZiUA59Jdb1UyGT5yKR4l5beYWGQiSoEeUuv8ZXFXNDIL
 aKK70IRA0pT/+9QSlmSzNmTBBFxiuqo2CePRyvlXZkOD8iYCnAJqKUtnQ9LlBYcN3TYjskbdt
 vAAiJl+7UtZ3jP1bdJnBkDBv2WIkxZBToFo05HDYxph+/fTbN4H1U3N9P27cBJBbQnAPqK0gW
 M+98vYxx7RXU9bo+JgosWZnQnrv37ZmBHNVpU5jBAAZ6bk6F1kI9bOnOjBKfpzwt8vgJ+1yQl
 osewOTQTPjRQjP1qdWk0HUWnKLyW9/tOiWsjLr8SZKWDakBSNcxQoJz5fFGSpvXDioBhfDQIX
 E8vbolf8WZGzpikwNxz/2KYpm0PdjaLkWYdTFAYiJMcMrOKnb4/LByeo+q6wNmd1unu9n/YCe
 6VNRc7T1VAEQJnkOq9fXo7epCSJWpe9j6bbU1pUowIzF+2J3XaGalz+AbRIl9rp7bPtjjB/6l
 uRjAVfgNuog++8ggKI8K1A6+2xXc2vx2PKUwyz4KIE5PZG3+IHcwwhAwQdKdi8JSjKNuvTHQO
 WF9hPUQTn+VAIdEvaiSmCYsjWShmw8yzQJeCV3YFfngB7lnlwj5GwSQMtdb+UezcGEMfvxphr
 ZkjQTD2f9N5bb1F1Ai7s3H0XCeSQalyfDnAf3CXauvSZf5OMjJ5X6H6ETFr5dStqaYuVvB212
 PwdH7BncfsTDQTooM4/wUsM6gpBq7tlJKM+UyMfSjY/Xh0JvAQNV2jqaiT6Tk/PlyLnp4Z4ui
 9WdJKdkxYpTghKg49VLfV6m8IZnzKWC3TF9ISUZC18DRfH06NMfFPCQdLlMW1UVWZsu9DUgvQ
 Drp5XCzhDBuTNc0DPTk6A6rK480L3pTrrJLOZyzeCXUN0cdCLr/LsES+ufhqRQx2u6thi3Toj
 Uvb+EohhnHXsq7bDOiguOkO5sIcm0gT0XSaqA6SDuUicHbwh3Wfnnn03p9VObyxMFFsYsp/ZV
 T0nIKU/jYN5gl1bqM25Buub9sotUz5t7xOscdfrXxCKKlbBA12hRc05LrL+saI6s2X7cl1xTA
 PyA5oF5Ey6aYq020WnqrUMs6rB9oCOgeTyWfZdGSljlShgOGusweto9Tp7KOU4RThk5sd8CpQ
 07hlLszPG64p9z0uJ58M0ROyDEbKe7to//C9NnsKeq+TZVFjeZiWalqJlipFQvN1kuwvCIKcj
 tqfhjwDJ1YMyvjmJzWwOrR+d1ZUajQv+95kJFZ2prN5vHjHle4IgsXHJ+sllLOG0NIpr6lku3
 lIyWKIbnhcAI9fRkSgoHjEToUwhN0FRw4V/1aWpY8vfsWRNJldBudVbLnJxlt/FJ1ZurN68TG
 L70SlOZk01HcHTYGrHxxgLp6va1M=
Subject: Re: [cocci] [PATCH 1/4] media: nuvoton: Fix reference handling of
 ece_pdev
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2427
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/b8e127d4-0a8b-437f-a856-3f75d4680045%40web.de>

=E2=80=A6
> > Found by cocci:
> > ./platform/nuvoton/npcm-video.c:1677:3-9: ERROR: missing put_device; c=
all of_find_device_by_node on line 1667, but without a corresponding objec=
t release within this function.
=E2=80=A6
> This driver uses this construct:
>
>                 struct device *ece_dev __free(put_device) =3D &ece_pdev-=
>dev;
>
> to automatically call put_device. So this patch would 'put' the device t=
wice.
>
> Does cocci understand constructs like this? =E2=80=A6

Not yet directly (for coccicheck scripts).
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/scr=
ipts/coccinelle/free/put_device.cocci?h=3Dv6.14-rc3

I am unsure under which circumstances support can be added for the detecti=
on
of scope-based resource management also by the means of the semantic patch=
 language.

Regards,
Markus
