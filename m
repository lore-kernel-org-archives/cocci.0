Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC51C4707B
	for <cocci@archiver.kernel.org>; Wed, 10 Jan 2024 13:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3Ymobp386Sr69CbdAIJKkz88XtWN3McGZjXialmzRCM=;
  b=tyDnW1rsOqpZb/Ou/qrwMru2GRzOCEenQNV1dsEmqN731yXGcUfxqOw0
   E34FkGIDpHnIuV0/EXrczkaHPuTrzM4rYrqREsKFYOc/FOWjwosPdqc+l
   J6YFE6KOGUygFr5fj1hNZRXh5ClV42jXSBR1dMaB9gdI6qzD60O0IBjXz
   E=;
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
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145876125"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jan 2024 14:01:42 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AD958E004E; Wed, 10 Jan 2024 14:01:41 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6AAB1E0AF1
	for <cocci@sympa.inria.fr>; Wed, 10 Jan 2024 14:01:37 +0100 (CET)
IronPort-SDR: 659e9531_pPltKyimXsaSKdxTSka/7nmoo8a3dTsLeNnti1K8SFy+jwX
 5UjgLwimYNoHnFfto3aC3+EFfd5QNupdxliIp4Q==
X-IPAS-Result: =?us-ascii?q?A0FtAACMlJ5l/wwR49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YI4B3VWMgQLSIRTkTYwVYNmjwGIb4FWgUA+DwEDAQ07BgECBAEBAwMBhH8Ch?=
 =?us-ascii?q?z0CHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQKBBhOFb?=
 =?us-ascii?q?A2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAg06QgEEASMdAQERJgEECwsaAiYCAlYGARICAQGCfAGCKgEDDiMHD?=
 =?us-ascii?q?Qa1WYEygQGCCgEBBoFFAgwCQ61AHywiVoFgAwaBGi4BiBoBhEWBIoNBeicPg?=
 =?us-ascii?q?VVEgTyDAz6CYQOBX4NbgmiFXINvjDNSfx0DgQUEXA8bDx43ERAFDg0DCG4dA?=
 =?us-ascii?q?jE8AwUDBDIKHAshBVUDQAZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDEkkCEBQDO?=
 =?us-ascii?q?wMDBgMKMQMwVUIMUANlHzIJPAsEDBoCGx4NJyMCLEIDEQUQAhYDJBYENBEJC?=
 =?us-ascii?q?yYDKgY4AhIMBgYJXSYHDwkEJQMIBAMrKQMjdBEDBAoDFAcLB3uBFwMZKx1AA?=
 =?us-ascii?q?gELbT01BgMLGwY9ApUqAYI5gTkCXZRWshg0B4I0gWCBYQyKGJUTBhMvg24BE?=
 =?us-ascii?q?pMlDgYxkiMuh1CQTyCLVIF2mnyBagQygVkzGiSDNk8DGQ+OIIQrgQuDVopmQ?=
 =?us-ascii?q?DUCOQIHCwEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
 xZamdvF
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:uYxILK1N0WQDroMkT8UcYQqjBGYkLtp133Aq2lEZdPWaSL38qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:D9xtlWFz5aJO+/IcqmI7yXMeAu8UcUfHklP0AkaUG3ZPUoeKHAo=
X-Talos-MUID: 9a23:mCglDQnG3IaYEW2Qk/OLdnpzaflD3PWQJHtRjKUl5eLUCA9QJDm02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145876101"
X-MGA-submission: =?us-ascii?q?MDGct8TTQlnqxgea3aFECjSONPk3jbJd+pBQtL?=
 =?us-ascii?q?c5Z17YU0KrR+E04D90ZBzxXTdhFBvR0/rMT0MlMt540P3rgFiRsAdZoD?=
 =?us-ascii?q?5rfxPSTOGr5HLRw/2LybytxWGrOC2EqEecwWJDCfFH5LEfvFm7YOMnLJ?=
 =?us-ascii?q?GK9apnzfGY3VvZyhLFkbg0tQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 14:01:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704891686; x=1705496486; i=markus.elfring@web.de;
	bh=fqSFKY5Zirnw4hSO+f9JSpx6szHta+QQy+nLiPG9ozg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=HR+QsUTh3JMkedWITQ3E4tHVdgeuKVdUK1yjOWV+UvLTU+X/yU1G4TQ42tpBCwXu
	 +BOpP86+ZoVzh9vdfwzENzMs8j/Gg1z/V0C+sVE68OrSQFGzjIg96C/3/h9JFAfKx
	 tKTVXdES+YKrs/gCiI/9VDSa24gkZYTZWvUn4bEdBBJV3lV8HAlvKoX4T1BdLc8LG
	 4C7Dv8htTMshKzV/h3Jb2Rw+6B2IYUvvurOtAfpbaXRMt5uM4dLvJf0Wev7Of1BHt
	 wJm5XGWp/c2I6k1sSxSHDBHKOs+2X484+ftVgto6UYd2H984y/cgP66xNT14alSQ/
	 oBo5sKm5dpJwWrRAKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2jaQ-1rBQEc12ey-012zo4; Wed, 10
 Jan 2024 14:01:26 +0100
