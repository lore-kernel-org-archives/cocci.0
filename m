Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539C2C87FCB
	for <cocci@archiver.kernel.org>; Mon,  4 Aug 2025 10:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=R6z9UD+oSm7qZAFA9rdllapSoLLy+cuVh8Og1vPE+7o=;
  b=YyDtx6o6700HxYhg0AHJ0XJLLHjAYNZ14tROXEUVD+PdhqL4ueHpmts8
   e9IxBuC4wBbt2SKETatecugHgs634PCc7FxBKBNQiZA67FRa2LdyfrtyV
   JgwbdLT2prw4Mi4QDcXHfyHkb0XsCgK8C1Y7+GpbFr4iM/y/WBZydVRe/
   g=;
X-CSE-ConnectionGUID: IyCwifD5TB6BkJV4o7n9/w==
X-CSE-MsgGUID: kowFttsjTjG1uUxMNUIRYw==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="234097856"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Aug 2025 12:55:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 69F45E0B0D; Mon,  4 Aug 2025 12:55:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E4133E0171
	for <cocci@sympa.inria.fr>; Mon,  4 Aug 2025 12:55:37 +0200 (CEST)
X-CSE-ConnectionGUID: pppGJ869RYurA8idX4P0/A==
X-CSE-MsgGUID: 4JJVQvuOQ3urWlCjZ8W5bQ==
IronPort-SDR: 689091a9_eWyga2+ZNOKQeSzZ+BOtPJEsaptoa5juGostMGQ0Roap5NS
 G0160maSEFTbfVB7IfO7KsIp7TYw6r+CFTeKHjQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0ExAAANkZBogAwR49RaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDgQAGVDMEC0mEVYgchzSCIQOEO48RiHmBVYF9Ag8BAwENPREBAgQBAQMEg?=
 =?us-ascii?q?gyCLkYCjBoCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg06R?=
 =?us-ascii?q?AEBAQIBIx0BAREmAQQLCxoCJgICVgYBFAEBgn4BgiEBBhABAw4kBw2ufIEyg?=
 =?us-ascii?q?QGCDAEBBtpeHywiWYFkAwaBGy4BhWyCZAGGJ4NCeicPgVVEgTyDAz6CYQKBY?=
 =?us-ascii?q?INbgmmCJoEWg2ONBYhwUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnfYMNg?=
 =?us-ascii?q?Q6EKCtPgiJ1gXlBGT+DUx4GbQ8GgRUaHi0CAgIFAkNFgWAZBhpAAgELbT03C?=
 =?us-ascii?q?QsbBj2TVYMhCHoTLCIyJ5gTrmKBCjQHgjiBZ4FkDIoulT4GEy+XUg4GkwWZB?=
 =?us-ascii?q?iKNZpNGh3OBaDqBXDMaJIM2TwMZD44hhAAzuzpBNTwCBwEKAQEDCYVGAQGMD?=
 =?us-ascii?q?IFLAQE?=
