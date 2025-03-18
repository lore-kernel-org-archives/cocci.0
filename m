Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A85C35FF8
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 19:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jKvx1tQY5iHKh0dcLdhcAtIBq3PRAex85dXOvmmGNl8=;
  b=lF25lJ4CwNNgVzEp2xIQeShp6/wmjIPxUpbOE3Uig2gE9ibHs6DNAWs8
   f811DtukoGWcszluhAOP/iYG+BwmO6GFzrOACinQkuN9djy7yJgBRNkg0
   DtK3v2K9T6hqgyPSW2ScFRR5KyWz19b4kHatDZDAo3P4HPKjihhs7cvc0
   A=;
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
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213568356"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 20:18:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CEB0FE0261; Tue, 18 Mar 2025 20:18:34 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 608D4E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 20:18:32 +0100 (CET)
IronPort-SDR: 67d9c707_r2ofrUW031d9AR57ocLQH9X7B5sXyf0beIDjgMAAH3ALnLS
 IAkC/DqtWYsY0uYGFzecHEl/J5YlSmBxSm/FzwQ==
X-IPAS-Result: =?us-ascii?q?A0FnCQBmxtlngAQP49RagQmBU4JEgVczBAtIhFaPUIF0M?=
 =?us-ascii?q?IQ7hzuHU4h1g1QPAQMBDUEBAgQBAQMEhQACiyACHgcBBDMGDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAkdEAQEBAgEjHQEBEScECwsaAiYCAlYGARQBAYJ+gjABAw4jB?=
 =?us-ascii?q?65jgTKBAYIMAQEG2lwfLCJXgWUJgRouhW2CYwGGJ4Q8Jw+BVUSBPIMDPoRDg?=
 =?us-ascii?q?1uCaYIzhENniVGIVodUkDRSexwDWSwBVRMXCwcFgSlDAyo0MSOBIgU0NA44K?=
 =?us-ascii?q?YFjaUk6Ag0CNYIbJFiCKGoEBYEkgjeEPoRBhVCCEYFdAwMiAYIwb3UcgxM1d?=
 =?us-ascii?q?j6EZC1QggkdQAIBC209NwkLGwY9o2fOXTQHgjiBZoFjDJ9eBhMvg3ABk1UOB?=
 =?us-ascii?q?pJ9LphQIqkRgX0kgVwzGiSDNk8DGQ+STrRqQjU8AgcLAQEDCYVGAQGKVIFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:s9IcUaxHs6iBcmbpZhh6t+cJwirEfRIJ4+MujC+fZmUNrF6WrkUCy
 2pNCD/VO/eJM2L1LYh+aY7n/UkDsJPRy9FqGgFtqVhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgmIc3l48sfrZ9Us05aSq4lv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFPA2/J+VlgYIbEK69ttDSZ09
 tZILi8kO0Xra+KemNpXS8Fpgdk/atbmNsUTtxmMzxmDVKxgG8qcBfyXo4MwMDQY3qiiGd77b
 tAadCEpQRDOeRxJNX8IBZh4kOrAanzXKmQB+Q/N/PZqi4TV5Ah1/77hP/fqQfuTZsFclWS3m
 G/g202sV3n2M/TElWrdqSLz7gPVpgvwX4kZFZWj5/tyiRuSwHYSAVsYTzOGTeKRj0mjR5RAJ
 kZS9idGQbUOGFKDYsH6T0ehjmK4rA8hQdYXKe4QuAeS4/+Bi+qGPVQsQjlEYd0gkcY5Qz02y
 1OE9+8F4xQw6dV5rlrCr9+pQSOOBMQDEYMVTQMpJTbpDvHmp5wvyA3CRJBvHcZZb+EZ+xmgn
 FhmTwBn2d3/aPLnMY3lpzgrZBry/PD0ovYdvFm/Y45cxloRiHSZT4Kp80PHyv1LMZyUSFKM1
 FBdxJTEtrtQUc3dz3PXKAnoIF1Pz6nVWNE7qQE/d6TNCxzzoi7zFWytyGovfRYybK7ohxeyP
 BKK4Gu9G6O/zFPxMf8vONLuYyjb5annE9P+HuvZBueikbAhHDJrCBpGPBbKt0i0yBZEufhmZ
 f+zL5zwZV5EU/oP5GTtHY81j+R0rh3SMEuJFfgXOTz9geLGPBZ4iN4tbDOzUwzOxPnZ+1qKq
 4YAa5XiJtc2eLSWXxQ7OLU7dTgiRUXXz7iswyCOXr/TeFhVCys6BuXPwLgsXYVgku4H3q3L5
 3yxEAsQglb2mXSNe03AZ2FBeYHfe891jUs6GigwYneu+XwoOri04IklKpAYQLgA9c5Y98BSc
 cUrQcu7L850emz1wAhFNZjZh65+RSuvnjOLbnaEYiBgXptORD7p297Dfym0xhYvExiYiMoai
 J+j3zP9XpAsaVlDDsHXSfT31HK3nyEXt9xTVnvyAOt4WRvT4rkxDhfunNobHtopKyif9gCF1
 g2TPwgUldPNr6Ax7tPNo6KO9KWtLMdTAWtYGDP9wYutFCyH4Fem/5BMYNyIcR/ZSmnw3qeoP
 sdR7vPkNcw4jER4iJV9H5lr3JAByYPW/ZEC9TtdHVLPc1iPIZFjKCPf3cBw64t89oUAsg6yA
 k+y6t1WPIuSA/zcEXkTGREEa9qS3vRFixjQ6vUIeH/B3hFVx4bec0tuPEirshd/fZ9VK4Iux
 NkztPEGszKfjgUYCffYryR22VnVEFk+ffQJipUoDrXvqDIX8XBZQJmFCibJ8JCFMNpNFU8xI
 w6rvqnJhpUC50zOd0sySHv/5stGpJE0oBsR5kQzF1eIvdvkh/EMwxxa9wosfDlV1hlq1+FSO
 HBhEU9+NYGi2ihOv9dSeVysFyVqJgyrymaox3QnzGTmHlSVDErTJ2gDCMOx1UE+8VMEWANE/
 budmV3XYRyzcO7fhiINCFNY8dr9RtlM9yrHqsCtP+KBO7IYOTPFoKufVVAkmivdI/EapRP4/
 LFx3eNKd6fEGzYaoPQ7B6mkxL0gck24C1IYc85x3pEiPD/6Qy6z6wisOkrqW8JqJt72y2GaJ
 fFqBPpyU0WZ6H7TgBEdXbUBMp1lrs4PvdAiQI7mFUQCkrmYrwdqjq7uyzjDtDcrbelDwccZA
 aHNRg2GCV2V1Cd1mXeSjcxqOViYQNgjZS/g1ruLqMEPG5YysbxvQ3oTyZqxhW2eayF8ziKXv
 STCRq7Y9PNjwoJShLnREr1PKgG3CNHrXsGa2VqXn+UVSOjQI+LiihgwqGS7Dz9JPLAUZct7p
 Y6NvPHzwknBmrQ8CELdpLWsCIhL4p+UcNdME8eqMkRfozSOaPXs7zQH5Wq8D55Dy/FZx8u/Q
 jqHeNmCTsEUV/hd1U9qRXBnSThFMJvOb4DkuS+ZhNaPAEJE0QX4cfWWxUWwZmRfLiI1K5nyD
 zHvgMmX5/dakZ9tASEVDPQ3Er56J17eAZEdTePTjgXBLGeUgQKlgIDAxCoQsWSBTjHOFcvh+
 pvKSyTvbBn46umC0NhdtJc0pRENSmp0he4rZE8G5tpqkHaAAXUbKfgGe4AzYn2OfvceCLmjD
 N0MUIcjNck5dTFDbAm6/9npGAuSbgDL1hEVORRxl354qQ/vbG9DPFel3jht6TF6d1MPCcm5f
 MoG9CSY0geZm/lUqCV62hB/qfhqzLXWyxrkPKw7f9PaW34jPFnB6JCt8Mehm8AK/wEhWXgn/
 VQIeF0=
