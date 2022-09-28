Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B60DC32771
	for <cocci@archiver.kernel.org>; Wed, 28 Sep 2022 09:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EltSfB2x78I4pfl5FednZYMFnvoR81Dh4XYtWhWLQDw=;
  b=MwxHMIDd1rnKAW9WynpcFiyVzVqL8sZTBQYnWD+MoTVh5ZXsnXPjL3XO
   Lc7ngsZuEhIZke7HZzSz2AIG+/aIhK4lmvsK/R3rDBtTk9FBK6dZN0NHa
   to2PV3/98oO+/pSdfu2MnknvuNyiWa4sROfcBFPOaTxF9zJ2RjTQDHriP
   k=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.93,351,1654552800"; 
   d="scan'208";a="54901922"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Sep 2022 11:24:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F2F46E028F; Wed, 28 Sep 2022 11:24:47 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5F973E0076
	for <cocci@sympa.inria.fr>; Wed, 28 Sep 2022 11:24:44 +0200 (CEST)
IronPort-SDR: 633412dc_Mrg83iUah60ytqoRnMrhcj4pdUr0FRQlOcRV0DKc17bPN28
 ilVg5wBuDYJvS5EOjYmnmVp4znZhrX0KNA5wOAA==
X-IPAS-Result: =?us-ascii?q?A0DKBQA4EjRjhwMP49RaHgEBCxIMQINzgVcuBAtFhE6Qb?=
 =?us-ascii?q?imLP4cljCsLAQMBDT8BAgQBAYISgnMChGwCHQcBBDQTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECBAQBEwEBARkJFwcOBQsFIoVoDYI1KQGDZAECAgEjH?=
 =?us-ascii?q?QEBESYBBAsFBAIaAiYCAlcGASOCbIJtAQMNIwePc5wXgTKBAYIIAQEGhE4fL?=
 =?us-ascii?q?CJSgVwJgREshxWEbIMueicQgVVEgUiCRzA+hESDVoJmlHqEQzgDRB1BA30DF?=
 =?us-ascii?q?QMUAwUkBwMZDyMNDQQWBwwDAwUlAwICGwcCAgMCBhMFAgJNNggECAQrJA8FA?=
 =?us-ascii?q?gcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHEzMZAQUyJxAJIRwOGg0FB?=
 =?us-ascii?q?hMDIG8FRA8oMWsrHRsKgQwqKBUDBAQDAgYTAwMiAhAqMRQEKRMSLQcrcwkCA?=
 =?us-ascii?q?yJnBQMDBCgsAwlABygmPAdYOgEEAwIQIj0GAwkDAiKBTzkoBQMNGSYIBSMXH?=
 =?us-ascii?q?QQIPAIFBlcTAgoSAxMPBi6dGYFjwWU0B4IZgUSBSQyecjMDlmEGkgmXCyChY?=
 =?us-ascii?q?YVogXgjgVszGiRPgmdOAxkPjiAZhAyKLT80OwIGAQoBAQMJhUcBAYRqAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:8BUx+q829PheLgN2DCtuk+AaI+orL9Y04lQ7vn2ZhyY0TiX+rb
 HXoB17726XtN91YhodcL+7Scy9qB/nm6KdwLNhWYtKGTOW3ldAT7sP0WKB+VLd8kTFn4Yx6U
 4jSdkGNDU0ZmIK6voSizPIcOrIruPnzEnSv5al8593JzsaFp2IAj0JdjqzIwlLZE1jCYAiHJ
 SRovdWvjbIQwVtUiyDbEN1INQqLLDw/q7bXQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,351,1654552800"; 
   d="scan'208";a="54901910"
X-MGA-submission: =?us-ascii?q?MDHPg8RB3ZdZ2POfciDG9Ag+KLh7Pqc//U+DMc?=
 =?us-ascii?q?4y/kPohkZnKAzpdGqw1tO1nMiVEZ1tbTj20GqB3/pdwVQp5OZeR7WRyx?=
 =?us-ascii?q?/AjiTyaqzZ9yqu8heuhWFbI/zuSkfQ8kPClDGIF0kCATTXD62sBReam/?=
 =?us-ascii?q?tCRK0ilZtQLWST217Nsdz+Dg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 11:24:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1664357072; bh=zpeG0zq63i8PRAOCJvWZ+f4raPkwX1dLDHv/HoloefI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pCFZNktL0zMRLspwLeElwNTnAa+U7bSKENqyOkdI7DkkwJSRVpWK0iPhMiBrYlkU7
	 GJZONJ50mmPvUiHMH51SCiAgHJbdXVyx4ZYIBJm/m46/BgurrGprSMq3EpewjhCmtJ
	 jjuEF0iKy0PHTFjH/7ZiVTRX3bMlL4HLMTL2Q0xOQeOEiBgB0ied2QyuXtFF1KNPWl
	 oUqGFLWn9fs6FjPLmqf0b17pH3k0m2HlQTPi7lw2e+q9f4O1hjiUrUbLj7GjXCF5y+
	 PePNqu9mnfGv9H21dnU2KgfKerp130yPhsAnO2/G5qW9YejpnxIlWuFbB3g67s6TSq
	 DKeF0e8JJWrng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [212.144.252.253] ([212.144.252.253]) by web-mail.web.de
 (3c-app-webde-bs16.server.lan [172.19.170.16]) (via HTTP); Wed, 28 Sep 2022
 11:24:32 +0200