IronPort-PHdr: A9a23:+8QcxhaCql7zSFqvkCYVbR3/LTFG2YqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1wSPBd6Qsqse07uempujcFJDyK7JiGoFfp1IWk1NouQttCtkLei7TGbWF7rUVRE8B
 9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUhrwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9I
 Ri4owjdrNUajIVtJqos1xfFvGdEduBLzm50OFyfmArx6ci38JN/6Spbpugv99RHUaX0fqQ4S
 aJXATE7OG0r58PlqAfOQxKX6nUTSmsZnQNEDhbK4h/nRpv+vTf0ueR72CmBIM35Vqs0Vii47
 6dqUxDnliEKPCMk/W7Ni8xwiKVboA+9pxF63oXZbp2ZOOZ4c6jAZt4RW3ZPUdhNWCxAGoO8b
 pUAD+wdPeZDsoLxo0ICoQaiCQWwAe/izCJDiH3r0q0gy+kvEg/I0wMuENwTrnrZstv1OqcQX
 u+pw6fF1inDb+pM1Dvh9ITEbBIsrPeRVrxwa8rRzkwvGhvCgFqKs4zlPC6V1v8QuGaU6+pgW
 /ivi28hqwF+vzOiwcAihZPThoIW11DE7j91zokxJd22Uk57YNikEJRLuiCUKYR5WdkuTHx2t
 ysjzLANpJG0cjQQxps92x7fd+KIc5KO4h/7W+icLyl1iG9ldryxiBi//kqtx+zgW8e7zFtHr
 itIn9fDuHwQyhHe69aKRPVh8kqu2juB2A7d5+9KL00qiafWN5gsyaM+mJoUtETMBC72mEPug
 a+Zd0Uk5uio6/n8bbn8upCcMIp0hwfjOaotgsyyGfo0PhUQU2SB5+iwyr/u8VfkTLhIlPE6j
 7fVvIjeKMkUvKK0DRJZ3pwn5hqhFTuqzsoUkWQBIVlYYhyIlZLpNEvLIP3gDfewnVCskDBzy
 vDDOb3hH4nNImLNkbj/Zrlx8VNTxxQrwdBe4ZJbFK0BLertVkPsqtDUFAE1PxK2zur9Fdlw1
 JkSVX+RDqOBNaPdq16I5uYhI+mWY48VvS7wJf8/6P70jn85hEQdcbOm05sTZnC4BPVmI0OWY
 Xf3jNYOD3wFshAjQ+P0kFGCSyJcZ26uX6Ig4TE2EIamAp3NR4+3hLyB2Dy2H5xXZmBDEV+MC
 23ne5+FW/cKciKSI9VuniYKVbi7U4Mhzw2htBfmy7p7KerZ4jEXtZX/29dp5u3ejgoy9DxxD
 8SFyW6BVWB0nmUSRz83xq9zu0J9yk2b3ah+mPNXDcZT6O9RUgcmKZ7cyPR3B87qVgLOYNiJT
 1WoTM++DD8/Qdw928UObFhjG9uhlB7Oxy+qA7gIl7yXHpA1/LzT0GPrK8lg1XnKzLQuj1onQ
 stKLWConqFx+AbNCYDVj0iXkb6merkZ3CHX7meM0XKDsllBXgBoXqvJRWsfZlPYrdnh/E3PU
 6KgB6k/Pgta0c6CJLNFat33glVCQ/fuIMzQbXuplWm/Vl60weaucY7rci051TrUDExMxwIO+
 XePcww3GS6lp0rfCiZvHBTheRWoueJ5o3i6Zk4y1QCDKUN7hJSv/RtAoPWGSO4Ilp8Atj0gr
 To8SHO0xdHLEJytowR7faNTScww6hFL2DSK5ERGIpW8IvU61RYleANtsharjk0vYm0huc0jr
 XdwiRF3NbrdylRKMTWRwZH3PLTTbGj05hGmLaDMiRnFyNjD3KAJ5bwjrkn7+hmzHx8H+m9kz
 sIT/n+S/JTMAyINXJi3XktkvwNiqeTiazImr5jRyWUqNKC1tjHY3Nd8IeI/yQu7OfpbPrmFE
 gDaDMAQQcSje6Qxg1b8SBUCMahJ8bIsecOrc/zTwKmwIONphy6rl0xC551hlF2B/WxwR4Ykx
 r4jxPeVlkuCXjb41hK6t9zv3JpDbncUF3a+zi7tAMhQYLdzdMAFEzXmJcr/3dh4i5P3PhwQv
 Fe+G1ML3tOochuOfhT82wNXz0EevX2gn2Ox0TV1lzgjqqfX0jbJxqzucx8OO2gDQ2cH7x+kB
 IGujM0BGmWsYRIokhSN+kvwgaRW5ex+I2TVXUZUbn3uNWgxGqC0t7eEf4tO8MZy6H8RCr7jJ
 wnFDOen8H54m2v5EmBTxS42bWSvs5T9xVlhjX6FaWx0pzzfcN1xwhHW4JrdQ+RQ13wIXnod6
 3GfC16iMt2u5djRmY3Et7X0cmu7VYBINwTvw5mBsiST+mBgRxGy1aPW+JWvAU0h3Cn32sM/H
 wDBthXhec/G06qgMORoVlZlDhnw5oApf+M22pt1j5YW138Ag5yT9ndSimb/P+JQ3qfmZWYMT
 zoGqzLMyDDsw1YrbneAxoajE26Y3tMkfd6xJGUfxiM66clOTqaS9r1N2yVv8BK0qgfYYP41m
 Tl4q7NmzXcAgPwS/icpwD+cBL86AkRSeyDh3xiF9NGxqqxLaX3nK+HqkhAkwpb4U/fb+ElVQ
 z7hd40nHDNs48kaUhqEy3D15oz+OZHRYd8VqhyIgkLFhulRJog2k6lCji5mNGTh+Hw9nrRi1
 1o0h8785dfBcj8+mcDxSgRVPTD0ec4JrzTkjKIE292Tw5jqBJJqXDMCQJrvS/usVjMUr/Xuc
 QiUQ1he4j+WH6TSGQiH5QJotXXKRtqOPmuUOWJf4NFsXhibK2RAjQpSUDhwzftbXki6gdfsd
 kt0/GVbw1fiqQZXjM9sOQP+VGj3uwqiLDs5Asv6TlIe/kRJ4EHbNtab5+R4EnRD/5GvmweKL
 3SSewVCCWxaElzBHV3oOaOioMXR6+XNTPTrNOPAOP/dzI4WH+fN35+k1ZFquiqBJtnadGc3F
 OU1gwJKD3V+BtifhDgFDSAa3yufasmGuFKs9Cptscml/LL0VQip6YbqafMaOIdq/A2qxK2EK
 uibiWBmJDwe2p5EzC3Nz6UDmVUJgTxqdH/0GLIM7GjGS6e1+OcfBkwebD5vccBT5KUmxk8UM
 MjX05X+0bswmPcxDx0tuUXJvMavaIRKJmi8MAmCH0OXLPGcIjaNxcjrYKS6QLkWjeNOthT2t
 yzJW0nkdi+OkTXkTXXNealFkT2bMRpCuYq8bgclCG7tS8jjYwG6N9k/hCM/wLk9jHfHfWAGN
 j00f0RIp7yWpSRW55c3U3RG9WZgJPKYljyx6u7FNtAJvPEtDik13+NW7XImyqdEuSFJQPsm/
 Uma5tVqolygjqyO0m89CUAI8GwUwtvU+xw4asC7vtFaVH3J/QwA9zCVAhUO/Z5+D8H3/rpXw
 Z7Jnb7yLzFL95TV+9EdDo7aMpHiUjJpPBz3FTrTFAZAQySsMDSVokVHk+yJsFCRoII7rJfEh
 5cEDLNWHg9QdLtSGgF+EdoOLY0iFCsjiqKehdUU6GCWqR7MWINFs5qBWv/YUpCNYH6JyLJDY
 RUP27bxK48eY5b610JVYV5/hI3WGkDUULilRwV+YwVyrEgfqBCWoUUs1kijZg7/uRf79Naxm
 QMqzBRza6Ih+WW0i2o=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3aOpJKr36i8bNoN5xvIZNU0aV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3AUiMJUWp1ZXOMyrENpIbOMU7mUdg9alL/nCmBGX6?=
 =?us-ascii?q?lE085SbGlFWfIv4oxxg=3D=3D?=
