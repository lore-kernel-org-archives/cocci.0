Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859F9CEB2CA
	for <cocci@archiver.kernel.org>; Sat, 15 Nov 2025 09:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=9fKAD2yR9JDQIn8hgzEJDg2Oi5rYu1Lk68UqHnQ/FYk=;
  b=TFQ31JMuwf5SBCtFqXG4+ZM2mqUCZyNjPWbEQikNA2AWKo7FWYE2MOJr
   4rbGdRushyTAfSLdxZmMvY7RjBjVKHML4epWMki0WDgd1dsqQlnmrcaM0
   c0xe358LOBsAVBf7camorio79mvM/O8sgyKFH/ce7ITph9vvu60f868Vs
   k=;
X-CSE-ConnectionGUID: FyYZIVnXR4e68a+VtWGPWg==
X-CSE-MsgGUID: RpZu4p6BSIejQfKgvac//w==
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
X-IronPort-AV: E=Sophos;i="6.19,306,1754949600"; 
   d="scan'208";a="249307525"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2025 10:27:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B72B0E0264; Sat, 15 Nov 2025 10:27:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CD3A2E0171
	for <cocci@sympa.inria.fr>; Sat, 15 Nov 2025 10:27:11 +0100 (CET)
X-CSE-ConnectionGUID: QQpssao6SiGEZFbDW3U1Ng==
X-CSE-MsgGUID: vv7TZBDmQN+fb//lk3xwwA==
IronPort-SDR: 6918476f_dO7ORxffQ82zll82AmR8T50sFEliJA33oRFDDslInn2ogyO
 ZJEYUSjWIF1honbJXYoHwBWMPzjrLJDFhNbKU1g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FpEQDFRhhpgAMP49RaHgEBCxIMQIQQZR0GWDMEC0kIh?=
 =?us-ascii?q?E2PU4ZfjxGIeYNSAg8BAwENSgQBAgQBAQMDAYIMj1ECHgcBBDQTAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgluBLIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECR20dA?=
 =?us-ascii?q?QERJzQCJgJzAQGCfgGCIgEGEAEDNgcNBq55gTKBAYIMAQEGgUYCEEFQ13YfL?=
 =?us-ascii?q?CJZgWQDBoEcLoVugkobAQVuihoPgVVEgTwLgkeDUAEDgiuDDoJHIoImgQ6Zb?=
 =?us-ascii?q?4FKHANZLAFVExcLBwWBYwOBCzI8Mh2BJEEQCHE9V4NJImgPBoESg1GJHA+LA?=
 =?us-ascii?q?gIBC209NwkLGwY9lSVRgw4tLJV5swE0B4I4gWcFgV8MiQiBJpU+BhMvg3GTY?=
 =?us-ascii?q?Q4GkwUemGiOCJVgE4VGgX8jgVwzGiSDNk8DGQ+OIYQzgQvDMUI1AgkxAgcBC?=
 =?us-ascii?q?gEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 JdcE9eztXQwEe4GTFtoFpoOLcUvNg4=
IronPort-Data: A9a23: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
 QwhtFcfNBg=
IronPort-HdrOrdr: A9a23:4K87R6pP6uoURumKcW9GDh4aV5oJeYIsimQD101hICG9Afbo9P
 xG+85rsiMc6QxhPE3I/OrqBEDuexzhHPJOkOss1NSZMjUO2lHFEGgK1+KLrgEIcBeOk9K1u5
 0BT4FDKJnXEUVwi9r87TK1CtA63bC8gdiVbKvlrkuEVmtRGsddBupCe3+m+sYafmN7OaY=
X-Talos-CUID: =?us-ascii?q?9a23=3AVmvQMmtrReytDPwN0+pE4BrM6IscS2XG137XfXS?=
 =?us-ascii?q?5JktbZre5dgStoYVrxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AU6jTFA3pWRXH4rcJx2o6/r6r+TUj/brxNHInvZA?=
 =?us-ascii?q?/nYqKP2s3PzTGnCuoa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,306,1754949600"; 
   d="scan'208";a="249307524"
X-MGA-submission: =?us-ascii?q?MDHNNVZ2HHjJFu8Do52+SCoYffcXk6NOpMLth/?=
 =?us-ascii?q?cRB6Uld5V5PjjC8Sy6xZKb6DD+il3K1j/e0DwxQpL0ExvWWgZwcsqxQq?=
 =?us-ascii?q?89SBSNi2RfXZ3V4BHSjkFtAg71xhb4SBj6PnuUXJ+R7oJShxpaMGVivR?=
 =?us-ascii?q?Pa8UkzTZ6W95ECX4w6ELcKOw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 10:27:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763198830; x=1763803630; i=markus.elfring@web.de;
	bh=9fKAD2yR9JDQIn8hgzEJDg2Oi5rYu1Lk68UqHnQ/FYk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dx6xgWgFs2Kdy9Od0cBZzg34lHH4OViPfTrUkXPOuRc38QHUx1sy47y4htuDxGOk
	 jTWIdoXM8V+A7OeLlrYz0EGU/axYVI/7zxwii1sdQI6Stob+Jn1cT3/eDbSazOHEy
	 CUO4iHfs4Nx9GGWRc5VB43bgaJGyc3dfHsCzD8ltPDXkmqpINJE77DTywLifZwgk7
	 +E3gWiQlIqAp9RWjZyYcwkr/nobaI9zeDxAGceQfYA3/Oo8jVsK+wMb1lbFB8lYrW
	 7VrlatuSy85ATDohVeeQCFuHVUnJw2wPJdq+p7wUStuJj/0LEdBOBWUimCNRMj0kU
	 BcgPQnIJqV2jCnyQMg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.174]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V26-1vKkWa1Xtq-003Eyx for
 <cocci@inria.fr>; Sat, 15 Nov 2025 10:27:10 +0100
Message-ID: <f29ecd7d-5841-4989-b3c9-1055a6df5eec@web.de>
Date: Sat, 15 Nov 2025 10:26:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jjp6Y1Sz75Dxi2zQjySCeZg0z+8w8LsrCQKASi28PsDzyUBBLEU
 isMQkT5fL5r8t9fvAgAvqNo7biaFP+rax9woBewDlHwIcWZdcAI/CZQacCyFFhgSMx2njtg
 DvUP6JKeBc/NSCEfP+tLPFKHXunjqOWeS1X0kDlzR7y+XEiTj9KM4zYao+aRfFfb/XxocJ7
 QUNDTJsg15Hm+eWc9BrDA==
UI-OutboundReport: notjunk:1;M01:P0:VYm8gKula0A=;j58r74SIVRdAQzFjmeWmfPDNIpe
 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
 YD6XPjEtCMqjX6fSA=
Subject: [cocci] Missing file filters for data processing with SmPL scripts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3177
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/f29ecd7d-5841-4989-b3c9-1055a6df5eec%40web.de>

Hello,

The Coccinelle software checks if file filters can be applied by a tool
(like =E2=80=9Cgrep=E2=80=9D) for the evaluation of scripts in the semanti=
c patch language.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d2731=
a9d546dc4f0b181526e/docs/manual/spatch_options.tex#L24-25

Under which circumstances do you observe the information =E2=80=9CNo grep =
query=E2=80=9D?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/e6f8731b851f5d76d2731=
a9d546dc4f0b181526e/testing.ml#L660-679

Regards,
Markus
