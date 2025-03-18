Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A44C28B2F
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ahWS28M3IeBbimw+CAC3mWy5ntmjv3X4RS/XD+LOuuE=;
  b=E6mpvkz0tJJF7Jx21dJrfibsvxNONVOcxRijtCg3YT8oaJJFCwe3uGNl
   cPntcbaJLeBeX50Am/1Dcu8tB5CxPjeYnIbymRVRtcKN4NEg79R8Rp9Tt
   DCUpQNBuZNZeK7pJFgSWdiihyvmtxC13Git7hq1eceutC4uVNX9KaCDce
   I=;
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
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213534551"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 16:44:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BEFA3E0D1D; Tue, 18 Mar 2025 16:44:03 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DD5BBE0D1E
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 16:43:56 +0100 (CET)
IronPort-SDR: 67d994bd_H+yErjIXiQ9gV25hLchXClBv7F4DMTqm3ALrtwy3+xFaSdo
 qW1aRHW0Vav8qZIZ3gRnKEL/uBEjKtCYMShmwrw==
X-IPAS-Result: =?us-ascii?q?A0E0DwAMk9lngAQP49RaHgEBCxIMQIQXYnUzBAtIhFaPU?=
 =?us-ascii?q?IF0MIQ7hzuHU4h1g1QPAQMBDUEBAgQBAQMEggyCdAKLHwIeBwEENBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnDwsaAiYCAlYGARQBAYJ+gjABA?=
 =?us-ascii?q?w4jB64NgTKBAYIMAQEG2lwfLCJXgWUJgRouhW2CYwGGJ4Q8Jw+BVUSBPAuCe?=
 =?us-ascii?q?D6EQ4NbgmmCM4RDZ5l7kBxSexwDWSwBVRMXCwcFgSlDAyo0MSMPgRMFNDQOO?=
 =?us-ascii?q?CmBY2lJOgINAjWCGyRYgihqBAWBJII3hD6EQYVQghGBXQMDIgGDH3Ucg0h2P?=
 =?us-ascii?q?oRkLVCBTR1AAgELbT03CQsbBj2jSYQ9gRUBGzKVRrJ3NAeCOIFmgWMMn14GE?=
 =?us-ascii?q?y+XRg4Gkn2YfiKpEYF+I4FcMxokgzZPAxkPjiE4g3W1SUI1PAIHAQoBAQMJh?=
 =?us-ascii?q?UYBAYpUgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:C7Wl4KwajD26QkAxgUbOKrPwSb1zdoMgy1knxilNoHtuA6+lfq
 GV/MjzuiWftN98YhwdcLO7WZVoI0myyXcd2+B4VotKNzOJhILHFu1f0bc=
X-Talos-CUID: =?us-ascii?q?9a23=3A0OqdtGhcxZ87xBEUoMyvW+uA1DJuaCCa/TDVc2O?=
 =?us-ascii?q?CNDgqbZuVdgfJoqBnjJ87?=
X-Talos-MUID: 9a23:XL7+JAt2bNfv6U6F382nhRo7BJt45KuUA0Umg9IKv9aADHRxEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213534505"
X-MGA-submission: =?us-ascii?q?MDGjWctKD1dyEJHwp96Wl8+4piKyQBudQZ6XZP?=
 =?us-ascii?q?s6KrgjXk9PMQNKzM9uRFs5oXjxW9GgGMQ3pT0zoGATYITbDGBF9vS5Ro?=
 =?us-ascii?q?naN6uUkUr4K+Dw3mR/tXaST2FF8HkaHFbBVkPacE7ek02+7j8Zr7bDhc?=
 =?us-ascii?q?d4nkk988QmO/TI3zHDGv45+A=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 16:43:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742312634; x=1742917434; i=markus.elfring@web.de;
	bh=ahWS28M3IeBbimw+CAC3mWy5ntmjv3X4RS/XD+LOuuE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uLSC7eM3pK/6Wph7N7UTNTcGAe3GGcvfAwNDjO4QWoKLVpY5rgZZvjJOoG/nEfSM
	 oEz+dCJJC0B+bhq7CQkXXx9zQAxMql74m/Ays0zhiQXbdkPW9bagbbaX9usyx0uCi
	 tdEjTeAB7rAtku63kRUu8vRJHCM/ZYOeF+L9s5W0OjikekCEushDq4E3qNwZEu+Ne
	 bUPJfDx/LEzhrv6a8NOoLzgzyiXJcyaLizDO1c/QjbvoGmvFnq01nsSVErG72Gu2Q
	 COK5EmY6nYwJweALuich1Tl/el1uf6iXvg25BSZvI3oBK8H1ENYxT7L8nob8Krbw6
	 GAa2wQ3fh/Y3FFtlPg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.69]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2xrs-1ttTB00Dim-000D9m; Tue, 18
 Mar 2025 16:43:54 +0100
Message-ID: <ccd65b9a-caaf-4852-bda3-cab980a42b58@web.de>
Date: Tue, 18 Mar 2025 16:43:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Florian Stinglmayr <florian.stinglmayr@proton.me>, cocci@inria.fr
References: <Cj-R4IgEgd_zgRLBVFxVy7ffXmhDSmTrxrSQhr83u3Lf9M8N9dEBDK8M_idtO0mGjO480pEeMHrQHH4xWmQn1uSwLUHW-jXSt0mlIy_HiNY=@proton.me>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Cj-R4IgEgd_zgRLBVFxVy7ffXmhDSmTrxrSQhr83u3Lf9M8N9dEBDK8M_idtO0mGjO480pEeMHrQHH4xWmQn1uSwLUHW-jXSt0mlIy_HiNY=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oPkmkP0ZWzrrbl1AfnCdR6Wxz6sN0zh9ABg8EYVgTosSzBY62OG
 SpnIThoXbeZL0UPOJJ51+E5CkCqFSj768YpnFHv56ekTWqXpOHhZDheJTqal9ITAd3NR1+r
 LSrc1vj0at1E/93ObwIlnZ+73QZler5mGLd/dAbIgTcEIpyu8DPBWSqEjk+QCWxNSIcQ89d
 ngSOYl0m8ctMdGypOpEPw==
