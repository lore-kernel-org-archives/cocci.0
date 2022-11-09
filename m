Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11E3C4332F
	for <cocci@archiver.kernel.org>; Wed,  9 Nov 2022 20:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=euISB1EFKgeLVrdl/PTmG21g2PI4TU1Pm+3EUo1o27o=;
  b=Mq+4hd2VyqZwdOvUzCO/snhWuGBT0EvqBjCiJNCJzbO1vdzlVr1loPxk
   dtiM24sHI/e//h0ML0ImPDsX/26KFJOcyJ58hVgW2iqsqX9W7fLCzZ4nB
   68fZ4cZWnmWarymSVtEee01SUEEMnzMwjQqTJgDq2WQyKZNoBCnvEGsre
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,151,1665439200"; 
   d="scan'208";a="77534672"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Nov 2022 21:21:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8514AE0092; Wed,  9 Nov 2022 21:21:55 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D628DE0092
	for <cocci@sympa.inria.fr>; Wed,  9 Nov 2022 21:21:53 +0100 (CET)
IronPort-SDR: 636c0be1_afmwXdGtYlID1ywyW8jgOoOiYxSh/CCv8MurIy8ECBGhx8b
 B3X2TU3qs38II2XfRa9KKXmmBLvtfJ1NHfM3W1g==
X-IPAS-Result: =?us-ascii?q?A0F4CQBPC2xjhwwR49RaHgEBCxIMQIFEC4ItgQIDUy4EC?=
 =?us-ascii?q?0WET451gXcxhCmOTYhggxY+DwEDAQ05CAECBAEBAwSCC4JzAoR7Ah0HAQQzB?=
 =?us-ascii?q?g4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEZCRcHDhAFI?=
 =?us-ascii?q?oVoDYI1IhljUzUBAQEBAQEBAQEBAQEBAQEBAQEBFgINOhg7LAECAgEjHQEBE?=
 =?us-ascii?q?ScECwkCDgwCJgICVwYBDAgBAYJ5AYJtAQMNIwcMj2qcF4EygQGCCAEBBpwGH?=
 =?us-ascii?q?ywiU4FeAwaBFCwBjFuEMCcQgVVEgTyBFYE+MD6CYgKBYINXgmeMPIJAiFomB?=
 =?us-ascii?q?A4DGSsdQAIBC20DCkkbMScOCR8cCgQXDQUGEgMgbgUKNw8oL2crHBsHgQwqK?=
 =?us-ascii?q?BUDBAQDAgYTAyICDSkxFAQpEw0rJ28JAgMiZQUDAwQoLAMJIR8HFhEkPAdXO?=
 =?us-ascii?q?gEEAwIQIjoGAwkDAiRVcwIvERUFAw0XJQgFTQQIOQUGUhICChEDEg8GJkcOS?=
 =?us-ascii?q?j45FgYneA4OFANegWsENWeaEIMqLMR1NAeCHoFMgU0MiXSUcgYTLpZtDgaSF?=
 =?us-ascii?q?JcyII0jlH6FN4F4JIFcMxokgzZPAxkPjiAMDQmDUDOKLEA0OwIHAQoBAQMJh?=
 =?us-ascii?q?UcBAYUcAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:6iQYXKloAhtEYESe8J4iBbMK3dDpDfLy3DAbv31ZSRFFG/Fw5P
 re/8jzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,151,1665439200"; 
   d="scan'208";a="77534669"
X-MGA-submission: =?us-ascii?q?MDGwAYz2YX3Mwd1hd1ToVDp7sDQpxqXA1K9yt1?=
 =?us-ascii?q?MOnj7PORQIcLtAeVxr+e1hJUbcXiBMwUXuu8a5mcmrIvwFuDxNyDXYVA?=
 =?us-ascii?q?39JDORCBfXyN18jdOz8/p+jbF3DxBjicuwvclx6UDCZxnBFhNdXvcIxO?=
 =?us-ascii?q?JaCIPoD/O5Kt9AZWp7iOePyQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 21:21:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668025312; bh=euISB1EFKgeLVrdl/PTmG21g2PI4TU1Pm+3EUo1o27o=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=EmpPQyhUygCgWiCC4nQFBwizMVrhorbg8sCAK25F93u+QvyfpQ3pJhV/hYLrWfsB6
	 9FWCaHOeIPPPaL2qbivCDoD6Se8REw4njme6Ed5tW1f5QJTq5Szhj34MYhINkGnOS5
	 znlKrUZTPUBQItZ1zSECEUjFzhAB8fpamrIulltwXruIt91mo1dSMXzMVaK0ACYduc
	 PSrluqnV9MUUAghBTLPRjbpbigW+wYHE3AHM0mBlnexIqIDzX0AS83jbjVAAlGwLQP
	 xApJoYJgp/dr4aWaeF7EgkMi1SPUvpl2ylxUOqCsh8bHhH8lFhIAXLtZcGhPJhHSH5
	 X70zRGTAufWVg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N943B-1p62sR1eUR-0161mQ; Wed, 09
 Nov 2022 21:21:52 +0100
