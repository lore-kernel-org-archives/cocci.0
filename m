Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01ED8E77184
	for <cocci@archiver.kernel.org>; Thu, 19 Dec 2024 19:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=sOp3gspRiZxAaeqgI9ZyoLabYcKvfO9YJUPaxawoSvY=;
  b=oLFQP6MMip5C1YuDi4HXnunO2LJjkf8kOgMv1aUpV04CPnI9y6KFEgaC
   /k1i6gEzrhHD2ciUpTeOEzCntNc0UkCh33l6Sd3CilQ1yJu9gamu6IrBz
   fiReBXdBb1JhjUWpg1koMTBqCKE+JkQTxH/aP88EPGo63SzwnoRuJUPGc
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.12,248,1728943200"; 
   d="scan'208";a="200146405"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Dec 2024 20:55:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0F480E007A; Thu, 19 Dec 2024 20:55:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 29CB3E0077
	for <cocci@sympa.inria.fr>; Thu, 19 Dec 2024 20:54:57 +0100 (CET)
IronPort-SDR: 67647a10_MtIeskLcBYp0muhk2IBVD0ZQagKCWWHmkpCFDAyUxJ0mtXB
 uhxNuxlrFZa5aiL4dlJt/Relg8K3/2MAOynTb2w==
X-IPAS-Result: =?us-ascii?q?A0GUFABZeWRngAQP49RaHgEBCxIMQIFIC4JEYiFUMwQLS?=
 =?us-ascii?q?IRWj02BdDCEO4c7h1aIdoNUDwEDAQ1BAQIEAQEDBIUAAoptAh4HAQQzBg4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmAQQLCQIaAiYCAlYGARQBA?=
 =?us-ascii?q?YJ9gjABAw4jB5YxnEWBMoEBggwBAQbaWx8sIleBZAmBGi6Fa4JjAYYmhDwnD?=
 =?us-ascii?q?4FVRIEVJ4MDPoRDg1uCaYI9gxWCZGeKaoNThVWKHlJ7HANZMgFVExcLBwWBK?=
 =?us-ascii?q?B8rAy42MYIFgVsFN0c6ghBpSToCDQI2giIkWIJNgSUEBYEtgj2EYYRWhhqCF?=
 =?us-ascii?q?4FoAwMWEgGBNh1AAgELbT03CQsbBj2deoNhgSmDD8VZNAeCOIFlgWMMn1wGE?=
 =?us-ascii?q?y+XQw4GknqIKZBSIqkIgX0kgVwzGiSDNk8DGQ+OIQwWhAu/EUI1PAIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYltLQWBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:26vYHKEpYq87O+Z5pLqEPMeALOsnbusQ8zAXPo5KOHhom7+j5q
 WTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AZBUsLmggbcECtqI7aDvHe3KhqDJubXDYwXHUGHa?=
 =?us-ascii?q?EWE1LEYGkdnaV2Z1jnJ87?=
X-Talos-MUID: 9a23:KbYZLwmZ7CcgPxvDQbPWdnpYP+tP4bvpK3k3kJM/gcigDyhbESak2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,248,1728943200"; 
   d="scan'208";a="200146394"
X-MGA-submission: =?us-ascii?q?MDFJsJHR98S5UqTyLjWb8+Xza0ms3HHvBMVTsE?=
 =?us-ascii?q?0BmXgJcPYypoeJLj5y/W23e7im5XgTsbegpiy+zVt7mvY0JOtAb9iJJk?=
 =?us-ascii?q?aQGKcUPX6fSApML1UnP9iLOC4VydkDAzdlt2US448Rb4MYXODVes0Q6H?=
 =?us-ascii?q?dv+FYdmrQYRfYWwpUK2xT7DQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 20:54:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734638095; x=1735242895; i=markus.elfring@web.de;
	bh=sOp3gspRiZxAaeqgI9ZyoLabYcKvfO9YJUPaxawoSvY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RSrVim75O5RTrxpS/29Dz7ZhsHRWcMIpGf+TtVaT1LM/jol7IIAEbaNkhqw7eDK6
	 jygd0Rrp4VG2GuSvodmgT7cIp/aWSE60IX2O9R3x9XJLnrAszC6Si70YK12eiT/by
	 Ebl9kOqtnhtGs7OW8r8q9TkmCwRmNJMLagxqMOOOI5eYvB4xGfqTLS/8f/h6uw2ep
	 kNhskZaJcVz1N76Tuf6YD5TgM4WmGPX1Qk9DvCc8fGwbNXgrgX4GWl++aZ+M2c5SZ
	 Z6PGBCkdw22QqTJZnUIq2t/tvK31MKaMWVoS4zEGciPcJEO11zG396h3te5kaL1mp
	 Q9x2uOZdOgWDA4oDKg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.70.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRQJ-1u409Y1PTz-00f3Ty; Thu, 19
 Dec 2024 20:54:55 +0100
