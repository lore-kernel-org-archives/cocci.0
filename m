Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C6DC02193
	for <cocci@archiver.kernel.org>; Mon,  3 Feb 2025 07:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=76ak89OEGf6cpJT+ox2q4ztkodd+5nXQpwjXqZ9yOKc=;
  b=FN6Z3IW8spu16hYa5vQVm6bPbvEESJmi1uclk5wZT2qcEGGUjFvOqEgY
   mw+e7uI22fQQw3+OxLTK4uKXRp1qu2Y/XMd9cOCviyXJeiL2MlioiDK1L
   R5HRFeNbQ7XI1stFl82gZp7oOLeho0tcVcW9Kpkfy/iMuhpE+GyeNYJh+
   E=;
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
X-IronPort-AV: E=Sophos;i="6.13,255,1732575600"; 
   d="scan'208";a="206174816"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Feb 2025 08:24:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 33D9BE0D33; Mon,  3 Feb 2025 08:24:32 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9D927E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Feb 2025 08:24:29 +0100 (CET)
IronPort-SDR: 67a06f2c_y5b1UXcR4sjefVjtA/aGacpiJFO7bXBONAMA2LBKuuKkqG5
 wqCvdw/V6xyplkxp45COLc/1oSw1n6cRcwUYB6w==
X-IPAS-Result: =?us-ascii?q?A0HzAADtbaBngwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDYhtaMwQLSAiETogdhzKBdDCEO5gFgVYUgWoPAQMBDT0EAQIEA?=
 =?us-ascii?q?QEDAwE4gVSCdAKKfQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABAQE6Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQINOkQBAQECASMdAQERJgEECwsaAhEVA?=
 =?us-ascii?q?gJWBgESAgEBgn4Bgi8BAw4jBw0GskSBMoEBggwBAQaCaNdzHywiV4FlAwaBG?=
 =?us-ascii?q?i4BhWqCYwGFazuEPCcPgVVEgTwLgkA4PoJhAQOBF0c/gxyCaYIzgQ2CDoEvZ?=
 =?us-ascii?q?4c1hXaCFiV7hUoEEVpsikpSexwDWSwBVRMXCwcFgSlIAyo2MSOBJgU1Cjc6g?=
 =?us-ascii?q?g1pSToCDQI1gh4kWIIrawQFgS2CO4RDXy8DAwMDgzaFXYISgV8DAxYQAYMle?=
 =?us-ascii?q?ByDNh1AAgELbT03CQsbBj2eKj2EZmKCPZZMr040B4I4gWaBYwyKKZUzBhMvl?=
 =?us-ascii?q?0QOBpJ7LodkkGoii2mBeZsqgWc6gVwzGiSDNhM8AxkPjiEZg2EzgQuDVcMIQ?=
 =?us-ascii?q?jUCAQEHMQIHAQoBAQMJhUYBAYppgUsBAQ?=
IronPort-PHdr: A9a23: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
 xRwhgYsOYzFGx/z7l1xKleY/UMN
IronPort-Data: A9a23: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
 Z86eodV312r5w==
IronPort-HdrOrdr: A9a23:idmtjKz8KFikk07SX/MFKrPw+L1zdoMgy1knxilNoNJuA6mlfr
 OV7ZMmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B9eftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIK7voSjjPIceoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:x01N7mBqMRlrxXX6EyJW7XMkFtl9S1r+3SfOHUW/ESE0dZTAHA==
X-Talos-MUID: 9a23:GmySRwqFECrX8U5bT74ezwtbD+dJ4L2LMXAQjLMku+e+KRByOCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,255,1732575600"; 
   d="scan'208";a="107989590"
