Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4D1C61DB9
	for <cocci@archiver.kernel.org>; Fri, 28 Aug 2026 11:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=0uRhO5qYms3ADnFCm1UZ8ANHc4jjoXKfyrP3TyrSUwk=;
  b=ZpaVs9JvoicE6G22c3JQKF0dbYFGOBYQLTO/6I761jP7Zo7ccopVFaYe
   tS/RD7kHuXfEAu3HmnrjVWv+1zbrkqy2/6iwMMWoXA1Ur0O2SeqcWNlrm
   XXyOtidzTeMWJiGx4JBMF04JPvSH39XCfWqq0GE7ttPgM8C1eWg0RbtTU
   Q=;
X-CSE-ConnectionGUID: 5o/HWd8SSguScriyTt0o7g==
X-CSE-MsgGUID: Zey7sl6VSReNzJXl+ACkuA==
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
X-IronPort-AV: E=Sophos;i="6.25,248,1779141600"; 
   d="scan'208";a="292005182"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Aug 2026 13:51:49 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id DA2618053C; Fri, 28 Aug 2026 13:51:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id EEBCE80562
	for <cocci@sympa.inria.fr>; Fri, 28 Aug 2026 13:42:54 +0200 (CEST)
X-CSE-ConnectionGUID: U3bZSf47RfGNkqLxnviWyg==
X-CSE-MsgGUID: JAB1QCC9Q4GgXmtiJf5pGA==
IronPort-SDR: 6a91743e_SfORZihbZSap5zmMfsk3rn+m86BgvWsQJUNYV3KoWo9jFWF
 ed8hbldZWRPnKKIrEPAo9sl3k9KZayEhs6xmBSQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EAAwCxcpFqgwsR49RaHgEBCxIMggULgkGBCl40BAtJC?=
 =?us-ascii?q?IRQj1KGX48RiHqDUQIPAQMBDUoEAQIEAQEBAgMBgguCc41zAh4HAQQzBg4BA?=
 =?us-ascii?q?gQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBOgcOO4ZPD?=
 =?us-ascii?q?YJbgSyBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAg06RicdAQERJgE0AhgOAnMBAYJ+AYIiAQYQAQM3Bw0GwHSBMoEBggwBA?=
 =?us-ascii?q?QaCatd/HywiXYFpAwYVgQouhXGCURwBBW6JB4EhD4FVRIE8C4JIg1ABA4Irg?=
 =?us-ascii?q?w6CaoImgQyTbYFKHANZLAFVExcLBwWBZgOBBjI8Mh2BIz4XNVgbBgWBHYEoh?=
 =?us-ascii?q?BAjGTZ6gQlegSspYAESF4EJggcCglqBKVwCAUlDDgdHRQttPTcKCxkEPY9lH?=
 =?us-ascii?q?4NEEyyCPZM8swQ0B4I5gWgFgWEMiQqBJpU/BhMvl1MOkwuZCI4KlWCFWYF+J?=
 =?us-ascii?q?IFcMxokgzZQAxkPjiEZg2kzgQvKXUUyAgEINAcCBw8ChU8BAYxWgUwBAQ?=
IronPort-PHdr: A9a23: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
 jnnkaXuNHFd/tiS8cZOX6A8x+qYPXBnPRe7QVbp
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:TUc/2qlHS4k6gloNZQPIvbz2PurpDfL03DAbv31ZSRFFG/FwWf
 re/sjzpiWE6wr5P0tQ/+xoWZPwJk80kKQf3WB/B9iftWXdyQ6VxeJZg7cKoQeNJ8SWzIc0uJ
 uIGJIObOEYY2Ibse/HwE2fD8sqxsWB/ZulnOHE0h5WPHpXgu1bjjuQEWygYzRLreR9dOIE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:X3OX820fg9D1jLjY0FBvKLxfJ5svQEbTkCjqLWCeCn9NWLuLSGCB9/Yx
X-Talos-MUID: 9a23:1OdiFAQ6aKfEZ15LRXTOrRs7DexDsp3yJ089lIkHmcfZLQNZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,248,1779141600"; 
   d="scan'208";a="155292056"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDH8oDFtZRGbuF7R9uLpbHTucKSnZMqLlil13C?=
 =?us-ascii?q?YBAFRhFe2QMKVDUalcld+aelEfoWypZlddCX7wOx14TV8Wa15hyXkkuj?=
 =?us-ascii?q?IEzRojFgtisIOI062gqdMVzUAO8JmAczsoKp0LQXBamEuzAMwZZGSfrn?=
 =?us-ascii?q?DB+WCYISn1bnLHlXiEv4rDHA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 13:42:54 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MI3p7-1x5djP3IbH-000QVB; Fri, 28
 Aug 2026 13:42:44 +0200
Message-ID: <03b6c464-5533-44e9-9514-99cb012a27ba@web.de>
Date: Fri, 28 Aug 2026 13:42:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
Cc: kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:anys+wT3XUXcQBWfiRQx8DOipi4siaBDoVXeqGRpg+Bo+nkjmhk
 rO93s/Sl0J05Rk0f7CkAoTNfKzdOj10tj1QHVoGTiYV6kAKmB8Im2TCi+2L7tsUYUcO2xFn
 8sEDFwirwwBZ5gBK2rQ0sAJjW+7zBxa8d6M0DZLlx9J2Vx38v5HWcbO0fmAtdcOKscsu3Rf
 Bw5I1jGqhZXpe1q4Qu9RA==
UI-OutboundReport: notjunk:1;M01:P0:fWDkVASCX/s=;rrVqkp7Okt7u3SGRAl/1Fj/QGzW
 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
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Improving support for first columns of SmPL patches
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3719
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/-471U4MQofgAduMjL-Mk7w>

Hello,

Another SmPL script can occasionally be tried out.

// See also:
// https://elixir.bootlin.com/linux/v7.2/source/include/net/ip.h#L305-L308
@replacement@
expression cpu, mib, offt;
@@
-* ( ( ( unsigned long * ) per_cpu_ptr ( mib , cpu ) ) + offt )
+snmp_get_cpu_field(mib, cpu, offt)


Questionable test result (also according to the software combination =E2=
=80=9CCoccinelle 1.3.2=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --parse=
-cocci use_snmp_get_cpu_field.cocci
=E2=80=A6
lexical error: * not allowed in the first column for a patch
  File "use_snmp_get_cpu_field.cocci", line 6, column 1, charpos =3D 133
  around =3D '*',
  whole content =3D -* ( ( ( unsigned long * ) per_cpu_ptr ( mib , cpu ) )=
 + offt )


Would you like to improve any software components accordingly?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/78ac4072c68190fc929f2=
e3c7534350a5ef6496a/parsing_cocci/lexer_cocci.mll#L133-149

Regards,
Markus
