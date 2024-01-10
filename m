Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14033C4707B
	for <cocci@archiver.kernel.org>; Wed, 10 Jan 2024 11:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=old6CeuXScNk9yzbsNBBqlZ73fgEf4rDiIA0+yk62/A=;
  b=HolyEid37d80xyPHmUnUWCWIOx/A//LbmqzSPFX3j2bYB2liMqFGDk0b
   2ghnptINDsz2VhHwq16WlypCGiLm2Ynh4qp6NUHJVHopeUTR6lI4qDCWD
   3p/k+VU4dXtRADQ0oxF3dsiZy9QaeItuulEoY0BRrJuKiEX9F2GlrqhHV
   Q=;
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
   d="scan'208";a="145859197"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jan 2024 12:49:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 51156E0AF1; Wed, 10 Jan 2024 12:49:00 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D3DEFE004E
	for <cocci@sympa.inria.fr>; Wed, 10 Jan 2024 12:48:58 +0100 (CET)
IronPort-SDR: 659e842b_J59wXwXVhox3KE8lrhSPZ/9+F73VbM3QAynXxNnG+EkSBBz
 0gTopYIPjfgIiNEBlwf3gqD3aiECA47oHTK9URw==
X-IPAS-Result: =?us-ascii?q?A0EqAADagp5l/wsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4B3VWMgQLSIRTiB2JGS0DhDuPAYRrhASBVhSBLD4PAQMBDTsGA?=
 =?us-ascii?q?QIEAQEDAwE4hEcChz0CHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQKBBhOFbA2CVRiBDIEeAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQECDTpCAQQBIx0BAREmAQQLCxQGAhEVAgJWBgESA?=
 =?us-ascii?q?gEBgnwBgioBAw4jBw0GtXuBMoEBggoBAQaBRQIMAkNOrHIfLCJWgWADBoEaL?=
 =?us-ascii?q?gGIGgGFZ4NBeicPgVVEgTwLgng+gmEDgRiBBoMcgmiCGoNCihyGBlJ/HQOBB?=
 =?us-ascii?q?QRcDxsPHjcREBMNAwhuHQIxPAMFAwQyChwLIQVVA0AGSQsDAhoFAwMEgTAFD?=
 =?us-ascii?q?RoCEBoGDCYDAxJJAhAUAzsDAwYDCjEDMFVCDFADZR8yCTwLBAwaAhseDScjA?=
 =?us-ascii?q?ixCAxEFEAIWAyQWBDQRCQsmAyoGOAISDAYGCV0mBw8JBCUDCAQDKykDI3QRA?=
 =?us-ascii?q?wQKAxQHCwd7gRcDGSsdQAIBC209NQYDCxsGPQKVKgGCOnsTKgKCE5Mpkx2ec?=
 =?us-ascii?q?jQHgjSBYIFhDIoYlRMGEy+DbhOTJQ4GklQuh1CQTyCCMYkjgXaafIFjPYFZM?=
 =?us-ascii?q?xokgzZPAxkPjiCEK4ELg1aKZkA1AjkCBwsBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 HsmT7hGSBoqG/lcBkk3RLTqz79oUzlinbPJ1aY1
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:sVS3FashJyhEd0mFb9Q7k9SE7skDotV00zEX/kB9WHVpmwKj5q
 STdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniFhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD9HZK3BgDVQfexQpeWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:GRZOZG0HMetXOc17DvxIvrxfHJwFa1/Rz1jpMwyiIGhRR5SXTHac0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AYhkidg0dRZhBdu7OQ2thfqszlTUj6rWMImJTuJs?=
 =?us-ascii?q?/puaBOxRPIjSnj2j0a9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145859195"
X-MGA-submission: =?us-ascii?q?MDG6PUjC9VGCNRVZlw2LvPhbe7rWt2Rmp4WZ9Z?=
 =?us-ascii?q?V3W3xxCMDHltyZszO/WCvHSlMMQ2V5BH2I/G4qCkZe0UfDjiuuIh7eYt?=
 =?us-ascii?q?GVI5+sV7IRLmB86Q4mHIEJPfUYEVHwvPZCD1VwOmZ6BiudvBzBwD5nQO?=
 =?us-ascii?q?dz9oXt9zOCbBjhlfjA4lquNw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 12:48:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704887327; x=1705492127; i=markus.elfring@web.de;
	bh=LTkB4g/EgdPEET+xqwliNWj/wGfk6xQ9qpWM5jUj2tc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=JhZjCYhSzB5Non1e7VG+S9wpK2Ggk1YkD5CAWjhOgSu+L+CnupAZVW3P465sG5Rt
	 VCGQUs4q2+EnfC693AMDacbf0yZfoT/JrHCk4uOdD7BP9MX9uIzRvdOmBgfm8zdjf
	 MIlP0Y75D2kzXiT6jvlk2E6OnDCxkssUEdNsRFquOmEC4+e6GkLH3e71OCHF/j4OJ
	 7SfBWerQrp64098xO4m2SQzglS1vI1VASaH03Kay4nxQtqQZ3JmFzqJ7ERgsumKPk
	 GRL3FD6Nk/x3bPUMpa3WsKpJJzGLBevkjbguF+1AArqS2sisRwQ7eURHj37SSjudF
	 jw3zkM64d5dy0yeqcA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mfc4g-1qhck32AZ6-00gBHR; Wed, 10
 Jan 2024 12:48:47 +0100
