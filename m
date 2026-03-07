Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A1AFC9ED3
	for <cocci@archiver.kernel.org>; Sat,  7 Mar 2026 10:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Hqd0iQf3QksHCjYTjIwIOml9Xu7Po0cLuTQ7jQDmvuc=;
  b=sGtJhERNU4NuqNgtbL5OqrrZE+oUai7kSHm69GnkaLYquRiONdTIwr4i
   G6RCDjqWR9yJf72j9Ay2KFoi4Ml9w1CBZwLPV0WPKr52oO8au3w1LkVvm
   4gXoNsN99A52aWro8vKM05BjNWaBIKybQxUf6FZtRIRH0arzsQM920vbM
   k=;
X-CSE-ConnectionGUID: C19GoUeFSnqGcvL6tkppTw==
X-CSE-MsgGUID: NXX+sxJOTqaBKne+idDQjQ==
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
X-IronPort-AV: E=Sophos;i="6.23,106,1770591600"; 
   d="scan'208";a="266688047"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2026 11:15:51 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5C2AD81372; Sat,  7 Mar 2026 11:15:51 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 292778137D
	for <cocci@sympa.inria.fr>; Sat,  7 Mar 2026 11:15:45 +0100 (CET)
X-CSE-ConnectionGUID: 9g09+qQzRc62Su469GdXKw==
X-CSE-MsgGUID: JFRAjoDcT+mWMMChHtFFaA==
IronPort-SDR: 69abfab9_hygw10mKAgyF2y4ZRvpPyObmcmMCETK14cpAIHp3seqlcoE
 7iccbg2zZFEOPHhzTivXN0kBr/TDQOrsN/BrIAw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H8BABu+qtpgwsR49RagQmBUoI/aH00BAtJhFiPU4Zfh?=
 =?us-ascii?q?zyHVYxLAg8BAwENTgECBAEBAwSFAAKNIQIeBwEENQUNAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQE6Bw47hk8NgluBLIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBHQJHRAIBAyMdAQERJw8LGgIYDgICVhsBAYJ+giMBBhABAzYHq2GBM?=
 =?us-ascii?q?hNuggwBAQaCadd7HywiWYFnCYEfL4VugmUBim4nD4FVRIE8C4JHMT6EQ02DD?=
 =?us-ascii?q?oJpgiaBDpMpUngcA1ksAVUTFwsHBYEjQwOBBiMPPAUtHYEjIR0XFB9YGwcFE?=
 =?us-ascii?q?iEqgWl4ggEPhmp5Ay5eGg4iAjpcgQYKAVoFgiYCAQttPTcJCxsEPY50PoNCg?=
 =?us-ascii?q?yPGAzQHgjiBZ4FkDJ9tBhMvl1IOkwuZBqlBggAigVwzGiSDNk8DGQ+OLQ0Jh?=
 =?us-ascii?q?BHIWEUyPAIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
 CaA9raGQnmjlfSTjCVqWlxCp2QT7L8=
IronPort-Data: A9a23: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
 d0DgKbOyckwYNicTSjB3Q==
IronPort-HdrOrdr: A9a23:WDEJOand4153c1eIlFNeeQ28fFvpDfLy3DAbv31ZSRFFG/Fw5P
 re+MjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNSftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3A98dV72uKINCB5ST+POT2yCdi6It0fSWMj27pMXW?=
 =?us-ascii?q?zVzxSVeHLGHCcyIB7xp8=3D?=
X-Talos-MUID: 9a23:cSwj8gVo1iRdH9Xq/B3CvhhgM+tj3+erN2UoupUmp+eqPAUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,106,1770591600"; 
   d="scan'208";a="140681071"
X-MGA-submission: =?us-ascii?q?MDE7FzLBWlDMF5Meq4vCKxuwrj27qHXgwM/8xi?=
 =?us-ascii?q?cAxHBYMJhDC8U7N0anxva5hep7YKXzjRBC37zyMghANA3bz8c+lPbwdp?=
 =?us-ascii?q?xZqudgHcdlRtEz+MgJQWy5QjbGYPUup5cZOOpzUEoc94BKfd7TbLAVQB?=
 =?us-ascii?q?G7wFqt2hAsi7QoRVyVId+Piw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 11:15:20 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsJOq-1veFbN3VQQ-00yIpZ for
 <cocci@inria.fr>; Sat, 07 Mar 2026 11:15:15 +0100
Message-ID: <f25025ab-4500-4315-b41c-53cd5775c69f@web.de>
Date: Sat, 7 Mar 2026 11:15:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z3wvorut2w00BaHfBMtL7p+IjERhYpT3vqBkgDS2xfITgbwf90L
 1O9HwmNScYU9g1JrzWcQiGRLR+xSv/l0T+O8Y+AHMRyC2Y+ZcJuT4IKwg3w8gBQuJ1S19fJ
 E8NgvH7WPTZ0NqyHEi/kegqO/L0baIJ+u4zmHzOA/jIxXiB71yuXnarMtjDffb5MQ0sP1/Z
 Rjfpquzm2BrO+aNYcF8Aw==
UI-OutboundReport: notjunk:1;M01:P0:i1mfA61/mUY=;ixs8NFFReTvg2SVmYn1l7Nr06IN
 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
 TGRF7iPJyRM+yw==
Subject: Re: [cocci] Reconsidering source code search challenges for nested
 compound statements
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3327
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/QGCsQPCPXVgE61G-ItZzbg>

> * How should the data processing be improved in more desirable ways?

I constructed another source file example together with a corresponding Sm=
PL script.


void my_test(void)
{
 int item;

 if (1)
 {
    item =3D 1;
 }

 item =3D 2;
}


@display@
@@
 if (...)
*{ item =3D 1; }
*item =3D 2;


Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
test-item_assignments.c show_selected_assignments_after_compound_statement=
s3.cocci
=E2=80=A6
@@ -3,9 +3,5 @@ void my_test(void)
  int item;
=20
  if (1)
- {
-    item =3D 1;
- }
=20
- item =3D 2;
 }


Can it be achieved that the source code search pattern will work also
after the omission of the filter =E2=80=9Cif (...)=E2=80=9D?

Regards,
Markus
