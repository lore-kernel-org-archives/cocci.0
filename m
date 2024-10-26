Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2139AD10BF7
	for <cocci@archiver.kernel.org>; Sat, 26 Oct 2024 11:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=g6tZlBzwPNMBYq//M55x6aGLznhK1DQ5lkgmAeSGMVE=;
  b=a+fEtiU6ngcpEuUBPPd0JH6OmqQP2zkctSYwNCBT8vBuaAxBoaPMb4g4
   MaNJ2ePe60yF0BjuDlB1G3r8wiP773biKfB4xqRnaSxqyZEMCFUhjOFFY
   52IM9AEGbN9ahor2K4i/jEFZeHaMRpEAYEAoklmbs9JTllL8HEwpKJEHI
   g=;
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
X-IronPort-AV: E=Sophos;i="6.11,235,1725314400"; 
   d="c'?scan'208";a="190849637"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Oct 2024 13:43:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9D5E6E0D1C; Sat, 26 Oct 2024 13:43:51 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E0F52E00B7
	for <cocci@sympa.inria.fr>; Sat, 26 Oct 2024 13:43:46 +0200 (CEST)
IronPort-SDR: 671cd5f2_wq5fwnAcasP1rAwOYF0oeVOji7SX1zh7xOIIqwMSuqfhqAm
 ZOIHLGTtejPDBifys0OwGL8k36U4gLXcQs4gppQ==
X-IPAS-Result: =?us-ascii?q?A0EDAAA51Rxnfg4P49RaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQGBfwQBAQEBAQsBgkNidTMEC0iEVogdhzCBdC0DhDuYB?=
 =?us-ascii?q?IFWgX4IBwEDAQ1BAQIEAQEDBIFrIYJ0AoonAh4HAQQwCQ4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCQExhXsNgmIBgSSBJgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CR0QBAQECASMEGQEBESYBBAsLOwcCAgJUGwEBgn0Bgi8BAw4jB?=
 =?us-ascii?q?7AGfzOBAYIMAQEG2lsfLCJXgVwHCYFIAYVpgkgaAXKJbicPgVVEgTwLgng+h?=
 =?us-ascii?q?RCDDoJpkSg+BgQFFIUIgySBbQGBUCVXSQICAgcChTmBWW6THFKBFwNZIRMBV?=
 =?us-ascii?q?RMXCwkFiTUKgxwpgUUmhBEIgRkSE4EbgkSBZwlhhHiDSoEMgT6BWQGDOEqDT?=
 =?us-ascii?q?ByBRQU4STeCFmpONwINAjeCJIEAgk+BJQQFgzyCOh02CgIBC209NQkLGwavO?=
 =?us-ascii?q?oFrNyWBLgGBSzAdMikypBeWQolbgQo0B4I4gWWBYwyEbIMwlzkGEy+XPw4Gk?=
 =?us-ascii?q?ngsmEujTYVUgWc6gVwzGiSDNk8DGQ+OIQwWFoN1y3tBNTsCBwEKAQEDCYVGA?=
 =?us-ascii?q?QGKTYFLAQE?=
IronPort-PHdr: A9a23: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
 MM9hsFjqReqn7vWogc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:oI9dk6Op6zVm58BcTh+jsMiBIKoaSvp037Dk7TEXdfUnSL39qy
 nOppgmPHrP4wr5N0tPpTntAtjnfZqYz+8N3WBzB9aftWvd11dARbsKhebfKn/bakjDH4VmpM
 RdmsZFeb/NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsLV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:dXf5Q2GYuN899a5AqmJ3pWJNJcx7dkTy50X7Ek6fEX9rRaKKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A9nHygQ08Udd0xI7nLdTdqZvAzDUjx563BmMzt5w?=
 =?us-ascii?q?8hdTcLiMgOXSdqBCHa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,235,1725314400"; 
   d="c'?scan'208";a="100101974"
X-MGA-submission: =?us-ascii?q?MDHl4an5FAjW9+NA1KSoklN8Zqw5m/THKPp898?=
 =?us-ascii?q?uW0aIJY33AOjzCfO/KcONMguL/PXlk49QEKpTgxUcWWuXB1O26PWa5N3?=
 =?us-ascii?q?r4980rS0PhDBID9XMbIpR2WQJgQOGh78K6TH2VdphRIX8p48H1uhx6WT?=
 =?us-ascii?q?Wma6qaFsrd5NrvjmbMEAocuw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 13:43:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729943024; x=1730547824; i=markus.elfring@web.de;
	bh=g6tZlBzwPNMBYq//M55x6aGLznhK1DQ5lkgmAeSGMVE=;
	h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:
	 Subject:To:References:Cc:From:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wb/qdBhXu6VbTFuU7BeKMsSEmuxQE4X5VKiTyw9DDns6uicebxkPl+te3bX1Fwdr
	 UCQg3ETlEK82bKFqo/63O/ggf+o1bupRBbdEPdrS5J6EOsFj/Mq4GMh+CIoKAVPl5
	 n+kKyFq+sPCPaZoakLXNsYhc2K3GEPFKQCLazaiQqVVcQH4CHjuxNCZcrffW+2goM
	 zVvcM7516hsdh/fYLxs+e89kmPyXd0hwU2OC2j0ABhYZWoi6foMYs3eHUuRVzK8Tz
	 abf8u7Sos4m6CcdgmXIPCF0BUcOHg5yB9jHu1XX/lBP0Sy9RoYFojACdG9sH+F9b4
	 N3HTAEwQ74a2WS0/Qg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2xw0-1t1MtA30k0-00E0Dw; Sat, 26
 Oct 2024 13:43:44 +0200