Message-ID: <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
Date: Wed, 10 Jan 2024 12:48:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Russell King <linux@armlinux.org.uk>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
In-Reply-To: <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fu16EWDvzTMZHLAc4WQ6rkStfY9mvBZxuOny3HBgTQQDY6Gw6uq
 JdJuHrBQm+zOJRxWN4gsCMiJhlj1jPrxu/qHhl2E1nYpT4OuhJhE61RcDTZ8+10PJ2N9jsZ
 dXr8wE62fo84k/VdDcoXljA1Vl4CTco4PBQWzvTfpR96W8xQp23yEI4aiEqiT9dJH8UNViS
 LmvoOj0AbxycHXmeFbpNg==
UI-OutboundReport: notjunk:1;M01:P0:zSs1X3od1UM=;50UtiU5PEFqbpBp+t0vuIWXLgyW
 a3mMcTu2My+XaS28YjykZmKNbHVp24MtqrnNhK+ddJ2li1Q5KNEZyEFD6f2HPOfjb86p6FguU
 s8bo45HprpIpVyhCleOoyfsYLChl+XgSBu+3q9ZPlh9QeniUGCTGPDs0BOXx1O0PVfZEB6OWi
 vfB/4cTAImcQWXyiiK9vayKsgcUdwUfEgN6nV91AMyqkhAdNsQ2qwMfxq7RDsDCxWCwReJQw0
 Bed5p2d8EDWcWRvee7pxw0flHoEKcIBVd9x66ZPnO+oZK4IClEHEGHVuZ7/1LtUcnLtJp9lKS
 tFpGDpP+t2vRnmWaTbwu9eHnzuXYqhqeibVhnRSWli5zWKvPLI2hnk389roaSsesvscmi1s5F
 3KhmMY6IyOyD7fSNkt6LBNNyubEoBgf1f9AsGFhPqe1hW+plsQGjhE2W2fu2vTraW83iVg5gJ
 X1fmvC4TBsUHg1r8Bv2CkJKpQHwC00rgaSIFaVgDXd92CtFMsCpWpIS+cozdUzq5PYj2mLtCy
 nGjv60ijz0A7NoWo9lfaiO3tgJ3KV+9dxI9FovabRXf+Ryj/NOUFyC/E5PXxpCWwty4l1WLIR
 yavguvwZikEBC3kLONw6BXD38J2dGaHdbUh263/LnVLjL9XSpjdOvU1oLSd92C2ilqkj2b+q9
 2AMtItNL0DgJ4thBlvMZB2c8hgyPRfry4t7G4Hj4NVH/Ak372LCoo/9dQZkdP/nLdFtEHH9LE
 /c7yNQCF0h+aY5t0SyXt0G2Uw63/PbQ7QnHu2kTCMVja3DWy4QftPTIyl+TgANihsqex57wTX
 dsK27N34M+eMgIeIMFT/HpICkH5SBjJ53W7JM1MLDr56zn1o81WsJFYn3b3WiSCyrgmjTGpyW
 lxIfcGEQLeWuGjUbSKFYC5KUsSxKkfs8tzo/cTUIMGmlak0ZxF6nW2AXqIKPPHci5Cw0dukaG
 r+nIpQ==
Subject: Re: [cocci] [PATCH 0/2] ARM: Adjustments for init_atags_procfs()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1447
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/b3c42397-c879-4381-aa96-c7887e81c068%40web.de>

> Date: Tue, 28 Mar 2023 19:06:32 +0200
>
> A few update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (2):
>   Delete an error message for a failed memory allocation
>   Return directly after a failed kmalloc()
>
>  arch/arm/kernel/atags_proc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Is this patch series still in review queues?

See also:
https://lore.kernel.org/cocci/2258ce64-2a14-6778-8319-b342b06a1f33@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-04/msg00034.html

Regards,
Markus
