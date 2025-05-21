Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887B7C2D0CD
	for <cocci@archiver.kernel.org>; Wed, 21 May 2025 11:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/SCxxqG+tN1UMxZkrYTSiMYvM8SzuSKd9KUcG+3oAx4=;
  b=lFTdZefDeHribVkSFDwMlrRmQLl4H8WxHTFZj2EnaBmLy3gOo67BgwDh
   B61I+vsI8RRCE3wc5aQBjM2/o6hlbKfRB1mwfqxy7CBMpiIGObor3Uex1
   VGipaGIzQE1oI09J7Mk/qBpKbcPKZB7GZQazSnwyxTAB61eI10Q8GKAR0
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.15,303,1739833200"; 
   d="scan'208";a="223169114"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 May 2025 13:57:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 937A5E0AF1; Wed, 21 May 2025 13:57:06 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 08FB2E0131
	for <cocci@sympa.inria.fr>; Wed, 21 May 2025 13:57:03 +0200 (CEST)
IronPort-SDR: 682dbf8e_/eFJ81kOPN0a+PFU3xGRvXHVR/lh0ZPqkldR9l/58PBXztQ
 bT4ci7H9LRe+u/TbZqhdj1eOwIVqYaQMv9orJXA==
X-IPAS-Result: =?us-ascii?q?A0FAAADvvi1og07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDgVgzBAtJhFWPUIZfhzyHU4h3gVWBfg8BAwENTgECBAEBAwQ4B?=
 =?us-ascii?q?oFOgnQCi1ECHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEBIRkHDjuFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAIBAyMdAQERJ?=
 =?us-ascii?q?w8LGgImAgJWBgEUAQGCfoIiFQEDMgeyN4EygQGCDAEBBoJp13UfLCJXgWUJg?=
 =?us-ascii?q?RsuAYVsgmMBhieEPCcPgVVEgRUnC4JHMT6EQ4NbgmmCL4EWQxIrQIFciXyFH?=
 =?us-ascii?q?I0RUnscA1ksAVUTFwsHBYEmEDMDKjQxIw88BS0dgg2CLU+CHYIPcGwDAxYPA?=
 =?us-ascii?q?YMTcRyDQIEjhEorT4MkgQN7TBlBgzZAAgELbT03BgMLGwY9l2GCc4E3PhOCa?=
 =?us-ascii?q?cYrNAeCOIFmgWQMn2cGEy+EBJNGDgaTApkDIoI2pl+BbwsogVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIRmEGsgDQTU8AgcBCgEBAwmFRgEBinaBSwEB?=
