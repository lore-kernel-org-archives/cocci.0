Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FDFD29C37
	for <cocci@archiver.kernel.org>; Mon, 19 Jan 2026 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=wbHrjMa+5Kl8TrmDfDpH+Kh+CTAzV7+sC5kSN1htHzQ=;
  b=coHhn0yRxePt+jHG8764+nLDNdLe6xOPjck/jO+Otwkvqs/jyBT8Vhv5
   XFBTWB5Z5Zr4yCKCAqVF5+CURLKaYN6nFnwZXeZM2HDAsiTbcCuPAKxpr
   X22HfrOhlIiyo2qxDH2uiCmKJCUfJPGx1jv0cy3H6GKIIrIT5t19T4X1P
   8=;
X-CSE-ConnectionGUID: FVXzbjShSayVk8Rvw5IU0Q==
X-CSE-MsgGUID: Kb4JkBucQnKr3ckSmXliyA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,238,1763420400"; 
   d="scan'208";a="259296517"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jan 2026 16:10:22 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8244583829; Mon, 19 Jan 2026 16:10:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 12A468382E
	for <cocci@sympa.inria.fr>; Mon, 19 Jan 2026 16:10:12 +0100 (CET)
X-CSE-ConnectionGUID: d/1j18xxS2KONlsuT8DQgQ==
X-CSE-MsgGUID: 5P1XRZvRTPuumQQ4dgKxxw==
IronPort-SDR: 696e4953_kcqDNx8mR3h6Il2QLamFEc4ghSJ8k0yEDdKzCVZWkjaDxi8
 c6zBf4FeIJzxXh96ejdwnlPXj3EAHBaHPGWi+fA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E7QgBOSG5pg07ASNlaHgEBCxIMQIFSgj9oHwZZMwQLS?=
 =?us-ascii?q?QQEhFCPU4MNg1KPEYh5g1ICDwEDAQ1ECgECBAEBAwQ3AYFUgi6NQQIeBwEEN?=
 =?us-ascii?q?BMBAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBAToHDjuGT?=
 =?us-ascii?q?w1JARABggCBLIEmAQEBAQEBAQEBAQEBHQINOm0EGQEBESc0AiYCcQIBAYJ+A?=
 =?us-ascii?q?YIiAQYQAQM2Bw0GsUR/M4EBggwBAQaCadd6HywiWYFnAwYVgQouhW6CShsBB?=
 =?us-ascii?q?W6KGw+BVUSBPIJSgzkXBIIrgw6CaYImgQ6UDoFKHANZLAFVExcLBwWBZgOBB?=
 =?us-ascii?q?jI8Mh2BIz4XMlgbBwWBIokCD4kwgV8CAQttPTcJCxsEPZAER4EyfYE5lXmRP?=
 =?us-ascii?q?KFFNAeCOIFnBYFfDIkIgSaVPwYTL4QEk04OBpMFHphogliJN4F6lWAThUWBf?=
 =?us-ascii?q?yOBXDMaJIM2Eg0wAxkPjiEZJYNCM4RgwjVCNQIBOQIHCwEBAwmFRgEBilCCB?=
 =?us-ascii?q?oFLAQE?=
