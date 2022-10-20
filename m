Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0243EC433FE
	for <cocci@archiver.kernel.org>; Thu, 20 Oct 2022 18:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:date:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=TR99Y3l490fzgH+Xw5eHFZQAFsKH9bdF1dcdi8qQQok=;
  b=qMLhQX+F7eRou+zMNd0V1p5b79wEdjc0/EhhQCjfegDIDisShkL3vlDK
   n6rI6wqAlUKOCiZGYDtC84ceD+jgR5Ve06AijTo5y6KoWjfQNGCjtAY3d
   n65BXDlp4TgYwU7YsOqtZLTEEFxorZ3KTDesoCpFkDmCvNy2XQPYMh4an
   4=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.95,199,1661810400"; 
   d="scan'208";a="66249096"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Oct 2022 20:40:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BD9A9E0130; Thu, 20 Oct 2022 20:40:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 459FBE004E
	for <cocci@sympa.inria.fr>; Thu, 20 Oct 2022 20:40:52 +0200 (CEST)
IronPort-SDR: 63519625_BXUchHKOLBKxmgsiKrDGQde5ioOk5Bomfnkic+OD+a2YiSg
 6KyeHrC4rsxFFjA2p37UUs/5PA1TsPovAgKazXg==
X-IPAS-Result: =?us-ascii?q?A0A6BQBxlVFjhk7ASNlaHgE8DAILFYFPgi2BAVYuBAtFh?=
 =?us-ascii?q?E6OcoF/n0APAQMBDT0EAQIEAQGCEodnAh0HAQQzBg4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIEBAETAQEBFwkZBw4QBSKFaA2CNSKEFR0BAREnFAQcA?=
 =?us-ascii?q?iYCgQOCbAGCbAEDMAcMkTGcF4EygQGCCAEBBoFAARVBgjcfLCJTgV0DBoERL?=
 =?us-ascii?q?YcTDwxViH0QgVVEgUiCR4NQAQECgiuDCoJmjx2GGzgDRB1AA3kNWhwxJw4JI?=
 =?us-ascii?q?BwlDQUGEgMgbwVCDygvaSscGweBDCooFQMEBAMCBhMDIgINKTEUBCkTDy0HI?=
 =?us-ascii?q?3EJAgMiagMDBCgsAwlAByUkPAdYOgUDAhAiPAYDCQMCIoFLMSYFAw0XJQgFN?=
 =?us-ascii?q?xoECDwCBQZTEgIKEQMSDy1HDko+ORYGJ3kPDhYDPpZhgnlZgVpXjSGFW68gN?=
 =?us-ascii?q?AeCHYFIBYFFDIhKgSKNd4cZMwOWYgaSE5cajUGUdYU+gXgkgVszGiSDNk4DG?=
 =?us-ascii?q?Q+OOYNZM4ELiSI/NAIJMAIGAQoBAQMJhUcBAYQwXgEB?=
IronPort-PHdr: A9a23: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
 nO6kw==
IronPort-Data: A9a23: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
 Pwhoofv5eURkAmoqSnB3ek=
IronPort-HdrOrdr: A9a23:+Vzvh6zMXbfdY50Z9QdmKrPw9b1zdoMgy1knxilNoHtuA6ulfq
 GV7ZcmPHrP4wr5N0tQ++xoVJPvfZr8z+8R3WBzB9uftWvd11dARbsKhebfK/iKIVybygc378
 ddmsZFaeHYMXg/q9rm6w+lFNsazMCA673Av5ak854Xd3ANV0l6hT0Jczpz/3cGPDWvjvcCfq
 ah2g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,199,1661810400"; 
   d="scan'208";a="32012544"
X-MGA-submission: =?us-ascii?q?MDEWslLBuY/mORzKSr/691l/qLaTPYvtcPgwYK?=
 =?us-ascii?q?/F6/H9eqc5+5SYfxLArTHithxVTE2WkwNjJVL7tMPziu9z/R9Cdff/uo?=
 =?us-ascii?q?3to1/CihUnjTn3E+ERtFw1AyNLUH4zQrMgL1aO3AtIXPu9in7KY7sYqr?=
 =?us-ascii?q?TIMJHZsoJHOygnPqID73F8VA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 20:40:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1666291236; bh=TR99Y3l490fzgH+Xw5eHFZQAFsKH9bdF1dcdi8qQQok=;
	h=X-UI-Sender-Class:From:To:Subject:Date;
	b=XINMyArU2ls7Ufg1pmrw7xASvYvBvZ/Q+onUMFENup67tF1UfhOX125b8MmfFgQqY
	 0rgwb4ediEh6LQp70Bvqlj0EsQMwx6omhs+M2WjvTmuAleJ/jofZGEd0gFjHVPSZKy
	 jkRbGL+zs7nWacBMXjOl3FOHFH9iXnUhoHxmFkEP0JNXmfXTaKu2X+6PkTuyViemLm
	 pAAUPCQKJfeAox3YSruZW5OboWgB0Ezt4aU7+GzlqQ0EkjdzTmOVOyS191eBchI/Lr
	 9tzihCMNGiZTexMKIiuUfTipk83m1MoivxMXbgYn1Lm4pSdmemyU7LblI7cc9s3Iey
	 QmuHDJo2VBTSw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.89.160] ([94.31.89.160]) by web-mail.web.de
 (3c-app-webde-bap34.server.lan [172.19.172.34]) (via HTTP); Thu, 20 Oct
 2022 20:40:36 +0200
