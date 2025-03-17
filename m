Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64E0C282EC
	for <cocci@archiver.kernel.org>; Mon, 17 Mar 2025 22:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GQIlUycBgnzKb90jV5ZxRLRHuRfZQ79kjz5DaK0e3h8=;
  b=mGyj+LlGkic3plmjNinNAXmTyn9Hesyzj34G0Vrn2grfZ7b9oASnVkJO
   NYnuL8MWZp2zff5jZQ2UY1aZnR1pOMsBpbe+D1h3qcVzWOtAuN1OCOXM4
   7Uq/3a2/Kj/u8LWr63X+hm4x8TBprcon9SvmJilaVd/SoChMbBhVyqCWv
   4=;
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
X-IronPort-AV: E=Sophos;i="6.14,255,1736809200"; 
   d="scan'208";a="213357502"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Mar 2025 23:24:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0C24EE0D1D; Mon, 17 Mar 2025 23:24:53 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0FB83E0260
	for <cocci@sympa.inria.fr>; Mon, 17 Mar 2025 23:24:51 +0100 (CET)
IronPort-SDR: 67d8a132_mAtqZ3kalHZ1BrUMP2IUwE5VpqdcvD4++j7Tk+ahSCwFJqD
 4l1v/Cch1aAcoQeiym0d5F2+sGAKtWnrV/IlwKw==
X-IPAS-Result: =?us-ascii?q?A0EtAAAGoNhnjduSqVFaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDfS4rNAcISIxzfIhbnhSBfg8BAwEIBTkLBAEBAwEDh?=
 =?us-ascii?q?DpGAosfAh8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBAQEBATkFFzKFew2CYgEzcYElAQEBAQEBAQEBAQEBAQEBAQEBARcCDX4BA?=
 =?us-ascii?q?QECAUABATcBBAsLRlYGE4MCAYIwAw4SEQcNrgaBNIEBggwBAQaCaNg/IleBX?=
 =?us-ascii?q?gcDBoFIAYFXhBWCYwGFawGEdycbgg2EPz6CYQKBYBWGL4IzhSeqFUgKgRcDW?=
 =?us-ascii?q?SwBVRMNCgsHBYEpQwM1DAsuFSOBIgU0Cjc4ggtpSToCDQI1ght8giiCF4I3h?=
 =?us-ascii?q?DyEQYVQghGBXQMDIgGDH3UchD49hGQtUIFNHUADCxgNSBEsNxQbBj5uB6IWA?=
 =?us-ascii?q?TqEUoEsIqcAoXGCP4FmgWOKNZUwGjOBS4IlAZNVDpMDmH6OBZZGhGiBZzqBX?=
 =?us-ascii?q?DMaCBwUgyJPAxkPjiEZg2EzuhlFMjwCBwsBAQMJkByBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 dvKUHusng==
IronPort-HdrOrdr: A9a23:aKO8hKvKuKYTas76przmvxS87skDvdV00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssb8b6LS90c67MA/hHP9OkPQs1NKZM2fbUQSTXeJfBOfZsl/d8mjFh5dgPM
 RbAtJD4b/LfD5HZK/BiWHZLz9j+qj+zEnCv5a4854Cd3AOV0gZ1XYDNi+rVnZEak1vOacZfa
 D82uN34wGSVzA8S+yAPD0kcoH4y+H2qA==
X-Talos-CUID: 9a23:uXLHBWACzl2qEk36Ew0kqW0eIf8lSULA9GXJD3blInk3bLLAHA==
X-Talos-MUID: 9a23:euKg1Qo8H6hZfpj+Ue4ezz5AG/ZMuJ2ENEIIyKwUlPOvJzJ8MjjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,255,1736809200"; 
   d="scan'208";a="213357497"
