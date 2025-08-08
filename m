Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA62C87FD3
	for <cocci@archiver.kernel.org>; Fri,  8 Aug 2025 08:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=OGjngIfVY/QozJzXiPrF0hwznW0abJavfzlZlA876lw=;
  b=ZYL8d2xZ02JExEjjuKEAOheomvjpyM2sgIIqOAg+ayTM4OUuAy55tS9i
   9eDP0q1T7mP/yVST2Jm5OIyV8FrYKIPjDMYR5uwO18J6XlPw2Ol71zk4K
   c5GMkFcFM4wlfL+Elpf2YFNoZ92wMZ7U2FGMOdLE2HCHftkF/rYlEhqrS
   I=;
X-CSE-ConnectionGUID: ap+EOh51QPCJ2aW8rCJqtA==
X-CSE-MsgGUID: S86xcpDARhC0WVIjMcjRQQ==
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
X-IronPort-AV: E=Sophos;i="6.17,274,1747692000"; 
   d="scan'208";a="234521032"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Aug 2025 10:00:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 01EACE0BE9; Fri,  8 Aug 2025 10:00:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 216ABE0171
	for <cocci@sympa.inria.fr>; Fri,  8 Aug 2025 10:00:22 +0200 (CEST)
X-CSE-ConnectionGUID: lqvwyASiTXi1mzoAsOYUPA==
X-CSE-MsgGUID: 7YAKKduQTP+IdnfWZ4enwA==
IronPort-SDR: 6895ae95_r01UaLG3JL9LHBuNXw9FZ7plrrA6FulboikBk9LTggK1Otu
 mqheznko7E1iQydTl9GDXY+vEpIwT+dXhwR6d0A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G4JgAmrZVoeAQP49RaHgEBCxIMQIFIC4JEgQRUMwQLS?=
 =?us-ascii?q?YRVj1CCeYNmhzyHU4h3gVWBfg8BAwENTgECBAEBAwSCDIJ0jCQCHgcBBDIHD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAUMOCjGFew2CR?=
 =?us-ascii?q?QEEAQEBAQEBAQMDAQEMAYEhgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdGJx0BA?=
 =?us-ascii?q?REmATQCJgJzAQGCfoIiFQEDMge2U4EygQGCDAEBBoJp13UfLCJXgWUJgRsuA?=
 =?us-ascii?q?YVsgkkaAQVthAqEbYEhD4FVRIE8C4hGgw6CaYImgRaDY4QSiHKJGIFKHANZL?=
 =?us-ascii?q?AFVExcLBwWBYwOBD24yHYEnhAqBDoQnK0+FEEFYg1MkbQ8GgRWDcwZXQAIBC?=
 =?us-ascii?q?209NwkLGwY9k26FApVWsWiBCjQHgjiBZgWBXwyJB5ZgBhMvg3EBk1gOBpMCm?=
 =?us-ascii?q?QOjXjmFIIFvBi2BXDMaJIM2TwMZD44hhDO2TEE1PAIHAQoBAQMJhUYBAYxBA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 DMXzLm+IYlBb+XG
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:olkgnaGEY04SBCMepLqEXMeALOsnbusQ8zAXPjNKOGBom62j5r
 qTdZEgvyMc5wxhPk3I9erwW5VoBEmskaKdgrNhRotKPjOWwFdA/LsSlLcKqgeIc0aSmoE9tZ
 uIMZIObeEYZmIK6voSlTPIbOrIruP3kpyAtKP3y39zTRsvT6ds7wh4BgvzKCNLrIosP+tJKH
 Pl3Ls7mxOQPU0NaMK1H38EWPWGieHqufvdEG07Li9i0RKJizyw7r78Dly/5TcxFx1y4ZpKyx
 m0r+Tejp/Txs2T+1vkzGnU4I1RmNz9juFbDMjJp8QJIjXokEKFY44JYcz9gNnwmpDc1GoX
X-Talos-CUID: =?us-ascii?q?9a23=3AAwjPO2kADDcPOOUgda1mHSpIIn3XOXnE0mjBCnS?=
 =?us-ascii?q?5NVZoEbiHTnaL35JZq+M7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AlMeHfQ1YoapAFDyFHbtpCdU8wTUjvJWHK2MBjKw?=
 =?us-ascii?q?6g4qlOSp+BAXBgTKoa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,274,1747692000"; 
   d="scan'208";a="234521023"
X-MGA-submission: =?us-ascii?q?MDHcVyGr6sWHDujLHfN9d7VNExW3QAFCqoCONG?=
 =?us-ascii?q?gtRCqpFf+nTY95PrQ6DrXwZBrzhrI3s0oegHUc8PlHjzWi+jdaKUAhUu?=
 =?us-ascii?q?Q5vR1dcU/UkjBbC1/X55pxzUzE2kQwjG40hx/GhA2sn+TAevIPkpOSFR?=
 =?us-ascii?q?uTDD3JYOvSJIoMQfc992/+rg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:00:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754640012; x=1755244812; i=markus.elfring@web.de;
	bh=OGjngIfVY/QozJzXiPrF0hwznW0abJavfzlZlA876lw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JBamBZX/vFN6M2LEe/G1BXu/fIXHZl0321qnXuq/HBLdC3OryB6XrB5xIDdbmFj5
	 78bfsoU3dRMFPeUXTwIZBhZS812YfucxY8wOzxtQ/nXu4astwbhRlRIPc/mS0Y76t
	 JH9R60vkN6CnyfpkqG6s5AMmDv2F6Po+4DYSOFXVleKSSi8D8dYOzyaMLRW1xJJio
	 i8b79tgoL4sAcB58lj6Lx5lkt0q0LvHyCjah/RAjR48rHe/vsxiBPHNT9DXmD3BgA
	 Qfa7paA7R6iSMXcPUb04TlY3Rm+7Y8XDLlBUKktXCalKI+vu1y/oEUwYhfGW/nXMa
	 K5yPbu9vA41eoQOxoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.242]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McZnl-1uBlc93HDx-00p1nE; Fri, 08
 Aug 2025 10:00:12 +0200
Message-ID: <0bf5c015-bb4b-42ff-9734-d7de549417e1@web.de>
Date: Fri, 8 Aug 2025 10:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
Cc: Michele Martone <michelemartone@users.sourceforge.net>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ji61n2+Br4tY4bxCtFjj1CB/HqA39Ci/DyO74Rx6f9UcqU5LSD3
 tKplUH/oIXBLOAqd7PvH4l3wVAUKWxelngsHI0hYjzSrdRiuAcv6YZmuJGxOGuJsKPBuI8p
 QPXQA85COrryBG4fNFD65WYHOGF7ElI4AgT58JHamJADi+o+0LBjxZ7Y3jD6Xyl5dV1UeLT
 B/J8CW4Ki9n9Xap8LKJLQ==
UI-OutboundReport: notjunk:1;M01:P0:OsFWPAvDyac=;BRJ7w2Z05h+93j0KgiR3uih/2CL
 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
Subject: [cocci] Searching for C++ delete expressions (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2967
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/0bf5c015-bb4b-42ff-9734-d7de549417e1%40web.de>

Hello,

Another SmPL script example:
#spatch --c++
@display@
expression e;
@@
 delete
?[]
*e


Questionable test result (by the software combination =E2=80=9CCoccinelle =
1.3.0=E2=80=9D for example):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci show_delete_expressions.cocci
=E2=80=A6
warning: incompatible arity found on line 5
=E2=80=A6
delete [] *e
=E2=80=A6


How will clarification interests evolve further for this issue?

Regards,
Markus