IronPort-HdrOrdr: A9a23:6bJYC6tNe65HkR9Sy/nsKeQ47skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3A7xCyMWtsfcSev/cLyHETizrZ6IsJanrNlm7+P3O?=
 =?us-ascii?q?qGFtzRPqvSnXA/rxNxp8=3D?=
X-Talos-MUID: 9a23:FiRn+QoYrXQUn7V8CCgezzVmG8Fk7ImRM2cUspEPsOurCyFWHx7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="111950145"
X-MGA-submission: =?us-ascii?q?MDG9VzUREzHXJBOsfegh7eHTuIJg2A4lWWVM6A?=
 =?us-ascii?q?puqUKoYhHTAmH/JCoJ1hLa5FA4d47S3PHgEvjdsYM774vjQu6jtHDaP1?=
 =?us-ascii?q?L3MEtpDJRvHfXFQJzNJzadLj2WPshKMdvyVKD/abEn8glFur+zM+PWsu?=
 =?us-ascii?q?4zaWnbYNaeFk1xdJq/f2/c0A=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 20:18:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742325510; x=1742930310; i=markus.elfring@web.de;
	bh=jKvx1tQY5iHKh0dcLdhcAtIBq3PRAex85dXOvmmGNl8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fBg4wbCncaGmm5mg28bzSodTU0smXYn9J4xql5DWydu9c02cZxJV8oWwYeYaouPJ
	 SALK20zH5IjhMYbSZL4XleKFaR+PLtOvCV9FhA+26IMPImDjSCDindhkMktrm50lr
	 qghftxfkYinhctt9z7WIBFfu5f5dG0RLrJe2S3P2lj8gax+OgrcWcIZYiwLqpBQxZ
	 FIA47ueC8I3qlgbPhKrIUhLiRaSBB60jnQbWzEsuI58CFOZOeNDvNFINt/zHeucXv
	 D5D0XT+9FeMil130oFYmHCvE/ILmyjxSUfP1RrZsM0m3KmuwuPjB0kbr8JsqV1Spz
	 O63GtDxTKHoWqG7OiA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.69]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRQJ-1tG4ug46RT-00eVtU; Tue, 18
 Mar 2025 20:18:30 +0100
