Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADA9C87FCF
	for <cocci@archiver.kernel.org>; Mon,  4 Aug 2025 13:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=E5+4FxpRGCz+YenKBRhbGEvX9u+lTwwcfgdMDlAAfCA=;
  b=hrgFV8W+vo9CsTEnuociBnnPbpYymmi3YaoyYxxRALmGKbQoWkJiaHl0
   Jbxomufub52QlkxSB8QFf9HenpyxDvJ7FtaG7+zLJG7U8sz14J5kzgsSC
   oFOoT1W7LLGjECpQWB4fzL+z3KBYImPDqs4wyQhJampGmRWgB/D2mgQvU
   U=;
X-CSE-ConnectionGUID: x72lpCPZRQaRNb4ZxrBuAQ==
X-CSE-MsgGUID: LXKYU0XuSy6lZfANJwxQvg==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="234115405"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Aug 2025 15:11:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7C8E0E0264; Mon,  4 Aug 2025 15:11:32 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6CC6EE0171
	for <cocci@sympa.inria.fr>; Mon,  4 Aug 2025 15:11:30 +0200 (CEST)
X-CSE-ConnectionGUID: QnRFVaTfQ5OzSd51fMO8Yg==
X-CSE-MsgGUID: 8jNtzB7jRLmsuXCmhScufQ==
IronPort-SDR: 6890b181_stCmk2E8cUjFjtyrcqO+g1XEaLaYHjcDFsDBBEuPnAmguab
 nXmAf5gjJeIC4b1GciR93iKJKa7fJQ0x4egh0HQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FAAAAVsJBogAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgQZUMwQLSYRViByHNIIkhDuHPIdVik6BfQIPAQMBDU4BAgQBA?=
 =?us-ascii?q?QMEhQACjBoCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjH?=
 =?us-ascii?q?QEBESYBBAsLGgImAgJWBhUBAYJ+giIBBhABAw4kB68SgTKBAYIMAQEG2l4fL?=
 =?us-ascii?q?CJZgWQJgRsuAYVsgmQBhjCEMycPgVVEgTyDAz6EQ4NbgmmCJoEWg2ONBYhwU?=
 =?us-ascii?q?ngcA1ksAVUTFwsHBYEgQwOBDyNLBS0dgSd9gw2BDoQoK0+CInWBeUEZP4NTH?=
 =?us-ascii?q?gZtDwaBFRoeLQICAgUCQ0WBYBkGGkACAQttPTcJCxsGPZNVg1VOEzCVVpN7n?=
 =?us-ascii?q?yU0B4I4gWeBZAyfbAYTL4Nxk2EOBpMFmQajcIVRgWg6gVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?YQzumhBNTwCBwEKAQEDCYVGAQGMDIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:fa753KwBlfRhSlzu/Px6t+fwwirEfRIJ4+MujC+fZmUNrF6WrkVTn
 zRMCz2HOveKamXxetAgbouy9UwBv5XWy9RhTARlrFhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliOfVAOO6ULOZUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDtLg06/gEk35qmq6GtB5gZWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x138FFtO/n7/nRVYBS7jUMBLmoiI+t3+K33CuDgRrukoKHKJ0hXV/011lrPgto
 Dl5jqFcfC9yVkH6dEvxZDEDe812FfUuFLYquhFTu+TLp6HNWyOEL/mDkCjalGDXkwp6KTgmy
 BAWFNwCRimFvcyIyY61c7RLlP8vcZDlGaRPi341mFk1Dd5+KXzCa6DN+MMewzo6wMxDdRrcT
 5BAM3w1NkuGOkIJYw1/5JEWxI9EglHaeidbtUnTiK45+WnVwyRu3bKrPNe9ltmiHJ8PwRrE+
 T6Xl4j/KkEYEsCN42WHyFapnfL/tib7Y4kPGoTto5aGh3XImjxLU01JPbehmtGyjUW1WvpEO
 kkM82wvq7Iz/QqlVLHAswaQpXmZolgDVtAWH+BSBByxJrT82gCjKFYNcjB4Nfs0j8NrHDIP8
 Q+4kIa8bdBwi4G9RXWY/7aSiDq9PykJMGMPDRPoqyNaurEPR6ls1nryosZfLUKjsjHiMR3dq
 w1mQQA7gKgPy9EG3eO38DgrYg5ARLCYF2bZBS2OAApJCz+Vgqb7PeREDnCFtJ59wH6xFAXpg
 ZT9s5H2ABoyJZ+MjjeRZ+4GAauk4f2IWBWF3gMzRcV8pmzwoiX9FWy13N2YDBg5WirjUWC2C
 HI/RSsMvM8JVJdXRfQmOtPqVazGM4C5T4i1Cpg4keaikrAqKF/fp3ExDaJh92Hqlk832boyU
 ap3gu78ZUv2/Z9PlWLsL89EieFD7nlnmQv7G8qnpzz5i+T2TCDOE98tbgDRBt3VGYve8G05B
 f4FZ5PSk32ykYTWPkHqzGLkBQ9adyZkXs2m8qS6tIere2JbJY3oMNeJqZtJRmCvt/09ej7gr
 y/jCHxLgkHyn2PGIgisY3VuIuGnF5VmoH5xeWRmMV+00jJxKcyi/YUORasRJLMHze1EyeIrb
 v8nf87bPO9DZA6a8BsgbL78jrdYSjKVuSy0MRCYPQcPJ6xbe1SR+/vPXBfeyy0VPy/m6eo8u
 +KB0y3Yc7oiRiNjLp3kV9Oy/XyMvFw2uuF7b23XKPZ9JWTu94lLLXTqr/kVessjFzTK9gG45
 S23XygKgPbrmJAk1uXJiYSvjZabI8EnEmV0R2DkvKuLbw/E9W+d8Kp8eeevfwGFcljr+a+nN
 N5n/9ulPNIpxF914pdBSZB1xqcD5vzqlb9Q7iJgOF7pN12LKLdREkOq7Pl1lJ9m5+Fm4FOte
 0e15NNlF62DO5rlHH4vNQMVVLm/+s9OqAbCz8YeARvc3zB2zoqlQE8JHhiriQ5hFpVXHr4h4
 98cvJ8x11TipDssas2LnwJFxVSqd3YgaZgqhrseIY3sizco9G18XIzhOnf2zayLOvpxMRgMA
 z6LhaD9qaxW6WjcflESS3Xc/+pvqq4fmRJNzVNYGVWtn+DBp/4o3S9+9SY8YRRVwy5mjcNyG
 DlPHG9kKZqe+wxHgJB4YFmtPAVaFji1x1fUyWZVpFbGTkKtaHPBHFc9NcmJ4kod1WBWJRpfw
 52110fnVmzMUPzq/y5vR3NglePvfeZx+iLGhsqjOcaPRLs+QDj9h56RdXg6kATmDewxlX/4i
 7FTpsgoUpLCNAkUv6EfIKuZ3+5JSBm7eUpzccs496YNRWzhaDW+3AaVEH+Ie+RPGufr9HGpA
 Mk/N+NNUBWDjBy1lA45PpJVAbFIn68O3uEgK5fLPm8NtoWNogV56Kzw8jfMv051YtFMv/tkF
 KbvWWOjKFGAvVpVhG7Hk+dcMEWaf9QvRVPxzcK1wsozBrMBt+BmThBr3pDp5EeqERZV0C+Vm
 CjhZKbm6fNo5qoxvonrE4RFXx6VL/GqXsu20QmDifZ8RvKRDtXrqCUUtUvCEzlNGLksB+RMi
 rWGteDo0HP/vLoZV37Tn7+DHfJr4fqecfV2MMWtClVnhgqHBdHR5iUc91CCKZBmlM1X4u+lT
 VCabOqybdskZMdP9kZKaiRxEwcvNIqvV/3O/RiClvWrDgQR9SflL9n9rH/gUjx9Rx8yYpb7D
 lf5huaq6tVmt79zPR4jBcx9IppGMVTmCLoHddrwiGGiNVOWoGi+45nsqRlxzgvwKCi0IJ6vq
 9aNDB3zbw+7t6z03clU+d469AEeCHFmx/I8ZAQB8tpxkCq3F3MCMf9bC5gdF5VIiWbn4fkUv
 t0WgLcKUk0RnAiocCkQJPzmWRqDQPMDMJH1K1TFOq9ShzieXOu97HlJr0+MIEuavhP8wevhJ
 dx2FrjYIE2q2p8wLQoMzqXTvAqkr882AloX9Eq7n8Ga79Pyx1kV/CQJITehnhAr3y0AeIsn6
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:qTQRz62FUP4HD64z6LBurAqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3Ay1AcwGmHRjiMUkbsDr7g/CBYFzDXOUTb9lnuKnO?=
 =?us-ascii?q?2MDtOWoaZFAae3YQ0osU7zg=3D=3D?=
