Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B98C76196
	for <cocci@archiver.kernel.org>; Tue, 28 Mar 2023 19:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0SyDV37hgEDzvP+fLgULsjf2WPN6iNEyBBXGcTpZYRk=;
  b=egcoQq1mHj0JnrNcq0l2rd5auckm/B1Xfxphmo26M9Fol6rJddLmVr/g
   rXI4CD5kNw1c8IUhaCp0DTfWdczyGmMQI6giFthUOMD8I7r462174vi2G
   RAlLbG7z8DalKpvQtSYl7BvQ5zalAZuFb8T2AgRoNq1YOKukzLQACuDDa
   8=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="99584551"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2023 21:24:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B9B06E0D44; Tue, 28 Mar 2023 21:24:11 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4014DE0D40
	for <cocci@sympa.inria.fr>; Tue, 28 Mar 2023 21:24:10 +0200 (CEST)
IronPort-SDR: 64233ed8_tPeKDPorL6aRYtbG/Xh1O9tbIFf9aMVRComNKiEcnCa7GM/
 T0D2M/6+P9DioU2sdswv3A6DPyv4XTkiUVb1nFQ==
X-IPAS-Result: =?us-ascii?q?A0FEAAC2PSNkhwMP49RaHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YItdVYvBAtGhFORAS4DhC+HLIc6hGeEAoFWFIEsPg8BAwENQQECBAEBAwSCC?=
 =?us-ascii?q?4JzAoU5Ah0HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBA?=
 =?us-ascii?q?hABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkdTPQECAgEjHQEBESYBBAsLGgIRFQICVwYBDAgBAYJ6AYInAQMOIwevH?=
 =?us-ascii?q?4EygQGCCAEBBpwKHywiU4FeAwaBFC0BjQSDNnonD4FVRIEVJ4MDPoN9Rz+DG?=
 =?us-ascii?q?YJngimLdoslCoE0c4EgDoE9gQQCCQIRa4ESCGuBfEACDWQLDnGBSgJkTIEgJ?=
 =?us-ascii?q?QQOAxkrHUACAQs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg5Bhs0EQIIDxIPB?=
 =?us-ascii?q?iZEDkI3NBMGXAEpCw4RA1CBRwQvXnwKBgEmJJxgBm5SKD8gJpRckkCeDjQHg?=
 =?us-ascii?q?iiBVYFZDJ8MBhMulwgOBpIjLpc8IKd6gWUBN4FcMxokgzZPAxkPjiAZHoNuj?=
 =?us-ascii?q?0g/NDsCBwEKAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RwjFqXMAyWM
IronPort-HdrOrdr: A9a23:mVE+uawyeQZds86TSg5YKrPw+L1zdoMgy1knxilNoNJuA6mlfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIceoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="99584547"
X-MGA-submission: =?us-ascii?q?MDGchhYwHEyMJeglN2/OfeJcUKvtURyOUYQziz?=
 =?us-ascii?q?zwADsdEi6Q7W5lL5vzoqC4/DOi+KmAj/NysMLYyAFxmIV9YgepVZ15H1?=
 =?us-ascii?q?GXCtKdu1J5G+3NMz+Nrcbk0UIxzNkjBAmywPdxmXZu5q8IcC3OlMxuJM?=
 =?us-ascii?q?VD6NGPP9nCtTadYT0QKR8xtg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 21:24:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680031441; i=markus.elfring@web.de;
	bh=0SyDV37hgEDzvP+fLgULsjf2WPN6iNEyBBXGcTpZYRk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V0xgfvDoEtJ/278iofS4JAt/4z2Mi6i/QtL2qKl4MgPrDf/eKO5oFYS47KSxsCUGs
	 FqvnD4NCi2on3lnJPiPJ8m7PX35QHpvjgqVC0xrbpJ1lqFX2xdSQyBCyrctVDat7eI
	 wtGzvgRi/1rhiBc/U1pUffBv0cBOnLrcdgBg/LrDbk4ER+IG1wj47e6icZOaurzSsA
	 9z8wdc6zDUMb8NuSAWzC0eMS5pNoVbZIkmD+H0nJAUGPDBmYrxszMSARaOlWnRi4v0
	 ailsBpanpdAg0nnQqg38vUpxK3LIZKzBHF4iVRWO60NyDVFeV1Kx+0989tnP4+Rg/a
	 2Pbw8PazZi0Qw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBB3y-1pb8nP0mh4-00CkQC; Tue, 28
 Mar 2023 21:24:01 +0200
