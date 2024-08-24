Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B359C52D6F
	for <cocci@archiver.kernel.org>; Sat, 24 Aug 2024 13:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=mSTeA4eSdzpUP1LzUw/mnLZFfNgUPZ4h+ElWznlqamA=;
  b=bbtPyl5JOIklP7QaIdQ6ea0+CE3u3116ZlkXg3REY8cKdICQjhXK365f
   KZaosASjwYUAQs76H2/Xd6MY+oNlXMwBV1qgAWuAgheyxVctvaW7tijZx
   qy2F8eq5kX4oPkfyjplif4yX1pANd1XS1z59AZe0griXnpWaYuSF4HCVZ
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.10,173,1719871200"; 
   d="scan'208,217";a="179932112"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2024 15:01:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C1034E0133; Sat, 24 Aug 2024 15:01:09 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2F633E00B7
	for <cocci@sympa.inria.fr>; Sat, 24 Aug 2024 15:01:05 +0200 (CEST)
IronPort-SDR: 66c9d985_jamJL0qC6fwRsKh0370PFsNNOyne3W1DNab6p8pziOOTRKj
 GzBbS6GkDZ/3nvY6FHy1WR5LQF5grFXHaf5+E5A==
X-IPAS-Result: =?us-ascii?q?A0H3AgAQ2clmfzSnVdFaHAEBAQEBAQcBARIBAQQEAQGCD?=
 =?us-ascii?q?4FyUoFXMwRThFaPTIF1LQOEO4c6i0iIFioUDwEDAQsBAUICBAEBAwQ4hEcCi?=
 =?us-ascii?q?WkCHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABASIZB?=
 =?us-ascii?q?w4SKYV1DYJjAYEiYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEFAixeAQEBAQIBEhEEGQEbHQEDDAYDAgsNKgICIAIRAQUBHAYTA?=
 =?us-ascii?q?gEBHoJegjABAw4jAwGSDI80gQVCikF6fxYFAhaBAYINBtpaChkoDWwDgWACB?=
 =?us-ascii?q?wkBCoE0hHMpW4IyBAEdASqBMgKIAnonD4FVRIEVJ4EUgW8+gh+Ff4JHIgSBa?=
 =?us-ascii?q?QWDZ4IfhTKBYYMADgGCEQqCClcPgluDEHwlPguHJIF7i0AIBx8SCQkTBgoCS?=
 =?us-ascii?q?wUQEgMEAwQEAQILCQoJAwMCDgIIAwIIBg4TAT8SBBMKDQsDBgUfCAIEBwwRC?=
 =?us-ascii?q?hcCAwMCAgMCBQMDBQUFAgMFAwQDBQMDAhEBBgIFDQgGCwUFBwIGAgQIBQICA?=
 =?us-ascii?q?wMDAgQQAwMDAgUCAgMDAQIGDwYCAgMFBgMDAwMDBgMDAgYDAwICAwIDAQMCA?=
 =?us-ascii?q?wECAwICAggCAgMFBAUCAgQIEwICAgIDAwgDAwoEAgIEAQQCBAIEBgIEAgIBB?=
 =?us-ascii?q?gIDAwIDAgcCAgQCAgICAwIEBQIDAwMCAgIBCQIFAQEGAgMDAgMFAwkDBAUCA?=
 =?us-ascii?q?wgBAQICBwcDAwQDAQIBBQQCAgYFAgMCAgQCBAUDAgMGBgIBAwIKBgMFAwMDA?=
 =?us-ascii?q?wIDAgMDAgUCCAICBAQFBAIFBAIEAwMDAQoCBgMCAgUBAQICBQMCBAQHAgIHD?=
 =?us-ascii?q?wMCBwUCBQUFAgcBBgUCAgMCBgECAgYBBgIEAQINAQECAgMBAwMDBwIEAwIIA?=
 =?us-ascii?q?gMDDwEDAwkGBQQFBAMJBA8CBAEIAwEBBAgCBAMCDAICIAIFCwQEGggDAQEDA?=
 =?us-ascii?q?QECAgICDQMCAwICAwoCAwIKBgQCBAEBAQQEAQQCAQIHBA4JBQgIAQMCAQQGA?=
 =?us-ascii?q?QIQBRAJAwcEAhAGCgUDAgMFAQUVAwgDCQIEDAMFCAIDAgYDBgIGAQYDBwsBA?=
 =?us-ascii?q?QcIBQMDAwIXAQICDwgEBg8IAgMDAwQKAxICBg4DAwIDAgECAgIDBQQFAgcDA?=
 =?us-ascii?q?woFAggDAggFAwcJBAoCCgIGAwICAgIFDAEBAQECAwIFAwcHCAgEBQQDAQEGB?=
 =?us-ascii?q?gweAgIDBA8DCQMGCwEFBQEDAgIOAwYCAwYGAQkEAQUECQIFBwYFAgEUBw8GA?=
 =?us-ascii?q?QYCCgIHAgICAwECCAkIAgMCCgQBDgQZAgUBAgIDBwIDAhMDAwUEBgMCAgICA?=
 =?us-ascii?q?wIBCgsDAgIDAwMDBQUDAhkDAwIBCgUMBQQDBAICAR0DAQUCAwoBBQkBBgICA?=
 =?us-ascii?q?wIFAgMGBAIEAQ4BAQEDBgsJFAICAgkIAwgDBQ0CDQIDBQICCz0LBQEBBAMJG?=
 =?us-ascii?q?C0CBAIGDAEBAQIDBgICAhUFBwMFAwgBAwECEwgGAgEDCgoCAgQCBgMDAgoDA?=
 =?us-ascii?q?QgCAgIPAwkCBwINAgIDAwwPBAMDAwMIAgICEQkKAgICDAQKAgkCAgMGAQIDA?=
 =?us-ascii?q?wUDAgEBAQQvAgQHAQMGCgMCAgIJCAoJAwMFAwwBBgQBAgMMAQECEwQJAwIBA?=
 =?us-ascii?q?gEBBggBAQIEAQQCCAYCAgICCgMFAwIDBRUFBAICGQMEBQMFAwMEBwECBQQLC?=
 =?us-ascii?q?QIFAwIEAwMCBAQCCAUJBAMLBgEBAQMEAwEBCAcHAwIBAQMBAQoLCA0IAwgDB?=
 =?us-ascii?q?gkDAQYBAQUSCAIDDgICAgMCAQoGCAUCAwYNAgQCGQEMAwEDAwUOBBQDBAUCA?=
 =?us-ascii?q?g8MAQIDAwQFAwUCAgIDAgICBQQBAgQCBAEIBAkBAgICAwIBAQIEBgUCAgIDA?=
 =?us-ascii?q?gcMBwMEAgYCBgIDAgcLCwIDBgUFAwUCHgIDAgIEAwMWAQEDAQIBAgMCAgMCA?=
 =?us-ascii?q?wQBAwMCAQEBAwcCAgIEAQEBBAYFAgIDDAIDAwEBBgEDAQIPBgUGBAEKAwIUA?=
 =?us-ascii?q?wUiAg8FCAEoAQQCAgECNwICAwQNCAUCAgcCBAwCBA8FAwMOBxYGAQQIBAUEB?=
 =?us-ascii?q?AwKAwYOBxcRAQEEBAIIBAICDQcCDAICBgQCAQMHIwYDBQkDAgUFEAICDQIEA?=
 =?us-ascii?q?xYEBBsDAQIKAgIYAgEHAQIUAgIHAgIBFAIKBAIHBgcCHQICAQMHBAQBCQMGD?=
 =?us-ascii?q?BEDCAIHAgEFBgUBAQQSAQIBAgEBAgMDEQECAgMDAgIBCQICAQECDQgBBAMBB?=
 =?us-ascii?q?gIFAwUDCgEBAQIBBAkEDwYDBQMDBwMEAgMCBgIEBAICAwMCAwEGAwIBAgMJA?=
 =?us-ascii?q?gEREQoPAgIDBAIGAgIBBC8EARUFAgMEAgIHAgIDAQIBAgICBAIFAgIGAwkIA?=
 =?us-ascii?q?QICCAECAgIDFgIFAQQJAwMFEg0jAwMBAgICAwcKAwUCAQECBAMFAwMJDQcCA?=
 =?us-ascii?q?wECAQMFAwECAQIJAwcCAgMDBRIZBQMCCAkDAgEFBAIJEgsJAQESGgUECQUVC?=
 =?us-ascii?q?QIDBhcLBAUDAwMBEQUODgICDAMdBQEEBwEDEwsDBAQCAwMDAxQCARcBAwQDA?=
 =?us-ascii?q?gkCBAECCgICAwMCBR8dAgkDIw8CAQsJCBM9DAcyBDQBCQsUBwYlgQCmSQQOg?=
 =?us-ascii?q?gKCR2EhEwF/cXg9nWamPE09NAeEF4FdBgyZVYV6Bg8EL5c9jF2GKJhvkX6Wc?=
 =?us-ascii?q?AIKBwYRIxKBSSOBXDMaI1AxgjZPAxkPjiEMFoNYy1JBNTsCAQYBCgEBAwmFa?=
 =?us-ascii?q?YYBgUsBAQ?=
