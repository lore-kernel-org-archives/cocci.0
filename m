Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10043C28B20
	for <cocci@archiver.kernel.org>; Wed,  2 Apr 2025 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZKn2ryuVOfYc4h58OsupZOJKG/NqnK52/qDCUO6Cr+I=;
  b=TN+Yz5CEa7TtOBk7DI/ET1MsVIV8wn3xwHlyWC5fYRQZ8ouVGvVKYuNm
   +4gL4VD15fqhMYqtvbS8Bnhq7yUFtLpeEO2En+Q5+IkX30TJr7xiMht0f
   3yXM6/RgrC/0bV2CnHYauMK7sF5fY/1voUISd+/F63Xy8eyvQu9dtSiWM
   8=;
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
X-IronPort-AV: E=Sophos;i="6.15,182,1739833200"; 
   d="scan'208";a="216003338"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Apr 2025 14:25:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2D28CE0261; Wed,  2 Apr 2025 14:25:51 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C6D4DE007A
	for <cocci@sympa.inria.fr>; Wed,  2 Apr 2025 14:25:49 +0200 (CEST)
IronPort-SDR: 67ed2ccd_i1y1dFaURD50f6zIPIF9DlpI+TdniZgeyjsxGvfGIN7HaAC
 0rTb2uROGvYxHjqzJvhGxe1cmnZjZyQ/yXnwGGw==
X-IPAS-Result: =?us-ascii?q?A0GfAAAXLO1ngAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDgVczBAtIhFWPUYF0MIQ7hzuHU4h0gVaBfg8BAwENQQECBAEBA?=
 =?us-ascii?q?wSCDIJ0AospAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBOwcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BA?=
 =?us-ascii?q?REnBAsLDgwCJgICVgYBFAEBgn6CMAEDDiMHrjyBMoEBggwBAQbaXB8sIleBZ?=
 =?us-ascii?q?QmBGi4BhWyCYwGGJ4Q8Jw+BVUSBPAuCeD6ECjmDW4JpgjOEQ2eJR4hRh1GRZ?=
 =?us-ascii?q?FJ7HANZLAFVExcLBwWBKUMDKjQxI4EiBTQ0DlqBY2lJOgINAjWCGyRYgiZqB?=
 =?us-ascii?q?AWBI4I1hDyEPYVNghGBXAMDIgGCL293HIMQNYEphF0tT4NBOR1AAgELbT03C?=
 =?us-ascii?q?QsbBj2kZoU+E4JpxiI0B4I4gWaBYwyfXgYTL4Nwk1YOBpJ9mH4iqRGBbQEzg?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OIYQtyhJBNTwCBwEKAQEDCYVGAQGKIDSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FXZnVx5fXw=
IronPort-HdrOrdr: A9a23:Mojio68u3uoSzVpO6jpuk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:vSxYVGDJ2wdilWr6EwJE029OCPtiSHuDyUfVMnKCWH9rToTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Am/aAQw+nfB1ru2H65rk2t7+Qf+hkpIS8EG5VqKo?=
 =?us-ascii?q?tp46AKjBhGBCsvR3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,182,1739833200"; 
   d="scan'208";a="113255287"
X-MGA-submission: =?us-ascii?q?MDHiwfCKDG5J8VHSudwgrdd5AUMbOCVe2rnCQg?=
 =?us-ascii?q?zJ+j0N7R4FLlHgI7OxsdUdgYKyDo+XQ0hFmyDgt0s5Ko6cmOnYQT3gBd?=
 =?us-ascii?q?1Xv7adpXnc+8+1omf0MEiE3TP5j9p9CgFK9q2/PGvygMUbL49WHIkPLp?=
 =?us-ascii?q?ApgR9zdtfGNFxzdMiH1K8Mtw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 14:25:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743596748; x=1744201548; i=markus.elfring@web.de;
	bh=ZKn2ryuVOfYc4h58OsupZOJKG/NqnK52/qDCUO6Cr+I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CbFBH9RsQHxBwVtlukkBf+k4XqCF1CxBZA01MOVSSwWRNzLHfQa0uL9WqlOXN48O
	 fizZie+EuVX+cx9clw6W2DwrVii8eePr4AOktdVzq8QK0XfdTlDWFptUF20rO1QA1
	 vr1hIvNsoWCeoHXKdnXdbbua6uJtbncXRTWWCUO7UqRbhtRL5rL2QR1N2CJBT8HmT
	 dq+MTvSzThhaKWZfueBdg7x4BaL22qeLPFJ2zQFyDuerqijDAuSQSJ6QS6pnAfKbR
	 S7pUeIhbVHKyFaNKmnE9uWWN+QOvZh065sY5+itfUepRFhlrUKvgppkK24gECV9ct
	 w52r898COACYrj5QKQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4sc1-1tz7wy434Z-007YkH; Wed, 02
 Apr 2025 14:25:47 +0200
