Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B579DD3ABCE
	for <cocci@archiver.kernel.org>; Mon, 11 Nov 2024 17:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hzNVM6fF10a2YiLQ2uMDBEIUjoQrsJWohUUrMbJ7WNc=;
  b=IQ87nhX+JBsLb4g4d1nE43jMY8mR/KLHHQlQclVomTOad7PQqh2VjXIq
   9uf5ELLEkbv79Lj5Glma7L3fo4YeVUFJaBW/8J2+pT/9CXK3w0A6vCMbq
   aPqhfeJer9r3P8Crtcbh0aiNmS7wp84yP8Smc08AZkqNWZCwtSYdskkHV
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
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="scan'208";a="193200350"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2024 18:01:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E3EEAE0D1D; Mon, 11 Nov 2024 18:01:58 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6B5F7E00B7
	for <cocci@sympa.inria.fr>; Mon, 11 Nov 2024 18:01:54 +0100 (CET)
IronPort-SDR: 67323881_i3jN7FZMDXorASMJbL4kcNBQgScGKAsumso+km+FO9wk9pP
 2NUC0vzW+JtUdCXylG2yct9OpNz9BTUIkBlaRfA==
X-IPAS-Result: =?us-ascii?q?A0GlAAC9NzJngAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDYiFUMwQLSIRWkUEwhDuHOodViHWDVA8BAwENQQECBAEBAwSFA?=
 =?us-ascii?q?AKKOwIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?TsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLC?=
 =?us-ascii?q?xoCJgICVgYBFAEBgn2CMAEDDiMHsFaBMoEBggwBAQbaWx8sIleBZAmBGi4Bh?=
 =?us-ascii?q?WmCYgGGJIQ8Jw+BVUSBFSeDAz6EQ4NbgkcigkeFHCWILWiYWVJ7HANZMgFVE?=
 =?us-ascii?q?xcLBwWBKSIsA4F6V3+BOYFRAUKCXUqDPIFeBTdJgkppTTcCDQI2giQkWYJPg?=
 =?us-ascii?q?SUEBYNvgQuDZIRngiMdQAIBC209NQkLGwY9n3SEPAEKlWmyeTQHgjiBZYFjD?=
 =?us-ascii?q?J9VBhMvg3GTTg4GknqYdyKjP4VCgX0kgVwzGiSDNk8DGQ+OIYQtxR5CNTsCB?=
 =?us-ascii?q?wEKAQEDCYVGAQGJb4FLAQE?=
IronPort-PHdr: A9a23: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
 QPNo9Qor1z0yoFnKxJiVwdS7ClGjsSHsBc6UZg=
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:JNxwNa4f3s59tqnLbgPXwBbXdLJyesId70hD6qkDc20xTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ8+6U
 4KSchD4bPLfDtHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-Talos-CUID: 9a23:uslmG2OIVqOTGe5DUSBdrRcZJc4cez6C9W7LDU++M3hqV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AkkYmIA2W6wLdZfCQcnn+Q9yMmDUj7pmBOlgGqqk?=
 =?us-ascii?q?9kOa0CyhdNRqHyzeGa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="scan'208";a="101280714"
X-MGA-submission: =?us-ascii?q?MDGQSr+hWRXOF0Vx0KjYobm/xYoK4/rCiSMZHG?=
 =?us-ascii?q?4ktaXFSfIigMpUXJ4QG3szYhyWhYSrq9kYHFceA426rtQ4xV/Iq45Qmy?=
 =?us-ascii?q?AzB641zaccHMem3yiVF8R5JY/iqob5lUF3NvbmylyCzNuZsiJza1SjqG?=
 =?us-ascii?q?Pe87Z45UGsxr9y4soTrA44Zg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 18:01:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731344513; x=1731949313; i=markus.elfring@web.de;
	bh=hzNVM6fF10a2YiLQ2uMDBEIUjoQrsJWohUUrMbJ7WNc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=T87/+gb+shrMapXpnqP7wXufti35ynkujoaF3DsumsH1jWSQOOscm448m5ml8Zko
	 aQuqxJ8FobwToTExEOPo3+2H1vOOP/h7NXbK7XTYIgfHhLwkMexW257ad3MDKGEwA
	 3UxHxU6xdMWqX0Xd4Nm7dqFApQVnlUKO1HE7rVgFZGGbOQidGVeKN6aWnIxm0x+nf
	 0m2heSLu3zVF9j5w2gjX6KDIV8+zxRj9j2/DSV9yARMhZJX6rszjCFRQbhp7MAgaZ
	 yZZK0WF4mxKXn0Y5dj+Ejf6anUjEqxw+zyBGB80NLA7mlIzacqk9jTSYJBnryB/Yl
	 uYKSMoMtfPK7JwhQqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvbik-1u26SM3pCg-015YNC; Mon, 11
 Nov 2024 18:01:52 +0100