X-Talos-MUID: 9a23:rXSmKQY+gQImiuBT5z3KmCNIa8VSx6G1FXAmlJU9sNSKDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="122744749"
X-MGA-submission: =?us-ascii?q?MDEXYaae+2QyafXke+HSKfzeRtBYBy4FyKhPzG?=
 =?us-ascii?q?jo6u3Rn3S17CLGo5Tk2GdPWlxc+bP16jTAKqmnHgOgD3URDulVpGPZso?=
 =?us-ascii?q?69rwMXTecHQZeTSR2pgU/2YirQxh2NbLCmhrW8fBZnnTXgjXz+D9JjiK?=
 =?us-ascii?q?t13Q8rMKTt8Owvc9tFa7gT+A=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 15:11:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754313087; x=1754917887; i=markus.elfring@web.de;
	bh=E5+4FxpRGCz+YenKBRhbGEvX9u+lTwwcfgdMDlAAfCA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OgaGIM//jNfuF+pzVC6brtnm+sZ8jDtNP/BU4percZugyZpHALY6tFVU5wIn9V11
	 KZKCw76uqH+QkVU4t2LMr3lII3YISfI88DCuyIGypb0MDGzbOn7DQCxTxMXk8Thqr
	 jSLShxt+07yrzRNbuWHiAy/Osdh9MpLVD5kD7pSKk9AUmsVE6V0nJpCScB3IZkEiV
	 lEPMVok54XV0rwbRbvGXVA8bNuCVO8w8qsuGwxsjfJmYkFRC+Qbz1hbtzRyywQWgH
	 HeEOwTWKOami6Kr8AhfNEMtrMNTaZI6W4dXRZZJLqGiNj9eOL131QG7yZtmOR10dU
	 oVu8r0QxriXvWZ8j7Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWzCt-1v7PpG1WCP-00OgWL; Mon, 04
 Aug 2025 15:11:27 +0200
