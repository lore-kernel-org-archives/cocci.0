Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A0AC48BC3
	for <cocci@archiver.kernel.org>; Wed, 14 Feb 2024 18:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=W4KWcIo29CFI0imjJ4atFRTnom9vOBaVL6FK+CddTWM=;
  b=jw0lSlt5eGglBiuUAr09lch+2LHhuC8px+QWxkkg3aXgirBSHxz5mN0y
   YK6/ewTUC/u6hA7W9SAJGhPGvL8H3rzDld72sLG9K8zVTOgiZZSGITuHL
   vWHm5ch7WIu23qW3OjDy54i66yz2a9evfcID7GwmB8tQhDrz4SxZSc72D
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,160,1705359600"; 
   d="scan'208";a="151997379"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Feb 2024 19:08:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 68B53E0CD7; Wed, 14 Feb 2024 19:08:26 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DC79CE008A
	for <cocci@sympa.inria.fr>; Wed, 14 Feb 2024 19:08:24 +0100 (CET)
IronPort-SDR: 65cd0198_QMScWuWHwZ8vRi+cT05z1eC0goapRiRVOpEYGhFXhHL5OV9
 Jb593blAUYBuvEgqbd5NcuLHWn9//C05KWjoFBg==
X-IPAS-Result: =?us-ascii?q?A0ELAADp/8xlhwwR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYI4f1MyBAtIhFOIHYcngXUwhDuHN4dOiHCBVoFAPg8BA?=
 =?us-ascii?q?wENQQECBAEBAwSCC4J0AodbAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBASMXBw4QJ4VsDYJcARCBDoEmAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBFwJHQgECAgEjHQEBEScECwsaAiYCAlYGARQBAYJ8gisBAw4jB7Iug?=
 =?us-ascii?q?TKBAYIKAQEGr1sfLCJWgWEJgRouAYglAYVvhDwnD4FVRIE8C4JABzE+gQUBg?=
 =?us-ascii?q?z2DW4JoghiDO5klVH8dA4EFBFoNGxAeNxEQEw0DCG4dAjE6AwUDBDIKEgwLH?=
 =?us-ascii?q?wVUA0MGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUAzgDAwYDCjEwVUEMU?=
 =?us-ascii?q?ANnHzIJPAsEDBoCGxsNJCMCLEADERACFgMdFgQyEQkLJgMqBjYCEgwGBgZdI?=
 =?us-ascii?q?wcPCQQlAwgEAyspAyF0EQMECgMTBwsHeIIJgT0EE0QDEIE0iiwMTwMZKx1AA?=
 =?us-ascii?q?gELbT01CQsbBj0CohiBV8ZONAeCNIFggWEMnzgGEy+DcpM+DgaRPYEhmFggq?=
 =?us-ascii?q?FeBZDqBXDMaJIM2TwMZD44gFwKEFI9HQjU7AgcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:cJW9P6ip0VBO55heDg4NjG1FHnBQX+d13DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03I+ervBEDmewKjyXcV2/hvAV7MZnidhILDFvAB0WLd+UypJ8STzJ866U
 +PG5IOfOEZIzBB/LDHCSODYqQdKODuytHeuQ81p00dBD2CEpsQmjuRaTzrbnGeJjM2eKbRT6
 DslfavzgDIERh5DrXZdxx1O5mlmzDSrvPbiHg9dmUaAWG1/HmVAZHBYlOlN3wlIkpyKNkZgB
 D4e82Q3NTTjxiO8G6Q64af1eUUpPLRjv94QOCcgMkcLTvhziyyYp56ZrGEtDcp5Mmy9VcDir
 D30k8dFvU2z0mUUnC+oBPr1QWl+i0p8WXexViRhmamidDlRQg9F9FKietiA0LkAnIbzYpBOZ
 9wriWkXttsfFf9dR3Glp31vsRR5wyJSDQZ4LQuZkdkIMUjgY9q3MAiFXxuYdg99K2T0vFWLA
 BPNrCc2B8ESyLbU5mehBgs/OCR
X-Talos-CUID: 9a23:B5kqV20Agq3vd8z5AuAe7rxfA5kncnPg3mfsJEKBAndxbpaqGXCM9/Yx
X-Talos-MUID: 9a23:A1UPXgbcLqWjh+BTt2TsnW5zM8lU5LWkI2EhlMk8pNGHHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,160,1705359600"; 
   d="scan'208";a="151997369"