IronPort-PHdr: A9a23:B9fVBBz5IZmwC8DXCzIfwFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xeZva0m1weQFcWDsrQY0LCQ6/ihEUU7or+/81k6M6ZwHycfjssXmwFySOWkMmbcaMDQUiohA
 c5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/I
 Ru4oAnLqsUanYRuJ6gtxhfUv3BEf/hayX5yKV+ckRvw+N288IJ//yhVpvks69NOXaLmcqs3S
 rBVEC4oP2cp6sP1qBLNVxGP5nwSUmUXlhpHHQ3I5wzkU5nyryX3qPNz1DGVMsPqQ780Xy+i7
 7pwRx/zlCgHLT85/3rJhcF2kalWvQiupx17w47TfYGVKP9zdb7TcN8GWWZMWNtaWjdfCY2gc
 YQAE+sBPf5Zr4bjoVsOsQC+DhSoCO/21zNEmmP60ag83u88Ew/JwRYgEsoNvnrao9r6OrocX
 +CrwqnGzzrMc/xY1Czh6IjRaB0tve2AUaxyfMfX1EIhFxnFjlKVqYH9OD2azP4Ns2uG7+p7S
 OmhhGonqw9rojiuwMcshZTCi4USxF/e7yV5w5s1JcaiREB0Zd6kHoFQtyCcN4t5Wc4jTX9nt
 z0gxrIbp5G2ZS4Hw4koyBDDcfKIaZSI4g79W+aLJzd1nHNodbCwiRiy70Wuyu3yWtSo3VhEo
 SRJjsXBu38Q2hHT6cWKVvVw8Eig1DuL1g3e7uNJL0A6mKfVNZIvzbA+m54VvE/eHSH2gF37g
 LGLekgm4OSl6frrbq/7qpKYKYN4kAPzP6c2lsG7Duk0KAYDU3WB9em90LDv51D1TbdOg/Awj
 6LUrpTaJdkApq6lHQBVyJst6xe+Dji4yNkUgX8KJ09fdh2dlYjmIVTOLej4Dfihh1Ssly9mx
 /XBPr38HpXBNHbCn6n6crpn9kFT1hI/zdFZ551KFrEMOOz/VlLzudDCDBI1LRa4z/vjBdljz
 I8TW2GCDrecMKzIsF+I4uwvI/OLZI8QoDvzLOIq5+TtjX8kgl8RZ6an3Z8ZaHCiH/RmJUqZb
 GHig9gfCmgGpBcxQ/LyhF2ESjFcf2yyUL4k5jEnFIKmCp/OSp61jLybwCi7BoFWZnxBCl2UD
 3foeJ+LW/IXZyKTPMBhiCcJVLmgS48kzh6urhX1x6BmLurS4C0YtIjs2MJ75+3JjR0y7yB7D
 9yB02GRSGF5hn8HRzgq069joExw0UyD0Kh9g/xAD9Nf/fJJUgEgNZ7d1eN2Ed7yWhiSNuuOH
 WinScmhG3keR9c7wtIUKxJjGt6+iQqF0COvCb4YjZSKAoY1++TSxS61b+F5wniO9KQ7jl8pC
 p9IMWSorqdy7wbXCsjFnhPd362tfq8d9C/L7maKi2SU729CVwsldKzfXm0ELmbSo8744EyKG
 5qnE7c6KU1szcCYK61FQsLkhxNKSaGwa5zlf2utljLoVl6zzbSWYd+vIj1FtM28IE0NkgRJu
 G2DKRB7HCCq5WTXED1pE1vrJULq6+h37n2hHQcv1w/fSUpn2vKu/wINw+SGQqY216gHpTxnh
 jF6Ble70PrJBtDGqwcyNL5Eb4YF6UxcnXncqxQ7O5WhK654gVtLVg1tvF71kThzBJ9Bl8cCs
 34gigZ/euqDyF0UUTSe0NjrP6HPbGn/+Bf6c6nNxlTXy8qb4I8K7+kk7UrutkelGyLO6l1B1
 N9YmzuZ75TOVk8JVI7pF1ww/F58rq3bZS8048XV02dtOO+6qG2K3dVhH+Yjxhu6GrUXeKqZC
 A//FdEbDMmyOaQrnVaudBcNIOFV8uY9Icqnc/KM3KPjMvxnmXqqimFO4YY11UzplWI0b+fS3
 Isehdyc0BGGUTjUk1qr9Mz62MhFaTwUAmuj2H38HocCLqZ2fIsNFSKvO5jtn4o42MSrAi8Cs
 gHzVDZkkIezdBGfbkLwx1hV3EUT+zm8nDegiiZzmHcvp7ae2yrHx6LjcgAGMyhFXjoH7x+kL
 I6qgtQdREXtYRIukU7vwE/gxLVA4ol7IXPSR0hgYCX8aW1vGPjV1PLKc4tU5ZUkvD8CGsG1e
 1OHUfjQpxUA0iXsN3RTznY3env53/ex1ww/g2WbInFpqXPfcswl3hbT6uvXQvtJ1yYHTi114
 dXOLmC1JMLhvdCdlpOZ9/u7S3rkTJpYNy/i0YKHsiK/o2xsGxy22f6pyJXrFg0z0Cmz0NcPN
 22AiR/mYZTwkYm+P/hmeEZAG1L2rcZ3Uo1ziYo/gpgM1GNS3MzKuyVd1z6ia5MEier3dzIVS
 CQOwsLJ7QSAugUrNX+Py4/jFz2czsZne9imczYT0yM54dpNDfTc57hFkC1p51ug+FiIPr4ix
 HFEmKFoty5J5oNB8BAgxSicHL0ISExRPCi20g+N88j7tqJcImCmbbm30kN629GnFrCL5A9GC
 xObMt8vGzF96sJnPRfCynr2v8vBccPTcMlVmxmaiRbGgMBKJZh3mvdA1k8FcSrt+GYozeI2l
 0kk+Jigv5WcbUhp8ri4BBFwKTD/Ic8esGKI7+4WjoOd2IahGY9kEzMAUc7zTP6mJzkVsOzuK
 weEFDBv4mfeA7fUGhWTrVt3t3+aWY7+LGmZfTNKqLcqDAnYPkFUhxoYGSk3joJsXB7/39TvK
 Q9wtDUW+0K+tRZGjO5lfxCtV2DCuEK4ZDAuV5GFIFxJ4wsE60qwU4TW57B2GDxEu5emsQqGJ
 yqEag4OAWxBUx6BAE3/e7K178TE8K7BD+yydr3FZrDry6QWXqWNwo+zl4B99DGWLoPWN39uV
 rsw3U8LS3l9H46xdywnbSsRmmqNaseaoE354ShrtoWl9/+tXgvz5IyJAr8UMNN1+hnwj73Rf
 +iXzD10LzpVzPZujTfB1aQf0VgOiipvayjlELIOsjTIRb7RnakfBgASaid6Ps9Fp6wm2QwFN
 cneg9Lznrl265x9Q09CTkDkk9q1aNYiJmagKBXYCUzNOLnHbTzHzsfrYL+tHL1diOIH0n/48
 T2fEkLlInGCj2yzDk/pbrsK1XDBekMO6+TfOl53BGPuTczrcEi+Od5z13gtxKEsw2nNPigaO
 CR9dEVEqvuR6zlZi7NxAT8kjDItIO+aliKe9+SdJIwRtK4hJy1ulP9Bplk+xaFU6i5sW/F/3
 iff5I0LwRnugqyUxzxrXQAb4C5Mn56OtF5+NL/x855dRTDb8RhL4WjaWHFo75N1T9bova5X0
 N3Gkqn+fSxD/9zj9swZH8HIKciDPRLJ0DLsHyPIShQIR3inODOH76SyuO6f/DuZo8pjwnAJs
 IUDQPlXWQ5tfs4=
