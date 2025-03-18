Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E112C28B28
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 10:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=tyxCaFlaN3fSs5C+DPPpwmdrYRD1MxeUXI+3WKK63qM=;
  b=tTqUDV3W8eSSko5sMqjByRr/fyDoeP67gGCsGNQ1WFC1lq1EOL9cCkcy
   4p63lPJOhkGLmcFb+lMgED3nCGlZ/XSXColZW9TmqPiRNaBrQT0tvXR6y
   63LcR8hJaCV9JQw8DgHswsconOoXmm+rnxpmVi9FfjLEzvgk+NNmLpcIq
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@aepfle.de
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213440064"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 11:13:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 01A8FE0D1E; Tue, 18 Mar 2025 11:13:19 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0A5E9E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 11:13:15 +0100 (CET)
IronPort-SDR: 67d9473b_fRPfeFQJ9FfFWNMaAQsZdCpRdJHTdQclGFYGefrEI6Ak0G5
 J5j06DiCLbRXshN922ABLr6aJz5JWBpQk4CdQAA==
X-IPAS-Result: =?us-ascii?q?A0H7DAD5Rtlnjxj/11VagQmBU4JEfS4rNAcISIglhUqmb?=
 =?us-ascii?q?4F+DwEDAQgFMRMEAQEDAQOFAIshAh8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBE?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECEAEBAQEBATkFDjuFew2CWzuCFiwNN4ENAQE4hFEBg?=
 =?us-ascii?q?lMRB61VgTSBAYIMAQEGgQiBYNk4gV4HCYFIgViEFYJjAYpjJxuCDYlVOIV3g?=
 =?us-ascii?q?jOFKqoXSIEhA1ksAVUTDQoLBwWBbAM1DAsuFYFFe4JEaUk6Ag0CNYIbfIIoh?=
 =?us-ascii?q?E6EPoRBhVCCEYIFiS2EZC1QgU0dQAMLGA1IESw3FBsGPm4Hohg7h3sHoyKBf?=
 =?us-ascii?q?KFxgj+BZoFjijWVMBozgUuCJYFqkWwOkwOIKZBVpEuEaIFnOoFcMxoIHBSDI?=
 =?us-ascii?q?glGAxkPjjqBUoJCtxdFMjwCBwsBAQMJkByBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:hImo963ZN8+CNukhSHgrvAqjBGskLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN93YgBapTngAtj5fZq4z/Ea3WB/B8bAYOCLghrLEGgA1/qa/9SDIVyYygc178
 4JE5SWY+eAaWSS4/yKhTVQa+xQpuWvweSStsmb50tRbGhRCp1I3kNDOSjeOGhffjMDJbdRLv
 ah2vY=
X-Talos-CUID: =?us-ascii?q?9a23=3AxhSntWizhVw7eJSiUT8hCjwxdzJualbv6lfhMVW?=
 =?us-ascii?q?CMzw1Fbytcw+Bo6F/nJ87?=
X-Talos-MUID: 9a23:l5JWBQrz1WEDyQO90E0ezwB6GupRyaCrMUcUtsQkvdSddjJVOA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213440050"
X-MGA-submission: =?us-ascii?q?MDGVHItqHrZdQi8hdjKZ6l6RbVI+Fu/9HWFaC3?=
 =?us-ascii?q?uEb5dVFkgolpv8viuXu+XJ/kJwTX2ACZ5f02xbT669zOWEcuiWYcjKET?=
 =?us-ascii?q?qSpgNzsgMsNBF63+cCVMPFn28M5k2gMoCkHFoDPLthzjwj/VZ8nvin+/?=
 =?us-ascii?q?/uck/oORpZATG4EOg1lEseGA=3D=3D?=
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 11:13:14 +0100
ARC-Seal: i=1; a=rsa-sha256; t=1742292793; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jxgT5CHvJslQvBh9bSIqHmur3EwCX90siGLHig7SrcPPrgWEsAkqdWywiqGITKWhq1
    zxNhXORNIBNTAnyVHmcY/MFMQG/DoA0TkHNFG0LmD6t03+QDdDKBO0hhcgbtLlt+B0DQ
    xIxu6FFhxatADJdkt3DPeGSKWGqhQxbbY37vHncgs7nofjh8Ou9c78klnGEcxQu1wAUi
    E7t0Jb5HTKQWg+3IHtijF6YecBKb2BUDxuDn4Rzw04kEYzsm44xcuSKDp39P8jruISIl
    UFYeO5aYSeNQcE45UxQVaibR9RTBZ2dyeKQmd/AowDEtQouKWprTfINn5fAvy/ORbUJc
    e5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742292793;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=tyxCaFlaN3fSs5C+DPPpwmdrYRD1MxeUXI+3WKK63qM=;
    b=HZxBdDtKCKPi9By3R2YgaeC7hjsuDYb3G7230wNh6xtzeyQWI3BZ5COc+0oIi1KkwF
    H2JNp0RTY4F8kLKlK5ewxgaPSoAfyu+kWhfF3lnP+WHGeZpISCEEYf9W1ZvxYVP1yPhF
    FDJ0uxuVCAAOodHOkq5fEvy/105r5SGWMYS1tSh8xB/tjeE6f8CaNDAaA4TjTKAtQuDu
    cW+KBhu/P3zA6EM657nRkfCcVuDd0KfNst4Y5BVWar35iylwjHsMIVZXbAcveHUrSb00
    ZJo1jyiuze1R/ZkYTIoBAUUWN4m9qGIdPlI1yMygJ7HyZZuiLUEyE7fOM0ZhPD+fiBHY
    UWBw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742292793;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=tyxCaFlaN3fSs5C+DPPpwmdrYRD1MxeUXI+3WKK63qM=;
    b=X9nkTWs4PWCK64n7sdNy7Ks54L54liQbGNzjF9D2OjdgrKZ5nlf1QJv5IiYO3EfTDV
    Y12j4us4M4n7Nw8dVuhq1bf7MSJ/RuuBL+Vtugz3TRzsf0YkiV4C6LI1LRl482FwTbkA
    zOipF4VRqVGJeA4YTdyUCA1CCxMz2KbOm2ScbiGGmcevWW+OLgFnVob3R7V2S22STdEx
    dgbmKjvaBmimXptnhaxxv+MjodGCrJC6f5RI2n5aGyW7CnVPGtRzz1oo5CyzJuRQpt0d
    /4zOXYUw20P3SezTm84zLLdsdFjGte8kgzg1kS7ufamK8npXFsvfsXUg0peLuxwavdw/
    7+CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742292793;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=tyxCaFlaN3fSs5C+DPPpwmdrYRD1MxeUXI+3WKK63qM=;
    b=JiPAraqc4Ug9Idd0jZprIBK93w+X2t6lAn746sHJWMYoj5iPAK5nlxRet7359rS865
    GEvfs2jMZO9/54ZKYYDQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OmD4uXd0fmxSoJ8/RK6b07KGriu4yBf+6JptMSdiuOzXC/d"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd12IADD0cx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <cocci@inria.fr>;
    Tue, 18 Mar 2025 11:13:13 +0100 (CET)