Content-Type: multipart/mixed; boundary="------------EdXqGhJCpze62TUjQaHey5qn"
Message-ID: <d60a9857-1e86-4316-89af-0f25cf29b81f@web.de>
Date: Sat, 26 Oct 2024 13:43:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
Content-Language: en-GB
Cc: "Derek M. Jones" <derek@knosof.co.uk>,
 Victor Gambier <victor.gambier@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
X-Provags-ID: V03:K1:zZyWd/gunqRBUQeR3SZuaphWMcDHH4rCshD7QDAhYp1HGuPfMtW
 jtpa6Qd12S4qrn4Yc+T+/cbZzMs3QXTleof4yPtN9vA8EN1/X4I8vUM49Jxgrliv7s+bDL0
 n+f6Nr5+IWCwf2hbRkVNs+ujQ9pUBTRPyQelgWHs4xMBS1brZwORbJ0rXQEAuBdo0ZmtcqI
 xigOGt3ROj4vrKd+JpxaQ==
UI-OutboundReport: notjunk:1;M01:P0:DU566UoHdPk=;ppaAf7ET5U+CtTD39ti3RCKxInu
 fNi6RrILRlhSYEPczd/RmMyGcwWU53jyzpor5jh06oqoO2xxbpPxYuAIiCfs6uZ38gMlCidlJ
 4jsFssHkVDJZAvRS2XyJlDm36QMAeFeiPCKNdCQKWLQv2X4AabWHsE1jyyLTPRFTUAyu3RwVv
 ZYPgwz7oizuSfaqJ2WvoC7Kc18wLzKOuRarD5liM71+J6cOarMbzQxnS45K9J5Ix4ipWxbgP1
 PldGohhFidIPx29LuvRQAW8wNL5cVtMKRGkiczrXofjgfhVtprf9gbOamPap0ZjsOpCsrbJbq
 SYhjLf+Cxyb1gpJOmhL9RSYQZxz8to9Ne5/Vr3DBiDots9ezRHBBh4BF/bwTAysb9YkPu+AGl
 lGeS6tJbtMB9peVoBe+VOUcrg+jkGObiy0+qYXBYDo6o0mkJWH/1Hri4ZlNPmbHgbgXf2Xx+O
 2tjFarqYK5S0R9f1o+76lGt0Xa5JlBAjBOEQV9LlIirB+R5fj0hzdwsbS+wmErxgpD8wUIuw9
 qEbHXVA541Zuaebxcsv1tNpG51GjcI+Es5wK02/3Yegp01/wSdDUtYeFEgUd9RMZbovqJgxCj
 7wNcJFVRqnITosxWmL6Q7C/qnAwq9eJ6qbQ4ASSQYmogQfvI1Bl7N5A+Y31bRVYsCUoQ7TWN4
 Qlr+rF2yrLfo12FbOTedVJ7DoFs6nTWYJUEbKHPoDCJlTMl1I/jhBJZqU5ltGrRh6M9VOrycV
 kdsYjJiniknOJIIzdU4EVWx37AV92VUkoMBz9ovIp/j4hWb0uMO3JKMebDBkue/Yk1ZxJq1jT
 Z3QpGgXx+8jsdzAp5BEyZoSg==
Subject: Re: [cocci] Checking SmPL run time characteristics for code block
 position determination in function implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1939
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/d60a9857-1e86-4316-89af-0f25cf29b81f%40web.de>

This is a multi-part message in MIME format.
--------------EdXqGhJCpze62TUjQaHey5qn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> Just tried
> ... when exists
> on a couple of files that timed out after 600s.
> The reported time was 0.209s, so it's a lot faster!
Corresponding measurements can be considerably improved also according to
the software combination =E2=80=9C1.2-00097-g7bc8a7ac-dirty=E2=80=9D with =
the help of attached
two files (for example).

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> time spatch --=
profile list_curly_bracket_positions_for_function_implementations1.cocci .=
./Probe/puts-test1.c
=E2=80=A6
action|"source file"|"block start line"|"block start column"|"block end li=
ne"|"block end column"
my_message|../Probe/puts-test1.c|4|1|6|2
=E2=80=A6
profiling result
=E2=80=A6
Rule searching                           : 0.000173 sec          1 count
=E2=80=A6
real    0m0,227s
user    0m0,189s
sys     0m0,034s
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> time spatch --=
profile list_curly_bracket_positions_for_function_implementations2.cocci .=
./Probe/puts-test1.c
=E2=80=A6
action|"source file"|"block start line"|"block start column"|"block end li=
ne"|"block end column"
my_message|../Probe/puts-test1.c|4|1|6|2
=E2=80=A6
profiling result
=E2=80=A6
Rule searching                           : 0.000196 sec          1 count
=E2=80=A6
real    0m0,242s
user    0m0,203s
sys     0m0,015s


