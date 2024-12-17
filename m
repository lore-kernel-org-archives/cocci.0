Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B2EE7717F
	for <cocci@archiver.kernel.org>; Tue, 17 Dec 2024 19:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=b09uUSkTv4jImDNxdCAKoImGqzrouuyT+O5jNX5yyWc=;
  b=YjAFEnEF2To7GVNbw7BXkx+m6BWtWrkwflRaL9zHBFHteB5SdLL66Enr
   nnASbk9Pq3CsZwHeX81eDQqrHYrj/BycmtedMnmjExK0d7H74b9kFLaH4
   FlWREV1YANplcZJN/yALy/vZdF7qcymk3D2Yqygx1UTCGKyseb+uyjKBB
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.12,242,1728943200"; 
   d="asc'?scan'208";a="199721753"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Dec 2024 20:18:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 75CABE007A; Tue, 17 Dec 2024 20:18:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 24D18E0077
	for <cocci@sympa.inria.fr>; Tue, 17 Dec 2024 20:18:50 +0100 (CET)
IronPort-SDR: 6761ce99_fNXJiXyGzlFN19HPBUJ4J4Id/IA6qWE+6/ug/jL8p1jCvxb
 395DwiHO50d7ya81QEFbO4sVj2/wRatF4ju1ljA==
X-IPAS-Result: =?us-ascii?q?A0E2HwAEzmFnhY4kQ7laHQEBPAEFBQECAQkBFYFTAoJCf?=
 =?us-ascii?q?VozBAtIiCWFLYZRgV8lHRSDFIJVjHGLLRSBaggHAQMBCAUUAgECDg4NAgQBA?=
 =?us-ascii?q?QMBA4IMjWMCHgwFLQcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQEBQEmFQQgyDYJbO3GBJQEBAQEBAQEBAQEBAQEBAQEBAQEXAg00d0d8e?=
 =?us-ascii?q?4JlAYJkBwGyYYEBM4EBgxzbF4FdCgaBSAGBV4QTglgLAYFaiS8bgUlEhH2BB?=
 =?us-ascii?q?QGBWwKBJoEHhXcEgjqGYIdEgi15hBCFGolrgWkDWTIBSwo1DDmBOgOEdYNNg?=
 =?us-ascii?q?TIQAwMDAwMDGAINAoJDch+GJoE/hGGDQYEWgWuEL4IXghaBCB1AA3g9NxQbB?=
 =?us-ascii?q?pkxCByBDYJzR4RqJg4CVAMBR0YGGDo9kyiyYoQkgWMMgwCHKZYOg3GTTZMAk?=
 =?us-ascii?q?maGFYJXiEqBd2qbKIFuBS6BXDMaLkWCZ08DGQ+LGIMgAoNhM4RhuSBDNTwCB?=
 =?us-ascii?q?wsBAQMJhWkTiWaBSwEB?=
IronPort-PHdr: A9a23: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
 Bg7llklCQzM3DLr/ktvfBzSozAsnU53ldi32Vis
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:wcA5yK3QOZ5BxkM4nKHt7gqjBL8kLtp133Aq2lEZdPVwSL38qy
 nOpoV46faaslsssR0b9exoW5PwIk/00ZZ05M0/O7KmWhf7oS+UKuhZjbcKoQeAJ8SWzIc0vs
 1dmsNFZuEYY2IUsfrH
X-Talos-CUID: 9a23:434zNm6PTQVs26odntss7UUOHcsBdmPhzG6NHmnmJU92d56LcArF
X-Talos-MUID: =?us-ascii?q?9a23=3AA6K2oQ8INROqiXfynBzjYPqQf9xF7YCjMkUjqJk?=
 =?us-ascii?q?b5vevdgpTNXTGsSviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,242,1728943200"; 
   d="asc'?scan'208";a="199721748"
X-MGA-submission: =?us-ascii?q?MDGyaYkd1MNvsFFcF5C65jczK0QkOTtM+UQ4xa?=
 =?us-ascii?q?TRwIfFDptVR255a/G91N/8lY7R/8PeqRuN2fQBjZ7Tqy4sKC4qf6lJIV?=
 =?us-ascii?q?QvxO1AjUmYe4YsruK0CAbawFvWd5w5orQQ5KZff4iDwQLvbk3tvsK6E9?=
 =?us-ascii?q?Q58wiLCDiRuQz95tpBcZf/OQ=3D=3D?=