X-MGA-submission: =?us-ascii?q?MDEG2RZ0LI/t9/jUQqtTOWcN0U5cU6hN1vYXcR?=
 =?us-ascii?q?HyzD1CqEg2PbIfDiAzNMBGzNpmRgMOludmIGqdDeg2yf7aMeqa1Wm0DG?=
 =?us-ascii?q?FP8mZfbq4ahw3afhReoYEwbkjsC+HQQ7EtHa/HktgmsqqHMAMf8Qy3yj?=
 =?us-ascii?q?0rlLnJvRtVDjp8a+1pBCpLxQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 08:24:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738567460; x=1739172260; i=markus.elfring@web.de;
	bh=76ak89OEGf6cpJT+ox2q4ztkodd+5nXQpwjXqZ9yOKc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wdF6T+KCAbAQPHtval/iWwDO33k8/S4h1JYkZkuCvIRGwjbHt4JnkKQi+xGR4+Bw
	 H0BC5+gGoV5Bkygpv1QydzwlAEMqnRTPt5Z3tdA+s/szywNlr8krtmc9bPgqTJL/l
	 m43pM0uYNjr86d6LJoGFn3vRbfVvmmH3UhogIx6YkeHzpIK88ewzM5ltRK0GmHuYz
	 uJ65bY3H4HxJCiICSVN16WeM9AA2cOSDCyj2pE3qtIfe6LG8MfIcoZleKl+Ic730P
	 z8CVRgmJuWNeKZ9UYlho4uzq63KesQSPsgvhMznyhGunfkF9iBghglX/9RlPGodHP
	 saV32DJWQnwT3Ot5pA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.29]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyvBA-1tSHoc1goM-00tLWv; Mon, 03
 Feb 2025 08:24:20 +0100
Message-ID: <80cae791-663c-4589-b67e-d4d1049fcd98@web.de>
Date: Mon, 3 Feb 2025 08:24:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Easwar Hariharan <eahariha@linux.microsoft.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, Ricardo Ribalda
 <ribalda@chromium.org>, Victor Gambier <victor.gambier@inria.fr>
References: <20250128-converge-secs-to-jiffies-part-two-v1-1-9a6ecf0b2308@linux.microsoft.com>
 <565fb1db-3618-4636-8820-1ca77dad07a2@web.de>
 <2402812d-b818-4d1b-9653-767c9cd89dda@linux.microsoft.com>
 <9ca0337d-e378-4de5-99be-1dfa1d4f8cff@web.de>
Content-Language: en-GB
In-Reply-To: <9ca0337d-e378-4de5-99be-1dfa1d4f8cff@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HFy0LVj+DeY80/+bsPHMXBwLtRD+7CynvELc3D19FkeUZr+iQwn
 tQDzZFV/qBLLeet8ApiuPh0I0fDpfZYd7gmj26W2keHKbLVpFDZRGgRPrOcXEbVUrR+hUaV
 oddoLg2mxi2s/7bATo0/je8bYMTNkYAP2FlDbhSr3XDhlVQaXki0I64NZVmAvG90SGe6I1f
 S9Rwr0P4NtnFwriJhZI6w==
