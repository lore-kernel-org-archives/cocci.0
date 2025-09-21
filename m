Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F67CAC59A
	for <cocci@archiver.kernel.org>; Sun, 21 Sep 2025 11:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=O/+RBrHJ1yql7wFkEREke8mV974plJ+XFKB0jwlSufI=;
  b=AuMIp7JBligsVmWBbCi33hO7RYczTDd+u6L9aVxNBy0vhfi/I6e2tUvR
   QzLu5uKLXmlg8PWpvAUgcdXlO6F23XYUFpVzEjQaiG8RUK5GoicjBCU1j
   6B7+eVeiVJ0ZqvVQbWTNFWspEY9J4mUiWx/pavpHjEFyWqT+XudUaRuSs
   U=;
X-CSE-ConnectionGUID: 2K6GkcAIQW+bB0Z7M2LQeg==
X-CSE-MsgGUID: /N++epVSTx6iOG8hxIaPsA==
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
X-IronPort-AV: E=Sophos;i="6.18,283,1751234400"; 
   d="scan'208";a="240236408"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Sep 2025 13:26:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C0A80E0B0D; Sun, 21 Sep 2025 13:26:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AD02AE0171
	for <cocci@sympa.inria.fr>; Sun, 21 Sep 2025 13:26:22 +0200 (CEST)
X-CSE-ConnectionGUID: 0n9PAZ9lQz+hJVIWi/HObQ==
X-CSE-MsgGUID: FrPRYxImQwiD1QhKzthzMw==
IronPort-SDR: 68cfe0dd_oVoAaEzII5n+DR/Ragif1ryNqAi3nooZWYEcWAIhHbHKCr5
 VOEm8VXiO43XCzNFTj358UicQuDhsQZmEjcsetg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FhBACg389og07ASNlaHgEBCxIMQIQTgQIGVDMEC0kIh?=
 =?us-ascii?q?E2PUIMNg1KPEYh5g1ICDwEDAQ1ECgECBAEBAwSFAIxAAh4HAQQ0EwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBOgcOO4ZPDYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEBAQEBAQEXAg06RicdAQERJgE0AiYCcwEBgn4BgiIBB?=
 =?us-ascii?q?hABAzUHDQa2ToEygQGCDAEBBoJp13YfLCJZgWQDBoEbLoVsgkoaAQVuihcPg?=
 =?us-ascii?q?VVEgTyCUoNQBAGCKoMOgmmCJoEWg1aEAItPiXiBShwDWSwBVRMXCwcFgWMDg?=
 =?us-ascii?q?Q8yPDIdgSeDfoENhB4rT4UCPlqDUyRrDwaBFYNbBocuQAIBC209NwkLGwY9l?=
 =?us-ascii?q?xqDKoE/AoI9kyQYgxWvbDQHgjiBZwWBXwyJCIEmlT4GEy+DcZNhDgaTBZkGj?=
 =?us-ascii?q?giVYIVZgX8jgVwzGiSDNk8DGQ+OIRmDZzPGckE1AjoCBwEKAQEDCYVGAQGMV?=
 =?us-ascii?q?oFLAQE?=
IronPort-PHdr: A9a23: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
 RcFk+uQEA==
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:V53exKNgEqLrLcBcThmjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoV86faUskd3ZJhEo7u90ca7Lk80maQFg7X5Xo3NYOCFggeVxehZhOOO/9SKIVyaygcy78
 ddWpRfTPvtEFN9kcH22wWgFc08qeP3i5xAyd2+8593JzsaEp2IAj0JcjpymSBNLjV7OQ==
X-Talos-CUID: 9a23:mDkQd27eMrf0X9qDA9ssrEhFIukXI3nk3jTQAXGZNmcuaJqfcArF
X-Talos-MUID: 9a23:oD+jzwSqbAKkIpwnRXTCnglYBddJ5p2xCWxUqJUlqdWEJwlvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,283,1751234400"; 
   d="scan'208";a="126141200"
X-MGA-submission: =?us-ascii?q?MDEQSLiU0YZ5u8G3W1/wDiqoyn4W9JbwH1WlkP?=
 =?us-ascii?q?LpSHGh0K21RMQVX3k921vI3/c7mkfAcDPm4H7S8qSE3swOhoYphIX1qM?=
 =?us-ascii?q?QWDZJGrwOEV4xPyUy7MbS89WGs+HL/Nl9Knl0STws2p5wlg9AwbUy4FU?=
 =?us-ascii?q?2iDSGBXa5da/kkuiU6QpOMZw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 13:26:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758453979; x=1759058779; i=markus.elfring@web.de;
	bh=O/+RBrHJ1yql7wFkEREke8mV974plJ+XFKB0jwlSufI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Kvxg5Tj/svNkCL1EfkZhP1D2EoRJJ2oil8tE2QcvSr/Tents+a3U7poxWAn721AX
	 QxiUqg0UcJ7nvg4A5CXsQ9ERbns7HKTPppcaLa7SrUX8dMa1m+9aqldmM0ZiLhWwC
	 PtwcR+6TGjR02fI4IIsGP3U2W8DwkPXw+y5YliKW60i6QeTjiqAeSizTKFq1ZV+j0
	 r6awZO6WGiJCUyMiA6nmEYS6ZCBSJDdyLwteGvQvUN/I8/5YfbjN492MrffnUIJw+
	 WntLH8SZemV6u4Hf00bMliTgYrUzX+jgeTsNB41ike37L0Cbek4BCqPzAPCsSNjIS
	 hN1H++ANWqXuOOw3jQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.241]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPdr-1umlf038cL-00RTu0; Sun, 21
 Sep 2025 13:26:19 +0200
Message-ID: <d564f590-e51c-4a62-8b53-b536309c28a1@web.de>
Date: Sun, 21 Sep 2025 13:26:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: Erick Karanja <karanja99erick@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rjm7UdbuJqV8cNHQcbOoXa0JwPzp5O5SMpwbPXJ/0EWTguxio7j
 vD6LRnXKiTw4rJKxOBAObbUyMNNRrbjFb9kzXBBODdBLFBWdKb8Oa0ti7QyimdUMzdiYljW
 ReLEGR8i6ZcblPbrTvfLCJfEXtT58hobyfLt5vTxu0XM3uHWSGXCma8XFU7bKak12nXGJra
 Kased2MYUVAIAtshmPgXw==
UI-OutboundReport: notjunk:1;M01:P0:INKps7Kse6s=;7ot4MkiIasqDwp4hq3R2eJKoTVJ
 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
 Vl0FxeQ=
Subject: [cocci] Improving support for iteration statements by SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3029
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/d564f590-e51c-4a62-8b53-b536309c28a1%40web.de>

Hello,

There are statements which can be connected with iterations.
https://en.cppreference.com/w/c/language/statements.html#Iteration_stateme=
nts

Would you be looking for advanced possibilities to handle them in a genera=
l way?

How do you think about to use corresponding metavariable types for capturi=
ng
headers (or footers) according to loop variations?


The semantic patch language supports the metavariable type =E2=80=9Cstatem=
ent=E2=80=9D
to some degree.
There is a recurring data processing challenge to distinguish better betwe=
en
simple and compound statements, isn't it?


Would SmPL conjunctions become more helpful for such an use case?

Regards,
Markus