Received: from mout02.posteo.de ([185.67.36.142])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 20:18:48 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 75C60240106
	for <cocci@inria.fr>; Tue, 17 Dec 2024 20:18:47 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YCRS2689jz6twf;
	Tue, 17 Dec 2024 20:18:42 +0100 (CET)
Date: Tue, 17 Dec 2024 19:18:42 +0000
From: Michele Martone <michelemartone@users.sourceforge.net>
To: cocci@inria.fr
Message-ID: <Z2HOksmLuhWXEsZt@localhost>
Mail-Followup-To: cocci@inria.fr
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hPBt9v5SRKAa1coz"
Content-Disposition: inline
Subject: [cocci] Training: Semantic Patching of C and C++ Code with
 Coccinelle
Reply-To: Michele Martone <michelemartone@users.sourceforge.net>
X-Loop: cocci@inria.fr
X-Sequence: 2183
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-12/Z2HOksmLuhWXEsZt%40localhost>


--hPBt9v5SRKAa1coz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear Coccinelle Mailing List,

I am offering this Coccinelle introduction in person in Munich next month.
Perhaps of your interest.=20

___________________________________________________________________________=
_______
 What: Introduction to Semantic Patching of C and C++ Programs with Coccine=
lle,
   or
      A language to update large swathes of C/C++ code with non-trivial cha=
nges
          (with emphasis on HPC-specific restructurings).
 Why: Code maintenance and porting to new CPUs/GPUs is difficult. This can =
help.
 When:               Wednesday, January 22, 2025,   09:30 - 17:30
 Where:  Leibniz Supercomputing Centre, Garching near Munich, Germany  (ON-=
SITE)
 Who: Dr. Michele Martone    https://github.com/michelemartone
 Prerequisites: Good C/C++ knowledge; HPC experience recommended.
___________________________________________________________________________=
_______

 Registration URL:  =3D=3D=3D>  --->  https://tiny.badw.de/gsRkBW  <---  <=
=3D=3D=3D
___________________________________________________________________________=
_______

 The maintenance of a large software project can be very demanding. External
 factors like evolving third-party software library APIs, or constantly cha=
nging
 hardware platforms might require significant code adaptions for the code t=
o run
 efficiently, or to run at all. Failure in coping with this can lead to
 obsolescence, loss of performance, incompatibility, vendor lock-in, bugs.
=20
 Have you ever wondered how to detect and manipulate specified C/C++ code
 constructs, be it for code analysis, or better, to restructure an arbitrar=
ily
 large codebase according to a specified, non-trivial `pattern', without wr=
iting
 a source-to-source translator yourself, but using an existing programmable=
 one?
=20
 In this training we introduce you to a tool to do exactly this: match and
 restructure code in a programmatic, formal way.
=20
 After this training, you shall be able to write your own code transformati=
ons,
 be it for a refactoring, performance improvement, paving the way to an
 experimental fork, or for debug/analysis reasons.
=20
 The training will also show how to analyse code looking for interesting
 patterns (e.g. bugs), integrate your Python scripts to achieve the custom
 transformations you need, and leverage Coccinelle's increasing C++ support.
 =20
 Special mention will go to performance-oriented transformations, of intere=
st of
 HPC practitioners.
___________________________________________________________________________=
_______
--=20
Dr. Michele Martone                                   https://michelemarton=
e.org
Leibniz Supercomputing Centre (LRZ)            High Performance Systems Div=
ision
Boltzmannstrasse 1           D-85748 Garching bei Muenchen               Ge=
rmany
      ()     ASCII ribbon campaign   - against HTML e-mail
      /\                             - against proprietary attachments

--hPBt9v5SRKAa1coz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQdu1Va6jWbiq8Ma4jg5mnI7xJYuAUCZ2HOkgAKCRDg5mnI7xJY
uJzUAJ4/k3Tk5i7iJfuzqVs5SasMIvHXkACeMgp4wOgMY8ftNAQWSFYL18TA0xc=
=av7G
-----END PGP SIGNATURE-----

--hPBt9v5SRKAa1coz--