Will effects be reconsidered any more for the discussed SmPL ellipsis opti=
on
together with similar source code search approaches?

Regards,
Markus

--------------EdXqGhJCpze62TUjQaHey5qn
Content-Type: text/plain; charset=UTF-8;
 name="list_curly_bracket_positions_for_function_implementations1.cocci"
Content-Disposition: attachment;
 filename*0="list_curly_bracket_positions_for_function_implementations1.c";
 filename*1="occi"
Content-Transfer-Encoding: base64

QGluaXRpYWxpemU6cHl0aG9uQApAQAppbXBvcnQgc3lzCgpyZWNvcmRzID0ge30KCmNsYXNz
IGludGVncml0eV9lcnJvcjoKICAgcGFzcwoKZGVmIHN0b3JlX2RhdGEocGxhY2VzKToKICAg
ICIiIkFkZCBzb3VyY2UgY29kZSBwb3NpdGlvbnMgdG8gYW4gaW50ZXJuYWwgdGFibGUuIiIi
CiAgICBmb3IgcGxhY2UgaW4gcGxhY2VzOgogICAgICAga2V5ID0gcGxhY2UuZmlsZSwgcGxh
Y2UubGluZSwgaW50KHBsYWNlLmNvbHVtbikgKyAxCgogICAgICAgaWYga2V5IGluIHJlY29y
ZHM6CiAgICAgICAgICBzeXMuc3RkZXJyLndyaXRlKCJcbiIuam9pbihbIi0+IGR1cGxpY2F0
ZSBkYXRhIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiZmlsZToi
LCBrZXlbMF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImZ1bmN0
aW9uOiIsIHBsYWNlLmN1cnJlbnRfZWxlbWVudCwKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAibGluZToiLCBzdHIocGxhY2UubGluZSldKSkKICAgICAgICAgIHN5
cy5zdGRlcnIud3JpdGUoIlxuIikKICAgICAgICAgIHJhaXNlIGludGVncml0eV9lcnJvcgog
ICAgICAgZWxzZToKICAgICAgICAgIHJlY29yZHNba2V5XSA9IHBsYWNlLmN1cnJlbnRfZWxl
bWVudCwgcGxhY2UuY3VycmVudF9lbGVtZW50X2xpbmVfZW5kLCBpbnQocGxhY2UuY3VycmVu
dF9lbGVtZW50X2NvbHVtbl9lbmQpICsgMQoKCkBzZWFyY2hpbmdACmlkZW50aWZpZXIgZjsK
cG9zaXRpb24gcDsKQEAKIGYoLi4uKQoge0BwCiAuLi4KIH0KCkBzY3JpcHQ6cHl0aG9uIGNv
bGxlY3Rpb25ACnBsYWNlIDw8IHNlYXJjaGluZy5wOwpAQApzdG9yZV9kYXRhKHBsYWNlKQoK
QGZpbmFsaXplOnB5dGhvbkAKQEAKaWYgbGVuKHJlY29yZHMpID4gMDoKICAgZGVsaW1pdGVy
ID0gInwiCiAgIHN5cy5zdGRvdXQud3JpdGUoZGVsaW1pdGVyLmpvaW4oWydhY3Rpb24nLAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAnInNvdXJjZSBmaWxlIicsCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICciYmxvY2sgc3RhcnQgbGluZSIn
LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAnImJsb2NrIHN0YXJ0IGNv
bHVtbiInLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAnImJsb2NrIGVu
ZCBsaW5lIicsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICciYmxvY2sg
ZW5kIGNvbHVtbiInCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF0pKQog
ICBzeXMuc3Rkb3V0LndyaXRlKCJcbiIpCgogICBmb3Iga2V5LCB2YWx1ZSBpbiByZWNvcmRz
Lml0ZW1zKCk6CiAgICAgIHN5cy5zdGRvdXQud3JpdGUoZGVsaW1pdGVyLmpvaW4oW3ZhbHVl
WzBdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBrZXlbMF0sCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGtleVsxXSwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RyKGtleVsyXSksCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhbHVlWzFdLAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHIodmFsdWVbMl0pCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXSkpCiAgICAgIHN5cy5zdGRvdXQud3JpdGUoIlxuIikK
ZWxzZToKICAgc3lzLnN0ZGVyci53cml0ZSgiTm8gcmVzdWx0IGZvciB0aGlzIGFuYWx5c2lz
IVxuIikK
--------------EdXqGhJCpze62TUjQaHey5qn
Content-Type: text/x-csrc; charset=UTF-8; name="puts-test1.c"
Content-Disposition: attachment; filename="puts-test1.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+Cgp2b2lkIG15X21lc3NhZ2Uodm9pZCkKewogcHV0cygiSGVs
bG8hIik7Cn0K

--------------EdXqGhJCpze62TUjQaHey5qn--
