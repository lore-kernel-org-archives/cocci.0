Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE99C5ACB3
	for <cocci@archiver.kernel.org>; Tue, 21 Nov 2023 08:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Jbjya/e8CHNHxtTUTWdMt8aiivKlM/2lGTXmM50uK3c=;
  b=hgO3yy2AGiDJcoU+4lrrk8PexjCiYTx7TxWCBrjAwVOpw565if0PiyDE
   XraTKNz4qNds1zliZ3a9S4VipsY2BQq5QlrbuuegC7nxwuX80b8kyglvB
   Sc6YEs5jme5EcP/CO5k+8cVV9o3hNI2wpfbtHVyhSGnz9fTqhJOWj0/tE
   U=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,215,1695679200"; 
   d="scan'208";a="137540324"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Nov 2023 09:52:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9229DE0AF1; Tue, 21 Nov 2023 09:52:08 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A80E1E004E
	for <cocci@sympa.inria.fr>; Tue, 21 Nov 2023 09:52:06 +0100 (CET)
IronPort-SDR: 655c6fb6_bc75eR2qHAv1EvRmLWDNWYcxlU9h2CE+PY5QehvipLIaXSe
 t996NMjiwyPjtJbY1w9ln3vbdOSuqRrAEQzKdVA==
X-IPAS-Result: =?us-ascii?q?A0F4BADablxl/w4P49RaHgEBCxIMQIFEC4I5B4FJMAQLS?=
 =?us-ascii?q?IRTjz2BdTCEO4c0h0qIb4FWgUA+DwEDAQ1BAQIEAQEDBIR/AocpAh4HAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECgQYThWgNglUYgQyBH?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBARcCR0IBBAEjHQEBESYBBAsLGgImAgJXBgEUA?=
 =?us-ascii?q?QGCfIIqAQMOIwetMoEygQGCCQEBBq9VHywiVoFfCYEaLogNAYVZgzt6Jw+BV?=
 =?us-ascii?q?USBFSeDAz6EQ4NbgmiJJAeGJY5RXSIFQnAbAwcDfw8rBwQwGwcGCRQYFSMGU?=
 =?us-ascii?q?QQoIQkTEj4EgWCBUQqBAj8PDhGCPSs2NhlIgl4VDDQERnYQKgQUF4ESBGobE?=
 =?us-ascii?q?h43ERIFEg0DCHQdAhEjPAMFAwQzChINCyEFVgNFBkkLAwIaBQMDBIE2BQ0eA?=
 =?us-ascii?q?hAaBgwnAwMSTQIQFAM7AwMGAwsxAzBVRAxQA24fNgk8DwwfAhseDSclAjJCA?=
 =?us-ascii?q?xEFEgIWAyQWBDYRCQsrAy8GOAITBwQOAxkrHUACAQttPTUGAwsbBj4CJ6Zbl?=
 =?us-ascii?q?l+uSjQHgjGBX4FgDJ8jBhMvlyIOBpJPmEAgon+FNYFjPYFZMxokgzZPAxkPj?=
 =?us-ascii?q?iCEK49HQDU7AgcBCgEBAwmFRgEBg1qBQAEB?=
IronPort-PHdr: A9a23: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
 J7DmfCqQN+j29fT4NdaGMXebs6KYiJJDA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:44jIoaoHUQ4EsoitiQzOLe4aV5r/eYIsimQD101hICG9vPbo8v
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadD/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3A+fSNkWjG106cTHB4hfTFkIUlQzJuIyXU6lnsMW+?=
 =?us-ascii?q?ETntLS6CUTgLA3r1fnJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AlTReBQw5Zs/6mcDOkHBEmAlES96aqPnyUV1dwMl?=
 =?us-ascii?q?cgcaNDSUuAj3MqmzsQqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,215,1695679200"; 
   d="scan'208";a="137540307"
X-MGA-submission: =?us-ascii?q?MDH2eKTzDsdMBzFk3Li+zF/4FPumVMOCDptqr4?=
 =?us-ascii?q?Q2jg5X1EgZpIZclmoaTcuDb0ADMA0FMpxaYXGyqt1NOHfdsi/Xp7yJFr?=
 =?us-ascii?q?saY8/M0QHFv5uLwcYWkPIIwg+yCLiJDoPQOKycquMIm72BjIEsgKwUNA?=
 =?us-ascii?q?1k9Mfw05XD5OF03aem6YbqyQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:52:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700556716; x=1701161516; i=markus.elfring@web.de;
	bh=w1nXVLBpNtN58NGTg1Hi1tEZ2hWuodlftXNjiZP5OF4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=mqSzAdvbebRDgbZ5hogWE9yDICGyuFuQ4pXTqbv+efecXKaHmPfv3uCe5eDNSBnS
	 +W1qKYhemzAjqQPouxrz++zAVHeeTIlEOGU2vpHtsx9PZ+UTxnnxyE+442q1/x16m
	 dyWHG/bQ+X7Vd/C+gjEPNP9D11BPoQ9UVW1wd7J+f8Nggm61xCUl0eiSf72HfUAk1
	 GEekjf77TwJiKgwrWQKvgfrFu2CdUIlInMm/CGuOnIl3ICh6LN0oUfLlkrHIwaO3b
	 jiySzpNc2BtG4zHcR/8MiuwfppSYGsd3SBc/NFiM3Ei1tiKfZVijV3ELVNWBRGmqX
	 Q9GvJPWYf0llj2zf4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjgXH-1rm4gK3yaR-00l9g4; Tue, 21
 Nov 2023 09:51:55 +0100
