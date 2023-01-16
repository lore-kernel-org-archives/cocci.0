Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91204C54EBE
	for <cocci@archiver.kernel.org>; Mon, 16 Jan 2023 11:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=8WlTAFNVEZfKU/iCIzHbew+QiKEZokUs+lLx0YJK/g0=;
  b=kLYeEsf7Y5EPeV1oPbn2vrW5ahWW7bL4VHFgjhH3PjJt2wdKHjA2+J3M
   IphWzi1Q6zKroIoe/cmu4gmHTu+6XDMCg7WTBnE1SKtKCKHH1qwZlw5Nb
   9iHQIeyY6IBCrppI6Mj9GIhwy+G/f9LdV6sPLQiWJ/DwNa4A1hj429eD6
   k=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.97,220,1669071600"; 
   d="scan'208";a="87802061"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jan 2023 12:37:35 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7E669E0386; Mon, 16 Jan 2023 12:37:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D992FE016E
	for <cocci@sympa.inria.fr>; Mon, 16 Jan 2023 12:37:36 +0100 (CET)
IronPort-SDR: 63c53700_+WzvbLhsZBjKnlcQRTlzqzUayopNaXPopD+9wLs3qFQ6AV8
 VXA+7VyY+Z7nWh3vGpsDkA0+9zU4XyFMOLUKJww==
X-IPAS-Result: =?us-ascii?q?A0GVFwD9NcVjh07ASNlaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?VGBQwIBAQFjgQdWLgQLRYRPkHGEXI5YiGSDFj4PAQMBDRQBASUGAQIEAQEDB?=
 =?us-ascii?q?IIMiAwCHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQA?=
 =?us-ascii?q?QEBGAsXBw4QBSKFaA2COCIZZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESA?=
 =?us-ascii?q?g06GDtmHQEBESc0AiYCbAgBAYJ6AYJtAQMxBwytEoEygQGCCAEBBoJjmSYfL?=
 =?us-ascii?q?CJTgV4DBoEUKgIBAQEBAYc0HliJGRCBVUSBPIYMFwOCLIMKgmePc4oGbIE9f?=
 =?us-ascii?q?IEnDoFIgS8lBA4DGSsdQAIBC20KQDUJDUorGhsHgQoqKBUDBAQDAgYTAyACD?=
 =?us-ascii?q?SgxFAQpEw0nJmsJAgMhZgMDBCgtCSAfByYkPAdWNwUDAg8fNwYDCQMCIU5wA?=
 =?us-ascii?q?i4REwUDCxUqRwQINgUGURICCA8SDyxDDkI3NhMGgQYLDhMDUIFPBIENfwpXn?=
 =?us-ascii?q?DmDGhMqApU8r3Q0B4IjgVAFgUwMiFuBIpR5BhMulnsOBpIbl0uNTJR/hUGBe?=
 =?us-ascii?q?SOBXDMaJIM2TwMZD445hAyEYYVLQDQCAQE3AgcBCgEBAwmFRwEBhloBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 w0hoIfv5esRkNiEndjBDAzfYzqi
IronPort-HdrOrdr: A9a23:GEYC/q86/UOcR0F+S1Juk+D6I+orL9Y04lQ7vn2ZOiYlEfBw8P
 re+8jztCWE7Ar5PUtKpTnuAsa9qB/nhPxICOoqU4tKPjOLhILAFugLgLcKqAeQfhEWmNQ86Y
 5dU+xZFMD6C0R8gP33+Q+iDr8bsaG6GeyT5Ns31B1WPGdXgkxbnn5E4o33KCdLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,220,1669071600"; 
   d="scan'208";a="45153187"
X-MGA-submission: =?us-ascii?q?MDG1VPoM67qbA6OI9unERxntrMtq2VePMIfAej?=
 =?us-ascii?q?9N1EUVf/GOQHBzTitP0Wt8kuvyXvBJ6Es0/07o5LApZJJ6nLNQuAB/v8?=
 =?us-ascii?q?+6mMefp9q6a0eZgYSCcoyAEK/Er54lOn33cpHtdaLhpMPNS09/gmeiGD?=
 =?us-ascii?q?3v3mP9vxCQk4odyTuUKQcYmQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 12:37:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1673869055; bh=8WlTAFNVEZfKU/iCIzHbew+QiKEZokUs+lLx0YJK/g0=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=aXSVuwAH+zo3Qb3LM/nH28xADYK54WqU8VslXaMEm4OUPoT4JNm7NUTX1hzRl8vnp
	 +p6YjnqdLGsuqjHM27MX0DUAqctXa+o17u9KAHrgITreiyJyv0Sku6eMdY5rGqOECy
	 2SaPVxxRFLTNR+wgbAgYIHtvDVIL8niG5EOIyrME64l4uc6Aaz1SOsuK+HHqokKTDu
	 K5aFUpx+mYbqZfLDdq5n0Q4Y1GJHEBrGvzbwEzKM+cAvuHoPdzfY8UY2du7Wv5bTdo
	 YFNpGhPnCRqKm9dgmAYly+7C5I1vLNxBmhBMMDdc7oXPx3/BGDoNObzpJxlOeOFMDb
	 BWPLjEnHRAiNA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5CUp-1oYB8E0Ygn-010xcM for
 <cocci@inria.fr>; Mon, 16 Jan 2023 12:37:35 +0100