Message-ID: <d912872a-e70a-4e5d-aabe-26f289507f44@web.de>
Date: Wed, 10 Jan 2024 14:01:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <87b65f8e-abde-2aff-4da8-df6e0b464677@web.de>
 <05d334af-1a0f-4498-b57d-36a783288f07@web.de>
 <CAOQ4uxiRaTQyT1nxeRD7B89=VuA+KKEqi01LL1kqfJ17-qKKpw@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAOQ4uxiRaTQyT1nxeRD7B89=VuA+KKEqi01LL1kqfJ17-qKKpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h8tCbXXw0Swhpr88lNGFvUEGFYt40i2z0RuHlDmlga9TVUJiPh4
 JaiVj/0ZiSWg6/4bEGeMEgE+DJQpcfcPDxeGclF4igoN8nbuuCZ/KLECvsROT1ZePdxFF1S
 XqNkNsQ02shb2lmFyeNAo1QSKj2BonPY4fkSwWuKK0YuTRmzKy4gTj4oKVqH55tgdsCaBlR
 BzDlGVNtlRDiGW+I/E1Fw==
UI-OutboundReport: notjunk:1;M01:P0:du3gPScwpYI=;xWLpWwsJ6b0IwbjzBfQqcOG12Ci
 YtBsjgLTQIqOyffl58KRi4P0CfKo+Ln8fGqncCRADCO45AaIgrrFcfEa2Ss4gpoZnFzFYotzB
 T0oukIDp+Kw4TM3fmfieBqMYRVK4W3ZI85AeI0xlMnhJOR4VbnpXmVKdlIUZoZ1zisVnNfQPn
 E1UT8uA1U14UgyCcAPyVsoV25PunUFKBJkWtDdrGL/WPRVBoHGbQ0nK/nYoSqGA5UeaJjHXC9
 diWQeGf13mSUdLj8tlaj1hWxYSmjUoRJVYaFBTXsVE8RDoBO8EKJ8peM4PCk6URjmvij+UEFn
 jGI9GwrrfXylcy6TpAdSwzuXqW9N+S4bjv8PMt6g3m/1rDv+POs7iBtd8qYRcFZBUdmUArVab
 0Ks4vByapiiCbheNOJzShpWpIkNfpyzUudZAJEwFXpWbVh1JfqAcqKrtp1wdqXAmH3SSulcV7
 TvlY1E4pDsyb88RsStF4M25CpsYcAXAO0O1QaLFyN6mACwrvfmhUOzWQm/pm32mM+F6p5whBa
 n0cgaHziN8ejP70SlZUo2NYAAdOnP3ZeDG10C2vkO0jlpc6eaeFDZpyUkz3N+FfpLvADDBUA7
 spbMoZOqCxVwlH9yykYueh3VOw0h3mqciBDP1r/9bI7hmX8VVGkf5l0vojNecQ7wUoFbXhSzx
 iUUHRoYGnRQ+xekL5WU1+fbCx1QY/8gnHUe8/pOi9tvx2Sow2DhVIbd7PQasEBNOQetZTvady
 eFY6h32Zdae6/F+jeOTeHwvudaclhB3g6czqi63wUZEsI7/ADB3Qzi1VHEPgzXQ6+lwrIAdtT
 fwdVZT5oyd5D95xspSToRZ8ClHEnantDUE00C5DH8OLs7prhWGoajC0iqxlBAIg9Gc1wJJQGQ
 iBRWUkmyrx2S9jKdEIAiq4fkKUyadPjuQIsATi60v0etJwnhPMKfgbg8BliWZ0JwTywFObNaX
 yWl8tA==
Subject: Re: [cocci] [0/4] overlayfs: Adjustments for ovl_fill_super()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1452
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/d912872a-e70a-4e5d-aabe-26f289507f44%40web.de>

>> See also:
>> https://lore.kernel.org/cocci/87b65f8e-abde-2aff-4da8-df6e0b464677@web.=
de/
>> https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00115.html
>
> I will queue cleanup patches 1-2,

Thanks for this positive feedback.


>                                   but I do not like patches 3/4 and 4/4.
> I do not think that they make the code better to read or maintain.

I would appreciate if the details for such change reluctance can be clarif=
ied better.

Regards,
Markus
