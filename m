Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762BAFEA81A
	for <cocci@archiver.kernel.org>; Wed, 25 Mar 2026 07:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=etN8Xet1MEYNRlE76DWWMWZNpaA9wYqU0wI83cQuQ3o=;
  b=SnS3QhT+xWBUBpn8giubLU16eqYD68i24p2H1tJQnLxFjZvnQitx+g72
   4/etV6yj12JceQ34XZSDwQf/8CNr4s7T6V1eDUU8wAz3mRe4o4P2xGwXL
   nBfqN46QdFE01G0knICqBcCXHUYWFY0YSTtXXBexOC8xl2hCX+KE0PypR
   Q=;
X-CSE-ConnectionGUID: 8PAfe6ggSGyJqD7IouppQg==
X-CSE-MsgGUID: 4p7AeMEOT5eYIBFML6BcJA==
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
X-IronPort-AV: E=Sophos;i="6.23,139,1770591600"; 
   d="scan'208";a="269361352"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2026 08:20:03 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8BAA180E49; Wed, 25 Mar 2026 08:20:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 74C2C80097
	for <cocci@sympa.inria.fr>; Wed, 25 Mar 2026 08:19:45 +0100 (CET)
X-CSE-ConnectionGUID: /YPYv0QzTZKe8sB2PbEnqQ==
X-CSE-MsgGUID: A7Yny9fQQK2BhTNfdL+IcQ==
IronPort-SDR: 69c38c92_5dSfhZHUoXMelQfrffb6yrCYHrfz2Q3wMdEWEi/k9JPQxEV
 FO+a+YY7KGdFQ0Ji1LxG93ze2cDUG8EQ+BC9A/w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GfBwANjMNpgAMP49RaglkCgj9oH140BAtJhFiPU4Ihb?=
 =?us-ascii?q?INSjxGIeYNSAg8BAwENSgQBAgQBAQMEggyQGgIeBwEEMwYOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NSQEQAYIAgSyBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CDTptHQEBESc0AhgOAnMBAYJ+AYIiAQYQAQM2Bw2vH?=
 =?us-ascii?q?YEygQGCDAEBBoJp13sfLCJZgWcDBhWBCi6Fb4JKHAFziXwnD4FVRIE8glKDO?=
 =?us-ascii?q?RcEGIITgw6CaYImgQ6KDIdpgUocA1ksAVUTFwsHBYFmA4EGMjwyHYEjPhc0W?=
 =?us-ascii?q?BsHBYFsGA+IbYFhgRIBhCsCAQttPTcJCxsEPY1KM4ItgRYrYHpXk0iRPIxil?=
 =?us-ascii?q?GM0B4I4gWcFgV8MiQiBJpU/BhMvl1IOkwuZBo4JlWCFWIF+JIFcMxokgzZPA?=
 =?us-ascii?q?xkPklSEYMQYRTICCTICBwIHDQMLhUQBAYIGilCBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 PzwgLMeNBjA
IronPort-HdrOrdr: A9a23:OjOfbaxB7Lb4EKm+iJrQKrPwDr1zdoMgy1knxilNoG9uA6+lfq
 eV7ZMmPH7P+VIssRQb8uxoV5PufZqxz+8W3WBzB9mftWvd1FdARbsKhebfKlbbakjDH4BmtZ
 tIT4g7LsHsBl5nisvA7BC/CMtI+qj+zEnlv4bjJ2wGd3ANV0iM1XYBNu4Rf3cdeDV7
X-Talos-CUID: =?us-ascii?q?9a23=3AIpEpAGgyiS/Iq9ii3W/fpGmIdDJuNUzl/WmIGl2?=
 =?us-ascii?q?EO0VkGKa/E2ea1aV9qp87?=
X-Talos-MUID: 9a23:b+U8FQn+8SBO2B7LMKaSdnpLa/Zu8vWgMXkuy78Gh++KOQgzGjyk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,139,1770591600"; 
   d="scan'208";a="269361327"
X-MGA-submission: =?us-ascii?q?MDH0a098AYNN5TtmkaY67gcE0bUP5AmqCYP4BS?=
 =?us-ascii?q?rWObD5Hd4NhXHdxsxntiXk5AK3kuuHcgJHPqEV5mM8g77dyIUYMX/YGO?=
 =?us-ascii?q?p/SE6J1baBWqkAGeBmZPtsZgmCSqh+3qgj6r0tb38mFim636FsSjd005?=
 =?us-ascii?q?zMKs0uyE3hsqEaoPe9LpqLrg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 08:19:45 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc3F-1wJN1Z0wDd-004yDz for
 <cocci@inria.fr>; Wed, 25 Mar 2026 08:19:44 +0100
Message-ID: <d87a6e33-4c15-466d-b7a9-c7dac5d16146@web.de>
Date: Wed, 25 Mar 2026 08:18:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Xzk4voRpzJztMjA9C0lsXbvPknia0Lp6HDnVlCYylX6BextC/Ej
 5YGpbtfnCvpF/NGKGtxDeOE6U9+PX61JO/F3iZy+327FPHbckqJevf9TxpievEMICu1GCwy
 nrPTxMeGB8yIMZNH7U8rNAGNrYrvUBo5QRf45BGP5NATkzaf2LDCMXdG6PD4CgbAmlRRaIQ
 IvlrKc3K+unr3jMDYmObw==
UI-OutboundReport: notjunk:1;M01:P0:mkEfBAwpt/Q=;T5kBPO1TCOKRO+i0gHkE/S/oxfD
 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
Subject: [cocci] Adjustments for first statements from selected function
 implementations?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3446
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/DL5gaiiwwYuq0Z64wbntnw>

Hello!

A contribution like the following shows how a statement can occasionally be added
to the beginning of a function implementation.

PM: runtime: Mark last busy stamp in pm_request_autosuspend()
2025-06-18
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=18c1fe53d186867243f4cf17f4eef60737a16c4c

Such an adjustment triggers further opportunities for corresponding collateral evolution.
The semantic patch language can help in the determination to some degree
if the mentioned statement is still specified before a call of the known function
at other source code places.
A desire can evolve then to omit repeated statements before more selected function calls.

Usual case distinctions trigger further development challenges.

* How would you prefer to manage function names (for SmPL scripts)?

* Several inline function implementations are also stored in header files.
  Some header files tend to provide contents which are not really supported
  by the Coccinelle software so far.


Would you be looking then for further possibilities with improving affected
data processing?

Regards,
Markus
