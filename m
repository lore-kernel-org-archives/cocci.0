Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9A4C35FF3
	for <cocci@archiver.kernel.org>; Mon, 17 Mar 2025 17:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KvXfmcEOvnWakEiIBPk+PsROaIr4w1mGNnHAR3JyEd0=;
  b=tItTEvINWE2vpt0fKW4wvwYajaY1W4w53DdX/gyeCRU/TACPfpBcG4ak
   Dxg/hbJhjgYA3jDkaWbuDAQHGb86Nt/OECiQ7tzXVr0RY9pbxK3/vfmqy
   mp/JnOQKmJLpCNAuGV22hk1Omd5CIsxEGEriHT4U0opSAU6nyxzo9rFZp
   c=;
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
X-IronPort-AV: E=Sophos;i="6.14,254,1736809200"; 
   d="scan'208";a="213337130"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2025 18:45:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7C41FE0261; Mon, 17 Mar 2025 18:45:12 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1266DE0260
	for <cocci@sympa.inria.fr>; Mon, 17 Mar 2025 18:45:10 +0100 (CET)
IronPort-SDR: 67d85fa5_N7R4ifBIIEn8tGFNQLZiUQFOrXRbxF11Aoo1jtkhTt/qfIs
 YWIRZ0teuTEuUM+wvjhBv5ON8EAsBasNiBu+cvg==
X-IPAS-Result: =?us-ascii?q?A0FJAAByXthnjaOSqVFaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDgSsrNAcISIxzfIhbnhSBfg8BAwEIBUQEAQEDAQOCD?=
 =?us-ascii?q?IJ0AosfAh8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBAQEBATkFDgkyhXsNgmIBM4IWLA1+AQEBAgFAAQE3AQQLC0ZWBhODAoIxA?=
 =?us-ascii?q?w4SEQetSIE0gQGCDAEBBoJo2D8iV4FeBwmBSAGBV4QVgmMBhWsBhHcnG4INh?=
 =?us-ascii?q?D8+hFiGL4IzhSepf0gKgRcDWSwBVRMNCgsHBYEpQwM1DAsuFSOBIgU0Cjc4g?=
 =?us-ascii?q?gtpSToCDQI1ght8giiCF4I2hDyEP4VQghGBXQMDIgGDH3UchD49hGEtUIEvH?=
 =?us-ascii?q?UADCxgNSBEsNxQbBj5uB6IFOoVSgimlJKAzgT6CP4FmgWOfZRozgUuCJQGTV?=
 =?us-ascii?q?Q6TA5h+pEuEaIFnOoFcMxoIHBSDIk8DGQ+OIRmEFLxbRTI8AgcLAQEDCZAcg?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
 gMGxb6+IYlBbuXG
IronPort-Data: A9a23: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
 Qo=
IronPort-HdrOrdr: A9a23:UQaEGqgokJKY/8eFlSsKFTft0nBQXhEji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJjvo6HlBEDmewKhyXcV2/htAV7GZmaJhILGFvAA0WKP+UyDJ8S6zJ8l6U
 4CSdkFNDSTNykdsS+S2mDRc+rIguP3iJxA7t2uqEuFIzsaDp2Ilz0JcTqzIwlMdycDLaYFNf
 Onh/Zvln6aSlpSROGSPENAf8WrnbH2qK4=
X-Talos-CUID: 9a23:q6Mry2OGkr9r9+5DAwU81XRKC+UeLXCF0nbsIUqUK1c0R+jA
X-Talos-MUID: 9a23:DuocnwjbrvSo+uMY/vcUMsMpM9pZzJufERE3r5wYn9LHLgBvOC+2k2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,254,1736809200"; 
   d="scan'208";a="111817783"
