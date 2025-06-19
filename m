Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7FDC7115A
	for <cocci@archiver.kernel.org>; Thu, 19 Jun 2025 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=WaMG65y5YyAX123YndwFWqlPYRj2Xp7dl0V34nwMn5Q=;
  b=fe2y+wLGBmimbcWa7PpWPvYA53/TKmbUd4LjZI+CAEIArN5X8iWfCR0m
   hkC4nHqeDyUyO0UgSGrg0Le9pRxIf4EDEHbeVLRmG61hfaN0rmwhKylNx
   Obop5gNpmY7gs2+qU2J0iaqq6UsHHUIyoA9erbLZB5ZLcCI4x1gaqJiH9
   s=;
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
X-IronPort-AV: E=Sophos;i="6.16,248,1744063200"; 
   d="scan'208";a="228072516"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jun 2025 16:26:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0EF93E0AF6; Thu, 19 Jun 2025 16:26:27 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 37200E0131
	for <cocci@sympa.inria.fr>; Thu, 19 Jun 2025 16:26:23 +0200 (CEST)
IronPort-SDR: 68541e0e_4J/rfCfOPd68KlLrL4VGvlTBXN9o04iyNKo6ncurPiN/c24
 8VSNDezT/vS3F9cGIh+jOU7mnDZG3RKHcOjUm5A==
X-IPAS-Result: =?us-ascii?q?A0GWBgBeHVRogAQP49RagQmBU4JEgQZUMwQLSYRVj1CDA?=
 =?us-ascii?q?oNdhzyHU4h3gVWBfQIPAQMBDU4BAgQBAQMEggyOXgIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhUwvDYJbgSyBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CR20dAQERJzQCJgJNJgEBgn6CIgEGEAEDMgeuSYEygQGCD?=
 =?us-ascii?q?AEBBoJp13QfLCJYgWUJgRsuhW2CShoBBW2EaoUuD4FVRIE8C4EJgTeGBoMOg?=
 =?us-ascii?q?mmCKIEWhVKEUI5ggUocA1ksAVUTFwsHBYFjA4EPbjIdgSeBBoUQgRuERStPh?=
 =?us-ascii?q?SBMWoNeJHAPBoEsQAIBC209NwkLGwY9kmCDB4EvglwXky+PfaJ3NAeCOIFmB?=
 =?us-ascii?q?YFfDIkHlmEGEAMvl0sOBpMChiKSYqNhhVk2gTI6gVwzGiRPgmdPAxkPjXgBh?=
 =?us-ascii?q?Fu3JkE1PAIHAQoBAQMJAYFVg3ABAYp4gUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:tDosl66sXzpn7b9p6QPXwOrXdLJyesId70hD6qkDc203TiX+rb
 HIoB17726RtN91YhodcL+7V5VoLUmsl6KdgrN+AV7BZmXbUQKTRekO0WKI+UyEJ8SRzI5g/J
 tBN45jFdb3EV92tsri5hKkeuxQuOVvvJrIuQ/EpU0dKz2ChpsQljuQgWugeHFLeA==
X-Talos-CUID: =?us-ascii?q?9a23=3AQVmGsGiDx151tXIgAAzb1UGuQDJuKH3z0HrzZHa?=
 =?us-ascii?q?CJ1lvdbnLRQSu5LsnjJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AZq9OkA/vLsatqY392LnjRZWQf/5ZvZigDkULqLE?=
 =?us-ascii?q?pi5GCbTEuODLE0DviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,248,1744063200"; 
   d="scan'208";a="119500398"