X-MGA-submission: =?us-ascii?q?MDExjKKtBDY7fS9f7p7WKwPmqBPFzMhsgfTBRA?=
 =?us-ascii?q?pfK1BM/Rc63QSu/zS5YdytW8awYPahwAF5X3ctBn7SbICM2PqDv38+U7?=
 =?us-ascii?q?PBzI0TvXWqlmIHmn7Aw7oZ/TRYZt/xiyVdsDsGKWwG3v32fsRsCIMXIo?=
 =?us-ascii?q?0HbnMYMSuOU07i2TqP0d/JNQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:08:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707934103; x=1708538903; i=markus.elfring@web.de;
	bh=5vXByYVOws026ZeHpk+uwjgRpw1Fgfhz2PCgxoMQ/84=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=lY9aZsR+QoV8W/SwjqZX/oAo0aXMFpuHCtdr2j9BiNA6eIR+y9VulVajtoRUq32O
	 faJnq7zzc4MzESMX9eyHhBgMMMt2W7yNiXarF4fiYp9hXNkYHkPAXoxidv433dA1F
	 msQ6mErmX/3aE6woo6uVChxFJKqnMnjEPC8Z3zIAOwE2WMouWez7qbZmnyAoGoPOW
	 xuMJz+p/EK2EXEpOtxTx0bP2gfgpkn6Kc5IyQ3eB0QFkcLmAe0FRTfayrLexhSmv4
	 dg2w9Tk+DDkbSmaIISSNykAI39t/HPTT7YPhnmaQ7Su61uW9d2DWykhiLaLvrCaLF
	 eAxt4BqLHADAPX6Kxg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mv3Yg-1qjj3n2Qgy-00r2A4; Wed, 14
 Feb 2024 19:08:23 +0100
Message-ID: <186ffd15-1234-4636-90db-fd9e1f9a5ed4@web.de>
Date: Wed, 14 Feb 2024 19:08:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <6346056f-abf8-47b9-9024-ceb60a3f36a8@web.de>
 <alpine.DEB.2.22.394.2402132145410.5600@hadrien>
 <5a3fabb1-32a7-4c44-8825-70a863f76bfe@web.de>
 <631c5dc8-285e-810-16b2-b41987e3e24d@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <631c5dc8-285e-810-16b2-b41987e3e24d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9KdRwLR2gGiWsoogz+upqj0YAQOWc23TY+GL7b0qXNgO9j5XotL
 Ufq04DoX5NIfuPGKzo7/frRX59PIzSZsdR97cwDaXLuktjylSxUFjGF4CI59iTWN6CktWqJ
 4Cu4bWGSI15PKdt5aa3mudyGcErXGCjwb2MrhfH/s1k139v8uYrcGCDrGhY4lWsrkMd4yI8
 lACY6O9eTC21PPCq2RulQ==
UI-OutboundReport: notjunk:1;M01:P0:cGFISWjKcLU=;HTGjduaAketPdpWCkiGbQPmUcY2
 IYynsWb7FT+sxEdO3DLNRP8PHJ2zWL7wDfICZyK43xtijgZDWTlbv5i7ZzeUaOPUOZI77iKbb
 wjoWu7vBAmpXYFeop8/dycgJtngRa7morLLV+xWRig74OIwxfAF3+2SnbJxWhllG5x2W+Rzlq
 Tr12ww5wjyDBgZXq9c2+U+2R3qeJWfVnPgSx8CqnUPFSeYFrV9tZRRvlwBZMxSajs7NMzLBK0
 ivVrSjJzSY3Q+2QgGDnRDr2zuyNLQE0gltnFOV04ukpylNYFJfCM6b9kdBky9aW5nX+B2DGGp
 m1XE9uRRufvTTIjdu1LKR/LEgoNtylnsyEG+QYE+DFCIHD/yZUbhxZ8PzU9RkNNk3auRokFov
 OXRziUpZ19C0bSu9twYeqndg5WT6EPqs8+MrAZTQkpkrRKfOIKEjsXdCGd/W7praXkE73IzW/
 ePjnBjjTlmwq2dsGUMiT0wZ2424E6TogCU8m3OGrGRpdEaEs2EQ+Jo3r5HYxlLMgOoXIw6SC7
 LwLdwyFu63OwiZfZuKl4eTM+8y1qk1JrAzazy8HbQyrDmvhmfeZVcIMe7MAyJSFY3hyiOAkQT
 OxgSFZ8ItPCPyywh5/PeyYkBcU4dG22+Oy0MwmjPqqWyt4KO2aQma74U1bT/eQd8bW6mxiWw1
 pK4AWni/hd3+YIT7u1ciMvp1YXIhJeFGnUCLFH0xyB5F3UFlM70Yhl+krgYFPqNqHRM12NAuB
 I3kr5iZ6Lzf23MGnxq8Jtq+aM8I8d8CrnEBa6ihbX3k5jIFBEHubx0Bq83neymZkf7Md7Jvhu
 rp0SWW1Pbv0Tv9CDdrHXgHnMtCA8SQZRp3s5+tr9NIF+I=
Subject: Re: [cocci] Fixing a parse error for a SmPL position variable
 constraint
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1554
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/186ffd15-1234-4636-90db-fd9e1f9a5ed4%40web.de>

>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --pa=
rse-cocci show_same_statements7w-20240214.cocci
>> =E2=80=A6
>> Variable find.p2 in duplicated_code cannot be used as both a position a=
nd a constraint
>
> OK, I guess it is not allowed.  Actually, the semantics of positive an
> negative uses of a position variable is quite different, so it seems tha=
t
> it is not allowed to use both at once.

Do we stumble on a target conflict here?


> But it should be possible to use two position variables at the original =
place.

Would you like to adjust affected software components accordingly?

Regards,
Markus