Message-ID: <7985ac57-5b33-e7df-f319-ad6ee0788e2c@web.de>
Date: Tue, 28 Mar 2023 21:24:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
 kernel-janitors@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <5ed1bc78-77a1-8eb8-43f9-6005d7de49c8@web.de>
 <9e3705dc-7a70-c584-916e-ae582c7667b6@web.de>
 <7890284f-5809-2f46-9d5f-52e20a3ec327@microchip.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7890284f-5809-2f46-9d5f-52e20a3ec327@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TVIIelymUzfLb0a8r6UH3UIkwYTOmdaAM9MOMNNv36vSJ3lFEw9
 Y/Q8HwHzBA5I3v1TgsYQMNhnlI7qZGM1y3j+dqUhK2Q/eNJIYNHa4NAXUFGk2Mh5uemhrpn
 yWRqSIZVa47uJGErJiEpLB7zfFeUgaVDc1AqF1CR+mbrOdp/uOYbesg6L4wdH1w9kpd+7wi
 idgUyGKxA/OJreJtfuBiw==
UI-OutboundReport: notjunk:1;M01:P0:xZOgmyI43M4=;dAJGD6+Bom7jrJO0XXB1kSd809z
 Whzmb6KCEh01WhdG1/k9mCBAbBV7c1HjehwnX33Xd+7AmcRB+XmZG0nAQ0uFAZY/n1tals4gY
 dU18hbenwImTZZx5Pxn/ukznNB7kkc1yh+iAr4+MR/rsVGgjB8ges/45SkwNqfC9dq60m9lp0
 OmvOwFbtlQKpQqEW4lsaCdVBrgnOwydSHnKpY89VMJJJU364UKrRb9jnISxevm/xFsLqfmUMw
 6S1BIqmj1t7rXc5o8eLso5BZborb6ui1h2wi7tgllyU57JVw39ErpqwhahnldJXkzM+lbtfsk
 r76R6+i8CH6Lt13dSIZUJBUURzHwYan5Ci0ZFE036gs5G6Acj0FgzPpEfXh3FVsnBuuOaG+Ev
 MW8JHKBUEwFmoSCo/BpU/mzIKe9/1OM41zmSgi2o9qmOo4ipNHJ7mRsGUzpRWwLbvM/ylUQ2G
 DTKBNqAUcXTy8SnoPKOl+yaOQczw41fldW0e62cDYi0gXLRNoFM25TtI/Otdr8aPxsISjFotJ
 H+1ipprqf57VwbXf5bwbu9Zm0cML6pxGuU7VEz1jWNIw16qq0SGV7D0E5Ixn3XDD4mJEvPtbN
 dT+0XonyYur35cOwWYnq/Me0eCKt3AgVjpWYJEbzOa38ZTuZWovwiIzeyTmx2HBkaQb4l+fiy
 mgMb0WYWsaSav97Ifp2US4SSgZmRKjRw9W3AMBI/pVK0fEzXFUhT5ygoFDw8g1Jp2/C2i0b5a
 wxCYScduugXVeLtR9vNZHiNLbcOo+pDpJ7Gz+7DITIa5FaHNBl9wySnKB7LDPwGxV5i0wqIx0
 +Gmoayo9+s21EHmDdIxSiKfDD0LZA728xKTY4tHIPq6IQ/bLKuUu65RP09S1qU+JoOJv6jDqY
 yt4cKlYGXRJmkn52fEcfpKZOR5TKnXTGyqE8HgBa0COxhg4a/mwjSgOFf
Subject: Re: [cocci] [PATCH resent] clk: at91: sama7g5: Add two jump labels
 in sama7g5_pmc_setup()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 977
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/7985ac57-5b33-e7df-f319-ad6ee0788e2c%40web.de>

>> The label =E2=80=9Cerr_free=E2=80=9D was used to jump to another pointe=
r check despite of
>> the detail in the implementation of the function =E2=80=9Csama7g5_pmc_s=
etup=E2=80=9D
>> that it was determined already that the corresponding variable containe=
d
>> a null pointer (because of a failed memory allocation).
>>
>> * Thus use additional labels.
>>
>> * Delete an extra pointer check at the end which became unnecessary
>> =C2=A0=C2=A0 with this refactoring.
>>
>> This issue was detected by using the Coccinelle software.
>
> Fine, but I'm sorry that it complexity the function for no real value.

Under which circumstances can advice be taken better into account
also from another information source?
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es#MEM12C.Considerusingagotochainwhenleavingafunctiononerrorwhenusingandre=
leasingresources-CompliantSolution%28POSIX,GotoChain%29



> Other clk drivers have the same pattern so I want them to all stay the s=
ame.
> This is a NACK, sorry about that.

I am curious if other contributors (or code reviewers) would like to influ=
ence
the software situation a bit more.

Regards,
Markus