X-Talos-MUID: 9a23:BwANSgUPLV5VQGPq/GPOpg9bKtpP2v+zEn8Jupc06/bZPxUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="234097851"
X-MGA-submission: =?us-ascii?q?MDHzjB5avYA1JuCEwfz4Vk1D0gD5coTHKgwYjf?=
 =?us-ascii?q?M91NGSd8o83KaWXHiv0zXHJKmRnlOZeNNiqbrgtd8daUCVHTU1cSl8oi?=
 =?us-ascii?q?X+42g+AR99tu2XmxstKjMnD/Lsr90ncPmSiZ8jp5NmKOCc6U8zJPzhwS?=
 =?us-ascii?q?9lJkRNCWUw026lggS78ZRxBw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 12:55:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754304935; x=1754909735; i=markus.elfring@web.de;
	bh=R6z9UD+oSm7qZAFA9rdllapSoLLy+cuVh8Og1vPE+7o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ar0KMrrs8K6F4jisLO8BG4YJfPbZL+QrXHCsJMpFJkfa12Rux1F0efdBjJpmFkgD
	 2S+x1CCgFH9/vhMPpdSvpVF59xFR0QQjtyQ6klHlWVylLpq/SJKjobOuKPHWM7ze9
	 +8Rv92aR103le0tGVcMj3wbSlquK9X72FgdB05i2hwGI7A3MGRcxjMcNRcnY36/74
	 foXznNrRfiYRDFaXNEk3uiWNIB+4V/a/4IRjOuIGN3DALwqqerE57ii5CtcslRJL8
	 LVujr0tKI1t3yOmKiLXNr41e1xOKq0Nl2QchhDrFfQoyVLPR9N4karVs8YiQN23F6
	 ZhC/ik9ovPUAPOYVOA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6pYS-1uiKcr1dAU-00Fo8K; Mon, 04
 Aug 2025 12:55:35 +0200