X-MGA-submission: =?us-ascii?q?MDFmScPc2I0GG3eBUknMM01G8ZggBfEB+C3DMb?=
 =?us-ascii?q?/g31kJa+Uy4xZZCsh3O6g4CjSpp11473XLxm4mFnVseCgWp1E8OZhmNQ?=
 =?us-ascii?q?fvkLFZv+2PNGhjusSTz7FowUkIDnIK4SamsGfN7dOBfsMkRyxTM3a5r3?=
 =?us-ascii?q?2X4cCq3IFYXYOq1oGajjR8zw=3D=3D?=
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 18:45:08 +0100
ARC-Seal: i=1; a=rsa-sha256; t=1742233507; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AuBGzR6T+Gv0XpGfCh5MsmAItYm+FMoYkFq7z5TD8YVM9Ucu5KY4MNUEri9uZmPtUd
    aM8r7dSkQx8msMFWP/eYxuGMDPc8Jq5LWd8/taK0Lio2gr1rD4pLVfcinj71kQloG62c
    6ICt9hT+zLC8FT3AtFnzVpCRk2XPsKnO5iPrISwLx48T3FmPW77izrcNBFNvA2LUo8Fq
    4L6I4rNoMMSFC1PLZxQzBNf9rA2GQIOTSY2S/ND+d+PN9O6luCUxQugug1C9lQ2FnEGk
    RbIru/ry4UvY3ytdG4/4ywzp9irR/dZIHQIa+3ekH9FnN3rHlsFY4nZoCDcvSXvnEapL
    og/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742233507;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=KvXfmcEOvnWakEiIBPk+PsROaIr4w1mGNnHAR3JyEd0=;
    b=RrzVzKK0tbPyVt6iqTjqw3x+QCSdfhidUIxydePdUxt5O+j8CQrDPYoWJtLoeiz7Pl
    1J+BwW9LRGneGPCJVrmUuOgLl0onRcNO5T+lwEXiMGXFPEaEK+cKnpnfJKUuJOclzi3/
    LOO2GEftoBsRiOO5DwlQIaHG/mQ6k5eEyjAbXYv1dnVj6KkvyUn6nl7iJ8w92t69OM0O
    2RI0IEIKu6Xe0GHn5iHo7hns8rv4qSDqHEXbbHn+Ui9A55zALQuwtMhFjztMI+VeTom7
    +9MvR/1niya20AvvpHtROckMeGASEusu3X9JYkKkdHOJn4xenhhkHNT1Yx0aiC794GDq
    Dukg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742233507;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=KvXfmcEOvnWakEiIBPk+PsROaIr4w1mGNnHAR3JyEd0=;
    b=kztgtgLVBVkAscgUu+Pl6CnpEDJZgJxaCfS5spwqJ8hNRPg1Y0yFCkHjrxOS8tNRvV
    NdUywAWp2kps4eUj1tJsxHFYJEMORgz9ADj1vwoSTJBNN7PkNVT8cSUNg42k07V+JFnt
    Wnwqvqxi6Wb3bsATJnmfORKFeMxrzaiIfG6FrfB1TO5mz6l7DIkYOauYRoEnfsQbTb9C
    3zTEfWhWVbe8uKb6p3XzE6XthriYBKcUdpi0SHeVcBxBk6NTGZbIwVxWgR5qlQVRHDTi
    v+XIwFm9MqOk7953ESfbqSJFRBqD44TSyzX2XVfggdy2sWcvMUiyhlKJxDDlHF9tjXZs
    2BCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742233507;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=KvXfmcEOvnWakEiIBPk+PsROaIr4w1mGNnHAR3JyEd0=;
    b=IAwI28PJhD3+fvR5X/qUXTEHNfZyGKbHT6NUC2y50T65Hb28A/y2HS7BaUVrjVRqya
    athMs/KFvzPmI/ZXAvCA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OmD4uXd0fmxSoJ8/RK6b07KGriu4yBf+6JptMSdiuOzXC/d"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd12HHj7xaI
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 17 Mar 2025 18:45:07 +0100 (CET)
Date: Mon, 17 Mar 2025 18:44:57 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Message-ID: <20250317184457.7c9d8eaf.olaf@aepfle.de>
In-Reply-To: <2e62e29e-b1da-4493-81a1-61ffc2489c56@web.de>
References: <20250317150941.32415-1-olaf@aepfle.de>
	<2e62e29e-b1da-4493-81a1-61ffc2489c56@web.de>
X-Mailer: Claws Mail (olh) 20240408T134401.7adfa8f7 hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_13kymAVGRPjVzscD87RdT3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH] replace pcre with pcre2
Reply-To: Olaf Hering <olaf@aepfle.de>
X-Loop: cocci@inria.fr
X-Sequence: 2590
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250317184457.7c9d8eaf.olaf%40aepfle.de>

--Sig_/_13kymAVGRPjVzscD87RdT3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Mon, 17 Mar 2025 18:26:32 +0100 Markus Elfring <Markus.Elfring@web.de>:

> I doubt that the adjustment of a make script is appropriate
> because such files should be regenerated by the software build system.

I'm all for removing generated files from a SCM, like it was done in
2ff738c7c63d9f2ac271d5864110efa99e6f10f4 for example.


Olaf

--Sig_/_13kymAVGRPjVzscD87RdT3
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmfYX5kACgkQ86SN7mm1
DoC4SA/+Mlg4ocXhH76hQljOiZELQ1oz9cs4fCGy+ulCT+mRRGsV1ooLNZjfYro9
CVR0nsGV7INeGIqPEyzvluzPdQXrEmCx2IMve1U8hx/cQmn8JnDjWKYgn34pyuxk
QspYFjtL3I20pkg8KSmi01gKzAWAQ7B1ZlssRgVYgF5iso43ufnCaOtt4hVvp97F
JAbojSi/t9PxTumI/gO8e94v4PhhnKIb7NQFtJMe4Kb8OIFmFJMTR2ZSrW8eiQRg
gdvgpauhz7IjgzSON9BbL/sAF8ylHwkHoXXZ6bwO5tqD+KX+5XFtPI/aWIGPIhkf
NBATcAhplrKlfsTtUpgy4wd5lx3HvP8PTecvFMzLYHiIwTe44Az0q7i0OGleZu4i
2xbtyn7GU3X/D4ZGx1pwV7vpWglrg/jyGUcxlybUd25AcC96oDYWYj1ej+zODQko
Hy4dtAkkAd6wUdWwTUlJdRmfmhfDbJfL357uKhir2nr8T4oxS6Yg3aWf3IfcWSlT
eclEg0Vhj8q9+wcobSxsaTn28UGZdN7GCucE13sdQv60OjbVKkksB4GXh0jdw5ac
HMpf82KI0Nr01vLkzc8toKtf1W+Ywa7PXN064zVoxOV3PAZbioapPEGhEyZjVNto
5+bbZTiADRlUj9icgOvkIGd1djoHIdbG/Hzd1RdN0XGLkYwAof0=
=lPKH
-----END PGP SIGNATURE-----

--Sig_/_13kymAVGRPjVzscD87RdT3--