MIME-Version: 1.0
Message-ID: <trinity-43d24a5b-dc1e-4ca8-a98e-100c1f4da621-1664357072704@3c-app-webde-bs16>
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Yuan Can <yuancan@huawei.com>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Sep 2022 11:24:32 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <d375b225-04e6-15f2-d559-ad7f404b5087@web.de>
References: <alpine.DEB.2.22.394.2209251906090.3293@hadrien>
 <d375b225-04e6-15f2-d559-ad7f404b5087@web.de>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:HRTagcnWmdbtY7gneJgCRWToeVqt1qKiLCVdAR/K/XN5adEpdlepCF46myrp9e+KMZ/BW
 1fNfCZlFJiYJZPBFzKt298wf2TSRO4KQFTOAusSlJSmTB+NXDuTh+wX9xayrxZBxYQaucUlqhDhc
 C01X+rG+vAwaXmFEyUaTVxJqR1uti14MLoy2Koh6l0d9C94A/srjhSiVx4P8fjfDbc44HbeC69jm
 HrzCBtfxpm+mRki5rVbK+N3TpwnZxXeZoRMIOPNY8+2ap/jVtUyFnTQ4w71XeDEEt3nL+vJkTdYt
 nM=
X-UI-Out-Filterresults: notjunk:1;V03:K0:qCt2/E9/2ww=:dnV7kemlxHaZ8EMbDykH8I
 +KAe3ujJht6yHWP14fbs80cR+gOXL1x5SIqkJ3FeNm+K4ZCHWYPaTSjBGoUe9G69m7ysnDoyZ
 KPmDPGu+loyamJew7xWVduryzVasexp5IG/hmQTSp5OmhT3TjcX5MoXVdJjtdwxYZjLtVcTTC
 OXlm4SlNISbIrkI8om+5weDsvImi9bt+oAOhzoyU+6UDSGTmrJcOHOsCxDBwcLfAfxC4ooAgb
 oPDLylTPdMhgpa4yS2CQ79fg5MdjLcODoIYril+9id58TwE/9AAs0J3+7JbN0NnR6kK14yc53
 XmB7pBfkatf/+71rV02VppyRbOhH45ohh0m97K4PQ0hPTYD1gD6kdo3Ye/YS27BAjyWvinucH
 soIlmFZGewTN6JKOqoWszDM9/9RGNTsHb8yYGtXgaDxJwJ4aK9X3HeHBIpAr+yolijsHfjMFU
 ZzO6SmuulP3pm1esDgXwgvawIt2lCyf7GHpXGpRK3gkoOvKo5xKrzCRk9Ri4gQeAPyCrSAtFw
 /MMZzlZm4/3Zbu27r4FZKo5BnuUwV5YzzK3NOz8/kLsJSBTd+3g6iN25sD4gNY5NeVz12+qVo
 sswdgRot+qtH7HN5CBD+7PxymlqGfxqfrxUT/xrJBm0+UazbDoaBuE3xiUksAB3DhuNdE32F8
 9GyzIgR5M8K1iftgwUBrm77kpJq1+ZsYSivanyKq071n1nghbOZYNkBVGgTTzsdRMIr6A7SNX
 m7Vw81goO97DE98eUFJj5GVyE29Be7yHcoYziPehv+d+8QRRejfSq21GPx1V8WDuCrXzy4CyD
 2UDOr7O
Subject: Re: [cocci] Checking the usage of locks with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 597
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/trinity-43d24a5b-dc1e-4ca8-a98e-100c1f4da621-1664357072704%403c-app-webde-bs16>

> Can the following SmPL code variant be helpful?
>=20
> =C2=A0return
> (=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e
> &=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &o=2E
> (f@p
> |f@p[=2E=2E=2E]
> )
> );

I tried also another SmPL code variant out=2E

@alias2@
typedef spinlock_t;
type t;
t o;
identifier f;
position p;
{spinlock_t,struct mutex} *e;
@@
 return
(       e
&       &o=2Ef@p
?       [=2E=2E=2E]
);


Markus_Elfring@=E2=80=A6:~/Aktivit=C3=A4ten> spatch --parse-cocci optional=
_array_member3=2Ecocci
=E2=80=A6
12: opt only allowed for the elements of a statement list


How will the chances evolve to reconsider mentioned software limitations a=
ny more?

How does the source code search approach fit together for a selected point=
er
and the array access for a data structure member at the same place
(according to the SmPL conjunction)?

Regards,
Markus