X-MGA-submission: =?us-ascii?q?MDHwXl6N3k/86cryR8esfrf6Ckr76U0naxVn3V?=
 =?us-ascii?q?pk72KkKpeT6wXDAlwY9FGVzz9eIP92S9z0aZ6bFy4dwO7UZl7Lt6E4oH?=
 =?us-ascii?q?dmw2AqHl1nEq59m2WyZRiy5RE3oK/GgRYLTKgI50034OcZnGRpYSd3zR?=
 =?us-ascii?q?8SjZGMU3W2Cg4+iMdUC/Z94g=3D=3D?=
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 23:24:50 +0100
ARC-Seal: i=1; a=rsa-sha256; t=1742250290; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=C33xBcLzFmLQfmppEuDAvThEY3J4K5+bBWWmnfHCmS1g3GFAxswnjhu+i8mW0crZrZ
    lnI9pNcXca5DobijtmuoSjigrmB8cFRGhkmZ2TQ6DklQQzL6RzDi1KnYDg8reebWIHqY
    CFmT0XOmJZJ422OU/hfCIPeI6K1b3SbzYFE/76eYIvhKv2HgSG4yXb8bN+TIXLA5Rj8H
    BXkYZCEhXOFzvOLl9BsfXNxsYAKBRFtoUpyvT+/HnZDmgqti8/+kG1NsH2cLG4JrESdm
    tdYrrFeNpc4Wm7orq/se0yEjK9bTBjgah/Qs0x6wze+9uRS86MjJ7/yFmePH17W5zjVI
    rmNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742250289;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=GQIlUycBgnzKb90jV5ZxRLRHuRfZQ79kjz5DaK0e3h8=;
    b=ju33wPaWRYXk4wk/iksS94CzzLChV11ZxtpJ4Z40sL4dh27VxARThm6BOMydmIdx+j
    /g9TElPxCQJgakSqYee44QgPyzypi9ToQVIls2dYBmFaYXu0XeK3i6BrKcgJrguoDcHg
    AT/QRHJ5hL31zX/KVsNPslHs4wduPX7OD8rSrmbtrI2LivZmaHlNExHkg2N+QpWKPlPF
    nfkzLgsKtrTMMwPWe0xDfPoyW5UUWpXKRgqMDQEXwlrHyHuGZeEsoQYDdlKwQinhn/iq
    AwWwIPJ38aPu93j9/WWhwz64zKZN8CsFRETQGfCO4jl2ttjdeTt9IzRwu0URZbEHYKMg
    0d+w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742250289;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=GQIlUycBgnzKb90jV5ZxRLRHuRfZQ79kjz5DaK0e3h8=;
    b=bPh1kzmV8HpvUsW3aNb9W1ITntNGYICSnTxBVEf+2WIaLkgMfnDsjglf0CO3DNyioq
    ADypQBoYcmQnVDSqobtISpLUZXupvAVfXr3J/WevPRcNzZEumSdqaBM2A3AIynINdQNq
    HcZ0/blsvdakvUTdMTnIAUXME5LyVdYJQudkSGchKKS4NsNsSwEIL8PoJZgNFHbG20Rt
    cFsu/uP0FL5wBB1ZI1fGj7g+PqvqvR7lwR0tepKrxpc1bigl9jO+ZbIMqxLNTKrX72mC
    Jqe/JhFayYrZDDhr5i6/fxLGTPSd5Q0HsD2Z5kbd5e6JOxPrm6ABSe/qgWq5N8GZHrmy
    zlsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742250289;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=GQIlUycBgnzKb90jV5ZxRLRHuRfZQ79kjz5DaK0e3h8=;
    b=XWFCFNN/zeoaDBRbIS9XJJqyKxUhtHdE7VgQO/0/jxSf2kQRXePQFlfb4t4wy7jzqu
    7HGyyWwj/p8RjkNICTAA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OmD4uXd0fmxSoJ8/RK6b07KGriu4yBf+6JptMSdiuOzXC/d"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D1c4dd12HMOnyDw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 17 Mar 2025 23:24:49 +0100 (CET)
Date: Mon, 17 Mar 2025 23:24:30 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Message-ID: <20250317232430.44cfc68a.olaf@aepfle.de>
In-Reply-To: <2e62e29e-b1da-4493-81a1-61ffc2489c56@web.de>
References: <20250317150941.32415-1-olaf@aepfle.de>
	<2e62e29e-b1da-4493-81a1-61ffc2489c56@web.de>
X-Mailer: Claws Mail (olh) 20240408T134401.7adfa8f7 hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j8y5V+ADfFVSyBIVtH97eUC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH] replace pcre with pcre2
Reply-To: Olaf Hering <olaf@aepfle.de>
X-Loop: cocci@inria.fr
X-Sequence: 2594
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250317232430.44cfc68a.olaf%40aepfle.de>

--Sig_/j8y5V+ADfFVSyBIVtH97eUC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Mon, 17 Mar 2025 18:26:32 +0100 Markus Elfring <Markus.Elfring@web.de>:

> https://github.com/coccinelle/coccinelle/issues/149

This was closed as completed. Was this closed prematurely, where is pcre2 u=
sed?


Olaf

--Sig_/j8y5V+ADfFVSyBIVtH97eUC
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmfYoR4ACgkQ86SN7mm1
DoAp3g/+KUmzLxOQSiTb2rDcLKje+stWiGIOldsdz2Fh4jtQg+k+AaL6sVrAGNVi
T3BFMDr2s7EfH3ffdeqJdF+dwnb1haWb2nfdnZJTSlDI5XPbkJeNw6b8pZDqcCQI
02WLZWEw7JRJ4/5WZbZm5Gr6lqhMKHpovkpR4JQnGHd6vayW17pk1B79+xYbAdHJ
vXer7kRLL0p6jBlVkvcNDtT4dDePSelJsp9VAYg9AQjC6svDfaxZuozHAPRApUUh
tqgjBE9F7BDVqP2yJjDzo7/3yYrBJlT3XriLMnMMPbWfkjA0NQ8oWS2CiWEkJ5x8
9+UcCOCZKX8X8tTh5rTmzHHH99JDegBhyqN/m9Nl2jqb+G8ZX1sjtWXvFKbw8q2/
4/odW4DPzJfCmf4GNR1G9dwpfWbSIZnZxZABudRXsMDo5xqcUKpErFNH10rTF22F
HRbCg/KHZrSvbkZSDhWNL84AvwGjVUa3TSfVI/kq5OoX3Si8u6SOvKCtrFfNcY29
3PzErh3IQ2wpCLaJp0Zxw/eXlc0YmGZ+61Tp+gBooKC5t0V0PUF5sIEDA2aj6AXI
Jj4i1cRO2fzbVBCiWLcQao5N32TPa7ZABKbtNHLy/cRcYz6A9Kn0oIYm/TDpSjPU
irXyOLh1hNoVirTia+iK0lMGZHNLdO6KV13pHV3xHEgsaQuQptc=
=lQoX
-----END PGP SIGNATURE-----

--Sig_/j8y5V+ADfFVSyBIVtH97eUC--