Message-ID: <89dd6ea8-404e-4ce5-9d26-abd484fb69ff@web.de>
Date: Mon, 4 Aug 2025 15:11:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Lyude Paul <lyude@redhat.com>
References: <4e009fd868cbb48aa802ce472715b5ffd7bcabac.camel@redhat.com>
Content-Language: en-GB, de-DE
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4e009fd868cbb48aa802ce472715b5ffd7bcabac.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SVTQ9iqnDcIebswh0fNsseK3t6AlMONr86Aij2hdX02Fhdo0+MK
 1YfsYlfEShB76WltOZPlH2ngt1V/pwtylADBHIPhdUELA6F/fCeKtK0Bqo0OnyW+tzQKUEQ
 U9o5T3ETm2swEKIC2DEzxk+Q0c+LIfF8jzwO8TEntIvxFUKzYRytzBq+u1H2G83JbauTiLQ
 bhPJPoXqK6GwZcc5uwBSA==
UI-OutboundReport: notjunk:1;M01:P0:qX7MX7FNY+E=;zbGfNGn8+HysozsAdfKPmaeTO0X
 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
Subject: Re: [cocci] spatch really could use a --keep-going
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2963
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/89dd6ea8-404e-4ce5-9d26-abd484fb69ff%40web.de>

> @depends on patch@
> @@
> (
> - local_irq_disable();
> + local_interrupt_disable();
> |
> - local_irq_enable();
> + local_interrupt_enable();
> )

I suggest to refine such an SmPL transformation approach like the followin=
g.


@replacements@
@@
(
-local_irq_disable
+local_interrupt_disable
|
-local_irq_enable
+local_interrupt_enable
)();



> Which brings me to ask: could we have a --keep-going option? The idea is=
 very
> simple: don't stop performing transformations if coccinelle hits an erro=
r,
> simply either ignore and continue - or simply skip the one file that fai=
led
> and continue. =E2=80=A6

Has your fault tolerance any limits?

Regards,
Markus