IronPort-PHdr: A9a23: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
 5cEDLNWBgRd/hwyFUlvWtAPcs4fYw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:A6ihKa/Xks+egd/NL8Nuk+HXdr1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYW4qKQgdcdDpAtjifZquz+8M3WBxB8brYOCCggeVxe5ZnOzfKlHbehEWldQtnp
 uIEZIObuEYZGIS5amV3ODSKadD/DDzytHNuQ6o9QYJcegFUcFdxjY8LjzePlx9RQFAC5Z8PJ
 2A5vBfrz7lVWULYt+9DnwlWfGGg9HQjprpbTMPGhZisWC1/H6VwY+/NyLd8gYVUjtJz7tn2W
 /Zkzbh7qHmn+CnxgTa32rz6Y0TvNf60NNMCOGFl8BQADTxjQSDYphnRtS5zXoIidDqzGxvvM
 jHoh8mMcg2wWjWZHuJrRzk3BSl+Coy6lf5oGXozkfLkIjcfnYXGsBBjYVWfl/y8Ew7puxx16
 pNwiawq4dXNxXdhy7wjuK4GS2C13DE4EbKo9RjzEC3YrFuKoO5arZvuX+9Ja1wXB4SLrpXVN
 WGQvuso8q+OmnqFEwx9lMfuuBEGE5DUituC3JyxvB831Vt7Q1E5lpdy8oFknga8pUhD5FC+u
 TfK6xt0KpDV8kMcMtGdZA8qOaMexnwqCj3QRavCEWiELtCN2PGqpbx7rlw7Oa2eIYQxJ93nJ
 jaSltXuWM7ZkqrUKS1rdR22wGIRH/4USXmy8lY6ZQ8srrgRKDzOSnGTFw1icOvr/gWH8WeUf
 euP5BdBePlMALVaPB09hy7X4MXJWgVUcUTtNp+U1WSotjTIomvreDfeOa7HsueLd/lYBKNPp
 IuZkmDGCwb1DHVZpbRummuZ1r9Pkri4Jl3DK/Wu+AO1YllDPw9jjQo
X-Talos-CUID: 9a23:kV8rA2/DD1luxf4Wn9aVv0JTQ8J8Im3N9y3zBGm8EntVGJGsRmbFrQ==
X-Talos-MUID: 9a23:beotMwuUCtNAXB5fQc2n2Qk7BP1a/Z6SMF0QlKw/58WLFjxgJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,238,1763420400"; 
   d="scan'208";a="259296272"
X-MGA-submission: =?us-ascii?q?MDGmzph9T6Vl4vMWk7wZsupKoAPcoYc8x5VNXZ?=
 =?us-ascii?q?Y99xqodZc5HQEG/oZGGLCbTn+hrD5qlz+It0TqPuQ1kJ+VxbogkHkwvM?=
 =?us-ascii?q?PsFQlcb1MKiBvcaJwYCKcjpWEHc8lwoJtdCHHmaEWxqgPsAbGfhYW//q?=
 =?us-ascii?q?QcGTIwrmMTNhvUUBhsMwFk/Q=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 16:10:11 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.178]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQ8ao-1vUbKM2h72-00Um5e for
 <cocci@inria.fr>; Mon, 19 Jan 2026 16:10:10 +0100
Message-ID: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de>
Date: Mon, 19 Jan 2026 16:10:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:R0YCP+IlBss0VgX+YLwmfk5GiR4zsItnxVq7RzHx4qccH5bDy+E
 PDBDN7FerST13R1Fn1O2OWFOM8RXquEHmDg3219STzokIPoJz7+4xYzZdXHyVwkWWD/xfqP
 3e1vMNaRJlDSZRN5qj/xUcVjSBLpuJBOcnZPLpoAcRUTHQle1UcbE9TuHeorwGsuilUJyA6
 1qqWOutH+YXoG+e2DgEBg==
UI-OutboundReport: notjunk:1;M01:P0:DZKw0kNT3Tg=;qyp6X6gNOee2MVGGinUZBE2s5/9
 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
 /c/J7BwqwENoP9SXeXiLw6tYNgIfb+/D5JyvvD
Subject: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3270
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/_l3y0iFYJ0bUtwBmHQjt3Q>

Hello,

Felix Gu pointed also another software correction out.

[PATCH] regulator: fp9931: Add missing memory allocation check
https://lore.kernel.org/lkml/tencent_5FCF2108621C51007E5526A7C60A5CC1F306@qq.com/
https://lkml.org/lkml/2026/1/18/129


Such an update candidate can be found also by the following tiny SmPL script.
https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/regulator/fp9931.c#L441-L442

@display@
expression action, action2, pointer;
identifier member;
@@
*pointer = action(...);
*pointer->member = action2(...);


May I expect that the same data processing result can be achieved together with
the application of an SmPL nest construct?

@display@
expression action, pointer;
identifier member;
@@
*pointer = action(...);
*<+... pointer->member ...+>
 ;


Regards,
Markus
