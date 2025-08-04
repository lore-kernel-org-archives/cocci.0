Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F94C87FCF
	for <cocci@archiver.kernel.org>; Mon,  4 Aug 2025 11:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WI+wAaTO4NpHuXQ2LoNJIqP6W9LtbD123bKlca8IyJU=;
  b=KRSWr+rClucwE0NwpGfpMy2b7UxUwYwj8ItWSJo0DRCL0LZuy3VzXnek
   MbG7F9a8AxYr5eGckB3PKFU2W++X7xoZbomaA8hSZzRbBt+/xmgT8GAKX
   ql8wuh9ZVbNovJgqycMyGBfHDJ8QekOyTvVYn+NfWVASClv7qlPhsaViM
   U=;
X-CSE-ConnectionGUID: pCtxssZTQwiz6AnJ/g1Q1g==
X-CSE-MsgGUID: mAFbP6G9QPW5BH57ZHqaew==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="234100667"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Aug 2025 13:26:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9D8C7E0BE9; Mon,  4 Aug 2025 13:26:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D982EE0171
	for <cocci@sympa.inria.fr>; Mon,  4 Aug 2025 13:25:59 +0200 (CEST)
X-CSE-ConnectionGUID: LAYdukJAQUaxhOlM11JZFQ==
X-CSE-MsgGUID: lessQ+aPRp+meDcQny2lvA==
IronPort-SDR: 689098c7_5lMdaoofcriTr34obGQ8eL1myeT5nZB4loxF1jV/855Egwa
 XQoU8cBnTbkQ7HCbqPizhwDu3w5Chljq3rhiLPw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EkAAA/l5Bog07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgQZUMwQLSYRViByHNIZfhzyHVYh5gVWBfQIPAQMBDU4BAgQBA?=
 =?us-ascii?q?QMEggyCdAKMGgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABAQEhGQcOO4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAgEDI?=
 =?us-ascii?q?x0BAREmAQ8LGgImAgJWBgEUAQGCfoIiAQYQAQMyB68PgTKBAYIMAQEGgmnXd?=
 =?us-ascii?q?R8sIlmBZAmBGy4BhWyCZAGGJ4Q8Jw+BVUSBPIJSMT6EQ4NbgmmCJoEWg2ONB?=
 =?us-ascii?q?YhwUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnfYMNgQ6EKCtPgiJ1gXlBG?=
 =?us-ascii?q?T+DUx4GbQ8GgRUaHi0CAgIFAkNFgWAZBhpAAgELbT03CQsbBj2TVYU2mDquY?=
 =?us-ascii?q?oEKNAeCOIFngWQMn2wGEy+XUg4GkwWZBiKjIYV+gWg6gVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?QwNCYQRuy5BNTwCBwEKAQEDCYVGAQGMDIFLAQE?=
IronPort-PHdr: A9a23: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
 jMNxq7ka5sePMv31h46ArGVtJvHEQzcUIIUyhA=
IronPort-Data: A9a23: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
 4QqbTgsfXxXgnId3Sqtl7C51f3ZUP7SI+0UUBqy
IronPort-HdrOrdr: A9a23:JlhVjaFhOiMveG2spLqEPMeALOsnbusQ8zAXPo5KOHlom7+j5q
 eTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hzAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3ANu17N2oWKasXhxKaFb3QA0zmUeQMQ3HAz1X5GnK?=
 =?us-ascii?q?xGWZOTJjMEH2i1poxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A8VIPdAzdFlck5o83o/Oy1geN9hGaqKCjE1s00pw?=
 =?us-ascii?q?+gdHHMCFcMA6bnW6zXKZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="122737250"
X-MGA-submission: =?us-ascii?q?MDH33WyO+x4wgKZ+Nhoihnn/OBOp49QsbW08QW?=
 =?us-ascii?q?MftDdZv/lpg9+GmSZNoC1Ei3RYntQCbtbQVN4uDrtGvYtZhEfv7eAamT?=
 =?us-ascii?q?iKNRgdifcbj1JZtNUGHGw3BTxT7ojPULcNlrZEO8plJWSHFS+cKaZI/o?=
 =?us-ascii?q?ajc/kxd5d3GQsJ+UhXMHyJcA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 13:25:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754306758; x=1754911558; i=markus.elfring@web.de;
	bh=WI+wAaTO4NpHuXQ2LoNJIqP6W9LtbD123bKlca8IyJU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E9RBzFZhkFAiMabErGBkulak7VQqi8Wjk3VNAKCh4ZHCW8af9TbBd45bD7WamOGQ
	 c+nndIMqSLPClTVw0xjG/Ie86E1ckABcqk2Lxp2ZcfGhnSV5skqgUSCZk2jYAndPV
	 FA+Yh9/8G0dnggaLAgkhLLt1NacEoTPFNUkM++fe4ahbD5lqTzX8E32sCoK4pBdG3
	 bVOEE/DfvxDqA132aya8+g0yBEembY++Wd9opMds1l5/hQngHZMD3zvZzEIFzDK5h
	 61bmvZD0kqECzHeF/TYy2bsu9w4neLNDWEwjMPVzFdkw1IyRoSYvopLa8uAsDKcdP
	 W8FVXZqMADfsv4XSbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQxo5-1uy4fK33xP-00UquI; Mon, 04
 Aug 2025 13:25:57 +0200
Message-ID: <eb07a309-901b-44fe-9fbd-e249052141c7@web.de>
Date: Mon, 4 Aug 2025 13:25:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
 <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
 <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
 <6373a5a7-15b5-473d-a628-c385f12d4e26@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <6373a5a7-15b5-473d-a628-c385f12d4e26@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ddyxPKvt0Zs3V6bZxdrAGY0HkbwwP3OuRwygI3mxN/pRdMY/1hc
 k+wEAq7RhctsPeeYURJ/q3vGoftnD6Z+Bh430crYB/2Kje68WuwAkddbARDJx8TPB7Icifs
 ew++w9uShT8Ql5G0/fN+O+6xmtJGtduHNjK26GoXUtm8AI82msLr629uUORsa6MxN3e6v91
 RUkfBOv3hStXapT4Bn5qg==
UI-OutboundReport: notjunk:1;M01:P0:EA5v4mhm9JU=;0Tp+iOvBlOjbkvgOITBNvkgKT39
 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
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2957
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/eb07a309-901b-44fe-9fbd-e249052141c7%40web.de>

> @mark@
> expression x;
> @@
>  action_lock(x);
>  <+... when !=3D action_unlock(x);
>        when exists
> -action_lock(x);
>  ...+>

May I expect a similar outcome as it happens for another source code searc=
h pattern
(like the following)?


@mark2@
expression x;
@@
 action_lock(x);
 ... when !=3D action_unlock(x);
     when exists
-action_lock(x);


Another test result (by the software combination =E2=80=9CCoccinelle 1.3.0=
=E2=80=9D for example):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
../janitor/show_lock_calls_without_unlock5.cocci test-action_locks-2025072=
5.c
=E2=80=A6
@@ -8,7 +8,6 @@ void my_action_test(void)
  if (my_surprise(123))
  {
   my_log("surprised!");
-  action_lock(&blockage2);
   my_log("blocked 2 once more");
   result =3D 99;
   action_unlock(&blockage2);


Regards,
Markus