IronPort-PHdr: A9a23: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
 alMOzLNRrYXhLxlJzgDtQ==
IronPort-Data: A9a23:6lkNjq8OVR38ZadIx+IhDrUDMXqTJUtcMsCJ2f8bNWPcYEJGY0x3m
 mAXDWmBPqrcamCkedt3Ydi//BkCucDVytNlS1Rs+y9EQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWcsWo4ow/jb8k837K6u4GlwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TEmdEtUkI/Z7Mi490nAHt32
 KQVOSwWYUXW7w626OrTpuhEg80iKIzvMtpatCw6iz7eCvkiTNbIRKCiCd1whm9hwJATW6+AO
 IxEM1KDbzyYC/FLElIeFIl4n+auinD/dxVXrVuUoew85G27IAlZiee8YYGPIo3ULSlTtnnAq
 yHM3GqjO0wDLuCt1mCb+1icj8aayEsXX6pJSeTgqa806LGJ/UQXAQIfUV+Ts/i8gFS3HdNZM
 U0dvCQ0xYA580egT/HmThigqTiFuAQdUpxeCYUHBBqlz6PV50OdCDFBQGMbLtMhs8AySHoh0
 Vrhc87V6SJH6pnWF3GUrImutAjiODIsADcPdDMfQl5QizX8m70bghXKR9dlNae6iNzpBD39q
 wxmSgBu193/auZbh82GEUD7vt66mnTeoucICuj/W2uk6kZ9atfgadHyr1fc6vlEIcCSSVzpU
 Jk4dyq2vbtm4XKlzXPlrAAx8FeBuart3Nr03wIHInXZ327xk0NPhKgJiN2EGG9nM9wfZRjia
 1LJtAVa6fd7ZSTwMfMsPNPtWp57nMAM8OgJsNiEPrKihbAhJGe6EN1GPxf4M53FyRd8wf9gY
 8/znTiEVi9AVPk6pNZJewvt+eR2n3hhlD27qWHTwBOg3r6TLH+TQvFtDbd9RrFR0U9wmy2Mq
 4w3H5LSlX13CbSiCgGJq9J7BQ5RdhATW8umw/G7g8bZfWKK7kl6W6GPqV7gEqQ595loehDgp
 y7jBBYFmQGg3hUq62yiMxheVV8mZr4nxVpTAMDmFQ/AN6ELON71svUsZNEscKM59edu6/dxQ
 rNXM4+DG/lDAHCPsTgUcZC3/sQoeQWJlDC+GXOvQAE+WJp8GC3P2NvvJTX0+Ac0UyGYiMoZo
 p+b7D39f6YtfQpZIfjzVOOO1HK05HgUp/JzVRDHI/5VY0Tdz7JpIC3Q0N4yesEFFgrfzBSrx
 yKpME49pLTLqdVk9tPmuL219da1MuphH3h1G3vQwqa2OBL7oEui495ke8SZcQ/NUFjb/P2ZW
 txU6PXnItgrrU1vsbcgI410zKk72cTjl4VawitgAn/PSVahUZFkHVWrwuhNsfdr6oJCmA7rR
 H+KxMZWCY+JNOzhDlQVAggvNcaH9PMMnwjt/eYHG1r76AB37Yi4fx1rZTfUsxNkLZxxLI8B6
 sUispRP6wWA1zwbAuzfhSVQr2mxPngMVps8ja4jAajptxEKz29TapmNGw7055CyM+93CHcIG
 QPNpqT+hOV7/HHgIl4TDnnG2NRPiase4C5qyEAwHHXXu97nqMJu4jhv32UWdCp3wC9D8dpPA
 UlwFkgsJayx7zZi38dCeGa3GjB+Ph6S+22v6l4FiFzmS1KMU0rTJlYcIseIxlgSqEhHTwhY/
 ZaZ6Wfrainrd8fPxRkPWVZphvjgbN5p/CjApZyDM+GaOaIlOBzJr7SLZ2UajzfGW+YKm1zht
 +1m2M1SeJ/LH3ccjINjArbLyIlKbg6PIVJzZM1I/YQLODr5Uy6z0z3fEHKBUJpBCNKS+HDpF
 vE0ANxEUim/8yO8rjo7I6ooCJ0sld4L4OsyQJ/aFVQkgZC+8AUw6Inx8xLgjlAFW99tyMYxC
 r3AfgK4T1C/uyFmpH/vnuJlZEyDftg2VC/t1ruU8cIINa45nsNCTEUQ6oaw7lKpaFZJ3hTMp
 w7SRb7k/8o7w6RWoobcOKFiBQK1FNDNaNq14D2D6+ppU9eeHvrN5iU0q0bmNTt4JbE+ecp6v
 pXTvc/V3HHqhqcXUWfYqcPYF6B2+tiDBrtLE8PoLUt1mTmJd9/s7iAipUG5C81tu/FM6va3Q
 zCXbJOLSucUfNNG1VtpZDN7AT9EL4jKNoLbujKag9GXLxoswSjrDYiAyyfyTGd5ciQoBcXPO
 jXssazz2uEC/ZV+OhAUItpHXbpqK0DHcok7fYTTsTK4MDGZsmmasOG/qSt6uCD5MVjaIsPU+
 pmfewPfci61s6T2zN10lYx+kxkULXRli9kLYUMv1I9qug++EVI5A7wRAbceBrFQtx7C5pXyS
 TXOTWklUAHWfzBPdzfi69XCACabIMEzOenCGz94xHPMNh+KB76BDoU4p20kqz1zdyD4xe6qF
 cAG9zeidlKty5VuXqAI6ub9ne5jwejAy2kV/Vzm1fb/GAsaHa5AwUkJ8NChjsAbO5qleIT3y
 WkJqaRsRUi6TQv1H58ldSMPXh4euzzrwnMjaiLnLBMzfWmE5LUo9RE9E7ibPn4/gAAiK7sHR
 HexTGyIi4xT8mJGorMn4rrFnoctYc9m3aGGwGvLSggbnqX24WMiVy/HcezjU+l6kDNi/5jhe
 vVALpTw6Ilp6Kyc5VFO9Tg0xg==
