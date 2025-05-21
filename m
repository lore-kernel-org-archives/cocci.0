Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B98C3ABC9
	for <cocci@archiver.kernel.org>; Wed, 21 May 2025 12:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=L/2f576Xkm8j/AIooYX/Mdo91qAUYbO8JA6BolbqJD0=;
  b=Shh2JqertKFpaQuOA1fUonRfXWN3l7fmGmk4i5XjdWI+FJy78ZE6uxae
   112ao0r+nKe7ehRQ+c1/xwlZC6sAZV8FAqZ9J7qYTczDqnBLwmK08BLzv
   jKpVTm4btCASJLjUggcI697cN9/X+T/Qhbq8Dcmyy5a4nZAArcLU8Ico/
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@aepfle.de
X-IronPort-AV: E=Sophos;i="6.15,303,1739833200"; 
   d="scan'208";a="223173751"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 May 2025 14:14:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3411DE02E4; Wed, 21 May 2025 14:14:45 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 84D1EE0131
	for <cocci@sympa.inria.fr>; Wed, 21 May 2025 14:14:43 +0200 (CEST)
IronPort-SDR: 682dc3b2_Ps0K3ZIvdjztdZ75Gk1yEE+2qmzVGU0S6sVhoW8r8uOEUX9
 3gnH6Vc4Z708x5ih8PYacNvPR1mwv2gC7qpwPqA==
X-IPAS-Result: =?us-ascii?q?A0F8AAC0wi1ogxT/11VaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQQQBAQELAYJDgSwrNAcISY1tiFyeFoF+DwEDAQgFUQQBAQMBA4IMg?=
 =?us-ascii?q?nQCi1ECHwYBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBATkHDjuFew2CYgEzghYsDX4BAQECAUABATcBBAsLRlYGE4MCgjgDDhISB?=
 =?us-ascii?q?7IxgTSBAYIMAQEGgmjYQSJXgV4HCYFJAYFXhBWCYwGKYycbgg2BFYJ5MT6EW?=
 =?us-ascii?q?IYvgi+BFkMSK4IcnClICoEXA1ksAVUTDQoLBwWBJkMDNQwLLhUjDzwFLR2CD?=
 =?us-ascii?q?YUZgg+BXAMDFg8BgxNxHIRjhEorT4MkgX5MGUGDNkADCxgNSBEsNxQbBj5uB?=
 =?us-ascii?q?5ZrhGiCfKRqoXWCP4FmgWSfbhozgUuCJgGTWA6TCJkDpE6EaYFvBi2BXDMaC?=
 =?us-ascii?q?BwUgyJPAxkPjiEZhBrIBEQyPAIHCwEBAwmQPoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 dvZUKpdT5B6etcpSfmSe8n3fmC6PPw=
IronPort-HdrOrdr: A9a23:8oIuaKkfIZEMz/FEKxAHciTLtwXpDfId3DAbv31ZSRFFG/Fxl6
 iV7ZEmPGzP6Ar5OUtLpTnuAsW9qB/nhPpICMwqTNCftWrd11dATrsO0WKK+VSJcBEWtNQtt5
 uIG5IObuEYZmIasS+V2njaLz9t+re6GPfCv5an8547d3ASV51d
X-Talos-CUID: 9a23:1hMgvGD7tYFtSGD6E25e5WoyPJp9SSLczlyOPVegV2pwTqLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AikolDg9SRcwfLMnnKjlX1xqQf8F5wKWJVhgKq7g?=
 =?us-ascii?q?94eWeHwo3ASbC3CviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,303,1739833200"; 
   d="scan'208";a="117170852"