Message-ID: <516d8b97-907f-5a7b-41af-ff162ffe7316@web.de>
Date: Wed, 9 Nov 2022 21:21:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-GB
To: Elia Pinto <gitter.spiros@gmail.com>, cocci@inria.fr
References: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QfemGpDs8QrFuYt8DbInu3i3tjsDzZjL0Fq5p+Orow7JBf0nneC
 CwprIrb3BZUb87E9/mqcMMyk70z4WFNYSXQTuZfgMR3dcMVgn6Fqv9uyiN30dFFq8qmuNQR
 ifuF4fwQ8rJY0QByBuD2UgtWeFzEqfpzr8H4qVS63YOl6Nl40B1zTQlE3gi63GmeMHEQdad
 JOiGS8h8c6zOFWU52qklg==
UI-OutboundReport: notjunk:1;M01:P0:paWSuHlioAo=;UESwjTbDmD3xoEwSrWCzXKdcQE4
 oWpAncZCVPW35o4xOinb62tTM3TDJJqmbuguAEzc4mdbY55uTOBELFDJ2mamnd3MRf4Us4mBK
 lY2uIHxZYToL38TSaDqOXUsP9D2cpCYwN3/Uvj7r5Hf595DNaGfJmC+PnIGAgiHz12jX4DCKk
 SJwB1qVNI1odTyBXAvSTho5XglrR9RKB0D1yUzAha4Icrm3BiK8z9CWZUjcv8tGk75pY+5E3E
 2W7Ww+zMPCmCmRZsfu6XGBjrKNQ+I1kzQ7GQKozSKh6p6lu/SOP8SO6C5V015cOCvLOS7Tfyi
 ioQk0ihHzcOqCP9tuX/3mX0AOeqV0OzgFu6SLSd05gW2UkP5ThxQU+vnziNj0yVKpQMO2OzBN
 gObKB1nMxXheaQ7iBBuQKAFm5IytHHX8IbRc/35vwISOz5X6tpp2vu1W09ft5AYtkaqSl3FYg
 ABmcWod/DxO4h4seOO6Ygtogk1AD0sGoV67Su/S97Y8fmXJExtRRlnKiqnfbylgUaa+ijrgYY
 /b1YmbhDKFn8dChQ28SbKLPpabblicxHyqTyaRhs8KNNAMGcoMhNkZ0l8tRS4gYIF75UypOEg
 gHy7YIo95+F8Y7CCdoc79Q5aphxb02zHs2DsEUfD/50VV0zWdxF3ij92oGq7AtDvc6scwm5Dg
 1vXrdmUEJ+JK0g0/Qfr1hKe0Tx8am/3UlmbMg8upNrSD07hg1idRbFPxwvQSrBTdh31scdwKo
 o2Us/kp+rZl/RQI4vb2OQQfLaTBvnH2icU9w4aBie6PbEpPwKWu/ElHefh5mj6X1ijMQCJnyA
 +mMfew981zP+XACYypoyd8lOQ4Rq4/s0Nej/dIDxLQJi3JFrI1aJ4M9HmkO2wjqcmest5TeZB
 POzj3oiDrJaif5VtSlsLPJr3Tmu8WABNcZ3/z7Pub4D2CpQiSLIuk7pH3QmT3gVDg6DREBehY
 9q0+iQ==
Subject: Re: [cocci] Fixing the adjustment of variable declarations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 732
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/516d8b97-907f-5a7b-41af-ff162ffe7316%40web.de>

> The semantic patch works on almost any code. However, it produces an
> incorrect transformation on the refs.c file
> https://github.com/git/git/blob/master/refs.c
>
> Doing
>
> spatch --sp-file sp.cocci refs.c -o refs.after.c
>
> An incorrect transformation is created:
=E2=80=A6
> which erroneously changes the type of the variable r.
>
> Is it a bug


You found a detail which will hopefully trigger further collateral evoluti=
on.

Another test result:

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch suggestio=
n_for_Elia_Pinto-20221109.cocci expand_ref-test.c
=E2=80=A6
@@ -1,6 +1,6 @@
=C2=A0void my_expand_ref_variant(void)
=C2=A0{
- const char **p, *r;
- for (p =3D ref_rev_parse_rules; *p; ++p)
+ const char **r;
+ for (const char **p =3D ref_rev_parse_rules; *p; ++p)
=C2=A0 { /* loop content */ }
=C2=A0}


> or should the semantic patch be done better?

How do you think about software development possibilities with the followi=
ng
script variant for the semantic patch language?


@movement@
type T;
identifier I;
statement S;
expression E1, E2, E3;
@@
(
-T I =3D E1;
=C2=A0... when !=3D I
=C2=A0for (
+=C2=A0=C2=A0=C2=A0=C2=A0 T
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I =3D E1; E2; E3
=C2=A0=C2=A0=C2=A0=C2=A0 )
=C2=A0S
=C2=A0... when !=3D I
|
-T I;
=C2=A0... when !=3D I
=C2=A0for (
+=C2=A0=C2=A0=C2=A0=C2=A0 T
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I =3D E1; E2; E3
=C2=A0=C2=A0=C2=A0=C2=A0 )
=C2=A0S
=C2=A0... when !=3D I
)


Regards,
Markus