Message-ID: <1ecbac88-9afe-42a4-bb46-de3abe59b500@web.de>
Date: Mon, 11 Nov 2024 18:01:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michele Martone <michelemartone@users.sourceforge.net>, cocci@inria.fr
References: <2406a49d-1609-4af1-9af9-ee3496e48606@web.de>
 <20241111162413.GD10291@localhost>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241111162413.GD10291@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dx1CZ9Q+KcuNplsPy7b90bW+HOs4fUi+wg63OGqW0j0XK95eeDu
 qvXRw8BKXgvZphNvTEoH3bJmQdMHNqyjKisOovDvHMOb22rZ06bj/L1UIZgP4DwIv2d+20G
 H+tobO3N0RVAO65Z2NQ5yCtvjboowpk6iZoObPo/4pR0EnXp+48G3VRzqPD7O1KhpO+IMyC
 JrSoNbiQe5J1Dd+ewjAcA==
UI-OutboundReport: notjunk:1;M01:P0:v0s1vwAugWA=;evgEH3RaJaPPOwrbYhaUuvRw0pY
 Hgy31EitUlFdrvjP5Md06E1MwtE6x44S5RZk3abTn4uMeGuBeOB9NtOrZYHOLrSBwPJNXdUhn
 MhjLam90L0Wyw9ZQFt96XxkUEaujdbSLJRHYJW2aXer4Vd0jjH7bpMrHvzMhTSIfLSwh+5NgV
 wvob6270MCjP3aDeS1CyqR6ZOWBNNb/PvoOswfDHzqIiU1iTLau5ETknTZOrLBj/sU41KG0wy
 JvYRpf320sIBJnpmuX1IhJ/DPh2rsQnS9xVVlaI2KvTPVYeo4j+97XP8Kft0lnIg8XMdVwXfv
 H+ilWeTHLSYwKbBf7OazetxPvgvj21uAMq0u5DGa6BHT6oAWPqQAG4ELCFtTwE/2Dh+Lat+yv
 LUEd/7p/gOj4rbgdutruF/rV8xwKoXw4ciJgslKRp9oXNE3Dqpx1ksx4oBBAT1ArruEWktX3U
 VbZJ5NXVgb4TWRPcF3Hzg+FLJcHUVTrb19NNYJppl2FTH1DNLmuUigVYri40bHCTYX+y4b9dC
 H2pSxYS4DnvP3QDzECbPuT9bExm3eZbY2P8a3/udHf8blqMXTWVD/6jjY78CNiWx7DsSm6ZcW
 w+Dsf9V0ll23oAmADTn44CdehgolnlZ4pAxjtcF/jP4MPHQaD5PooDsUMC1LWcwquifnJpwlr
 2RZyUAbhIvDyPUEoFVkKQRmYz3xz4gx3Dc7mO55P93Tj/iYZx3ylyBKkz0vAwwVtPts3WoSSZ
 geVf8uHzuWvv055C6OHWWsBnGibu2dx6SUTRaXFS0trMdrHIJNJsxkPKiZRyq+6tEElAFHvjZ
 4JQEN8GjjbvgSpx3GNqbEkpA05xDfH8D5WF76r+r9V3zLHoEz5gGy+VXzvp4ldsS0/DhJI6X1
 Q94PJV2uhThifW0jgpludcYzBfg/fcdt+g95QOF4nlllj+NseYaapnFDb
Subject: Re: [cocci] EBNF for Coccinelle file formats?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1988
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/1ecbac88-9afe-42a4-bb46-de3abe59b500%40web.de>

>> Will grammar descriptions become available as extended Backus=E2=80=93N=
aur
>> form for involved input files?
>
> Such descriptions would have half a thousand of productions

It is probably unclear how big a related grammar would become.


> and still be incomplete,

Can such a development concern be clarified better?


>                          because missing token-level
> manipulations, which escape that notation.

Which details would you find problematic so far?


> Would that be desirable?

Would you dare to look for alternatives besides tools like
=E2=80=9Cocamlyacc=E2=80=9D and =E2=80=9CMenhir=E2=80=9D?

Regards,
Markus
