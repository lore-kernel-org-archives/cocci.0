Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78A6CCFA18
	for <cocci@archiver.kernel.org>; Tue, 11 Nov 2025 14:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=5vomDvw3mm4FlptGfpw+P9fgyjrtBp3iXduooiNs2cM=;
  b=QwBPb3o8oRAOVzBlIMsg7ya3eb5iqGNmyyNu0gn9kF2WrxFcm9/Mp4go
   oe+rWh/PUQ9A/oXoRbtAIVWKbgr7wKX3//DUqRiT3pqLY5t0yuFVQMopl
   YQzhYs+tTFZuCpm2hhiBBoIdT2BSvVovuJI4nYvhj6S/d9LNKgF/aAGzR
   A=;
X-CSE-ConnectionGUID: tXI3deWcRWq9KiPgUUa/Pg==
X-CSE-MsgGUID: s49D/wl2R2O8VTt/SM7ouw==
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
X-IronPort-AV: E=Sophos;i="6.19,296,1754949600"; 
   d="scan'208";a="248595290"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2025 15:48:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D19B0E0264; Tue, 11 Nov 2025 15:48:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B113EE0171
	for <cocci@sympa.inria.fr>; Tue, 11 Nov 2025 15:48:20 +0100 (CET)
X-CSE-ConnectionGUID: WNuV1RkMQNOlXLHmdtaR0w==
X-CSE-MsgGUID: YAak2MfqTTGEQ4EVE+1sMg==
IronPort-SDR: 69134cb4_7LRF9qyFaBgfkZyqFamWjcOFu2b1VkDgOSMAbf/xnvXIc5c
 EAB+qfusz7p2vt8iJXJc6f8amJ92jUrxAJh1yDQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FACgAFTBNpewsR49RagQmBUIJAgQhYMwQLSYRVj1OGX?=
 =?us-ascii?q?4c8h1WIeYFVgX0CDwEDAQ1OAQIEAQEDBIIMj1ECHgcBBDIHDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQFCDgoxhiAvDYJbgSyBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CR20dAQERJzQCJgJzAQGCfoIjAQYQAQM2B7AYgTKBAYIMA?=
 =?us-ascii?q?QEGgmnXdh8sIlmBZAmBHC6FboJKGwEFbooaD4FVRIE8glKFf4MOgmmCJoEOh?=
 =?us-ascii?q?ieTM4FKHANZLAFVExcLBwWBYwOBCzI8Mh2BJEEYcT1Xg0kiaA8GgRKDUYkeD?=
 =?us-ascii?q?4pNAgELbT03CQsbBj2VDoIAdYEVgyaSf7MBNAeCOIFnBYFfDIkIlmQGEy+XU?=
 =?us-ascii?q?g4GkwWZBqNohVmBbwEygVwzGiRPgmdPAxkPjXgBNBaEEb8uQjU8AgcBCgEBA?=
 =?us-ascii?q?wmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 /DQmai1JDoQq7o8EuMDCsKSJM/VaRIc
IronPort-Data: A9a23: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
 t0AgKvOxBgRhQh5TCg=
IronPort-HdrOrdr: A9a23:+6sC4Kw+DlqSTz/6+Z4+KrPwDr1zdoMgy1knxilNoG9uA6+lfq
 eV7ZMmPH7P+VIssRQb8uxoV5PufZqxz+8W3WBzB9mftWvd1FdARbsKhebfKlbbakjDH4BmtZ
 tIT4g7LsHsBl5nisvA7BC/CMtI+qj+zEnlv4bjJ2wGd3ANV0iM1XYBNu4Rf3cdeDV7
X-Talos-CUID: =?us-ascii?q?9a23=3A3VMG5GgAe40oYLE833WjPse0CzJuTVvA8i7qIGq?=
 =?us-ascii?q?BL0FteJm1TFOM8Zk8jJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3Aczj9/w0dl62wBm2gSCku8+NIWzUj0o2nCxoon4w?=
 =?us-ascii?q?6h+apDHBdBRre1S+STdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,296,1754949600"; 
   d="scan'208";a="130523107"
