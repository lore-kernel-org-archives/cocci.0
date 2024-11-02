Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A4EE677FC
	for <cocci@archiver.kernel.org>; Sat,  2 Nov 2024 12:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=RAZoMl3nAxmQmnm6dc8FTRK0rx/bEm1rlDMv6//bspg=;
  b=HnMJChla1YrW4GTRx2b6sgDoWirdy8R8lHojZpKDDn5hwD0vy0Y2zpQG
   4+qMdHceDqnKePMAxyW9GcI6goJUOBMEZ07SrAt0fhjZe8v2mHZeVSaUx
   eT09VAclG1AVA5MqdwzjPbaSgSKt9RlJN98wN4W9ll65Xc9+QUeA4q2tb
   g=;
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
X-IronPort-AV: E=Sophos;i="6.11,252,1725314400"; 
   d="scan'208";a="191807108"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Nov 2024 13:10:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 39D86E0133; Sat,  2 Nov 2024 13:10:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B5CE6E00B7
	for <cocci@sympa.inria.fr>; Sat,  2 Nov 2024 13:10:49 +0100 (CET)
IronPort-SDR: 672616c9_pbLhlU6+/FMySbwh5wucP7R1RqZmuT4sjyBLTnJi9XAJMSz
 4tIAchCyb4S4BXR+vdcIsAVRYzj/vWUC0xswGvA==
X-IPAS-Result: =?us-ascii?q?A0GRBAD8FSZngAQP49RagQmBU4JEYhsGVDMEC0gthCmPT?=
 =?us-ascii?q?YF0hGuPD4h1gVaBWyMPAQMBDTsGAQIEAQEDAQOBSUODbYk7Ah4HAQQwCQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CW4ERG?=
 =?us-ascii?q?3QBAQEBAQEBAQECAQEBIgIBAQEBAQEBAQEBAQEdAg06bR0BAREnNAImAnMBA?=
 =?us-ascii?q?YJ9AYIvAQMxBw0GrWuBMoEBggwBAQaCaNdzHywiV4FjAwaBGi6FaoJIGgEFb?=
 =?us-ascii?q?YoVD4FVRIE8C4JHg1AEgiuDDoJpgk+EKXYliC9oh1CHXYgagU0cA1kyAVUTF?=
 =?us-ascii?q?wsHBYF5A2SCbYE5gVGDIEqFHoEBgkppTTcCDQI2giR9glCBJQQFg2+Ec4RuQ?=
 =?us-ascii?q?h1AAgELbT01CQsbBj2dLIEbR4QjEyyCMZM+sko0B4I4gWUFgV4MiQOBJJUuB?=
 =?us-ascii?q?hMvhASTOw4GkniYd4JWiyiVEzyFVIFnOoFcMxokgzZPAxkPkhszxDVCNQIBO?=
 =?us-ascii?q?AIHAQoBAQMJhUYBAYksgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:kSgvbqgzjIKHoDFEgGC7b+h8GXBQXvgji2hC6mlwRA09TyXqrb
 HMoB19726StN9xYgBFpTnkAsK9qBznmqKdjbNhX4tKPzOJhILLFu1fBOLZqlWMJ8SUzJ856U
 4PSchDIeHRSX5nkM39/A60KNo4xsKbmZrY/ds2g00NcelwAZsQiTuR5zzra3Gfz2R9b6YEKA
 ==
X-Talos-CUID: 9a23:KIBMrmEMv78Qul6OqmI/0B8uJMkCeUfs42bvGwiRLFRYaOKKHAo=
X-Talos-MUID: 9a23:dnyYxAmx529OCTSx6AcSdnpIFsc4u/uNEHlKkJYphJnUCid3KTWS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,252,1725314400"; 
   d="scan'208";a="100575788"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDFhGwOV8s8xaUkzdO/uBfzG9MPctGfsft9a/Q?=
 =?us-ascii?q?lJkyBblSuqRCu2JdlR0HNc17tyGRDtId6jpmYdOshUy04SEN6yO4CRKW?=
 =?us-ascii?q?lO+OAw60G72OkP+np/9Y5fk/HrXaHiyt4ZX5x16eeN9JoPIBtu8BHTnb?=
 =?us-ascii?q?fcoGNGNMonm1rl7f2Mp8e1kA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 13:10:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730549448; x=1731154248; i=markus.elfring@web.de;
	bh=RAZoMl3nAxmQmnm6dc8FTRK0rx/bEm1rlDMv6//bspg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s/qCF62M6R4ds39mZVe1VO3APRTBKjqsedEF3qtdhASYjIU3en4Km31AzyM9i5vs
	 Q4eco3wBYKNpDVTb3nsfNEtoHkU7RfwOhX2p607nIpAY+IjXsBmwDM6ZaoXxqz/H/
	 7nKTuLRTYQa9P3Xef2w1n6TPon6NStoYx6BPpQPImzCAn6hP/u4cxIPzbIXxQoQRs
	 2QM4WkvgpHLQphFDz0/LzRrkm1Ks/8LJIw2Za9qBVDl2P0knEayzhu2c5MOKCdkGy
	 46ZkwjGyTPkPHTSmsP/JyRdUO8IIngz/PLP23qDuCohv4uSwuUyrqbACUcPSRGIkV
	 in1PEj61lMqLTxUQ2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JF8-1t8rev4ASw-00EYAz for
 <cocci@inria.fr>; Sat, 02 Nov 2024 13:10:48 +0100