IronPort-HdrOrdr: A9a23:Fuiesazv+rRaZ5yRgUi+KrPwD71zdoMgy1knxilNoNJuA7Slfr
 OV7Y4mPH7P+VUssRQb8+xoV5PwJE80maQFnLX5eI3SIDUO21HYSL2Kj7GSoQEIcheWnoU86U
 4jSdkENDSZNzlHZK3BkW+F+rgbsaC6GeyT9IDjJrRWIT2CqZsM0+60MGmm+4RNKjV7OQ==
X-Talos-CUID: 9a23:QchT4mDSUFZ69En6E3NDtxAXE5obSGTmnHbKGmLgBHd1U7LAHA==
X-Talos-MUID: 9a23:2ZMZHARxARO1hrRFRXTT3DwhPuRmuZ3zEVoxo4pcpcCuBSVZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,173,1719871200"; 
   d="scan'208,217";a="179932096"
X-MGA-submission: =?us-ascii?q?MDGqSo1Gi4bPcKWdht/85cmXrZhqW83+vIG6fs?=
 =?us-ascii?q?bgIjhbDKaCManWOTuOHP+Wwu5Mi8dlH4aDTg0PuVIK8nLWlW/UU3ENRL?=
 =?us-ascii?q?gDd2LRpIsWpHTcZnd/nnShSVVeiXfSoVjtoXhjU0tv2/cIo46Nf+kIaJ?=
 =?us-ascii?q?Nq4JAQqt0LpQy4LC3SoeTXVQ=3D=3D?=