Message-ID: <cd35c301-c1fc-80d2-c3b4-bf37a5dca522@web.de>
Date: Mon, 16 Jan 2023 12:37:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XbAKXjGucEpsLjMECxQyIJLLObn11KNfZ7hyquQjHy/3JQwgsBp
 MNtsLESRW686M6MkVg/U+K1FLVNkiHoWmzIug9c6xeRwsBKOCuqutAoSyx42lBw3k3FgKu5
 JCSM2Pucx8PF26FjutSI28ETwIfhSd1T9DScWlknQJXlT8wRijTpXaf2odDqb9k/jN4y4zh
 XJSTjmQ0J2ARmgM9AgwEA==
UI-OutboundReport: notjunk:1;M01:P0:23YcilKmGws=;ll06+YxzoHnswSaYrZwRTn8ogTz
 MqszXVfRrx8R1uDwVs30MTtSwLupK4gWypvQYrtIsSmuxnHnhuia9dN5TvBhDKZqZbgzxPF/4
 rcdYsqi1RnN+KnEq43krqnxJYCNSneho/xsiFLscSdB4ME60zfKRolu8zkrdxSFXniLjuFebz
 V0Xq0j67mm9bHgMxo970gVky4TmWm6hl2S8Mhh0OLxKR4k8VADtCpCtLdT0re4Agq2bZu/jo0
 xbjal893HSanCxugEa2P+OnWs82a+EoUAkTcKAOuGxmNZmQmTQtWiMyb3W4vJByFRzu+84rB3
 NyoF5Oo+BClRIhKZhxFsxVYrUo2s11+IJidN0q/ml+nooaAEBbPpuTf+qKYcRF1hdVnGeqAHF
 U3FCPYqrualy8qlpe0ULnnOIWqvPLLjG7A0ihILwKsUVxPm41PhGI+X3H6jLsoTf/k3FhuiC1
 71n9qAP7IO5s1Ukhfn8LWac0xbXFUNYGUL148zx5wEjVWZIL5QmJeD0V+flTknHSjaL5RvlDq
 Wva+TEnTNNXVR7Uh210zLuJOKk1fzXHRTFRZsF0DTBGr22tD0e9hQU588vqH34sieh/XWTg/D
 bpFph0v3zKuH9Em64beG1HTiJKTfbBn2gR2HJA5F5xRxjo5U0BAGa5yvqc3yx6xJd6vSacuGY
 htMIpt5mYk+n5QihunjIfTP7b1APag5+BHP6WDejlOOSsfBei5psQAT6lqKdZ8ZHeby21XEpw
 LFwxYH3NOGWACXy4KEB2wLFwMmT43z852TwtgpYHakTUpD3sV96wUnUiUc4+DgmoXxGGytKnl
 /7zqcXkmjetv0HuPXhVVqtjqTa+K5eoti+Xn8FcFhzZC23TkDGiUFQ24EN5ZqwZ2KACIEixh1
 /VOu2KLmgENOvL9VfzPgZjdJPmwRgmgvK+FrS13R2f7HVwJawQU3iyTex+oF72skLAQAE0Zqs
 OB+0aF8dTBOJrq4oVmdn9RM7vRE=
Subject: [cocci] Adding function attributes with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 813
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/cd35c301-c1fc-80d2-c3b4-bf37a5dca522%40web.de>

Hello,

I would occasionally like to adjust function attributes.
https://gcc.gnu.org/onlinedocs/gcc-12.2.0/gcc/Common-Function-Attributes.h=
tml

Thus I have tried another tiny script variant out for the semantic patch l=
anguage
(according to the software combination =E2=80=9CCoccinelle 1.1.1=E2=80=9D)=
.


@addition@
@@
=C2=A0int must_be_checked(...)
+__attribute__ ((warn_unused_result))
=C2=A0;


Unfortunately, I stumbled on the following display.


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --parse-c=
occi add_warn_unused_result1.cocci
=E2=80=A6
plus: parse error:
=C2=A0 File "add_warn_unused_result1.cocci", line 4, column 1, charpos =3D=
 41
=C2=A0 around =3D '__attribute__',
=C2=A0 whole content =3D +__attribute__ ((warn_unused_result))


Can the software tool be extended accordingly?

Regards,
Markus

