Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B527606A32D
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=UXCckAso
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Sa+INVZg8KMk4Ur72zSM17/A44psBm0DS59kVwhmWMs=;
  b=UXCckAsoeH9VTlrsY9gR4wQUiP1KDxLHn3Unw8bxq6qCglYAt4PP4bhq
   K49ULzv0RiYKpEmm0FkKe6VbENiMIM0h7XPQr/T2CGCZsb1auzEHs8cMO
   rQ4PSV3tmYMBHisomJhD/0sDA+4WjUS+pRFokdkmb6LcxLVTEv/8K9ZpO
   g=;
X-CSE-ConnectionGUID: jZuqZGYBTcOS7t4B2tMu+w==
X-CSE-MsgGUID: JswqSmukQw+Z1INnTvaZjg==
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
   d="scan'208";a="304323084"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:13 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 93B0281693; Sat,  7 Nov 2026 11:59:14 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1831B819BE
	for <cocci@sympa.inria.fr>; Mon, 26 Oct 2026 15:05:56 +0100 (CET)
X-CSE-ConnectionGUID: ctmqXwk6TaC2b1dNCKmBVg==
X-CSE-MsgGUID: 6PJD9uOWROiJ61a3gAwnLQ==
IronPort-SDR: 6adf5e43_s6kwE/1WeU4eksGEfbpaR3QH+inZ6jS/2JHE5Bd3hjUyfuR
 NSiFsIAtT6Ifbml8NmeS9qGBqX5cWXfTX6YouPg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EnBwCUXN9qg07ASNlaglmCQYELYDQEC0mEWI9TgXSEa?=
 =?us-ascii?q?48RiHuDFD0CDwEDAQ1KBAECBAEBAQIEkxgCHgcBBDMGDgECBAMCAwEBAQEBA?=
 =?us-ascii?q?QEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABAQEhGQcOO4ZPDYwTgSxlCTgBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBFgI9Cm0dAQERJzQCGA4CcwEBgn4BgiIBBhABA?=
 =?us-ascii?q?zcHDbZXgTKBAYIMAQEGgmvYAB8sIl2BawMGFYEKLoVyglEcAQVviikPgVVEg?=
 =?us-ascii?q?TyCU4NQAgIBgiqDDoJqgiaBDIJdk1aBShwDWSwBVRMXCwcFgWgDgQYyPDIdg?=
 =?us-ascii?q?SM+Fy9YGwYFgR2BHnUqa4EHXYErKWEhgQiBdgKCUYElWwIBSUEOB0VTCSVDE?=
 =?us-ascii?q?kckIggSCQETGi4LgRo1PAkmBD0VDGQLGgViCAINDHs5EDUNbT03CgsZBD2SP?=
 =?us-ascii?q?IRElXmRPqFGNAeCOYFoBYFhDIkKgSaVPwYTL4Nxk2IOkw6ZCI4KlWCFWYF+J?=
 =?us-ascii?q?IFcMxokT4JnUAMZD447hByEYMd6RjI/BwIHDwKFTwEBjFaBTAEB?=
IronPort-PHdr: A9a23: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
 tWdzMrO
IronPort-Data: A9a23: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
 OzyMUEc8vR8Ll+FiArTCjGGbT9b+87n
IronPort-HdrOrdr: A9a23:hPEndaneJ3kYwSpx8Qs88PF+DKDpDfIO3DAbv31ZSRFFG/Fw5P
 re/8jzsiWE7wr5OUtQ/exoXZPqfZqyz/FICOUqTNWftWrd1ldATrsP0WKK+VSJdhEWndQtsJ
 uIHZIfNPTNLRxdkdvw5hW+Hu0t2d+d7cmT9J/jJjtWLD2DcMtbnmFE4+ugYzRLrIIqP/AEKK
 Y=
X-Talos-CUID: 9a23:GvYELGPS2LDNlO5DUzVi7X4LGZ4Ze1aHxi7cBWSbDExXR+jA
X-Talos-MUID: 9a23:OLPY3gbUPLvg5uBT6QfOqGB/E/hSxKWMVhkEypovpM+gDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,179,1787004000"; 
   d="scan'208";a="160888656"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEGtov3PHyh9sjk5/Za3RffwRSeFcWdNwgCXZ?=
 =?us-ascii?q?j5zkh8/H0DlFimNCpKWZlm7qo6wE2ge2Pk1Uxs9OJqv2vjO/xgyXMqaT?=
 =?us-ascii?q?vDZKOfyrGVAdek/cONfm0IhlKPEoHoDT1YIGVtYI9bX2CK+ehYeRaFcm?=
 =?us-ascii?q?VaGRHrx6UnabuarZaxXsbcRA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:05:55 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MALeD-1xR8u11Crj-00BsuG for
 <cocci@inria.fr>; Mon, 26 Oct 2026 15:05:54 +0100
Message-ID: <70f020a7-6d18-47f9-899d-b24282ccbe70@web.de>
Date: Mon, 26 Oct 2026 15:05:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wRt4IJKkTYrrflKrOv6GwRzvgRYmSLeRIje9y9oK0wNUAAeZHn1
 8iGqIpnAntXqK2fAkFkr98Pn2/eBokDQCQj3VWJ1eQPNUwXMJakjTa+XZ5AwEkyXNcICTqT
 wgxH60u+o87TNJwaeIXIgC2G2MDfWVgQzXQDxuHwvSRprmRYRZOfBcwi7kvTfNUYbFgAY1L
 2SuU4vJhoXZi42duD+P/Q==
UI-OutboundReport: notjunk:1;M01:P0:tlkUareFMbE=;fF0di6hJU0HI5XQbuDuJvqtYXAm
 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
 gs8zd2TDzXcV+RvkHIFUKbr
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Converting conjunction chains into nested if branches (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3766
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/D-ANjBnKo7zNmt0xrjKlcw>
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

Logical conjunction chains are also supported by the semantic patch language
to some degree.

Their short-circuit evaluation can be expressed also by using nested if branches.
https://en.wikipedia.org/wiki/Short-circuit_evaluation#Support_in_common_programming,_hardware-description_and_scripting_languages

SmPL script example:
@replacement@
expression x, y, z;
statement s;
statement list sl;
@@
 if (x
-    && y && z
    )
 {
+   if (y)
+   {
+      if (z)
+      {
 sl
+      }
+   }
 }
 else
    s


Will such a transformation approach become relevant for another isomorphism specification?

Regards,
Markus