Received: from mail-lf1-f52.google.com ([209.85.167.52])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 15:00:53 +0200
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-533496017f8so3840133e87.0;
        Sat, 24 Aug 2024 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724504450; x=1725109250; darn=inria.fr;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSTeA4eSdzpUP1LzUw/mnLZFfNgUPZ4h+ElWznlqamA=;
        b=XwlxpwY5STZ4/jjZuYM91QmN/nWZBYVloIayVaPQ3OCI4V9eR9rOnUEOoejUhDWNKg
         n0un2Z5gFTJN02NDjLWonOZvOLDEGCk/pGzyV/rbfRyDoUa/3dNy7cG9a0q8/EX0+yAv
         DwrKBIEbnvWR9oewa8MQ67lPz0m59cUCib30zotWRJur+665ULKx/m0SHpqCTeROilsB
         6HAttWhYMKwAYvJTVBvJ5mffoW+dVYyU7ZDBOIuhnEAsS0m3PisNQ0qKf4sxwsAryGLw
         xgtlxQRlEBtd1BIGErno9xfHbbSQOKzYtgdi9iJcd0HiTVkvU2lKKG/5lEQlLIznNsRF
         vuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724504450; x=1725109250;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mSTeA4eSdzpUP1LzUw/mnLZFfNgUPZ4h+ElWznlqamA=;
        b=m94XOo2RyyWGf51P9o2cy99MBkzQna2/RO18ov9SHiUpbSo0yLVJkA2hNkTVY15IaA
         Ot738x1FDIQdq89If5UdGv+sE8d+UYSL8udXps+y4e/xSGb1kZups+jEaasoiSTlc7Aq
         Pn38QEl1fVHb5J4NrKXEHgjqUl25qn3fqdfTEc6zX8eAOJJgSCGG7gHnNrEV3Y8ZYu2c
         oNMKVq18BWybSL/auRG2pNPpBsTLwqj8hhJaXyyr4bsSFtXMRcVTKeh1el49VVJYz5Ax
         PBGElu4DcrZmpZRZ5AeJqoloAkYP6vnfLyv/aNOac01r5lfzo3QABADDDudDsZL0CK2R
         AFoA==
