Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BFACF8859
	for <cocci@archiver.kernel.org>; Thu, 20 Nov 2025 13:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=L7PfPRwHq2eXeo4E9Z5JDxGgUyFN6gaT7RM3nzaG3Lo=;
  b=CkdWKFEYRxSGDkHzD+eKAbD2i9OBosb1U6RZso3VLKA3fEg9JiAs1ZW8
   CbAHjKp7l1ACifKV9+gY448W9Brpktwe91ABItdoCJK6QZZqCnfUkkGRJ
   09JNDoG691nSGUbjppPw0OhAY9IiFn/gGmOXfvlV7wcuLHcfC5Tz1w/4S
   w=;
X-CSE-ConnectionGUID: 2z2q2d8VQvyzQCyjSrqqIQ==
X-CSE-MsgGUID: l1DoXpycSlu06t3eoAaqAQ==
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
X-IronPort-AV: E=Sophos;i="6.20,213,1758578400"; 
   d="scan'208";a="250268743"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Nov 2025 14:36:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4BA62E0BE9; Thu, 20 Nov 2025 14:36:24 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2D751E0171
	for <cocci@sympa.inria.fr>; Thu, 20 Nov 2025 14:36:21 +0100 (CET)
X-CSE-ConnectionGUID: oash1Bi0Ts+eVvp21zk9eA==
X-CSE-MsgGUID: Am5jyan0SEm6wzZfmKIIUQ==
IronPort-SDR: 691f1955_UHSpKIT0L5UJ+vH8NVaNczklIdGnsdHzPneUfmkI2NHhFEA
 UG+TFQ5j1ze3qtXcyk0X3yCuVeo0B3F0/gscRvg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GeAwD+Fx9pgA4P49RaHgEBCxIMQIFFC4JAgQJeMwQLS?=
 =?us-ascii?q?YRVj1OCJIQ7jxGKToF9Ag8BAwENRAoBAgQBAQMDAYIMgnQCjF4CHgcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPD?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQJHRAEBAQIBIx0BAREmAQQLCxoCJgICVgYVAQGCfgGCIgEGEAEDDycHD?=
 =?us-ascii?q?bM1gTKBAYIMAQEG2l8fLCJZgWQDBoEcLoVugmUBhW6EeCcPgVVEgTyDAz6EQ?=
 =?us-ascii?q?4NbgmmCJoEOkDoGiQhSeBwDWSwBVRMXCwcFgSBDA4ELI0sFLR2BJCIfGBFgP?=
 =?us-ascii?q?RdAg0kcBmgPBoESGUkCAgIFAkA6gWgGHAYcEgIDAQICOlUMgXcCAgSCGH6CC?=
 =?us-ascii?q?g+IV4EJBVICAQttPTcJCxsGPZUIUYNngj2TAJ5alGM0B4I4gWeBZAyKLpU+B?=
 =?us-ascii?q?hMvg3EBk2AOBpMFmQaOCJs5gWg6gVwzGiSDNk8DGQ+OIYQzgQvBSEI1CzECB?=
 =?us-ascii?q?wEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:IBqTw63KnSUwoovBhQEaCwqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3Aw47b92v9W0c+qbkwqKaSsqOE6Isie2bdlV3Re3O?=
 =?us-ascii?q?jSmtXVqXPEE2Tqa5Nxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AQRoWbw9vaeud/5lo7a2/cpyQf+5tvqa/AUZVqrg?=
 =?us-ascii?q?D5daWByJ1GBa8sQ3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,213,1758578400"; 
   d="scan'208";a="250268727"
X-MGA-submission: =?us-ascii?q?MDENPzdWYGRX37tomknMrmOpUEF1VIiOML40FS?=
 =?us-ascii?q?AGbM1cBqmlBDB838mXmIJcc0tBa+ylqZqUk2D4VNtElhWF1ReSgh9dqR?=
 =?us-ascii?q?JyJyWnkA3o7kMLD2O/XdHe0QKRUuv2JCHN+3xQhxmNVXo5McCGR70VRL?=
 =?us-ascii?q?Yd/sz3bFYg8xtEbWcKCc5Vjw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 14:36:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763645780; x=1764250580; i=markus.elfring@web.de;
	bh=L7PfPRwHq2eXeo4E9Z5JDxGgUyFN6gaT7RM3nzaG3Lo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kkNtSt5rcpSv77vGUMRkLPiLcdpgrzNy9m+aymowFggjNMqjqZFPSjZdEHlJYG1l
	 v9FuLw+678UTFe5EmdWma2pfLIgasrTRbFVxrenajpzKbdqEIEHnLikbJhhkqaTAf
	 76mUBkl7txOC4/jHkqlj/DHGIVP1yT+8TpiDbbfHMAXplS3XS315PfVJx3r9rGeXG
	 X81+inkmXuqIRBUkLu0VzaoYQvik2kGlsk+oqX0iAcRp8Upsq7ICkd33DF5KlDZpT
	 Rn2Q4Q5mxzV0jAQJP61vVMIHs/bUXeHeVE9EIh8eH3tR2KfcJt0mlYJXjSw0ZsMjG
	 pd5mLMKoPxO4ZmlL3A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.176]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMGu2-1vc6JW0TO2-00TMWl; Thu, 20
 Nov 2025 14:36:20 +0100
Message-ID: <d06f7852-0a08-4a67-a415-cf096b0db478@web.de>
Date: Thu, 20 Nov 2025 14:36:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>
References: <2cd30151-1ac8-4e67-8ecc-962326931d99@inria.fr>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2cd30151-1ac8-4e67-8ecc-962326931d99@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ei196j+bLkgKCH2KuuOeIQdjgTYAXd9cqzXJnn0gO0k0Hjd/sel
 L/qL+nOmyUbkb6KOatXZSB+l9QaAVt/iAeCnuHCSEkyGxOReCUIqPBFINz+/jis/Gt8GUM7
 4cRBDe4JRvZx01uTbwqilOum96JukVqFUg8hX0AXiUh0AvDVMI8JbpjY/m0kzNpqFxf+Y6j
 qihEDCoiodpwOKpEtjvlw==
UI-OutboundReport: notjunk:1;M01:P0:QxkJIflhqDs=;2Joq+WJKktW/Uo+rg88F3MQwFAk
 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
Subject: Re: [cocci] Coccinelle 1.3.1 release
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3189
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/d06f7852-0a08-4a67-a415-cf096b0db478%40web.de>

> We are releasing Coccinelle 1.3.1, which adds support for scoped_guard a=
nd=C2=A0compatibility=C2=A0for=C2=A0OCaml=C2=A05.2=C2=A0and=C2=A05.3.

Thanks.

Would you like to avoid any date glitch with a companion software release?
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/2d5df416a939c5c7b9d=
958559be3b63e0b1414fe


Which adjustments are kept in waiting queues for subsequent releases so fa=
r?

Regards,
Markus
