Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DFBC9830E
	for <cocci@archiver.kernel.org>; Sun, 27 Sep 2026 11:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=NYEE9fWjmXcDOror2Jc1BIk+RzwpW4S2rGTDy8P4XlY=;
  b=N6NxLT8ArVDINmUPyWXZCEUK/09OKbRZG+1wW/e2bY5SDARNdE/eznV8
   RE752SO1CIK4wNcpoGVvc99HEkea8KwQTyA+N0jc/AEC4+ZzUjzcsR2vD
   urMVka19M+EhKaic2YmuygBDaNXXredqBkjJ1Hxc0wDGk4ZX9Mprw60Df
   E=;
X-CSE-ConnectionGUID: kjU62ykOSDyMasrnuvhROQ==
X-CSE-MsgGUID: nBKS+8KAS26gziRaBN+hgg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.27,126,1787004000"; 
   d="scan'208";a="297140670"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Sep 2026 13:12:47 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C05468184D; Sun, 27 Sep 2026 13:12:46 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D98CB8046B
	for <cocci@sympa.inria.fr>; Fri, 25 Sep 2026 14:26:08 +0200 (CEST)
X-CSE-ConnectionGUID: Q5chGSRMR6W+39MWwjFaHg==
X-CSE-MsgGUID: cosok/0hReiH9RFXXHlvmg==
IronPort-SDR: 6ab66860_EkFk82qDK9JWb6xeC3QWj8q+czBg/v6+7WkekxgRUM3sLh9
 nNggkEBvi88J53vj89M1d3mqBfo+o4kOy171N9Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ECAwDoZrZqgAQP49RaglmCQYELYDQEC0kIhFCPUoZfj?=
 =?us-ascii?q?xCIeoFVgXwCDwEDAQ1KBAECBAEBAQIDATcBgVOQfwIeBwEEMgcOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBOwcOCjGGIC8NjBOBL?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECR?=
 =?us-ascii?q?20dAQERJzQCGA4CcwEBgn4BgiIBBhABAzcHDQbAaYEygQGCDAEBBoJr138fL?=
 =?us-ascii?q?CJdgWsDBoEfLoVyglEcAQVviigPgVVEgTyCUzGDHwEDgiuDDoJqgiaBDJUbg?=
 =?us-ascii?q?UocA1ksAVUTFwsHBYFmA4EGMjwyHYEjPhcvWBsGBYEdgSCCGiMZNnqBCV6BK?=
 =?us-ascii?q?ylhEBeBCYIHAoJUgSVcAgFJQw4HRVMJJUsSRyYiCBIJARMaMAuBIzpBCSgLb?=
 =?us-ascii?q?T03CgsZBD2RIh6BcmyBQYIfEpMgKLMENAeCOYFogWYMiQqBJpU/BhMvl1MOk?=
 =?us-ascii?q?w6ZCI4KlWCFWYFvDiWBXDMaJIM2UAMZD415AYRdgQvKXUUyAgkyAgcCBw4DC?=
 =?us-ascii?q?4VEAQGMVoFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Yl2x0Ac9SRdDn2kqSj/KxB7bSpaKivm+081
IronPort-HdrOrdr: A9a23:smoVfK5K2wKxhQYWygPXwNvXdLJyesId70hD6qkRc202TiX8ra
 uTdZsgpHvJYVoqOU3I+urwW5VoP0mskKKdiLN5Vd3OYOCBgguVxepZgrcKrQeNJ8SHzIBg6Z
 s=
X-Talos-CUID: 9a23:BqxTz2MIfJ18Ie5DYXRs9GEvIOUfLEKelyb1HFC6J29JR+jA
X-Talos-MUID: 9a23:zOjf1QgO2XAreWypK6XjVMMpP8Bz5KfpUEA3nJQm6vOqBRxQPymYg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,122,1787004000"; 
   d="scan'208";a="296925920"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDG4Q7+ap4bekBR46ccDhm+uyk768kdF7Y4s1v?=
 =?us-ascii?q?ndeTIAD6NZsfE+QbQmV82rNJ6plaaNnHNwTXkxZ8JjpXIcLL2EoY9ByK?=
 =?us-ascii?q?OGpmTEORsP2kIxzYHQ20gtfRSdDV9sFS2DWZ2i9ilcLDIEdnhKQhbSNv?=
 =?us-ascii?q?LgcFE/87anByOHHav1GwRySQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 14:26:08 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSIF2-1xKy1P3mW0-00MW8j for
 <cocci@inria.fr>; Fri, 25 Sep 2026 14:26:07 +0200
Message-ID: <82ac5de1-a9d0-497e-88c2-c10793819ea2@web.de>
Date: Fri, 25 Sep 2026 14:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zz1XHuABPfU0RRo8GfPHB3UblJlFGPhZgFS14QebxvsuJVTamr4
 ks0wdBPEtyAjopzZKt4vfJ4/UIWZ96duaXYE4jYku1Vsp/tWRw48HizhAelOnDDggj0aH5S
 jC1g9lbJGoZn8awJXW72FR0nfc0PHVZitvql6bQkWJHL3qszjYfaIcl9RRKpIsAuXYkWWoO
 317uAH+RrHEzvuiHYnhxg==
UI-OutboundReport: notjunk:1;M01:P0:H5KKVwIFdG8=;gNqjlnRWY7h2WfGth/EBGB9rSs0
 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
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Reconsidering handling of generated metavariables for SmPL
 isomorphisms
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3745
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/Y1ybcaUjgoOKbPjCfClh1A>

Hello,

SmPL isomorphisms can be specified by a domain-specific language.
Selected SmPL code may occasionally be transformed according to known patt=
erns.
Code matching is attempted with the help of metavariables.
Transformed SmPL code may refer to additional metavariables which do not o=
ccur
in the input code.
It seems that the Coccinelle software generates metavariables then with
special identifiers.
The isomorphism rule =E2=80=9Cptr_to_array=E2=80=9D can be a special test =
case.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/2759351ca12bbf39dc72c=
6756282294aa85d06f6/standard.iso#L557-566

How can further technical details be determined for involved algorithms?

Regards,
Markus