Message-ID: <12c97288-7c3c-40e8-b901-1ed7fdc12ca9@web.de>
Date: Tue, 18 Mar 2025 20:18:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kees Cook <kees@kernel.org>, cocci@inria.fr
References: <202503171135.B1CCC51FA@keescook>
 <d8c968f9-db1e-4127-86dc-e9c42abf0806@web.de>
 <202503181101.71E61D5FF@keescook>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <202503181101.71E61D5FF@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DvRO/gWgmyeYXYVjqvzHUM893WM+MgaX7UzedMXOnp1QIfTIP8d
 Lz2nwvpGjO1aX986axye2+fRVjA18IHXtHBZ3pzJA6MhEi4VI3gJ2NadTMBuFPEcNcz9liH
 6cRxS6HNPfd+4aUdEkvBg3ByzKvQLDFDqUMZ2+NsnG3wFdZ85L5fjkFs6asLlu4CnlhnxvY
 InZQOlAC8z1plO3LrKRaw==
UI-OutboundReport: notjunk:1;M01:P0:k+WBXOYyq2g=;zAUXLzzP2ciatmw2DYOcY3iG3DH
 e75IqiaXB0MTKE/u2oy9q4rjp95IolN+2TQQngNArnICKTUvOeclhW/Dfwf7jQY6gDvp6r50Q
 aoqVDYyZsC6rO00P31hnvcxtl22RdohLbjyMyxGqPP0MZtRnmo9cHGAc/mloRdnhidYM9nIi9
 EYINxLXBOsz/zSNnv8vxAMMD1R66esa2fFxcYPoeQYBziGkvT+dRyHIOPkG+HVEAcw8fLcrS+
 xO09SqEhJYUh/2p3d7pzF6rJ7uf95YjbE7z0yxr78G7gkHBooMiCEPRsc1ISHiKUNyJ09fT2e
 yeEZv9WR5QJQjZlF26z5lcq2ExN5PC2dfrkvQjVK/6zC+zIasZ8I3uHoKxDNxoNZRv/yE3Bah
 4Gk89ZYvxy0wonkECAV4I9Af2oTA+QJwPYsmvaOdBFzEQNKFXzHSoeDvzuIc1agPUI94IsyD1
 xGn5+WlpmNwMNW7nFX9zN9YouzAKENfyIQsZ7dIDUiTK6r3Gin2mwqk+cry1uPtPPFW1GgYsq
 PPr3Hp203mm2ADAe4QI4j9fot9L/uVeEEjHU2bcChq4SqRO9K+KdJsgfzV5VdblcNdH427HXv
 26oU1B9xjTHcl3a8XIu69ZQP6obBpsL8ajWoQxQu6loEGEBq9GUedlXr9445eF2w1lh+CCJQF
 0ROk/arH6+dFkx76892nWMzzHh/1klS85AdxlNEOLljhqvzyo3v+/7yN4gc8KVjvWpyxawZoG
 UJZ8JJcgxQu+4+/0l5HqjvnO1/QLb4VLjbq6Zyx86egfcUqN8BzXi+kvz9SP3U+RO3Vjatd0e
 p35mroze0Q3fqfb1OPxSkGEwSlId/7tx1+f/lcZzQY4bDoL1dbJamHd6LMu5Shp6Og7lCsDqX
 9VzNyveKPFsILCkS9xKWoNyJPT54Cwi5YNFB7+GDL6+8Qxa7ZJGJqORlSZBO0+3SDnEIgqjS5
 xVKmxUewUaIO/caYNu5ggadE6Y7Sx9Roc+DXaQIvvv+xRKUOakoPTYPhGTzhV9p2w+xXOqqSq
 AMLV59U+G7cluPQ882+PKYpQ/8fcT1heaoY3ZW5tusuwi7NBfetfJny9REOjex9S4UAXy5yzh
 zqaA4hLIsQi1ZHB49OAECJtuFiViI4h70ZF0XHlu+368DKTAMgIqPKb6ZFGSdsxRwXoeQXPp4
 8ZH9Tt31c7yIWLpnMljR4fpmg+HNtkjugYnpVhLleuwRhTrYNd0DQJKCPAcPbJRj5RcVxFoAk
 jTHZ8cpXTqhuLCIhIV242pOhTUqL9WGZ2nZMot33IXpOI6D4hYb6xZcaq61CbwcLlKWmGmO4W
 9EKjuNvzuGHmEjDG+sYCWoxfG4/GKMp91wgwVpympR6+t19svZC973KkkkhdX5cRSyfGrdzG6
 3dd4V0r0+DvM9t1MdRn8G4mTb0k2hRsMjCM+q0M4RmNGbAd4oll8wrkERfNeBm9BIwklXodkw
 RVHEhKGiFUVrD7cpLXAj72+kHnIBrDTdv9uU4zQ2XWqZmBpH5ziYEcAFH3dtUoJ1h+J//Gg==
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2630
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/12c97288-7c3c-40e8-b901-1ed7fdc12ca9%40web.de>

> I was showing a simplified example. I am using this, which I find more r=
eadable:
>
> -	old(\(COUNT, sizeof(*THING)\|sizeof(*THING), COUNT\), GFP)
> +	new(*THING, COUNT, GFP)

Such SmPL code variants can trigger different data processing results so f=
ar,
can't they?
It would be nice if really desired effects could become clearer somehow.

Regards,
Markus