Message-ID: <bd627a83-9c9e-451c-a3d6-84e90d40dadd@web.de>
Date: Tue, 21 Nov 2023 09:51:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 kernel@pengutronix.de, kernel-janitors@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Amit Dhingra <mechanicalamit@gmail.com>
References: <20231105143932.3722920-2-u.kleine-koenig@pengutronix.de>
 <233689d7-9409-406b-9383-49f10cd29336@web.de>
 <CAO=gReGA17gHSr4ftN1Jwrjt5t76oAgaL6+n6X4wD0osJnuq4g@mail.gmail.com>
 <53db2c8f-7b9b-47f7-89ba-d78584c12d7b@web.de>
 <20231121075716.it3cpwhwymkaqjrh@pengutronix.de>
 <3e4c0c06-9681-43df-be12-b2bbc599fdfb@web.de>
 <20231121083246.wg5qtej6cll3snlg@pengutronix.de>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231121083246.wg5qtej6cll3snlg@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6OEugY/ccCMmSnnu1bYO8xVAfnx6gvIBwDrAqb+qR3qedlB/UHI
 /qBKpNxD3e41NeMDkVerg5jTnJPv4zydPwmn1FGlK9P1HgQsXUCU4/VoxAz54Qpkg9Of3Cm
 24ScyeUL3M9carLfB3gkonoko1vbh2pqsC/U6HUbHp9r4wYuo7cz6R6SEvQceR8OYLoImGv
 MWnkPorK676dMX5TTk8xg==
UI-OutboundReport: notjunk:1;M01:P0:OlBcnwh/aaI=;AiaBSDMaGWuUA6LKuDWeuGQF1Es
 W5Sx+PzOiMWNrXpJSRjdvuRxrGCMvk3h0K/R02Mn3vtHTyGZEIOw27SyUlzeIPwEa8irDGdwo
 qYsT0zhfnEPHpQcx6FQXtWOShKiwmgrvH/NQnHwi69Ivm9oQuInyQMI33OxxMDG7ynly4qH7Y
 tLURTKWmYXWU0ZF0ZjMwxYWdMfdxSA1PtlurcN2Mye9Ei4dkkFXnEqtgnszmSiRM/vzE8JKWB
 CJHlIxikArJg8GDgz8TB60+bO1NgsSzaAdlxwq5mc64+S3pDGTsrWwVyDNPlX5StjMmaIfnab
 MO5/ICB5e1hlTnk5gY/iGzOq3nAWl1wYbfq0fw0kqwVkdLSzcwal4tCv2inhnFl02fAchi8WS
 M3iyIoh6xKLltPStRCzbqTt+6zTixgFF30YkHfC6rtCVZAvTL48ACHwbKTfHJbInQq+4X2kuD
 6w373WtDCmxuwnNFK60Aqjq6X08uYEiLXGm4q13hlWg/Rs1dCF26LeRdpDupfKyzPoEqzuLUt
 Li5H44Yc+WCWd99Gtb77fFy6j0/DmfWt9AszVL2wWxGhiOVJD+dD/6bdsdlDl0aA0vNnEdaLa
 DrBnkqNcZmlYIG4PjC/kPI4fQmc/YGju5t4lBs1v1/U0YEcxLWoQW8eN+h5vxHsOj46kmOSeT
 nossqaQOTa2nfTaFCg+6tmOV+6gsboy2xkQAr93ieY1xRnIkwG2pX2jU/csF6g7HPmocvpTk9
 BQcDJGP3yGdQrmaaGmDxJsKTBRTP9tMhVN1CFMCMOHkuSiGyWTNBgB/eyYWX3yOfcgo0Ktari
 ivBxx3lOSL9D8JR9giWJGVCmbDEHp47xnLA+5tECvnlDDvcGDuSOLlvo2erfA10IUMY5/UV5V
 dTUBjeauZ/gbtV1IuDj0VtFWz/mP9Tyvb2kgxx5WXBe5HigmxJXGUYUHMzqt0n2s5AnnVKPwZ
 IhSYUQ==
Subject: Re: [cocci] spi: cadence-xspi: Drop useless assignment to NULL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1300
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/bd627a83-9c9e-451c-a3d6-84e90d40dadd%40web.de>

>>>>>>> Static structs are initialized with zeros for unspecified fields.
>>>>>>> So there is no advantage to explicitly initialize .remove with NUL=
L
>>>>>>> and the assignment can be dropped without side effects.
=E2=80=A6
>  static const struct samsung_pwm_variant s5pc100_variant =3D {
>  	.bits		=3D 32,
> -	.div_base	=3D 0,
>  	.has_tint_cstat	=3D true,
>  	.tclk_mask	=3D BIT(5),
>  };
>
> If I saw the resulting code, I'd wonder about the missing assignments
> in these three structs.

How would you get doubts here if you can depend on the well defined initia=
lisation
for unspecified members of static data structure variables?


> So IMHO the status quo is better even though it is more verbose.

Are any design conflicts involved here?

Will the Linux coding style evolve accordingly?

Regards,
Markus
