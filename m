Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD35606A32D
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=ATmD//1O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=9VTWMtfi/UqBqDsCr5D4xfOEpOxSpxbyyjdA+6dozfA=;
  b=ATmD//1OR7+cPEJJp+7DdynPM1au4un9fqASThFeFc7DITnyJ0WltnZg
   lSlSbs1gmN4d2rED7oq8JRntWkLC/n8NvqyMEtTUFkRHPGMTSSEClzytY
   OpfYQrYRRPA7eW2sm3dmrgktbQl/HbUPRf+Az6+w5Q04IyXSbWL3A76pR
   k=;
X-CSE-ConnectionGUID: GdY3M8u4RFODi7qeFbHu1Q==
X-CSE-MsgGUID: wLJkvUumRmCANsjVJP7UcA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304323172"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:16 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3646F816D3; Sat,  7 Nov 2026 11:59:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 040CF813E2
	for <cocci@sympa.inria.fr>; Sun,  1 Nov 2026 13:37:46 +0100 (CET)
X-CSE-ConnectionGUID: wsx8gBY/RnaoFNfsXh238w==
X-CSE-MsgGUID: y7zBwOYyQiuYvrqZSm8cQw==
IronPort-SDR: 6ae73299_gA2udfgPrRtoFKAQh1YrIwo6PaI5MoTitU6oAuUf9zYnDm6
 ZW0ORwbiFYwwvDZ5zIJd2nB5pVZRhfVJDS8/qhQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EPBwBiMedqg07ASNlaHgEBCxIMggULAoI/gQtgNAQLS?=
 =?us-ascii?q?YRYg0+MBIF0k32IfYFVgXwCDwEDAQ03FwECBAEBAQIBA4R0Co4fAh4HAQQwC?=
 =?us-ascii?q?Q4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBOgcOO?=
 =?us-ascii?q?4ZPDUmJTgGBeztxgSUBAQEBAQEBAQEBAQEBAQEBAQEBFwINOkYnHQEBESYBN?=
 =?us-ascii?q?AIYDgJfFAEBgn4BgiIBBhABAzcHuzGBMoEBggwBAQaBCYFi2AAfLCJdgWsDB?=
 =?us-ascii?q?oEfLgGFcYJRHAEFb4VAg0iBIQ+BVUSBPAuCSINQAoItL4JggmqCJoEMiCYDj?=
 =?us-ascii?q?mKBShwDWSwBVRMXCwcFgWgDKi8tbjIdgSM+DwgvWBsGBYEdgR6BGYEHXYErK?=
 =?us-ascii?q?WABIYEIgXYCglGBJVsCAUlBDgdFUwklQxJHJCIIEgkBExosC4EaNTwJJgQ9F?=
 =?us-ascii?q?QxkCxoFYggCDQx2ORAwICYwBR0mHW09NwoLGQQ9kneESoI9kzyRPqFGNAeCO?=
 =?us-ascii?q?YFpgWcMiQqBJpU/BhMvg3EBk2EPkw0BHphqI4o7SYJjlWGFWYFoOoFcMxokg?=
 =?us-ascii?q?zZQAxkPjiIZg2kzhGDJKEYyPQIHAgcOAwuFRAEBimGBdYFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 R3yN5E+0tVdAn2keArL2sGGvA==
IronPort-HdrOrdr: A9a23:IVlt967a3uM2OAuROgPXwYOBI+orL9Y04lQ7vn1ZYQdec8yGm8
 3rtOlz726xtN9wYh8dcLe7Sdy9qBLnhO9ICet4B9rSJTUO3VHFXflfBOTZsk7d8kfFh4tgPJ
 lbAuBD4bHLfCpHZSiT2nj8Lz4PqOP3vpxAr92ugEuE1WpRGuNdBz4QMHfZLqWdLDM2RKbRba
 DspvavxADQB0j/EP7LdkXtBNKz7KyAqHuOW3dvbHRHiHjs/FfYj8+dYmLoo2Zjb9oo+8ZUzY
 HrqX212kzJiYDO9vaz7R6t03xp8uGRvOdrNYirkcgaKjLlj0KEQKxbcfm4sDoyu+zH0idsrD
 CgmWZDAyx5gUmhN11dfiGDqnLd+Qdr7HmnwUSTgHv9raXCNX4HN/Y=
X-Talos-CUID: 9a23:gC8uNG35R0OhtdwkiR1xUrxfBds1InL3/TDqJUa/J0BnU42VEwTA5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AOszpJQ9fJt8dc5jgg9P0s0mQf9Y38Y6xL3EcqJQ?=
 =?us-ascii?q?biteeLB5LPmeWtSviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,190,1787004000"; 
   d="scan'208";a="303202711"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDECEbB6QAo0ncChQvZSYedNRNzTMNWr4nG0vU?=
 =?us-ascii?q?OgeOmTdsobN2dT2lYEys0ZauyNdFMPyqZT8PGpOiDcGXP5ZChId/TFbN?=
 =?us-ascii?q?IkeOz+wo859+GlUS3t1A8OJ0LTbEooBk/qXbQS8CdV5o1yPJdqWjRZoa?=
 =?us-ascii?q?rQFm4pmQn/jlkS6r+UjX8p4w=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 13:37:45 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBSB3-1xEwud0KFz-004ilP; Sun, 01
 Nov 2026 13:37:36 +0100
Message-ID: <aefccf2d-3ca6-4d15-9026-649fb0a0f63c@web.de>
Date: Sun, 1 Nov 2026 13:37:24 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr, tools@kernel.org
Content-Language: en-GB, de-DE
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:m+7tLzsQ+G+cZPc4vpMIyKdMtcZ7b5n7qbZQvw/JWFtnAwPKsNU
 8cQTtntTCX32iPUEWIrvLiL2YFnVLRROUeJeDrQeSSScy7AVbe25MEExhLzM1gFE9ZaExJa
 ucD79Jq9Fz46ryBU4kWSzx83Xq45xF+ob4F36Sx0byR1nDhRcLqh84e/jEVrDvhjdgU6eur
 mM0ADAZbWM/icBDsuem+g==
UI-OutboundReport: notjunk:1;M01:P0:SKDKEpuY8ps=;4F5RdN+8ZPGHA1WCmHwQXbI4zWN
 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
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [RFC] Distributed data processing for SmPL scripts
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3769
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/OpoOmdocgbBBmJKXGf2Wsg>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

Some developers got used to tools which support distributed data processing
for compilation tasks.

Examples:
https://www.distcc.org/
https://github.com/icecc/icecream


Would you be looking for similar needs also according to source code analyses
and transformations?

Regards,
Markus