X-MGA-submission: =?us-ascii?q?MDHniN91FqaxOhJrxRvmO5KxzUwxb0ON4D4Qow?=
 =?us-ascii?q?jVTabpvMw9a0qf3rv3cC9L55t8/Navi/cpG6FFBuEuW464HzO3qryIXp?=
 =?us-ascii?q?59lg6ws9hIVNRy0RB8ZPFLEdmRdZ1nn8GiRx0oMrHeU4Fh/2aGzhBq5U?=
 =?us-ascii?q?OWT6q2OVw+shzVFXNamkFkfQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 16:26:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750343180; x=1750947980; i=markus.elfring@web.de;
	bh=WaMG65y5YyAX123YndwFWqlPYRj2Xp7dl0V34nwMn5Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CF0NRQmxrUU3IpSUbG1kOgz1eMH37DLxXA3BgmOwb+oEXWlWkVthNfHhyKlapOp6
	 f/G/JMgnkDtb+Hp//Y7rSHBZ3hnmOHZKoIMYsgx3WoB6HaE4dx/WzEeBjwXHYJHbP
	 p6QA6mN8z6aYVu6/taHiDqRkgxkqiu2rJ+WGp15JCjdihJkWHYFXtvJfJ2/+p6w1P
	 0ueUUfmm+uWhtdxOyhBc0mjjJ+XoobPvX3G440IDPLCBpFqFa+B5G55SDhWyK+2Mb
	 pLB8S+wNuruR27tNe4GnOzrZ3v3/zqW9SRNqzzjjRpOVZxwdOrnGqW+m276Wa+hFJ
	 xNTfmtCSu1w1lFAKvQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.255]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUCut-1uKO9X25xL-00MCKQ for
 <cocci@inria.fr>; Thu, 19 Jun 2025 16:26:20 +0200
Message-ID: <74697802-b4d4-4f5e-ae52-c2b6d30a0c15@web.de>
Date: Thu, 19 Jun 2025 16:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NKxpfc2x0krmKknd6SmSzwC980wuDZpcKPKK8of5XTVVVd9dIZU
 Qj0ngGN/V5j07TskPpL4b54remuiUZWgSyJWcRJ6DSWvWll1pYfKll2H+4s5oCzEmMX+hUJ
 zGuT06ytZH4FXdXlF0o32kQlTo/gHJAkbl3nvG36C6rXvQh4ueawCBxGeROS/Y2iyHls5Hx
 U2nuPKYF8/u8MOkn738kw==
UI-OutboundReport: notjunk:1;M01:P0:EMpj9ef/jdk=;hDzo++p1D0tY7zhXuL2SPSV6zFH
 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
 m6D39YFEb+sFe0WD
Subject: [cocci] Adjusting applicability of =?UTF-8?Q?=E2=80=9Cblock_marke?=
 =?UTF-8?Q?rs=E2=80=9D?= (for SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2791
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/74697802-b4d4-4f5e-ae52-c2b6d30a0c15%40web.de>

Hello,

The application of =E2=80=9Citerators=E2=80=9D (or =E2=80=9Cblock markers=
=E2=80=9D) can trigger special software
development challenges (because the source code search specification share=
s
properties according to function definitions).
Some of them can be indicated by test cases like the following.

A)
SmPL script example:
@compound_display@
statement list sl;
@@
 do_something(...)
 {
*sl
 }

Corresponding test result example:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time /usr/bin/sp=
atch show_something_as_function_with_compound_statement.cocci return_test_=
value.c
=E2=80=A6
@@ -1,5 +1,4 @@
 char do_something (int context)
 {
- return MY_TEST;
 }
=20

real    0m0,419s
user    0m0,052s
sys     0m0,061s


B)
The SmPL declaration =E2=80=9Citerator name do_something;=E2=80=9D can be =
added to the previous example.

Another test result example:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time /usr/bin/sp=
atch show_something_with_compound_statement.cocci return_test_value2.c
=E2=80=A6
@@ -1,7 +1,6 @@
 int do_another_thing (char input)
 {do_something(1)
  {
-  return MY_TEST2;
  }
  return 5;
 }

real    0m0,068s
user    0m0,037s
sys     0m0,031s


How can a collection of such =E2=80=9Citerators=E2=80=9D (or =E2=80=9Cbloc=
k markers=E2=80=9D) become a general
part of the Coccinelle system configuration for a selected source code bas=
e
(so that parsing of involved source files can usually succeed)?

Regards,
Markus