IronPort-Data: A9a23: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
 YT5qa2ojq12pY4d3PuMo0JoJSw=
IronPort-HdrOrdr: A9a23:+biMu6l6Jf6djaYfBIlbBcblqgfpDfLy3DAbv31ZSRFFG/Fw5P
 re+MjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNSftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:YaIIY27lHxfLKVwPqtss5WEYBt49aiTn9SnyJ1+9V2hpdYOFVgrF
X-Talos-MUID: 9a23:+MYx5widUQdzMaRByCGSUcMpd98z4fSNCF02jtYcks+ONwFvZRi7g2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,303,1739833200"; 
   d="scan'208";a="223169100"
X-MGA-submission: =?us-ascii?q?MDEo0vzLuJryDvuRydsn8W8eDrPBfggbY4g+FR?=
 =?us-ascii?q?Jlrfp/wBOzbtNwPq/lTj6F0wMsH7twwOejzxgVb2v1qLKrxI46CfcJ77?=
 =?us-ascii?q?QYHSy1AvO5rYUZjs5sdkDHt3dR483jGEsUK0WCLUSF8Hu6TpOYiO4cAE?=
 =?us-ascii?q?0UWdN52hpCqkS+krafsiz4Mw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:57:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747828621; x=1748433421; i=markus.elfring@web.de;
	bh=/SCxxqG+tN1UMxZkrYTSiMYvM8SzuSKd9KUcG+3oAx4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oW8Ma85tESnHrefnOC4a4tq/2B6EFIol8olF5MGlEcxdYdg3veC6ExjVYhiW/4gN
	 qsrpE10tvtTzb+Vt++6u39ZFS5VIsqn364YO3N/1sM0PgDXthh32bTlmiv+cwPrmb
	 XEG6eeRKHxRch7nXZvJQUp1mIufhnw6b5eiI0ffEHIQWC3pa7Od7YkQjEYlcvwGcL
	 rz0Bj1zkS+7oMZ+Cf6LssbNF1j2ONNU0w0OcB2UssldtGhVClMcnhaxby6TJxKUdK
	 m+k/kFy0E35fIhkYta577AmveYtcIUGwhMBwoMqXQxEqVV0JnTpMAVQoZ/sfogudk
	 n+1PnppBJ6rILwuhdg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.179]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7QUJ-1v0Ohs0lY5-0180cA; Wed, 21
 May 2025 13:57:01 +0200
Message-ID: <e552401f-1dfc-4273-9fc1-cecb2c1ba635@web.de>
Date: Wed, 21 May 2025 13:56:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Victor Gambier <victor.gambier@inria.fr>, Olaf Hering <olaf@aepfle.de>,
 cocci@inria.fr
References: <55052f14-dbe4-467c-a7a4-41ce5fc1cc99@web.de>
 <6007e0f7-3d15-4490-a000-b10797c9d579@inria.fr>
 <fdc8e894-1d4c-4d55-bb5d-12cd0fbceac1@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <fdc8e894-1d4c-4d55-bb5d-12cd0fbceac1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Z5VWoEjNxcBI4EduZWu3oToMGB5ylmdK+QPU/EoPw/tvOnR5d2
 pks1/jw6vaAsZMnXpj6raksHPjrfWnQURKPvBblVGz8bpYVszLza/td2AizRv9OA2Mb5FX/
 ofXxMlzBB5z7ufm2hIyke9gERdDyhbQt++Ddrn1YcmuyabPBVLb0/G4Q2cDfdWWoYiYrWT/
 PVEGiEbgWVuj1uhjw4zLQ==
UI-OutboundReport: notjunk:1;M01:P0:16bhzHMKab0=;1E2FbXvyYQiaInQrYbCRtKTVsiy
 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
Subject: Re: [cocci] Reconsider software dependencies for PCRE support (with
 SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2742
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-05/e552401f-1dfc-4273-9fc1-cecb2c1ba635%40web.de>

> * Olaf Hering showed how the PCRE2 support could be activated.

I tried this update approach out.
Unfortunately, I wonder about the following information now.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/20160205> git checkout =
f622b07ade674191e849ff428ff63089498169bc && git checkout master && git pul=
l && git apply =E2=80=A6/Projekte/Coccinelle/my_tweaks6.diff && ./autogen =
&& ./configure
=E2=80=A6
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/20160205> make world
=E2=80=A6
File "globals/regexp_pcre.ml", line 1:
Error: /usr/lib64/ocaml/pcre2/pcre2.cmi
       is not a compiled interface for this version of OCaml.
It seems to be for an older version of OCaml.
make: *** [Makefile:455: globals/regexp_pcre.cmo] Fehler 2


With which delay can the current Coccinelle software be properly built aga=
in?

Regards,
Markus
