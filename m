Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD121CAC599
	for <cocci@archiver.kernel.org>; Tue, 16 Sep 2025 08:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=K9mO01k/XpnrFg4MLzJxoASy5N38sGyHVy80N/VC4a0=;
  b=N42SzioaI3kVgLmwzo1oZnLNipKY0Ci4zisCkeMlEOPf+FGAIQSOYb/w
   ulOg2TpBs2XB/Uu46kxmlxKDMSEkC7KawBPIIFS2IL7tUZIXEZo5V3x2B
   y2e5tf2dxIWDS+Xc64fXyjkQWIvyvxc2MZPgUZDU6cHjGPSomXg4B00wS
   w=;
X-CSE-ConnectionGUID: dOGQnt11TQqgXcXaRxl+0g==
X-CSE-MsgGUID: fq7mwW3VQA2ojX8Ru3gHZA==
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
X-IronPort-AV: E=Sophos;i="6.18,268,1751234400"; 
   d="scan'208";a="239283079"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Sep 2025 10:01:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EEF30E0CD6; Tue, 16 Sep 2025 10:01:12 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F2658E0171
	for <cocci@sympa.inria.fr>; Tue, 16 Sep 2025 10:01:08 +0200 (CEST)
X-CSE-ConnectionGUID: hLUMI6tYSNeiqaDQu0RdjA==
X-CSE-MsgGUID: KTXE++bbT8+OHjD6R52i6A==
IronPort-SDR: 68c91944_LYB6b5URENHdd7fORJqI0CP4qBw2AV95yyAJBwAEUvEivhS
 7AUgJpTw4vEs+FbF3p+nGIOX6+JB96CIoqkkHpw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ErAAA5GMlogAwR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQAUBAQELAYI/gQhUMwQLSYRVj1CCJIQ7hzyHVYpOgX0CDwEDAQ1OA?=
 =?us-ascii?q?QIEAQEDBIUAAowzAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBOwcOCjGGTw2CW4EsgSYBAQEBAQEBAQEBAQEBAQEBAQEXA?=
 =?us-ascii?q?kdEAQEBAgEjHQEBESYBBAsLGgImAgJWBhUBAYJ+giMBBhABAw8mB7RlgTKBA?=
 =?us-ascii?q?YIMAQEG2l8fLCJZgWQJgRsuAYVrgmQBimMnD4FVRIE8gwM+hEODW4JpgiaBF?=
 =?us-ascii?q?oNYmFFSeBwDWSwBVRMXCwcFgSBDA4EPI0sFLR2BJ3iDB4ENhB4rT4IccoF0P?=
 =?us-ascii?q?hlBg1MeBmsPBoEVGUkCAgIFAkM+gWsGHAYfEgIDAQICOlcQgXwCAgSBQkACA?=
 =?us-ascii?q?QttPTcJCxsGPZYvhyjGPTQHgjiBZ4FkDJ9sBhMvg3EBk2AOBpMFmQapQYFpA?=
 =?us-ascii?q?TiBXDMaJIM2TwMZD44hhDO9XEE1PAIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 IT7qa2ogK12dKIpLftdRg==
IronPort-HdrOrdr: A9a23:cd2h06ylxbsFopaq53THKrPwO71zdoMgy1knxilNoH1uEvBw+P
 rFoB1273LJYVUqOU3I++ruBEDoexq1nqKdirN+AV7WZniChILeFvAH0WKN+VHd8lXFh4xgPP
 BbAstDNOE=
X-Talos-CUID: =?us-ascii?q?9a23=3AViFDdmnwaykwY8bXcZkY5xO+3+TXOX358VLxfVO?=
 =?us-ascii?q?JMkBkSaScZWaNoJlokeM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ay6yljg21Yo6vzE5+s8V6MzykGjUjwJieJQNOm58?=
 =?us-ascii?q?664qjFS5cZQ3A1jXpa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,268,1751234400"; 
   d="scan'208";a="125608457"
X-MGA-submission: =?us-ascii?q?MDE6flWuM6rB/2EJNHJ3/cdNpRntKZc08SZNS4?=
 =?us-ascii?q?v7UEEEs1HkWjiF1Pll+XMEaGclCGDQRbrM6jJZq7l1jlXYl8KKi1GOad?=
 =?us-ascii?q?al9bHfA3SFvaanUqkeMNT0n+dfKpLjAif8kc10PRbkFGbcocnvbFhzzf?=
 =?us-ascii?q?xlgmLlPkX5HFhLLDVCTb6Gaw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 10:01:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758009667; x=1758614467; i=markus.elfring@web.de;
	bh=K9mO01k/XpnrFg4MLzJxoASy5N38sGyHVy80N/VC4a0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KB3bDY0zcIHVt6kdRWsNY+II9lRmSNNl9cX3UMT4fUbjYqRWtTFy6UJxyL/Zt/Kk
	 TVOMc9+0ehg/A2Dr6anG3q60CkPmdoTCWuLoPAkq5MZJFmOUtmn6l0fsFBrTWsZG0
	 i7LbyjAUb5piEWf70SUTnYBtfSodMp93/wRvybSCDvJOzqfsvumcbo0MLBrrwv5Ma
	 VuBK3uYd0PHyp8mBuUBeuIIhmWLz7tzdOB+kKGjXkV7/XYHESzaS196Jq73vs3VAP
	 uL2xucvq612NgoqA2D7Dcn9mJTGs+uimNqlXMT2Eau7HrZGyAZgWyveYmcdDEOtDs
	 0jX7lN+sfqp8/XoGCg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.197]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsOP-1uYTjs0Hch-00jbex; Tue, 16
 Sep 2025 10:01:07 +0200
Message-ID: <823b575c-505d-44bc-91cf-f424f9b2e14f@web.de>
Date: Tue, 16 Sep 2025 10:00:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Anon Anonson <anon@chud.cyou>
References: <d04274ea-7bff-4c63-8fc6-55a19ab45b55@chud.cyou>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <d04274ea-7bff-4c63-8fc6-55a19ab45b55@chud.cyou>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9nXuSeGLDbLTVyz8c4Vuz2RvPn3kE0bvIOgfYU6oykyLnp4W3LF
 DFuQO8q3XDiJSR8YUiF9wdolSPFX4uaAuDrSyOGBD6cMWl4XynXvfInzEYVvG96AqgM6TQS
 AEC4d4X58Mpb/hhdn2Vh0EL+s4TI0a1O0LCQAOPhv5xGpPdil3OubFd7mfmxvLnk5C06JPO
 OIP/qvf0iwqnUAoPhv8Nw==
UI-OutboundReport: notjunk:1;M01:P0:IZDafFD+fkM=;r3ukTcQuD+mLbXf2k57Ghdc/oA7
 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
Subject: Re: [cocci] Renaming identifiers with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3020
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/823b575c-505d-44bc-91cf-f424f9b2e14f%40web.de>

> Given the following script:
> @ rn_dec @
> type T;
> identifier I =3D i;

I suggest to reconsider the need for such an SmPL constraint.


> @@
>=20
> - T I
> + T b
> ;

 T
-old
+new
 ;


=E2=80=A6> However, I would expect the declaration inside the 'for' to be =
replaced too.

Would you like to support any restrictions where anything should not be re=
named accidentally?

Regards,
Markus