X-MGA-submission: =?us-ascii?q?MDEPfVhXWXsJ9sWxwxO/hrXTyLSwkVypPYK8nh?=
 =?us-ascii?q?rYGsvolribBmuLL7POvwI5aFUYIYNJe/O4z3M8nQuGfIvUYaA4tVVEcH?=
 =?us-ascii?q?wFCLVxg0DMzJEkUBWyS1A6KKkBgbPHfad3J38hR42fTF6ohhUynPw/xA?=
 =?us-ascii?q?RS1il41On8MqVxj89WPL5d4A=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 15:48:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762872499; x=1763477299; i=markus.elfring@web.de;
	bh=5vomDvw3mm4FlptGfpw+P9fgyjrtBp3iXduooiNs2cM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lzjP2jMVXS3HvbXoUtKHUKwznOg2S6LzDljgMo34kooZAlc35KOISwpqmv38RmTe
	 u/8cSYQpCV0tNtvoZDJYQkR7QZHyAQlvCDZBz0tjf0WbT5I7Rew92hntmMjjEhjpL
	 i4BEtdZqR993CcxLdRKXxHNyJWa276SV2QL4UhGmsC9my/1Qbr7TyJOC/pXLgtcN8
	 vuG9JGv7+GTlyp/OorKVTxKTYnbFxK8IxUo54yD7ZxJg+cpPweZOTqW4hZjffc3GH
	 V2TQ604C9uo5/+WtxySQCdRi6qvYAODQwtmQ32zRYHGtnRdN+oHryYZTr0tFjuuFP
	 rNHvPDukXWjlh5pX9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.1]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGQGF-1vQIRT3sUv-004iA0 for
 <cocci@inria.fr>; Tue, 11 Nov 2025 15:48:18 +0100
Message-ID: <37e60371-6ec6-475e-a901-d83c88d50e10@web.de>
Date: Tue, 11 Nov 2025 15:48:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m0cFOrdPlI9Y9vSUhDfPVpK2XPE8vB5v3xNUQvd1kUHymY15ypV
 aQFIy6mGvNNaVneGecKdmUav4y5UBGCoWTbk+hQigb0/FTyH3/HrfAzTz1nWXzPc6MJ3tYG
 Khe41ENR1/QJOfXwM15IXYhaJ6TCqGsrtcChdxFawrckVVb0Iu/iK8M40ArZxLMOcYJuyzg
 cgM1QRjqorOvP0BnDl/rA==
UI-OutboundReport: notjunk:1;M01:P0:SwElfK9Zh8c=;mh6TMvFWE9Jd7cj45sBkAL44zzX
 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
 OSvqxa3QRwM5Lg6UKmm6I/zPm0=
Subject: [cocci] Determining names for function parameters with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3161
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/37e60371-6ec6-475e-a901-d83c88d50e10%40web.de>

Hello,

I constructed the following SmPL script variant.

@initialize:python@
@@
import sys

def store_data(id, parameters, computation):
   for parameter in parameters:
      sys.stdout.write(f"identifier =E2=80=9C{id}=E2=80=9D: parameter: {re=
pr(parameter)}\n")

@searching@
expression e;
identifier action;
parameter list pl;
type return_type !=3D void;
@@
 static inline return_type action(pl)
 {
 return e;
 }

@script:python collection@
id << searching.action;
parameters << searching.pl;
computation << searching.e;
@@
store_data(id, parameters, computation)



Corresponding source file example:
static inline long my_test_calculation(int x, int y)
{
 return x + y;
}



Unfortunately, I am wondering about the following information.

Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h ../Probe/test-inline_function.c list_inline_non-void_functions3.cocci
=E2=80=A6
identifier =E2=80=9Cmy_test_calculation=E2=80=9D: parameter: 'int x'
identifier =E2=80=9Cmy_test_calculation=E2=80=9D: parameter: 'int y'


The function arguments are passed as strings.
How should their names be determined from such data?

Will any other data structures become more appropriate for this use case?

Regards,
Markus