Message-ID: <60dd718b-b828-4562-926a-a756f1666ce3@web.de>
Date: Wed, 2 Apr 2025 14:25:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Stefan Winter <sw@stefan-winter.net>, cocci@inria.fr
References: <87r02an6w0.fsf@debiant14>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <87r02an6w0.fsf@debiant14>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HqXyqGASuXYoTL5XeC6/kJp+WwuOwFY0VUMqCE0/bUTDycRVedC
 z9EqgDGMCimA5jwt91oyqBZWg/9tZxzgXGiZovdXbQd2rLOq9CKJ0KrSCm5CSYNQgPeRFgI
 0gpOGnF7RQqENd4BYTcnfNXzKbTH9GbXjMf2GBHxZ8fScDEBHyjIj1FhmEcTjYyogm73JAP
 qBtA9oIIICUfyZJOecpow==
UI-OutboundReport: notjunk:1;M01:P0:447V8pq7V8g=;IZOy7jY25Ju7pdoDxaoqtIO4YNx
 XMtU9OtJHqsuBznKluzNut1uFcY1IwDzEAvg13gUhyg49iFZaiUNZ+8d+gEwcOohZ/Fy1jbik
 m4/R/31PpECpm2G38f+WwybLJeD5ZsNKB4cL1HCp6K9FlRxsITnRHWohQA858dwuE9karsWLn
 A1tsCPjfRRKdipiLP3MbsUoXU2YbMY8E46Cu9EHYDFcOiXrP363+mU2tupmbUb0pYuibMtZYl
 n32R72zjKMv+llp6QkJVo4EWSlrcYqo/eDTkEmZJNA8c0WTM1R1tTGXxpCYDjbQexJD07qfR2
 7BDtCv3RUq0LZaImAgwQSRpaCaQZ+uEn0eS3ozP2Pz49k1AZ0bO4QNPRLlcKD0/OcwybZ1p6m
 1HnZe3kpGBykp2swQ7n0t/j7z0lAtBHS+Y9nIvF+6w3In3Opd+KQY9DxyJtY5gZM3VogPD/+g
 PKy2ivI6h3YqbWLwja5Rb9WmBNg9XSSqBePfjY8aIF3Q/O0+/ObBnnm12epqw7MXuN1qHO0Ve
 +MjXPRpwpGmAtp9GU2HH6w7cyf5JrLFC+93M2rBEV83j0EIE765azKB+Ahq+34WNOiuyI92t5
 r1ALpV/015bY/ilQaeBUr2Vwx5Ql4F/lpTot0poGQTvMD76DBD/ARVCLgZHgolcVSepoSheM2
 BNqZCuURJbOPcCh9qfNVxpSAIJil1WP+4q9k6DsGJdSGyiupscldiEpb4uW0Yf24tu6jVGADZ
 Slb/AtUpOL98Xh/my/UIaSX41o6eeKUp8DwEkzF3odMPMAOWcaMOSfgAW39bIwNqoHAbVaGdV
 aCyF4XGmSkMoyrs8+34g7mi4/lJwedsQakM0JK+FVdHr1MHe0ZXGTPflMq/mdDzBU+PVvji1x
 JZxyKVezjXaOWaRUGys+N9Suf/WXwZtPFvwX/cVOb9ao2TNPwa95pgytcnQTD1XNKPhWGyGZt
 XIGnAxrht1tuFaVs7XRzwjXocmQlUpNo3NdkOyj50Ztlucx+DRrLnDCa7egT3c+jaOi853zaF
 /KzJ03Ydk1JBxZgSTPRD/h3Lk3x0ke118617/mSQzkhsdHJ8Zei2PovhGK/0R28A/KpSEuXYG
 Nz9HgWzqVGXWfdsAFGzYRUXYUBdKmhyOzFbsn9U4d1E21g2OlgJOyCrpGAyxH2O6RLL0cDq1V
 BKYioC9nx5+bBrCGa1bi6OLq4tfz8ZBeWIRA8ITheiLYkvPgvfUm1XVPw7ABiII+hZLljE4/0
 5SaPJrNLLf6xGwExsCxw/P5gatpD/DJANlHkBTTh/NFqtW4WNJpOoDUUs6YtIL2AmcbOQ5C44
 Z/9yOZVBT27EvxxXfr68U8v0O80BHnjDQdhEUhTtfnioiCcUPPl2iyPq+yRx9oYOABYMnuAEH
 95SGFzzpUDHDoUV+FIPfcaUKRUvkNTXfYIkzK6tNFAprhZrCezOZclcKxI5Pe0XS04ldaEH09
 I37CKVVgMheVC7+mnHSdpTXoxMt6MahGKiyoyspnSS+DKBRIL98dQGzHjashgXThUsU5cqw==
Subject: Re: [cocci] Support for unary operator matching
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2681
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/60dd718b-b828-4562-926a-a756f1666ce3%40web.de>

> But it seems Coccinelle is choking on "unary":

I wonder also why a SmPL script variant (like the following) does not get =
accepted
by the software combination =E2=80=9CCoccinelle 1.3-00083-g4093aad2d=E2=80=
=9D so far.

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
meta: parse error:
  File "suggestion_for_Stefan_Winter-20250402.cocci", line 3, column 0, ch=
arpos =3D 25
  around =3D 'unary',
  whole content =3D unary operator uo =3D { - };


Regards,
Markus