UI-OutboundReport: notjunk:1;M01:P0:G8MfkOHipCo=;iGUbWBarwetgRpfOnz+/TFA0Ypd
 0XD5yRGwm0/UY0h0Nm/X3ZYENbJS7LSO33rohKyPfAO2kizP7kWsiwuBCcqY/DB3Q1yGiA1FQ
 BKl+aWQhhInChLUFyPTwYiHRiO94ip3qo8fW10x/8QZLXRr9tHpNlErB31KGh5UJSJZ43KLmj
 I1C31EUGLVjPS+TZvtuTGYlz5qs66MXi6YtFGxtx9nUcnkBfJwerFcuU5MVOv0jX6UF4+Uj1F
 akR9+Rx617/fs7OVZxKDVO5k9XaH4s6tc/DPle4YR7Q3gAXXaczPSrAHXBpxe59yhl+LMw1zB
 +dJT4d8k5ZOfyi7q2gXgnABMSg+kOGQ2yRxNcoUO5n/a6Rdwvb402lx2MtgKmpQSTnOrTZBR4
 Ubit4jhFfXZjti1SdUG4kznuyUMYdfkvj7j+/cQLIvueqqNn5F1Ys/y6YPMTX6FXjo9WqXfqx
 tu+LjNX2RmN/JXYuojAfMt1/04jvhto6ILRzl9pDX7NoKKl0XP08Fk5gCOMi22fGANLTI7IrB
 JAN6DSyJuOWTT9G4KFZh9E9Vhrz4zkLOB0lek7TeRP3Qc+SQ2hxqPQUPQqFTxw4Uk/MoAJouY
 DaZxxDcKU392sTybh2+XInX100H+Nz53n623w/zsNBnrYmVFxa4N/888+K/+RcR9tyZNeYKXI
 1EJpisfhSsCDRbtNHQGC5jJB6+Y9DbqHu0A79DdMGtxsDxNSQumRxHjHKWsNHR/IP9ThQSUKx
 8nSF2uI8GlAq0lyiAaoWdAJ06rw/k18y46WtCIMnIjY3csQhu7gI5NSd8wwzoHggDOaV1MWjB
 6DlRvlA+Q3xABi+P0OBjb6PpeOaa1+O5ErlPdMon+EjrMGrKbifSKtuGLK4zY+R0gYcESqyt5
 f6MVEp0wc+TZ5+kpGiR6v/Nn3uVhwbHqvxY/jC2xch5gdHYCm4/etXFB9hH4jLDUdLJruyeVI
 wE8dOt6lU6aqFVNHawdSY+CAavWhHR9UJl1fdS47fxgPgufgmd9C+zWucTgaqh6gQYrzqc7iJ
 5k8DtYILabEtOz/ti9dZ0bjIIf63hRJcGFNJchvS40OXTOTi8laX4Yuf08eumLdED6YbmBxwZ
 26Z7uguC35MwXolazAGIVBsKcJ76opr1efjAQX2EGFAxkKlkwmbxkCluc92A1cSYDbMRcdzgB
 MQXXbcE9pBEaJoDOXKpacJz/bk1jWzRWRqhgT9v64/Qfo2yh2CdREzHm8fOKSA57bVvqPTr5r
 p9kdhdVkthhsQXH5fnlC7H97kktZAmfsufNVi5hwJOwe7uiZmq2svb7N5axKqK9TZ/tuvtgMj
 yhCyDwM4MHUSvb+52uC9su3dh5gWjcqr4q5HjWupqNX0r/sZCciDk+7S1h0zV8FYCLT
Subject: Re: [cocci] [01/16] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2329
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/80cae791-663c-4589-b67e-d4d1049fcd98%40web.de>

> I tend also to present possibilities for succinct SmPL code.
> Unfortunately, software dependencies can trigger corresponding target co=
nflicts.

@adjustment@
expression e;
@@
-msecs_to_jiffies
+secs_to_jiffies
 (
(
-e * 1000
|
-e * MSEC_PER_SEC
)
+e
 )


A command (like the following) can indicate how isomorphisms are applied
for the transformation of some data into SmPL disjunctions.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/bd08cad3f802229dc629a=
13eefef2018c620e905/standard.iso#L252-257

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --parse-c=
occi suggestion3_for_Easwar_Hariharan-20250128.cocci
=E2=80=A6
@adjustment@
expression e;
@@


(
-msecs_to_jiffies
  >>> secs_to_jiffies
(-e -* -1000
  <<< e
)
|
-msecs_to_jiffies
  >>> secs_to_jiffies
(-1000 -* -e
  <<< e
)
|
-msecs_to_jiffies
  >>> secs_to_jiffies
(-e -* -MSEC_PER_SEC
  <<< e
)
|
-msecs_to_jiffies
  >>> secs_to_jiffies
(-MSEC_PER_SEC -* -e
  <<< e
)
)


Grep query
msecs_to_jiffies



I find parts of such a data representation improvable.
I would usually expect here that parentheses for the selection of call par=
ameters
will not appear in the first text column
(so that confusion will be avoided for the usage of delimiters according t=
o SmPL disjunctions).



The isomorphism specifications represent also a software development statu=
s.
It seems that they do not contain direct support for SmPL disjunctions so =
far
(as an explicit entity).



The identifier =E2=80=9CHZ=E2=80=9D is used by the referenced macro.
https://elixir.bootlin.com/linux/v6.13/source/include/linux/jiffies.h#L530=
-L540
https://lore.kernel.org/linux-kernel/173831299312.31546.879788998548796583=
0.tip-bot2@tip-bot2/

Is there a need to take further (preprocessor symbol) variations better in=
to account?



How do you think about the handling of multiplication factors within bigge=
r expressions
(and not only at the beginning or end of a term)?



Would you be looking for further restrictions on expression combinations?

Regards,
Markus