Message-ID: <9d5bd555-37ce-421b-b8f2-a743e8151b37@web.de>
Date: Thu, 19 Dec 2024 20:54:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mats Kindahl <mats.kindahl@gmail.com>, cocci@inria.fr
References: <f0764391-b0d3-48fa-8a54-6edddf8d2c8d@gmail.com>
 <da51b2de-12cd-4aad-d989-79e925ead01f@inria.fr>
 <a1e9628f-4d97-4fe3-99d0-585a0196d988@gmail.com>
Content-Language: en-GB
Cc: Julia Lawall <julia.lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a1e9628f-4d97-4fe3-99d0-585a0196d988@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:90X8EA6soZKHsml0C/06sFiRfCggLN2ky/E+0w8dDOEpsKqlCyo
 zcQJInHFpPYuIPsDyP/ZGiBDBzN9cUXk70uemrSo+Hpdfo52OMVQ2/8TysZMOewdpDAuYGT
 b9haFVxCM6V/oSiU2U3kxOhbV2yIYQmG0Xpwd7e3X/gZSsoWRFARlaCG8H9HxWj5GzUz3lW
 0yaaL/+/i1mnCeHwXo1JA==
UI-OutboundReport: notjunk:1;M01:P0:Cv/TEXbGVEY=;pl5RHj29QanK3nzy26Y0uA3PK+K
 s3PqdUb95E8ej5MCWewXwJx6vsppzvftP6U3LCdUFAeiNt01z8iSi/CltPQ/L623wsyaxuoxL
 YW35k5wehbYe3PIJdjS99TjAm3pP5VvoI30Ch/TINrl4zjLmRBN/5GLHm5W9nbOO/qjL02dv+
 losK3sgftqYgl+pLri5WY4y8WcrL8WkqXNb69D303Fn/zToHl1+k9qqUWoZPDbtApYvhLkaox
 wwRkhoX8ZExruVW/FXnyV0ikdOPCGOTHGOlPcD392CvW9voIM/8umbhderEyLHMxrB8zJWMMo
 ghXusU5ATIMpV+5N6SFvyq8HESVIaYx9mwPD29XDF1CRgLkV63lx2HMXQ5gcrvMcuhx48w7Fa
 HPfVPPy7+NiylxTCACG4HRkztqpYQKiFh3nnS5Mp8xRa2J6esYMTAh9XnMhADjf2QeOk3rajm
 x4P1/xplrBSsTYUDk/bJkQd/GetIkGbXEOIfrrSn4RxxBAMHFDOm5fJg2pRTsMG2BNSKZUzIS
 0Vm1j7QBUFm16RuVrJamcwlxgHcjpE3eXh5hiA21Ce27vrFLWXT1VB3WiKLBwVZQWUuwNW4mv
 OE6rjYApSkQa9Xmj3OXFDekc38bZWor7V7AXnMyHO1Fl6wdYLpo3fb0QVgOa92bsNgp4r0ETx
 0V2hIWjzAW9oLJoSW8VOiHdtZ7CQThVD1+BjlfOKAmE9vOIriOgvZyW6qjNfSNn5E/qDJyEEP
 3KyvKHa23kDB9kq5Jmk31k/xyTJq5G8N8n1YdtFrHPekVWr0iD57qqhj0hIF9A5pOGsiYc7CJ
 9pAgGbfKRoLdSEmG+eo+hdMrUiq8gWkSE+vFMjqCryOyP/FAWQu+zm7tMs/4hlNTFRXNtbeuQ
 0qvC5ve2/mafucce3P9WhI3D8AwSI1kwlo9rjAw+ngN4FoBEzyqjlQEB/NeBR1MLzdvbVyIpk
 8GkHGdFpW/HuSkSEdzfgrJsf3barSob53oDVtlbkqx4TXRoTP2SYPezwWDl4HVvubjyg1qCbQ
 JbcA2NiUpj7dZzlKuxthe6ebMFmC5doHWwvNQPl/hxuU/kwxZY/TnGRwXPzYrnWb2dO14515w
 Yn8Qu9WN0=
Subject: Re: [cocci] Depends on with negative matches
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2189
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/9d5bd555-37ce-421b-b8f2-a743e8151b37%40web.de>

> It worked for the example I gave,

Nice =E2=80=A6


> but the "real" code

Is this viewable by any public interfaces?


> has validation functions rather than comparisons with NULL,

How much will such an implementation detail matter?


> and when I tested with that, it did not work.

Will corresponding case distinctions be reconsidered?


=E2=80=A6
> Here is the new version of the semantic patch:
>
>     // Capture any malloc() to a local variable
>     @r@
>     local idexpression var;
>     position p;
>     @@
>     =C2=A0 var@p =3D malloc(...)
>
>     @@
>     local idexpression r.var;
>     position r.p;
>     @@
>     * var@p =3D malloc(...);
>     =C2=A0 ... when !=3D false !PointerIsValid(var)
>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 when !=3D true PointerIsValid(var)
>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 when !=3D free(var)
>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 when !=3D return (var);
=E2=80=A6

I would appreciate further clarifications of previously mentioned developm=
ent concerns.

Regards,
Markus
