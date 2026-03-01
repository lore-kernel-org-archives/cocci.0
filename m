Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A800BFD0066
	for <cocci@archiver.kernel.org>; Sun,  1 Mar 2026 12:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=C0zKpATYEM9ktmf0TY6AnVvlpXzAUM6vCuGH6vl/fZc=;
  b=YO9DDkpDE5cKbPHxigcd9b3fbZHW4GJG6RjR9H14JAyVd4Ek/vVQ4cVK
   fppsoIQlj/2YGFR5aKl9a7hOulFrLK7VetEu22//8ObFHBvwm/AUTIknN
   0bApSYgr+7BSSU9dYxTyus0TlbL3aiay6NZRWNWNE4nWS5ml7Wpdo393Z
   g=;
X-CSE-ConnectionGUID: dM4yVlPITFOQabQM7aYqtQ==
X-CSE-MsgGUID: catgWziPRpy/KBZ+tYsfCA==
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
   d="scan'208";a="265650447"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Mar 2026 13:39:21 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 40A3F80EEC; Sun,  1 Mar 2026 13:39:21 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D416880E19
	for <cocci@sympa.inria.fr>; Sun,  1 Mar 2026 13:39:17 +0100 (CET)
X-CSE-ConnectionGUID: rab/OyR4TG+B1wKCfXa2fg==
X-CSE-MsgGUID: dq1I9BCiRa+2kx3sZ6NU+g==
IronPort-SDR: 69a43375_YAhimxOq2FUZzzILIIXAXTBZVoCOwAavpwilfpPT14OfD+Z
 awDz9krwiDc22Vfr/UvtzsZoTkaZolvE7Z1vXcA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0F+AwDoMqRpgA4P49RaHgE8DAILFYFQgkFofTQEC0mEW?=
 =?us-ascii?q?I9Thl+HPIdViHmDUgIPAQMBDU4BAgQBAQMEggyQFgIeBwEEMwYOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDjuGIC8NgluBLIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQJHbR0BAREnNAIYDgJzAQGCfoIjAQYQAQM2B6pHgTKBA?=
 =?us-ascii?q?YIMAQEGgmnXex8sIlmBZwmBHy6Fb4JKGwEFbooiD4FVRIE8glIBAYV9gw6Ca?=
 =?us-ascii?q?YImgQ6TFIFKHANZLAFVExcLBwWBZgOBBm4yHYEjPhczWBsHBYV8D4pXgRIBg?=
 =?us-ascii?q?hgCAQttPTcJCxsEPY5kP4E4gnyVM7MBNAeCOIFnBYFfDIkIlmUGEy+DcZNhD?=
 =?us-ascii?q?pMLmQajaYVYgX4kgVwzGiSDNk8DGQ+NdgEBAYRbwgZFMjwCBwEKAQEDCYVGA?=
 =?us-ascii?q?QGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 QPXqcNy5U6rmK+Dx2g/OCc=
IronPort-Data: A9a23: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
 AzwUQ==
IronPort-HdrOrdr: A9a23:60GUYaCZmhFr2snlHemO55DYdb4zR+YMi2TDpHoBKiC9Ffbo8P
 xG/c5rsSMc7Qx7ZJhOo7+90cW7MBHhHP1Oj7X5X43PYOCOggLBQb2KhrGSpgEIdRefysdg9e
 NHb7V0DsH2AGN3lMDg/WCDYq4dKZW8kZxBno3lvhFQpOxRGthdB4wVMGymLnE=
X-Talos-CUID: =?us-ascii?q?9a23=3AAHX+SWn6tuSpDE4qSUx0R8GGpqzXOWfUxjD3MnX?=
 =?us-ascii?q?kNUkqYuSKanSeyKo+ncU7zg=3D=3D?=
X-Talos-MUID: 9a23:t6lBCgrtFYEc6dDWMoUezz17beY5yY+vMklOy5YW4NK2awpNeDjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,318,1763420400"; 
   d="scan'208";a="140079057"
X-MGA-submission: =?us-ascii?q?MDGF8NM59xSwY0Fwae5GzIgl1j6Rx1cR+OMPbO?=
 =?us-ascii?q?N2CJe3/JoZlnSZz79D60bZyY79gAjwACnrMVwry1RrUy71e/f+7Cg3/g?=
 =?us-ascii?q?ZVETHcI5LrrXJMBmEp/my2fqvSyTI3NS+NCYwwwW5O7Yi/FkrtINxJ89?=
 =?us-ascii?q?/kciMLE50k+p1WP+mRnSoe2w=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 13:39:17 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6lX-1vlbPH0GyN-016wX9 for
 <cocci@inria.fr>; Sun, 01 Mar 2026 13:39:16 +0100
Message-ID: <30ca5b1f-1add-4ce2-b01c-495966773a98@web.de>
Date: Sun, 1 Mar 2026 13:38:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lG2keqzMIvPZ8jzT7IpTh8sT//IeT3m88IHNeWtIFgf2w16BQOS
 CaaC78cBaJ381iCU4z9qGfMDtLmE8RtkGhZ6m89yFDZbhYqIzx+O5Ey50cFwfTNN5pONvu4
 fro96wAjuiB6hNFEtbvatYnOGXPuSBYLQ//eEx223c0xYV5ByLCC+wUgqlYS4BhxXFTJvo6
 vLU5XBLPylQ/7YIHTMypw==
UI-OutboundReport: notjunk:1;M01:P0:ShprYLfTBc0=;Gw2Qk1tunhJc/bMm6CvWeRFlXG4
 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
 Ns9whl4bV3jog9lWKx3l+fntIEHur3B2wnAybJ
Subject: [cocci] Separating label from previous key word display
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3313
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/E4T9hSqblCrVRt7fQWTWoA>

Hello,

I tried the following SmPL script variant out also together with the softw=
are
combination =E2=80=9CCoccinelle 1.3.1=E2=80=9D.

@replacement@
expression action;
identifier rc;
@@
-action(...);
-return rc
+goto special_target
 ;


Questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-parse-cocci test_parse_goto_display.cocci
=E2=80=A6
-action-(-...-)-;
-return -rc
  >>> gotospecial_target
;
=E2=80=A6


How can it be achieved to separate the mentioned label from a correspondin=
g
key word display?

Regards,
Markus