UI-OutboundReport: notjunk:1;M01:P0:ywCsV8g3Gp8=;8EEOilf1yQvHs72JZe7ueUr+oZd
 MCcUNwKmDyfjt2c2YBfuRoZdOOc4NQjfSE/fZ2jhuq7UF+q7kwU+Ckt573MsJ1MGVOv2jGidW
 zq3rudPXQQ6ED5Qk1tOpE4ibNvUmBPL6d+47W25TxEIQHV1hQZGY641MLUw9VGBKh3fY57yY2
 KMKZpMTvop7nsjpFdVWnPIBVoEcYjq3CQaSiudcAaJ6B8q5j2Vwr1cTDAk4pvyswpZz0SoMlD
 rUAwMaIfA08bnIojJJV+DgMjLp8geXztUNM1STyNQ4T7/Xzdnc+cbOyjqkcpJoM/Sr8MSUeo5
 RMsfv/Y5cKevOqc3JpA2/Vr02O/SWLIMWLyVIHhiSKIK6FaN1G6lmsqYYt+ObNdsUsnckH/1X
 D1usVDa+GOV93J+zYTBPD4iuXcDSIIbQx+JdMrlKr4JmIHM7ryr/+qdnK/vuwK1jkPTyVgIDH
 gQoHq+51TKu4iDyZSVXRoApRfnG6raE7YiC2bcuCq4O6zmld2M9djog90CLdE1JGWXazPP4GS
 NTNhVA2Ukoraom6g+dB9wCkTxwDvD9Tuv0kiGtMN37M1PonJX6UDsWFUzzXK2E0+IJj1lajwk
 OxHj9/q43qgGHVBVEQND/PtZFb/A7ZdX11vJxsSkFduEM9+J6koUeHd4CIXBXBUvWv/d7zZwn
 Sf4F6hYUUe9ySURPAG84Yey9I/Np7PyDOu4K5LbNZeqsn8ei6DjbrRPqM/p3X5BW7kAhCZhit
 rmyTE5IvTjJY5i7pJ3vrh4P4OdhBIpFmAkYN8ou4YHrqOJiOJkSp7qFP3EcitrSpfudZ6DKBE
 7wenS8VxNhGQFHz9WbpEtqVThIfTK/+brGH+1TSJFXnkUUQIJyiWnSuKDtbXgsxS9GfL5/1dT
 TZA8eBk+VHiLA87Oyd1dVTTiVQMs54luhShh9VXFUXoewBvGj+0ZhrSHYIQ2wDT11JgSXptEE
 Mol1eLfkiRAwX3rR2kSLVPqZOXn/zlYbMLsVj44Xu3ALXB05Slcv4tOyem6dz4+AwTrWv1z2t
 EP9TuKMFLP8B5Rt3mKzTDxz4f+rEI0tiqYdNFU7sUggAM9m4YrOEuqAyrWhqPyUgrT9kq5moo
 UjCsEGDCtGjOxFsNFyytJDS3mlg+zQbU2pPjdx2pCuxHEPclQqTNcugvM+DGnf+1JouOuejWL
 1P3ku94aO5kL20MWxIN5v7fQZCCE8MnY4SEPwm5KRfZUXD8kPzAESlwirPeOo+mB/xvNsvi8c
 GLErpzKzd8+4ciZR/TsX8eNJU1sPTepir0wdaAvAJ9lfFMj4HoWLyKeJCpI5E3JUWl7E8Mfcz
 RYlThDEEo8sXUMEFG3n0mPpaN3s8ofYISSJODRLd9y4+4iGAcfgSjG6rlMIC8DTIV3zyAuP0Z
 CAPc4Y3w2JtJnHXYO36fEcX4Yepvh5+AqDRsJzskOcZzMkxcUzSz5j37W8Lhe43FnegrCsTZu
 66tnRIriWxqyV+emfUvOM9+MzNnFnl00eJm6JaZ+Nk5zsJY3vyoCVP3LN81UpbU6Z++K2Mw==
Subject: Re: [cocci] Bug: cocci seems to have issues with math expression in
 struct initialisers
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2627
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/ccd65b9a-caaf-4852-bda3-cab980a42b58%40web.de>

>> rect_t dst =3D { SYMBOLA * SYMBOL_WIDTH, 0, 0, 0 };
> cocci complains about the code around multiplicator in the structure ini=
tialiser.

The test case can be simplified another bit.

Another source file example:
my_structure x =3D { 2 * 3, 0 };


Questionable test result (with the software combination =E2=80=9CCoccinell=
e 1.3-00083-g4093aad2d=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --parse-c=
 test1-multiplication_in_structure_initialiser.c
=E2=80=A6
(ONCE) CPP-TYPEDEF: promoting:(201) my_structure on line 1
=2D----------------------------------------------------------------------
NB total files =3D 1; perfect =3D 1; pbs =3D 0; timeout =3D 0; =3D=3D=3D=
=3D=3D=3D=3D=3D=3D> 100%
nb good =3D 0,  nb passed =3D 0 =3D=3D=3D=3D=3D=3D=3D=3D=3D> -nan% passed
nb good =3D 0,  nb bad =3D 0 =3D=3D=3D=3D=3D=3D=3D=3D=3D> -nan% good or pa=
ssed


Regards,
Markus
