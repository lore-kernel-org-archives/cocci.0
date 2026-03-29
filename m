Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F22F3D5FE
	for <cocci@archiver.kernel.org>; Sun, 29 Mar 2026 11:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=rRhgHmW2tqVeo17pdn1T2SUfw5GZtPrYbigu423G2ns=;
  b=qaoHCg24kj/yVKxtLQbb2Tp1rzR9yVXk7S9x3EYb3GoIyX0gpz5xW8I3
   jGrxVEoNhsnyAtsR/hryMtO9iNF+Gd9FAN/AxWblri/7H04eDq6CoUQJJ
   iIaXwKhD1mCZuoqEvGC9th86Yy7++lIm+88rq3U0ysj7dluf0HysmcYoS
   I=;
X-CSE-ConnectionGUID: IrZzu/GxS9y8xMeAQcoong==
X-CSE-MsgGUID: H1XC5tEySnmCNxvEg8Q9gw==
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
X-IronPort-AV: E=Sophos;i="6.23,148,1770591600"; 
   d="scan'208";a="269980742"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2026 13:25:15 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 233D1805A8; Sun, 29 Mar 2026 13:25:15 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id AEF53804DF
	for <cocci@sympa.inria.fr>; Sun, 29 Mar 2026 13:25:11 +0200 (CEST)
X-CSE-ConnectionGUID: 36557JN/TIaei0LrzK4qoQ==
X-CSE-MsgGUID: YhOp+MFWQvKHR6ZdC+UbTQ==
IronPort-SDR: 69c90c17_fiKxSNha0OPo0MX7yS8nGJLFPsIH5k4KwPHFiy7pTFb2lwh
 pA9K60cqCn2uyO3byr/AR7psjOIMEHCOxQQ87yQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EiCgDZC8lpfk7ASNlagluCP4EHXjQEC0mEWI9Thl+PE?=
 =?us-ascii?q?Yh5gVaBfAIPAQMBDUQKAQIEAQEDAwGCDIJvA40qAh4HAQQ2BA0BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEFAQEBAgEBAgQGAQIQAQE7Bw4SKYZPDYJbgSyBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAkdtH?=
 =?us-ascii?q?QEBESc0AhgOAnMBAYJ+AYIiAQYQAQM2Bw20RYEygQGCDAEBBoJp13sfLCJZg?=
 =?us-ascii?q?WcDBhWBCi+FboJKHAEFboojD4FVRIE8glKFf4MOgmmCJoEOgXmPK4FKHANZL?=
 =?us-ascii?q?AFVExcLBwWBZgOBBjI8Mh2BIz4XNFgbBwWBVIhFgWGBEgGDfjUCAQttPTcJC?=
 =?us-ascii?q?xsEPY0TK4NulXmzATQHgjiBZwWBXwyJCIEmlT8GEy+DcZNhDpMLmQaOCZVgh?=
 =?us-ascii?q?ViCAgQcgVwzGiSDNk8DGQ+NeAGEW4ELw1dEMgsyAgcCBw0DC4VEAQGMVoFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ewjxw==
IronPort-HdrOrdr: A9a23:8u40BKggmlrgjEYPC7XP7pAZhHBQXvgji2hC6mlwRA09TyXqrb
 HMoB19726StN9xYgBFpTnkAsK9qBznmqKdjbNhX4tKPzOJhILLFu1fBOLZqlWMJ8SUzJ856U
 4PSchDIeHRSX5nkM39/A60KNo4xsKbmZrY/ds2g00NcelwAZsQiTuR5zzra3Gfz2R9b6YEKA
 ==
X-Talos-CUID: 9a23:GAIaB2H2CbZuQL2PqmI8qhNJReIDNUH8xXrRe2uiG0U1UbqsHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AjcOmLw8WshE98fbKeyf8iFqQf/ZoxLztLW4yqIs?=
 =?us-ascii?q?lm/PaByBbeAqXsA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,148,1770591600"; 
   d="scan'208";a="269980728"
X-MGA-submission: =?us-ascii?q?MDGOPztEVZgXhgLbRCJR4TBhlvMmeiFANM45bc?=
 =?us-ascii?q?Pb1vyQJlPOM1lDLxfFoToxSF3sQXMZZRMIdM4hOnIe8JmIr1X9T2wBtP?=
 =?us-ascii?q?NxMET1efc2quIUG4iiX2nG44rK7epAfdFGhMciEgaOuDz6tLp38Um1vi?=
 =?us-ascii?q?iciN+JmSqE4dE3bek2VDDlEQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2026 13:25:10 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUCuv-1vyOMn045T-00WKF4 for
 <cocci@inria.fr>; Sun, 29 Mar 2026 13:25:10 +0200
Message-ID: <51b9e38a-7e91-4c39-86d1-25da2c6af376@web.de>
Date: Sun, 29 Mar 2026 13:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sxZLDGJZOobv/6n973xzbdqzgHLgmaMdEwLXmrH29sxBzh1ZpaO
 15voSfjF9Ea2vpSxcS28EUj7HYS9vy0Y3GJYKKxuW7nK8WH1y52z4OoHtkawN1KqqvWgMxO
 lVu6FdBnj2ykpbSy0ofJsAVC4O//u9H1JmIF8RaJhz4zIOGvO87rq9AhkZAGZxaHUhCJ77F
 Xiv2NO8LgKoiV/GKqVRQA==
UI-OutboundReport: notjunk:1;M01:P0:yKRqfY4AWZw=;JHWw0smXH4ZAof0sreaznE7+i5K
 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
 6SlK7jbFpaY65Hbee39+
Subject: [cocci] Logical consequences for applications of SmPL conjunctions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3466
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/9geJFcixQ_kGQLvXNIYsRg>

Hello,

The functionality =E2=80=9Cconjunctions=E2=80=9D became supported for the =
semantic patch language
by the contribution =E2=80=9Ccompleting the implementation of conjunction=
=E2=80=9D on 2015-08-25.
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/4069c543b25c819552e=
b080c849079f35f60a12e

The software documentation was extended by the contribution =E2=80=9Csome =
doc on disjunctions=E2=80=9D
on 2015-10-30.
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/48a6dd0aef1d233c8d2=
cf841aafedb1bf28cafb0

Are involved subterms as often evaluated as they are specified for such Sm=
PL conjunctions?

Regards,
Markus