Date: Tue, 18 Mar 2025 11:13:05 +0100
From: Olaf Hering <olaf@aepfle.de>
To: cocci@inria.fr
Message-ID: <20250318111305.281abcca.olaf@aepfle.de>
X-Mailer: Claws Mail (olh) 20240408T134401.7adfa8f7 hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yrrr1gmUHJcCJ9Qa.xf1kd_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Subject: [cocci] the future of bundles in coccinelle.git
Reply-To: Olaf Hering <olaf@aepfle.de>
X-Loop: cocci@inria.fr
X-Sequence: 2609
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250318111305.281abcca.olaf%40aepfle.de>

--Sig_/yrrr1gmUHJcCJ9Qa.xf1kd_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

While looking for the proper way to import pcre2, I realized that the
way configure.ac looks for required OCaml libraries is ... weird.
There is no way to force the usage of the variants in bundles/, the
version provided by ocamlfind is always preferred.

I think since a while the required build environment is easy to create
with either 'opam install $ALL_BUNDLES', or 'zypper install $packages'.

Hence I suggest to remove bundles/ and all code referring to it.


Olaf

--Sig_/yrrr1gmUHJcCJ9Qa.xf1kd_
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmfZRzEACgkQ86SN7mm1
DoAcNg/9FfxbTvlE4f1vheOA45AOk3daQ+WZAx8XY0pcsxApeLPQHNFG18TxtpiD
/z7be3jdUhAwtJxujHtO8HkrS0jJxwABS75JPHn27f82+glM01DgDtVmwgsmMBkE
tke/JdC59osS09EcofdHwoaWJKD7+9L7JD/u0nRCzIVCBGdsVB06/vR7oPGbKl2P
laUFI5kZ5IJhbz7dbrDHi7f6YzphsoeblVf/am2Ftx/tui3SoE0IYJ75aLczIME3
KzhQ1IraCwvSfAYrpFcBXABHobwL3nv7qDRS11U2JUp933iVxKZCWXeZL6JGqB+D
Z+xwjBt8te3kdxAX9OEgnOqT8/ZnqiGT2enkfkChgHQ5kSw+vn04Tag5tQxPSvoa
4F7z6381PQ61wERN2frkau54R2zJS2Ru449wjIBzNI/J1MgwNnZ8woUFEnfVAVBn
H7e/qrv23sZUlgyH2OpyQwbzTIoq3gcbuA8EmyJV/wslzsgeIzq5bNKRjyPOYUKT
p6gX9eqcVsDAPqUQZYGUyeuMntdFtx+bMfN6gHjHxbgwmxgj8hS70K8rOcH6Qr2K
C8v0c3WRFKLre8q/7wPi4jCxDZOMV5Qaxg7YiJ3x+nkC2SkZJxnss+B/6pdjYxe1
l+kwWGaBCxJ05ZSlj5JtqOZW78AwLEcEhDrziaG1h4simysv4vs=
=cs/8
-----END PGP SIGNATURE-----

--Sig_/yrrr1gmUHJcCJ9Qa.xf1kd_--
