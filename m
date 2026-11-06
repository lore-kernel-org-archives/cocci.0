Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63D606A32E
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=vAe/VDOp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9qaQPULHmGhMMXN/t8R1NNj3C4xlt2X3k7MVn4b1bE4=;
  b=vAe/VDOpSqKDMQSn+Ggjm+LjavFcc6pV1Du9ZDOGAJQTRpY5OuM37sUq
   gP9XeTF+kYjMYSyadWhDKZgN6N9Ri14CNptpQDj0VlSybgVFAvZI8mgga
   UtFZRLbqMnW/254oHTX+WJfUAnEf8SM5ZNJHfIK2yRFH6PrXXxE7nOc4I
   E=;
X-CSE-ConnectionGUID: W38PzZhCTqSGGX1w22TDyw==
X-CSE-MsgGUID: IEXwyD0EQNCedZecTbW0OA==
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
   d="scan'208";a="304323711"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:29 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6E42081753; Sat,  7 Nov 2026 11:59:30 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 00996818E5
	for <cocci@sympa.inria.fr>; Fri,  6 Nov 2026 11:06:43 +0100 (CET)
X-CSE-ConnectionGUID: is3XI2CGT0Gs7RsLDhaqhg==
X-CSE-MsgGUID: 6OCrkq4BQ3y381wHg/aEjg==
IronPort-SDR: 6aeda6b3_72aRa6L2IzbOGCDzLY3PBcp4f96wAQtlsNVh+ILJd0Sn8ED
 uTk2cIyBjpReQfv6HaQsdVYO26fvlnvL3yBPaxQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GlAAD1pe1qg07ASNlaHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wQBAQsBgkCBazQEC0mEWI9TgXQwi3iHVoh+g1ECDwEDAQ1OAQIEAQEBAgSCC?=
 =?us-ascii?q?4JzAo4eAh4HAQQzBg4BAgQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDA?=
 =?us-ascii?q?QEBAQIQAQEBIRkHDjuGTw2MGgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBI?=
 =?us-ascii?q?x0BAREmAQQLCxoCGA4CAlYGARQBAYJ+giMBBhABAxAnB70/gTKBAYIMAQEG2?=
 =?us-ascii?q?msfLCJdgWsJFYEKLgGFcYJtAYY0g0h6Jw+BVUSBPAuCSDE+hEN8gmCCaoImg?=
 =?us-ascii?q?QyIGo8kUngcA1ksAVUTFwsHBYElEDMDKi8tIw88BS0dcAwnEg8dFxEeWBsGB?=
 =?us-ascii?q?RIgKkFDW4ESgQddgSsoXQECH0YtFYF2AoJRgSMCWwIBSUEOB0VTCSVDEkckI?=
 =?us-ascii?q?ggSCQETGiwKgRo1PAkmBDsVDGQLGgUaRwgCCwIMdCgREBMdHiQvBRwmPhsKL?=
 =?us-ascii?q?209NwYECxkEPZMzhn1Gxgg0B4I5gWqBaAyfbwYTL4NxAZNhEJMOmQgjqSGBf?=
 =?us-ascii?q?iSBXDMaJIM2UAMZD44iGYQcynlGMj0CBwIHDgMLhUQBAYxWgUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:dRJrsKE4E0HFly8XpLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AH5Ax1GjNJbTBT/2OvstYwb9j3TJuc2aG/FaKCGC?=
 =?us-ascii?q?EUUlyF4eObXOQ8bpknJ87?=
X-Talos-MUID: 9a23:mw9E4Aqa8qBdtVDcdxkez29FH91r+viEMRscysVfpOmLciVdOTjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,197,1787004000"; 
   d="scan'208";a="161936113"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHldS6AFLlNCwKODY+DNSqzrFNRfGAButl6p8?=
 =?us-ascii?q?0yC0GKmQe5gUlUKb0JFU1Ee5pss5Ne8Xt3pcYEa590S0unzarj7dvt5k?=
 =?us-ascii?q?e+Wbcd/q+sgWiJwSFqEv0pjVe+0aZ7RuEChsb3QLUtXrVu6COqRlCYax?=
 =?us-ascii?q?uM904Eb9AlzOzKQt8MIW9VGw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 11:06:43 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKuON-1x4AgX3E8z-00VhqX; Fri, 06
 Nov 2026 11:06:32 +0100
Message-ID: <b0b99c1a-59ff-4948-9e7c-cff3da8acc6e@web.de>
Date: Fri, 6 Nov 2026 11:06:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr, tools@kernel.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <52418f50-b3ff-461d-8e66-c10f70e35b2a@web.de>
 <161f567a-f33-7865-8787-844a299ef9c1@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <161f567a-f33-7865-8787-844a299ef9c1@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gOjFVs95ad/7s+/u11uuD2Baa9cl4J+7AnQhYKxtXgjzhhOUW/k
 jd7eq9EooVgeNm3XTqY6tuH7DUx4sZbRNqEz8llzq6hGTi/R74adXGZgtGtCGx4CcK51B9/
 SL8082OkZhfMkbBuI+322h4CPSVj7wH2fKxIKKMpishHeKZT5u+xsKaLmMQfOBrMsa3X7XV
 38YE8KzEALJDk8bGzGM8Q==
UI-OutboundReport: notjunk:1;M01:P0:q701Lyem+j4=;nYux1a6O2DfrWWVwJsN3XB2998C
 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
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [RFC] Determining reachability for selected source
 code?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3782
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/_nyDQu49tofPH85aoozN-g>
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> I have not tested this.  It might not work, or =E2=80=A6

Will topics (like the following) become more relevant also for programming=
 interfaces
by the semantic patch language (Coccinelle software)?

* reachability analysis

* dead code elimination

* source code fragment exclusion

* data flow tracking

* call graph


Regards,
Markus