Message-ID: <6373a5a7-15b5-473d-a628-c385f12d4e26@web.de>
Date: Mon, 4 Aug 2025 12:55:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
 <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
 <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F/iyXvjD4qFfmTKpR+VfPuEFJCiHmBGtJKmR93GODwM+lo0TniQ
 zcCGEJc5WC0TYa1BBwWbwdykifbyqUFPBqXFTwOdueUslnKhwMdO61RRptIyhLsMCcqoRk0
 C+XVILZ1ucuHtkwQ8wfpgaFxw2UhW95teZU2HUOJP5sjPBo+Tx1CXGln5+jWtN5Rdr48ptE
 9V2ADl4TMriSITo4eCudQ==
UI-OutboundReport: notjunk:1;M01:P0:VbLRGjzAIvE=;BuEHuKM8FQHyyxoI7aP9XMJWLEa
 +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
Subject: Re: [cocci] Searching for questionable call pairs (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2956
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/6373a5a7-15b5-473d-a628-c385f12d4e26%40web.de>

> What is the goal of using <+... ...+> ?  The only way you should have
> multiple releases is if there is a double lock error.  If you want to
> search for double lock errors why do it only in the case where there are
> two locks involved?
>=20
> If you want to check for lock(a) lock(b) unlock(a) unlock(b), there is n=
o
> need for <+... ...+>.  Furthermore, you need to check that there is no
> unlock of a between the lock(a) and lock(b), likewise no unlock(b) betwe=
en
> lock(b) and unlock (a).

Would you get into the mood to clarify data processing challenges better
for another source code search pattern (like the following)?


@mark@
expression x;
@@
 action_lock(x);
 <+... when !=3D action_unlock(x);
       when exists
-action_lock(x);
 ...+>


See also a corresponding source file example once more:
https://github.com/coccinelle/coccinelle/issues/404


Questionable test result (by the software combination =E2=80=9CCoccinelle =
1.3.0=E2=80=9D for example):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
../janitor/show_lock_calls_without_unlock4.cocci test-action_locks-2025072=
5.c
[no diff output]


Regards,
Markus
