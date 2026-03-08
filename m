Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18022EA8520
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2026 14:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gv8ydQphPoY1V01E7ezqtK1kA9tJJUO4o0SawqcBUDo=;
  b=H/rOEDx14AjZgkCCmJ7EbP4/sdwvp+vKJ14i44IAImcsRQF8MKEXWttU
   6NaUD3vcC/HIWIeH2DdMgImSxmHN+8k6nLtXt5+Tu+HiWTo6RZcOBw61k
   K1EraJFV/4ZO3KLGGg4+TH7cRw6NOcFay0unvJq3ORc8znAHcnr/Qm7gV
   Y=;
X-CSE-ConnectionGUID: Kf2UnOK+Qm+VNmjiW/7DtA==
X-CSE-MsgGUID: GF2BpjA6Tbq4LkQHTRDtdA==
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
X-IronPort-AV: E=Sophos;i="6.23,108,1770591600"; 
   d="scan'208";a="266747309"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2026 15:55:35 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8A4FB81549; Sun,  8 Mar 2026 15:55:35 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 54E8281455
	for <cocci@sympa.inria.fr>; Sun,  8 Mar 2026 15:55:27 +0100 (CET)
X-CSE-ConnectionGUID: Pl3vPxZ4SSmp+4JoLqMvWA==
X-CSE-MsgGUID: ROkj3W0CT+i7nuc7BPY/4g==
IronPort-SDR: 69ad8dde_aoO2qYZJ7CofRNRRpTu2BupXPj1Dz9M3iVnKIxOJu3+VBwV
 HTMrkX+Urlw5ikFFBIdYongBMscYYvwWWsKSxmA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EeEAAsja1pgA4P49RagQmBUoI/aH00BAtJhFiPU4Ikh?=
 =?us-ascii?q?DuHPIdVik+BfAIPAQMBDU4BAgQBAQMEhHcBCAKNIQIeBwEENgQNAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgmIBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEECwsaAhgOAgJWBhUBAYJ+g?=
 =?us-ascii?q?iMBBhABAw8nB6sdgTITboIMAQEG2mQfLCJZgWcJgR8vhW6CZQGJdHonD4FVR?=
 =?us-ascii?q?IE8glIxPogegmmCJoEOkytSeBwDWSwBVRMXCwcFgSNDA4EGIw88BS0dgSMhH?=
 =?us-ascii?q?RcUH1gbBwUSISqBaXiCAQ+GaHkDLl4aDiICOlxKPgoBWgWCJQIBC209NwkLG?=
 =?us-ascii?q?wQ9jnI+hBBvpiShRTQHgjiBZ4FkDJ9tBhMvg3EBk2AOkwuZBqlBggICHoFcM?=
 =?us-ascii?q?xokgzZPAxkPjl+DdckGRTI8AgcLAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 t3SRDNKNBgRlgiovfkxDBoPk+tf6iEz1g/FGwEU
IronPort-HdrOrdr: A9a23:hNNO66EUq+wJM4gypLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:scpQ9mzzNTIktHm2uxqZBgUsHps7Sm3vkEzrJlf7VURubKSwV2C5rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AflqUog8EjsyItFhDaNsgXYiQf/1P4Kb1NxgmrdY?=
 =?us-ascii?q?H5M+ZPnNaAwba0DviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,108,1770591600"; 
   d="scan'208";a="140720209"
X-MGA-submission: =?us-ascii?q?MDHn4Wl2gQe0uUXx88lzAw4oxUFSDMTBFv80xQ?=
 =?us-ascii?q?mRGdHz2q6jr5VYXoUSXMBf58iKn/3CTnJ1ZfSeZFhbxEJk+3M4LksEMC?=
 =?us-ascii?q?shI0XEZ/lNLg7iAo6RHKUlGKFaQc9oogPwXtpThwv4G/OrHbtPXv+Olc?=
 =?us-ascii?q?TiYNDi4ONgWJWYtcJtIYoxqQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 15:55:27 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Myv70-1vmYAh3PEY-010F93; Sun, 08
 Mar 2026 15:55:25 +0100
Message-ID: <576f0704-7ceb-4e0d-ae1d-1beb1eb1efc3@web.de>
Date: Sun, 8 Mar 2026 15:55:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
 <f25025ab-4500-4315-b41c-53cd5775c69f@web.de>
 <20a815aa-5fa9-4b34-ab81-d6985ed193c0@web.de>
 <bc3eaab-b09e-4e67-054-b522d723c6a@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bc3eaab-b09e-4e67-054-b522d723c6a@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PN+0EzeCb+uwRvdkFXy8U3u6Nnkw7OQo7IydciC5J9Ge6bPSRmB
 mOAg5SPmVpZagICWm0kGNHmNZyobZFJ+mtWp437/yMVvUQbOH/XMSD1EWxnKKCItEeRRcYu
 iHdeK5M7rgvzW3yJNLN7Q70wRIJeybe7ZeuxzHTrV6gyWXOeizL3Vzr2fkeJ/unnMADAfJp
 p4KdWhD7/iVLIq7JREGKw==
UI-OutboundReport: notjunk:1;M01:P0:PDHzAk4Mho4=;VfZ9I6Fc/DTG7lQBqSAYsagYhem
 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
 uIaVABSPVsPDLRyOU=
Subject: Re: [cocci] Reconsidering source code search challenges for nested
 compound statements
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3331
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/UC_y-JV0GaoIcJEaeGd9lw>

> I have no idea what result you would like to see.

Under which circumstances would you dare to acknowledge remaining open issues here?

Regards,
Markus