X-Gm-Message-State: AOJu0YzY+ktzaJZ8zjB7m9kfKdelPbxN3lV1M/HFqOK/wYYONvVcyvdx
	oxhhHD/4fXF21zV6Rw4woQ8D9PYkJQiSyxAxqC+lIRyoUA6ph6cjJQ+PzQ==
X-Google-Smtp-Source: AGHT+IHPItFLZwkD11YfXZC8KFmGzhPltAXDiAOFjZeeFIFL+TXDsBSkFgPRsl+2XWnqYkWoWlbUaA==
X-Received: by 2002:a05:6512:a95:b0:532:fdba:e7c9 with SMTP id 2adb3069b0e04-53438868e00mr3541947e87.56.1724504449439;
        Sat, 24 Aug 2024 06:00:49 -0700 (PDT)
Received: from ?IPV6:2a02:aa1:1143:b0f6:a8a8:345a:5450:1e93? ([2a02:aa1:1143:b0f6:a8a8:345a:5450:1e93])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea8996asm851311e87.291.2024.08.24.06.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 06:00:49 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------xN4E7GMboJbLwV4CQlN0mUkN"
Message-ID: <5dea7b1b-3e0c-40ec-af12-b15e2a66502a@gmail.com>
Date: Sat, 24 Aug 2024 15:00:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: cocci@inria.fr
References: <983f5490-ee27-4558-832f-6d5af7344b79@gmail.com>
 <25488C8C-BE4A-4182-BD19-4D04562CEC4A@inria.fr>
