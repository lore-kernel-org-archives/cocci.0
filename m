Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B0BC624DB
	for <cocci@archiver.kernel.org>; Sat,  5 Sep 2026 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=XnjN0lUevyo9qL3txMKTxGWrEHINSKoE3M8GqgzpA3k=;
  b=N9XDNbq+XXWbS0XVCJ59HxWJlcaT/d4mDzEr7FOp0QrCrPOlQyjAnzTA
   gl6oV2HSa5bVRU3HqTVMHHlS956q/z+n4PTl3HUqnW77arm+7mstSEXsl
   wWof6T41NqWIklK3ttgtyJM3NtXZGyQg2G8ls9BQjwe7vgN7fgY74Lqtj
   Y=;
X-CSE-ConnectionGUID: 6raT9EvZTiqvViX2maGkyQ==
X-CSE-MsgGUID: DjjuLJnDRsiRT3rcCsGP7Q==
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
X-IronPort-AV: E=Sophos;i="6.25,264,1779141600"; 
   d="scan'208";a="293355517"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Sep 2026 17:19:22 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B124A801CB; Sat,  5 Sep 2026 17:19:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id BE4B780681
	for <cocci@sympa.inria.fr>; Sat,  5 Sep 2026 16:39:00 +0200 (CEST)
X-CSE-ConnectionGUID: oyBRY2yTSNehXEVKfRa7rA==
X-CSE-MsgGUID: yT/Q0WnWSUuLn7z4KZdJeg==
IronPort-SDR: 6a9c2983_8u0Kqa2BYVayEFrxQf59+7D9xgUL0yBrs40UQaD0B1Shkvx
 XTxAuZ6zO8iH6sTnVl8CXGgYSp1Zsm6h1D/j4Uw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GnBgAkKJxqgAwR49RaglmCQYEKYDQEC0mEWI9SgXSEa?=
 =?us-ascii?q?48RiHqBVYE/PQIPAQMBDUQKAQIEAQEBAgMBgguCLTyOEAIeBwEEMAkOAQIEA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBOwcOO4YgLw2FB?=
 =?us-ascii?q?4JEhFKBLGAHPwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAg06bR0BAREnNAIYDgJzAQGCfgGCIgEGEAEDNwcNwyuBMoEBggwBA?=
 =?us-ascii?q?QaCatd/HywiXYFqAwYVgQouhXGCURwBBW6KKA+BVUSBPAuCSINQAoEngQaDD?=
 =?us-ascii?q?oJqgiaBDJNygUocA1ksAVUTFwsHBYFmA4EGbjIdgSM+Fy9YGwYFgR2BJ4M/I?=
 =?us-ascii?q?xk2eoEJXoErKWESF4EJgggCglSBJVwCAUlDDgdFUwknSxIMC209NwoLGQQ9j?=
 =?us-ascii?q?2Mfg1ITLII9kzyzBDQHgjmBaAWBYQyJCoEmlT8GEy+XUw6TDJkIjgqVYIVZg?=
 =?us-ascii?q?Wg6gVwzGiSDNlADGQ+NeQGEKjOBC8pdRTILNAcCBw8ChU8BAYwiNIFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:oGR16a88Qhg0Ip/1j1Zuk+D6I+orL9Y04lQ7vn2ZOiYlEfBw8P
 re+8jztCWE7Ar5PUtKpTnuAsa9qB/nhPxICOoqU4tKPjOLhILAFugLgLcKqAeQfhEWmNQ86Y
 5dU+xZFMD6C0R8gP33+Q+iDr8bsaG6GeyT5Ns31B1WPGdXgkxbnn5E4o33KCdLeDU=
X-Talos-CUID: 9a23:bh6qg2yi6xkr3WSlhpF3BgUTC+ofQyfM8Ez2Lk+IJFhKRoecFkW5rfY=
X-Talos-MUID: 9a23:1L47NQW43P8WSHjq/C7Qwwg6C8FX2JmzLEZSg8klicWmOCMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,263,1779141600"; 
   d="scan'208";a="156023266"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDET/Dwbq4JL4kRpX2A4xbW+IE8AFR4TO2MG8H?=
 =?us-ascii?q?n0SSCFAK6ot+rNg+oO2UUlx9EJ0bTUprBlbTGAAGfKFV8T/WGTlCf5Bw?=
 =?us-ascii?q?0AFEmQeLAy9JV4A5lTFIVPDLmINLCd81EJdsdoX+UaG99lk99vCJlfbB?=
 =?us-ascii?q?1jQwj7SBwsqk2r4gGbXDdjIA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 16:39:00 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVrbz-1xSTRv37UT-00Vm27 for
 <cocci@inria.fr>; Sat, 05 Sep 2026 16:38:58 +0200
Message-ID: <db02aea1-9293-4eba-9f81-52b41a434a8f@web.de>
Date: Sat, 5 Sep 2026 16:38:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tbK80bWSme8g6LUmwUhsskgIiE1wNR+ambNC8acz4GxBs/biBE4
 2voIfOef8kbLHDu+vAoJyZFVKj/DVo++sxOiVFrFIF2IBSiJvMmPJYRgpAdoSEljg6DHjzm
 X9fVTD2I9WXgydck8VkcpfEj1iN3Sb9lkAYSsvCgy0Idr3iXJUyYsVbyrRKVirU7RqYiZ7i
 bMM/NxA7rmEGK1OEZUm5w==
UI-OutboundReport: notjunk:1;M01:P0:yyaOtAuvfiQ=;TZ283ESBL6ZIWyBetSv+B1JSlZ2
 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
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Improving support for unary operators with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3728
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/29zQx2-pBp_gqMjjcNcwPw>

Hello,

Unary operators were mentioned in the manual for the semantic patch langua=
ge
since a contribution by Corentin De Souza on 2020-04-02.

metadec: define them properly
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/013a81ad21ed2caf4bc=
5c46753828cefec4e60d5
https://github.com/coccinelle/coccinelle/commit/013a81ad21ed2caf4bc5c46753=
828cefec4e60d5


Thus I wonder again why an SmPL script variant (like the following) does n=
ot get accepted
also by the software combination =E2=80=9CCoccinelle 1.3.3=E2=80=9D so far=
.

@deletion@
expression x;
unary operator uo =3D { - };
@@
-uo
 x


Questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --parse-c=
occi suggestion_for_Stefan_Winter-20250402.cocci
=E2=80=A6
meta: parse error:=20
  File "suggestion_for_Stefan_Winter-20250402.cocci", line 3, column 0, ch=
arpos =3D 25
  around =3D 'unary',
  whole content =3D unary operator uo =3D { - };


Regards,
Markus
