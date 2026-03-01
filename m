Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E95FD0060
	for <cocci@archiver.kernel.org>; Sun,  1 Mar 2026 12:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KsqlcePUY5/GCHEQRIF/SSm2+o0wzy49QNn9Du+F1rg=;
  b=FoiNGCpWpXge3XlWi1UoWPKIXxGnhy637oTEa5j68FwBh7K+JS2WJmKT
   7ee8WrbLEVrRbmJD5oW5ohWmY+WDdwFlwbJ+fsZcjA9NqX89gXNP7IF3G
   aUvOuIRD0MRCFsXyor/wkyKuGbQakI2XixWLEBKlz2AccuieXrSAl+lzE
   c=;
X-CSE-ConnectionGUID: xkRTOWjqQcmK4HndZ1CBFA==
X-CSE-MsgGUID: BlWLIBn/T92yYqL/QSaNXQ==
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
X-IronPort-AV: E=Sophos;i="6.21,318,1763420400"; 
   d="scan'208";a="265651016"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Mar 2026 13:58:31 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9776980E19; Sun,  1 Mar 2026 13:58:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id CCEBE8052C
	for <cocci@sympa.inria.fr>; Sun,  1 Mar 2026 13:58:29 +0100 (CET)
X-CSE-ConnectionGUID: wWa5qjh9T0mihGZDOeFW6Q==
X-CSE-MsgGUID: +lGXLBIsTCq2FCGl8vGGeA==
IronPort-SDR: 69a437f5_Ee6jci4bzy22JGG1nUgzb13EQhEpHYSNrQckFBgHI9WEPiy
 z81Z8O/FkVskRpfwTwdEkFY1gt4G7bdLW4R+neg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H4AgAxN6RpgA4P49RagQmEEWh9NAQLSYRYj1OCJIQ7h?=
 =?us-ascii?q?zyHVYxLAg8BAwENTgECBAEBAwSFAAKNIAIeBwEENBMBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBDQEBBQEBAQIBAQIEBgECEAEBOwcOO4ZPDYJiAYEkgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEdAkdEAQEBAgEjHQEBESYBBAsLGgIYDgICVgYVAQGCfoIjAQYQAQMPJ?=
 =?us-ascii?q?weqL4EygQGCDAEBBtpkHywiWYFnCYEfLoVvgmUBiXR6Jw+BVUSBPIJSMT6EQ?=
 =?us-ascii?q?4NbgmmCJnoUkxRSeBwDWSwBVRMXCwcFgSNDA4EGI0sFLR2BIyEdFxQfWBsHB?=
 =?us-ascii?q?RIhKhOCE3iCAQ+Ga3kDLl4aDiICPFxKPgoBWgWBOQIBC209NwkLGwQ9jmQ/g?=
 =?us-ascii?q?UGCc4EUxyA0B4I4gWeBZAyfbQYTL4Nxk2EOkwuZBqlBgX8jgVwzGiSDNk8DG?=
 =?us-ascii?q?Q+SVMInRTI8AgcBCgEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:P0MtFqP9VU6AIcBcThWjsMiBIKoaSvp037Dk7TESdfUnSL39qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:LBIo22AZSdWxJTf6EzZY/RMNGMB0TiXYzXf/EWOfBEhWFoTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AvJcswAxloufWDflm3P6U7CxqDv6aqOeqJ3Apu7Q?=
 =?us-ascii?q?dh+KdbwJbFDPNkhuYT6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,318,1763420400"; 
   d="scan'208";a="140079466"
X-MGA-submission: =?us-ascii?q?MDEQa2qTWwN+w1E811tF5d1Xb0Ba2kJWU10W8k?=
 =?us-ascii?q?HdbQZWxlX4YvNOT71Ia0hoxa9gqgtbZRjkZJW6YfJk3li/kq8x1EdHVA?=
 =?us-ascii?q?Hg/H0BQ/LVBmlvOlrg3hMIqW+Xj2//yrunR+JApwwOXCf1lXtYLfRcBG?=
 =?us-ascii?q?BV80phvGyCb2LXazo1CouQCw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 13:58:30 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8TBM-1w145c3Eau-00EhfW; Sun, 01
 Mar 2026 13:58:28 +0100
Message-ID: <9548ebc2-57ba-4d35-aa07-015c9d2b1e2b@web.de>
Date: Sun, 1 Mar 2026 13:58:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <30ca5b1f-1add-4ce2-b01c-495966773a98@web.de>
 <1d6176db-f59f-9ebf-f96d-87babf92526f@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1d6176db-f59f-9ebf-f96d-87babf92526f@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0uBLQFj5K86gngei3FWEhACa2Gy0Pksydu9OTbrWjEnfbGnEMXd
 4B5uqMC1OBUUqOXfYfUs+7BSMq3FxVFZWq3/c3rFgv9RuRSQ42MBW3+qaQYxvk6nXirrw44
 jhvAE0p9XCkGRoGQP1XzKSB6q1X55qhE+HFxCvNFl0KJnc3wjB0JFWEFCCtdsEamkCZ4Ulm
 pw+Spe11vuSQFCTWWh8bg==
UI-OutboundReport: notjunk:1;M01:P0:3YF72CM7xyE=;SONEfsJoAyLxIT1NaenAZHjk8/V
 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
 E2wRALaSA2Prao0pw1puomAKF2jHk
Subject: Re: [cocci] Separating label from previous key word display
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3315
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/gnH3hWFQf3CLONc6SCbY6g>

>> How can it be achieved to separate the mentioned label from a correspon=
ding
>> key word display?
>=20
> I have no idea what you are asking for.

???


>                                          It would help a lot of you woul=
d
> provide an expected output.

Would you find the shown display improvable anyhow?

Questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-parse-cocci test_parse_goto_display.cocci
=E2=80=A6
-return -rc
  >>> gotospecial_target
;
=E2=80=A6


Would the representation be a bit nicer with an additional space character=
 here?

Regards,
Markus