Content-Language: en-US
From: Mats Kindahl <mats.kindahl@gmail.com>
In-Reply-To: <25488C8C-BE4A-4182-BD19-4D04562CEC4A@inria.fr>
Subject: Re: [cocci] Symbolic names in iso-files
Reply-To: Mats Kindahl <mats.kindahl@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1861
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/5dea7b1b-3e0c-40ec-af12-b15e2a66502a%40gmail.com>

This is a multi-part message in MIME format.
--------------xN4E7GMboJbLwV4CQlN0mUkN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-08-24 14:56, Julia Lawall wrote:
> Can you just add semicolons in your isomorphism?
> Sent from my iPhone

Hi Julia,

I assume you mean to write something like this:

    Statement
    @ pg_return @
    @@
       PG_RETURN_VOID(); => return;

But that fails with the same error message:

    mats@abzu:~/lang/cocci/hacks$ spatch --sp-file lwlock.cocci
    code/lwlock.c
    init_defs_builtins: /usr/lib/coccinelle/standard.h
    iso main: parse error:
      File "./postgres.iso", line 4, column 2, charpos = 29
      around = 'PG_RETURN_VOID',
      whole content =   PG_RETURN_VOID(); => return;

Best wishes,
Mats Kindahl


>
>> On 24 Aug 2024, at 14:23, Mats Kindahl <mats.kindahl@gmail.com> wrote:
>>
>> ﻿
>>
>> Hi all,
>>
>> In some code, there are macros used for different purposes. One 
>> typical case is having a "foreach" macro, but this is covered using 
>> "iterator" so that you can deal with code like this:
>>
>>     static Jsonb *BuildJsonObject(List *items) {
>>       ListCell *cell;
>>       JsonbParseState *state = NULL;
>>       JsonbValue *value;
>>
>>       pushJsonbValue(&state, WJB_BEGIN_OBJECT, NULL);
>>       foreach (cell, items) {
>>         KVItem *item = (KVItem *)lfirst(cell);
>>         AddJsonField(&state, item->key, item->value);
>>       }
>>       value = pushJsonbValue(&state, WJB_END_OBJECT, NULL);
>>
>>       return JsonbValueToJsonb(value);
>>     }
>>
>> However, if you want to make sure to deal with resource allocation 
>> and make sure that you release a short-lived lock, for example 
>> (grossly simplified, just to demonstrate the problem):
>>
>>     @@
>>     expression lock, mode;
>>     @@
>>       LWLockAcquire(lock, mode);
>>       ... when exists
>>     (
>>       LWLockRelease(lock);
>>     |
>>     + LWLockRelease(lock);
>>       return;
>>     )
>>
>> If fails miserably with this code:
>>
>>     Datum start_worker(PG_FUNCTION_ARGS) {
>>       pid_t pid;
>>
>>       if (!autoprewarm)
>>         ereport(ERROR,
>>     (errcode(ERRCODE_OBJECT_NOT_IN_PREREQUISITE_STATE),
>>                         errmsg("autoprewarm is disabled")));
>>
>>       apw_init_shmem();
>>       LWLockAcquire(&apw_state->lock, LW_EXCLUSIVE);
>>       pid = apw_state->bgworker_pid;
>>
>>       if (pid != InvalidPid)
>>         ereport(ERROR,
>>     (errcode(ERRCODE_OBJECT_NOT_IN_PREREQUISITE_STATE),
>>                         errmsg("autoprewarm worker is already running
>>     under PID %d",
>>                                (int)pid)));
>>
>>       apw_start_leader_worker();
>>
>>       PG_RETURN_VOID();
>>     }
>>
>> Giving the patch, where the call to LWLockRelease should be before 
>> the PG_RETURN_VOID:
>>
>>     --- code/lwlock.c
>>     +++ /tmp/cocci-output-12611-ff946d-lwlock.c
>>     @@ -18,6 +18,7 @@ Datum start_worker(PG_FUNCTION_ARGS) {
>>       apw_start_leader_worker();
>>
>>       PG_RETURN_VOID();
>>     +  LWLockRelease(&apw_state->lock);
>>     }
>>
>> Since this is such a common construct, and you do not want to deal 
>> with this for every potential case, this seems like an obvious case 
>> for using an iso-file, so I created one that looks like this, with 
>> the idea that we support replacing "PG_RETURN_VOID()" with just a 
>> "return".
>>
>>     Statement
>>     @ pg_return @
>>     @@
>>       PG_RETURN_VOID() => return
>>
>> However, this fails with the following error message:
>>
>>     mats@abzu:~/lang/cocci/hacks$ spatch --sp-file lwlock.cocci
>>     code/lwlock.c
>>     init_defs_builtins: /usr/lib/coccinelle/standard.h
>>     iso main: parse error:
>>      File "./postgres.iso", line 4, column 19, charpos = 46
>>      around = '=>',
>>      whole content =   PG_RETURN_VOID() => return
>>
>> Which I suppose mean that there is no support for handling anything 
>> but standard tokens in an .iso file.
>>
>> Have I misunderstood the situation and this is already supported in 
>> some way?
>>
>> Are there any plans that add such support to the ISO grammar?
>>
>> Best wishes,
>> Mats Kindahl, Timescale
>>
--------------xN4E7GMboJbLwV4CQlN0mUkN
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2024-08-24 14:56, Julia Lawall
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:25488C8C-BE4A-4182-BD19-4D04562CEC4A@inria.fr">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      Can you just add semicolons in your isomorphism?<br
        id="lineBreakAtBeginningOfSignature">
      <div dir="ltr">Sent from my iPhone</div>
    </blockquote>
    <br>
    <p>Hi Julia,</p>
    <p>I assume you mean to write something like this:</p>
    <blockquote>
      <p>Statement<br>
        @ pg_return @<br>
        @@<br>
          PG_RETURN_VOID(); =&gt; return;<br>
      </p>
    </blockquote>
    <p>But that fails with the same error message:</p>
    <blockquote>
      <p><span style="font-family:monospace"><span
