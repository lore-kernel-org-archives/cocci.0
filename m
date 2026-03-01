Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1728FD0058
	for <cocci@archiver.kernel.org>; Sun,  1 Mar 2026 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=m6ByEWOucNsbZD7eqd59f8z+vzJhjH1WjncZropkduA=;
  b=MeWfZoQYrSvbKpVDk11CDD3RFKKdKYZ+1abdsQw2458R52+odOHZ4fve
   VH4OAWxwyynbE2fj1FEYB7JXCRR20iRxg/zJUtZ82yru1C29LbvQjDADV
   t1gmJhBZvULqJBz7soKO4993Vq7SVHLzCWyD1X1LwAG9UQ+yrDajZ0dAy
   w=;
X-CSE-ConnectionGUID: i9LTfgxxSk6fQNOU30ELjw==
X-CSE-MsgGUID: Y2TkG11xRLCrJfkhe3nRkA==
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
X-IronPort-AV: E=Sophos;i="6.21,318,1763420400"; 
   d="scan'208";a="265662848"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Mar 2026 17:51:27 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5593B80F9B; Sun,  1 Mar 2026 17:51:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5116480F21
	for <cocci@sympa.inria.fr>; Sun,  1 Mar 2026 17:51:22 +0100 (CET)
X-CSE-ConnectionGUID: VY5SHX0XT32tPkQoc1nLwQ==
X-CSE-MsgGUID: RjNMxxk5TZC97E/RDjNHDQ==
IronPort-SDR: 69a46e8a_tGpoOMwMenIf8L2iZ7j+d0+3Di+Jt6Gw6HDXaJquvNE0Uru
 cvv1y/PSj24P701NiqhthWXZ6Y73mgKvmqA+Htw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HBAwANbqRpgA4P49RagQmEEWh9NAQLSYRYj1OGX4c8h?=
 =?us-ascii?q?1WMSwIPAQMBDU4BAgQBAQMEhHcJAo0gAh4HAQQ0EwECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw47hk8NgluBLIEmAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBHQJHRAIBAyMEGQEBEScPCxoCGA4CAlYbAQGCfoIjAQYQAQM2B6l4fzOBA?=
 =?us-ascii?q?YIMAQEGgmnXex8sIlmBZwkVgQouhW+CZQGGOIQ2Jw+BVUSBPIJLBzE+hRCDD?=
 =?us-ascii?q?oJpgiaBDo0DhhFSeBwDWSwBVRMXCwcFgSNDA4EGI0sFLR2BIyEdFxQfWBsHB?=
 =?us-ascii?q?RIhKhOCE3iCAQ+Ga3kDLngOIgI8XEo+CgFaBYE5AgELbT03CQsbBD2OZD+BO?=
 =?us-ascii?q?IUtpD6hRTQHgjiBZ4FkDJ9tBhMvg3EBk2AOkwuZBqlBgX8jgVwzGiRPgmdPA?=
 =?us-ascii?q?xkPklTCIUUyPAIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 MMzhttpvk3gjeSFjDZqAkImlw==
IronPort-Data: A9a23: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
 AzwUQ==
IronPort-HdrOrdr: A9a23:C+DHTqjCJx2jytt0lmVrjC/wbnBQXgQji2hC6mlwRA09TyXqrb
 HLoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhXotKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AbO9WiGro0U0t1923Ce3E8FnmUf4UL0b9/C/gHxT?=
 =?us-ascii?q?iFV5qcbqeEFm055oxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ACjDPOQ4knabuJ9/JVgshozG6xoxS4YKLGFAOzKk?=
 =?us-ascii?q?0kJjbGGtKFzW7rBiOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,318,1763420400"; 
   d="scan'208";a="265662835"
X-MGA-submission: =?us-ascii?q?MDHYjfHl3g7GDAwnyvKTXXvWHV4HR4GYd9vyGi?=
 =?us-ascii?q?FxHTet+D8Kcwf+LSF0MJ4cEDqQqtlLHelkYEGLFRFdB9V7QZGnvbpo3J?=
 =?us-ascii?q?URonOs3kCbm+ct8g2ah5JrVNFxZJp3EqZKUfFNugFKCdJwRU645stO4z?=
 =?us-ascii?q?Xi3QM1gtlnigMGJFWwKpJ2sg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 17:51:21 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhWop-1vSvAw0dGN-00iqn5 for
 <cocci@inria.fr>; Sun, 01 Mar 2026 17:51:21 +0100
Message-ID: <ea0289b9-912d-449f-a348-e7744a92f238@web.de>
Date: Sun, 1 Mar 2026 17:51:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dUzOamV4bydiLHm5f+Y0ggl8jOLiWOko6qcsNf9LSWuTLe+fdWd
 KIC3LqaO74ccQd/93GRRM98Etkg/lKzVj3+AvQnW7t8P6HK1FtfVoHazIkKc5q/1p6BRV/Q
 Fd31moVL03IrvtjsK3zQH74yC2xnePEiJq94JSriIUR5oRWfz8MDDEZtEa9aORQu3hBbUqR
 bHqQdRfujsSrI5LBZe6Kw==
UI-OutboundReport: notjunk:1;M01:P0:7KRNAN62yfE=;E9LXMPonaMo/At5GUykHq0Al+BL
 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
Subject: Re: [cocci] Reproducing a known patch with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3318
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/UAob0F181vGZUU-gpsdftg>

> * How should the data processing be improved in more desirable ways?

The following SmPL script variant seems to work as expected.


@movement exists@
expression action, context, last_action;
expression list el;
identifier member, rc;
@@
 {
 ...
+   last_action(el);
    rc = context->member;
+target:
    action(context);
-   last_action(el);
    return rc;
 }


How should related if branches be adjusted on demand here?

Regards,
Markus