Message-ID: <922a51a3-ec27-4059-8697-09c90385ffc9@web.de>
Date: Sat, 2 Nov 2024 13:10:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Thrt6HDhqfqQGecDY1y4/on5JeOyUEMdALTXQowWvJWuwEpE4yY
 +KiGYMhjU89Xd9mxZTVN4bBEke2cJfblZcHsmSXwB6iZkOhFQhKYfk9gmvvQrNe3URtr6OF
 FfFXwQZAat1Ur1zxnqRJkSnSPUHA9GdiI0Nv8RXd7LDR9need7V2hBoOECgUNGQTY5S7eZi
 71cJiMdPhYoGNTvQJxPug==
UI-OutboundReport: notjunk:1;M01:P0:tgecOjNt7Iw=;RhI+qIaaVvI4Z5FVl8cW85QoBpT
 aDSocnWzbiXZ+IRhcjBcTuB/lP1COMBWMz/MzFZg1aqLg+/F2uPt2a67Q6dILOSvu7e7x/wci
 f63CnHfVHzDkThidfPPiV0U2Kyix7a+7Cwwme5bKH+1ltp2Cy0+Sp59u8H5eK9yDb8ZrYroEw
 D6hc4LBYzkcI1q5QspdjXa7KUBXppoLLCKyRC9OaE5tF4vf0AYc9oxXzx4Mpj7gg/E5MRRRY5
 Y9/AVTn+xbr4JP4qQJ7rxDsfpv7x0kL2H1G/cbAloPm6rDOHK6nzMMZjtGtsEyGmik1Gelo+C
 88fioSso5vSnyInEy3l/qVlTYF79aEmxP73vGuK+7XfOeYlUaQYEXZ+h6RDGcspmIiXC9vHfH
 GLIf41rJIAWgdT1h4j/Ec3cd0dQTcg8c8AvOVv3CmfQjrILV5SgutUq5D2izlvFAl0SXhFEs3
 eyhrMzFcpyHhBKtaNjZpB5VN9OIInlaXOwDNvHSxm7NoXDwSBhyN18ah2uJFu7ajEsJbzPcSd
 Oq4/6vq03YSr3jcy8asi+hpQZVJhoIiZG9IgW9+47E5fb83UDAafyma4jzpE7CNkTQaV3o7iI
 EowbKzSdE04WA0RgqaJzLi2/d458Wfsmu1FIknD9a48+pd+8LUPPZHLe33Phjeu0BMvbpPhJQ
 adW/UwrAk5aau6DvQWTBEkz2wH83mnCqDDaVJLhr/bGJ/seIlDQLvpjSBtD510UazeLlbsoCk
 NTIvyB+77ZKGio6ByfWevnm5F1oaHiBKIV7lBnkUy0U9Fn1SNRZMpRKVB9Cq2pt/9cNPRY8lV
 oq07gBYsLM7mdrnycOQ9/lww==
Subject: [cocci] Searching for selected identifiers in code parts (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1960
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/922a51a3-ec27-4059-8697-09c90385ffc9%40web.de>

Hello,

I tried another tiny script variant out for the semantic patch language
together with the software combination =E2=80=9CCoccinelle 1.2-00097-g7bc8=
a7ac=E2=80=9D.


@display4@
expression e;
identifier i;
@@
 while (
*       --i > 0
       )
 e(..., <+... i ...+>, ...);


This source code search approach is working to some degree (as expected).
Can the following SmPL script variant become similarly usable to find
remaining update candidates?


@display@
identifier i;
@@
 while (
*       --i > 0
       )
 <+... i ...+>;


Examples:
* t7xx_dpmaif_rx_buf_alloc
  https://elixir.bootlin.com/linux/v6.12-rc5/source/drivers/net/wwan/t7xx/=
t7xx_hif_dpmaif_rx.c#L229

* t7xx_dpmaif_rx_frag_alloc
  https://elixir.bootlin.com/linux/v6.12-rc5/source/drivers/net/wwan/t7xx/=
t7xx_hif_dpmaif_rx.c#L384


Unfortunately, I observed the following information.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --parse=
-cocci show_questionable_while_condition2.cocci
=E2=80=A6
minus: parse error:
  File "show_questionable_while_condition2.cocci", line 10, column 1, char=
pos =3D 249
  around =3D '<+...',
  whole content =3D  <+... i ...+>;


Regards,
Markus