style="font-weight:bold;color:#54ff54;background-color:#ffffff;">mats@abzu</span><span
            style="color:#000000;background-color:#ffffff;">:</span><span
style="font-weight:bold;color:#5454ff;background-color:#ffffff;">~/lang/cocci/hacks</span><span
            style="color:#000000;background-color:#ffffff;">$ spatch
            --sp-file lwlock.cocci code/lwlock.c
          </span><br>
          init_defs_builtins: /usr/lib/coccinelle/standard.h
          <br>
          iso main: parse error:  <br>
           File "./postgres.iso", line 4, column 2, charpos = 29
          <br>
           around = 'PG_RETURN_VOID',
          <br>
           whole content =   PG_RETURN_VOID(); =&gt; return;<br>
        </span></p>
    </blockquote>
    <p>Best wishes,<br>
      Mats Kindahl<br>
    </p>
    <div class="moz-cite-prefix"><br>
    </div>
    <blockquote type="cite"
      cite="mid:25488C8C-BE4A-4182-BD19-4D04562CEC4A@inria.fr">
      <div dir="ltr"><br>
        <blockquote type="cite">On 24 Aug 2024, at 14:23, Mats Kindahl
          <a class="moz-txt-link-rfc2396E" href="mailto:mats.kindahl@gmail.com">&lt;mats.kindahl@gmail.com&gt;</a> wrote:<br>
          <br>
        </blockquote>
      </div>
      <blockquote type="cite">
        <div dir="ltr">﻿
          <meta http-equiv="content-type"
            content="text/html; charset=UTF-8">
          <p>Hi all,</p>
          <p>In some code, there are macros used for different purposes.
            One typical case is having a "foreach" macro, but this is
            covered using "iterator" so that you can deal with code like
            this:</p>
          <blockquote>
            <p>static Jsonb *BuildJsonObject(List *items) {<br>
                ListCell *cell;<br>
                JsonbParseState *state = NULL;<br>
                JsonbValue *value;<br>
              <br>
                pushJsonbValue(&amp;state, WJB_BEGIN_OBJECT, NULL);<br>
                foreach (cell, items) {<br>
                  KVItem *item = (KVItem *)lfirst(cell);<br>
                  AddJsonField(&amp;state, item-&gt;key,
              item-&gt;value);<br>
                }<br>
                value = pushJsonbValue(&amp;state, WJB_END_OBJECT,
              NULL);<br>
              <br>
                return JsonbValueToJsonb(value);<br>
              }<br>
            </p>
          </blockquote>
          <p>However, if you want to make sure to deal with resource
            allocation and make sure that you release a short-lived
            lock, for example (grossly simplified, just to demonstrate
            the problem):</p>
          <blockquote>
            <p>@@<br>
              expression lock, mode;<br>
              @@<br>
                LWLockAcquire(lock, mode);<br>
                ... when exists<br>
              (<br>
                LWLockRelease(lock);<br>
              |<br>
              + LWLockRelease(lock);<br>
                return;<br>
              )<br>
            </p>
          </blockquote>
          <p>If fails miserably with this code:</p>
          <blockquote>
            <p>Datum start_worker(PG_FUNCTION_ARGS) {<br>
                pid_t pid;<br>
              <br>
                if (!autoprewarm)<br>
                  ereport(ERROR,
              (errcode(ERRCODE_OBJECT_NOT_IN_PREREQUISITE_STATE),<br>
                                  errmsg("autoprewarm is disabled")));<br>
              <br>
                apw_init_shmem();<br>
                LWLockAcquire(&amp;apw_state-&gt;lock, LW_EXCLUSIVE);<br>
                pid = apw_state-&gt;bgworker_pid;<br>
              <br>
                if (pid != InvalidPid)<br>
                  ereport(ERROR,
              (errcode(ERRCODE_OBJECT_NOT_IN_PREREQUISITE_STATE),<br>
                                  errmsg("autoprewarm worker is already
              running under PID %d",<br>
                                         (int)pid)));<br>
              <br>
                apw_start_leader_worker();<br>
              <br>
                PG_RETURN_VOID();<br>
              }</p>
          </blockquote>
          <p>Giving the patch, where the call to LWLockRelease should be
            before the PG_RETURN_VOID:</p>
          <blockquote>
            <p><span style="font-family:monospace"><span
                  style="color:#000000;background-color:#ffffff;">---
                  code/lwlock.c </span><br>
                +++ /tmp/cocci-output-12611-ff946d-lwlock.c <br>
                @@ -18,6 +18,7 @@ Datum start_worker(PG_FUNCTION_ARGS) {
                <br>
                  apw_start_leader_worker(); <br>
                 <br>
                  PG_RETURN_VOID(); <br>
                +  LWLockRelease(&amp;apw_state-&gt;lock); <br>
                }<br>
              </span></p>
          </blockquote>
          <p>Since this is such a common construct, and you do not want
            to deal with this for every potential case, this seems like
            an obvious case for using an iso-file, so I created one that
            looks like this, with the idea that we support replacing
            "PG_RETURN_VOID()" with just a "return".<br>
          </p>
          <blockquote>
            <p>Statement<br>
              @ pg_return @<br>
              @@<br>
                PG_RETURN_VOID() =&gt; return<br>
            </p>
          </blockquote>
          <p>However, this fails with the following error message:</p>
          <blockquote>
            <p><span style="font-family:monospace"><span
style="font-weight:bold;color:#54ff54;background-color:#ffffff;">mats@abzu</span><span
                  style="color:#000000;background-color:#ffffff;">:</span><span
style="font-weight:bold;color:#5454ff;background-color:#ffffff;">~/lang/cocci/hacks</span><span
                  style="color:#000000;background-color:#ffffff;">$
                  spatch --sp-file lwlock.cocci code/lwlock.c </span><br>
                init_defs_builtins: /usr/lib/coccinelle/standard.h <br>
                iso main: parse error:  <br>
                 File "./postgres.iso", line 4, column 19, charpos = 46
                <br>
                 around = '=&gt;', <br>
                 whole content =   PG_RETURN_VOID() =&gt; return<br>
              </span></p>
          </blockquote>
          <p>Which I suppose mean that there is no support for handling
            anything but standard tokens in an .iso file.</p>
          <p>Have I misunderstood the situation and this is already
            supported in some way?</p>
          <p>Are there any plans that add such support to the ISO
            grammar?</p>
          <p>Best wishes,<br>
            Mats Kindahl, Timescale<br>
          </p>
        </div>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------xN4E7GMboJbLwV4CQlN0mUkN--
