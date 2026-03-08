Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B485EA853A
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2026 17:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+RxcWVIzjkcf2xxfcqWrft1qsZ0MQJ/SWoufJC8pS6Y=;
  b=vNINfkRZeCCpq5MTGlVWASGIwczOk/pQsvZStN9kUDTk1taKzQZhDZvN
   KgJKH9YPXlE1/uKELW/FOwVhtHuEt1uitHNDSblyMSx7zTeRBEgefSmnE
   NhU+5jiLMsSS1Sf4cP/MkAq2Xc8CYlclNS0z44c/e85O/TPrQ2QDY+uXe
   I=;
X-CSE-ConnectionGUID: lK5ImRAJSJG08TY+uw4uHg==
X-CSE-MsgGUID: y7Mu7P/1Q8OM4hB6ZerpDQ==
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
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266753761"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2026 18:52:47 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id E714280D28; Sun,  8 Mar 2026 18:52:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 6C95180D28
	for <cocci@sympa.inria.fr>; Sun,  8 Mar 2026 18:52:41 +0100 (CET)
X-CSE-ConnectionGUID: f+sq+yTAQ7CmEbHewZU32A==
X-CSE-MsgGUID: K4Mn0EE5T/uaHZbnDhxjcw==
IronPort-SDR: 69adb76a_dQ9Aj0vOmJLtTeHiR6VUDMHvWBzVkYF+cPjWQTReMfycDJP
 GHQ7P5wBLoqvOcu7cUXd6TN2f9MLmCYQ7JF4dgw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EwBAB2tq1pgA4P49RagQmBUoI/aH00BAtJhFiPU4Ikh?=
 =?us-ascii?q?DuHPIdViHmDUgIPAQMBDU4BAgQBAQMEggyCdAKNIQIeBwEENQUNAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgmIBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJw8LGgIYDgICVgYBFAEBgn6CI?=
 =?us-ascii?q?wEGEAEDDycHq2eBMhNuggwBAQbaZB8sIlmBZwkUgQsvhW6CZQGGL4Q/Jw+BV?=
 =?us-ascii?q?USBPAuCRzE+hEODW4JpgiaBDoxdhk5SeBwDWSwBVRMXCwcFgSNDAyovLSMPP?=
 =?us-ascii?q?AUtHYEjIR0XFB9YGwcFEiEqgWl4ggEPhmh5Ay5eGg4iAjpcSj4KAVoFgiUCA?=
 =?us-ascii?q?QttPTcJCxsEPY5yPoNKyR40B4I4gWeBZAyfbQYTL4Nxk2EOkwuZBiKpH4IAI?=
 =?us-ascii?q?oFcMxokT4JnTwMZD45fg3XJFEUyPAIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 g==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:V+uzGKrFhxV/rB8K3seN6wwaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:coS0KW+l/KgHfP4lV5WVv0BXAdlmY0H09Sj7JmKyKWt2eoDOE3bFrQ==
X-Talos-MUID: 9a23:AbCAegS+lefghvm2RXTP2BRkbOpFvpjpFUkto58Al8mUNydvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266753752"
X-MGA-submission: =?us-ascii?q?MDGSBxBEOwYx5XERBTKsow7RrW9jTPMFd6EEfA?=
 =?us-ascii?q?W04nGE+YFYHxKexUdEW1XQxtOvCCa6vScXNI7SMQINfjzvawpY2lOAEm?=
 =?us-ascii?q?9pVkGeuBARayWAsB5i9EMurPyNw878Z4l4Jg80XGi9APTsXsT8URJHDv?=
 =?us-ascii?q?frL0yNl0EVu7mpzgFzpXOPgA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 18:52:41 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MvKXV-1vhLoX2rCL-010sEi; Sun, 08
 Mar 2026 18:52:40 +0100
Message-ID: <8ceb30ad-1143-4086-afeb-45b639c87e49@web.de>
Date: Sun, 8 Mar 2026 18:52:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
 <f25025ab-4500-4315-b41c-53cd5775c69f@web.de>
 <20a815aa-5fa9-4b34-ab81-d6985ed193c0@web.de>
 <bc3eaab-b09e-4e67-054-b522d723c6a@inria.fr>
 <576f0704-7ceb-4e0d-ae1d-1beb1eb1efc3@web.de>
 <92db939d-8643-3bd5-ab3b-29605d36d29a@inria.fr>
 <0a740db5-eaae-43c9-9b73-d9317a1a92c6@web.de>
 <be59dbcf-c9b-745d-e15c-e8fcefaf40e2@inria.fr>
 <cd1bbe8e-ef35-408f-8754-173678bf3204@web.de>
 <f715289c-54d3-2c0-43fd-e6669973c5e1@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f715289c-54d3-2c0-43fd-e6669973c5e1@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dqst9KiEJQPLAxY7OxItzqd+Igp0DnVKtK5AWYseCsS6WzFK3vK
 6+PvW7CZCeVmH/HoVpklJwX+QROZuG+00IXpqtVweDA7KMor4ouKpzI6JmwnWi9RsOa7iuf
 Vj369qr+OKJb2ulOh4WONaUpwBnt2NLGnnjZ6Su1vlOBILf4vQ/606hn9pU9EGGBe+uSDbz
 zSd4VkpF/9Nho3X2FtliQ==
UI-OutboundReport: notjunk:1;M01:P0:m+m7wvrqzKI=;l/9T5PnArL1BQ5DN6Ic5KvKd24p
 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
Subject: Re: [cocci] Reconsidering source code search challenges for nested
 compound statements
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3337
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/GeGMTBrrfBPxtnvUgwrPcg>

>> How should this implementation detail be improved anyhow?
> By putting the * in the leftmost column where it belongs.

@display2@
declaration d;
statement list sl;
@@
 {
 d
*sl
 }


Another questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
test-item_assignments.c ../janitor/show_compound_statements2.cocci
=E2=80=A6
[no diff output]


Will further software improvements follow?

Regards,
Markus