MIME-Version: 1.0
Message-ID: <trinity-8d68c62b-e946-4ce2-b370-6555d910f65d-1666291236270@3c-app-webde-bap34>
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Oct 2022 20:40:36 +0200
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
X-Provags-ID: V03:K1:yb8qoBj89+DLvqj0fsxncJabFSbKCsmWaFjvVxCfP0GwUFgA3zmDdwRQFBMJ/o0zEp/4Q
 zdNVxj2boLqGhBbD/nrifaGgrfriKOPp+8EYoB3xhICeCWVm+8XLz1hZnPC3Y15Fi3RNV7zqnrIL
 yw1oNY7tkprqTkIDPSxqAobQzrjDBtgJFCchBtbeHk2JYgGEhx6XbkMTQ38jg/dlceaVwpaVhggu
 6aoVwVgPPKs4+z46Abt/8E+Kz9AJmjraTKKxqVlT3TuJL42ModpGi+AD6iYcueZ0VX/myrBYyAyd
 Hk=
UI-OutboundReport: notjunk:1;M01:P0:bIdTlgC0e/I=;4fu7UdkGsu1Sxp1/zB4HgKxrP32
 kKJ8B3lMWMeK4Mc719dzvUZidPOn4TQsHFj9LKOQ4FHNFT48iqyxOIbQfjTFu56HRV+Jf2Bf3
 BmVQoL1pZJqQ9Rw2syC40xsh6R58KzdwIJCH0UGfiLVFA1df28me4qTQ8MeyAvnUyUgr6hiMF
 zW4pNpZQA/gp0cm261S0RGvU+DEDoaSLsuHd9v0lvgtqgWhrcKNzQv9dpWhRXterYv/oFInTi
 lxKOisEihSjkUBFXyrYj10q8bf2cftaDA+K0uIRnRT3tMxE7eeAS83arK+vqFYWTxdadTjr2h
 P23FM9W4dMdqHmkRA4+vt23XhGcwzE7swZ5chKEbrl1/vGgkDiD5nPxrMzLD7V9swgtmFivGI
 AeEhix8m6XRx8zv2E/sfxW9D9/INNYjhFj6sDjQYAvAJrS/0ywbOKdm9f24g1gzjozPawzXQ3
 mcAGNPdQNMt82XGASkeLQ10dZEPJcI6JdDwCWNjy7dNQe6A3D1CoR7GmbeoawN+nAeJBP79Jd
 y1maQ9XoH2PgnpQnN+Eo0wwVbSVrK7ix/gRBpb3BPSW0+SYhqzzlV1HWn9jxAekdm8eHn14h8
 UYokhKEBJiJw2/RJkeGhQ3flo58vvSOre15x/k2MOPVFeTHtiJIEgnFiqwyvE3DFW+6cOd532
 nOV2YDZIgIC4fxUk+3gXvAuLjP+TZ3VlTi0MX4VqxOlij29TAd3/bDyomheL5LXF9NKcrEE+8
 cLK2Dt78MayWpw0ElC7CdS7iTd6rD+pYgua1gJJW3j+5jELVqy2J/FsA7+f5oUG5NWOij1wp6
 slV1FuYAolgmTvco+gMJUdacdwDpZacLVIHjMPRewIT/8=
Subject: [cocci] Handling of SmPL code exclusion specifications
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 659
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/trinity-8d68c62b-e946-4ce2-b370-6555d910f65d-1666291236270%403c-app-webde-bap34>

Hello,

It was tried to clarify selected functionality from the Coccinelle softwar=
e
several times through the years=2E
Unfortunately, it seems that especially the corresponding documentation
gets a questionable amount of system resources and development attention=
=2E
I hope that this sitation can be adjusted a bit by another clarification a=
ttempt=2E


I guess that the wording =E2=80=9Ccode exclusion specifications=E2=80=9D (=
according to
the semantic patch language) can be also helpful for some use cases=2E

https://gitlab=2Einria=2Efr/coccinelle/coccinelle/-/blob/86486f01bb7e1c2af=
326bba302c45cd54719445c/docs/manual/cocci_syntax=2Etex#L1021
https://github=2Ecom/coccinelle/coccinelle/blob/0406b12024e9943e26f255b0ff=
fd1088ca0fdf27/docs/manual/cocci_syntax=2Etex#L1021
=E2=80=9C=E2=80=A6
Dots may be modified with a {\tt when} clause, indicating a pattern
that should not occur anywhere within the matched sequence=2E
=E2=80=A6=E2=80=9D

https://gitlab=2Einria=2Efr/coccinelle/coccinelle/-/blob/86486f01bb7e1c2af=
326bba302c45cd54719445c/docs/manual/cocci_syntax=2Etex#L1134
https://github=2Ecom/coccinelle/coccinelle/blob/0406b12024e9943e26f255b0ff=
fd1088ca0fdf27/docs/manual/cocci_syntax=2Etex#L1134
grammar representation

This functionality has got special algorithmic properties=2E
Following source code (subsequent context information) needs to be checked
for the decision if something should be actually excluded (or not)=2E
Such checking is usually repeated many times=2E
Thus code reviewers and software developers can occasionally become concer=
ned
about corresponding run time characteristics=2E

Can the technology =E2=80=9Ccomputation tree logic=E2=80=9D provide intere=
sting hints
for this aspect?

Regards,
Markus