X-MGA-submission: =?us-ascii?q?MDHhhGMww8jkdpaR6gUKtYbUAHLfIARL8zY02h?=
 =?us-ascii?q?CIayBKmhHITiK+u7915JA9LTlAqlcdaceI1qdHgvR/zDq5mdVZbm0mAe?=
 =?us-ascii?q?VinqNYjaoJ4oumiJGVG5iqOUlCobRyTSQI1s+5FI1Fq8dT92QjQD2Zxc?=
 =?us-ascii?q?gKANvjc3sUMR5cROGpnQyn0A=3D=3D?=
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:14:42 +0200
ARC-Seal: i=1; a=rsa-sha256; t=1747829680; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qnoWIkL4n3Mb0FJykEy/QQsKuHl7ZLmrBaDAeE3GXWnr2T423EczlNZwoUDexBJfmE
    qK35zk3VhA/X+MX2gEgIzPLHvRNv/dJDWQHYyV2RYgx1J8fvoMG4cdWYs2VVD/tiIPV2
    C788hNW/wp4NtoroGWCqmHlhPxz/t3P2NDwLLievCu3ZxRMjVUb+XCHK6no6UN0TCK3H
    j6MDvqkApR61pJ4mpxKUvY83BqzzZVZLvnrb2ITu+G2rRxgkyrb2mR8Ppv/HJatIsUuj
    otEyB58vYozH6PiK9OvX90w+LA9qrMR/80vgZE3rVd7gI0POCXqeAiBi5G7gA1caF+rA
    Sk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1747829680;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=L/2f576Xkm8j/AIooYX/Mdo91qAUYbO8JA6BolbqJD0=;
    b=Dc9ZKyvzEV0RY+Tk+1+El4zZib2HBB3NlAIGATBOyMmC1iLduqUpMcXHL6QXgJ5lhr
    Qgaf68K8JrVbifnEG1aubOYEoMp9wU67AYN0brokMS026tWuopr9BLfyitpfWsA4pLB0
    wME9f7I2XkdQOwyIDYRm9aylXP8LpWTprTfW7O1N9tdtNrDmZEnllCn11/3KhBpfSlV4
    DOT8c04ab7+Vx5BaEIdVAtAthRPry6qcN5yCFXxfk4OwKtrVwGw0j79USeQ+mXLo4ZB6
    tsxrdgITfqYlKkT6yTWYJMKE5KFZqHw3iAFMav1hBQ/ki5IkcKD60i3EJKkOib2nqtdw
    Y7HQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1747829680;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=L/2f576Xkm8j/AIooYX/Mdo91qAUYbO8JA6BolbqJD0=;
    b=hLKNWWlXw7IClNIqAFa3RunKregl+ZZH2MvuUoRJunEOnQpyvZTRMuPEwdoPU0Gztq
    i5QgJQeHHJvcO1hawNKwIdAJck7oX9nWHcbQf3KMISaGVCGSDRXePjMK9/b5C72djdrk
    IhsgA/tK5SRFAY2RRrsbpGoTRwtXACYBwyMj3OWyH0Us9TD5+xJYCHITv2kdpuOUIGLt
    n++kBd+q1fNqka1BIEkju6FYPg7WTJVsH3CpdA7ogVyTpJQDNYYr44Z1CPfKey/C7d2h
    LQQMCfm7YGzf6vSvy17lr74PGS3y7dIV6D+B/vnVLNUDPvJ0uTKOSdcPFjLw9Z1THkwf
    iRCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1747829680;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=L/2f576Xkm8j/AIooYX/Mdo91qAUYbO8JA6BolbqJD0=;
    b=YPOj4OsWwsfC+YLKyAKhzOYkcin9jrAdDkXpnqwTL3HrEK8JMmiFBwVzZkgoRP1xOS
    BD5GtblF4ETYQi1PtRAg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OmD4uXd0fmxSoJ8/RK6b07KGriu4yBf+6JptMSdiuOzXC/d"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd14LCEe5OB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 21 May 2025 14:14:40 +0200 (CEST)
Date: Wed, 21 May 2025 14:14:33 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
Message-ID: <20250521141433.7dcf9ab6.olaf@aepfle.de>
In-Reply-To: <e552401f-1dfc-4273-9fc1-cecb2c1ba635@web.de>
References: <55052f14-dbe4-467c-a7a4-41ce5fc1cc99@web.de>
	<6007e0f7-3d15-4490-a000-b10797c9d579@inria.fr>
	<fdc8e894-1d4c-4d55-bb5d-12cd0fbceac1@web.de>
	<e552401f-1dfc-4273-9fc1-cecb2c1ba635@web.de>
X-Mailer: Claws Mail (olh) 20250514T101025.84a10d9e hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/h06z2e8ygUKE2Wig+F.PK5x";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Reconsider software dependencies for PCRE support (with
 SmPL)
Reply-To: Olaf Hering <olaf@aepfle.de>
X-Loop: cocci@inria.fr
X-Sequence: 2744
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-05/20250521141433.7dcf9ab6.olaf%40aepfle.de>

--Sig_/h06z2e8ygUKE2Wig+F.PK5x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Wed, 21 May 2025 13:56:52 +0200 Markus Elfring <Markus.Elfring@web.de>:

> Error: /usr/lib64/ocaml/pcre2/pcre2.cmi
>        is not a compiled interface for this version of OCaml.
> It seems to be for an older version of OCaml.

Run either 'zypper dup' first, or make sure OCaml from /usr is used.


Olaf

--Sig_/h06z2e8ygUKE2Wig+F.PK5x
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmgtw6kACgkQ86SN7mm1
DoDDYA//VD6JoEXpp97PuvZEkP8Fae8qhHl4tEziVkymfjxr22xiKyOx+zZfTC3h
ANTisJxGosDBQZJCVi4ZCcPDIH9nMaVUMoFgpJ7jObToxiXipPbWbCth8LV0kNLM
+m0eKWLFO2zPmrhuYEmmi3SdMwLUVsWAlJB9k4X2Emv7xmN97+UvN4v/Ec1rBOyo
ckgwSIBE2tHBcqvF4F6sO0BD8eJGbr6rt4SX5zc/PjlERao6Ofv0WFRSY46jh18t
0xy0Fp1ySBUDcZgM/Yh8J+S617ITD0X1eJ0qDlzH477kTW9BjTMOhYKxYejEvvJ3
TWg4XNZB1qa2PxXQ/phZee+dJgLCdvqEOLGUKwM274XYmGlkY1h8d16P3FP7cuFf
Wia7nB7u3KttJvCoTMNSCN7GeLUlcJ+cnwtVDsoPxwARxEHqKz/qk5rvqGaQQ7sA
LzmH+lDlBZrjm3d/IXTTch3gsIylk6cQguBUW4YX2ZeL6kcCWZC5szP2Oz2+yiQB
jAID/7lVo1RciFfzXu/EB6yOT99Phr2IpRNQMagZJvf43bjyyiC7S2Eo9L0IdMJH
XT0V0aKBA/oSf7sGc5dPfJnrnoSLh9599yMuxcja3YxpDpXjQjp/Z6X5Y0k7Adpp
sZYmkO+H18DhThtzal8tXORKVgy6aVqOT2YnvKJavznhWxpCcjc=
=h3z9
-----END PGP SIGNATURE-----

--Sig_/h06z2e8ygUKE2Wig+F.PK5x--
