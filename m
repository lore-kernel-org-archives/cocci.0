Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9A6C77B76
	for <cocci@archiver.kernel.org>; Sun, 23 Apr 2023 07:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=unj0qUpHGzVmt0LN5EJDfOdoLaLeKMu/wuz4Ac/0l/A=;
  b=eKYX9HgrZRqw9RLUbikhJcWOtbbjmxF0OH4NrbwogzAE1YBbUhDpaxtH
   eVI8pt+2nLsfy+xE6frowjfJXdLUMZzyXEu0NJ1Cm9ZsO32jYWBk7Odjj
   FteIl4ls2l/WHEa5cFgNXG8zEKpZUJAQvQlxJT09S6VYi3DixbVoqzVjg
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.99,219,1677538800"; 
   d="scan'208";a="104406125"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2023 09:01:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0D79AE019F; Sun, 23 Apr 2023 09:01:07 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BDEB9E019E
	for <cocci@sympa.inria.fr>; Sun, 23 Apr 2023 09:01:02 +0200 (CEST)
IronPort-SDR: 6444d7ae_8ZzzFk3iRfNtqHjQT+VVDPpzIetJIeXr770bODn75hu5wJi
 JPklu1EsNbHXOdQMVDCk41sDMDK1FnfQqTnjGNA==
X-IPAS-Result: =?us-ascii?q?A0E3AABi1kRkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYItgUsvBAtGhFOPEIF2MYQwhy6HPohqgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEgguCagoChTwCHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgJHPgECAgEjHQEBEScECwsaAiYCAlcGAQwIAQGCeoIoAQMOIwerE?=
 =?us-ascii?q?oEygQGCCAEBBpwNHywiVIFeCYEULQGNH4QxJw+BVUSBPIJTMT6ERINbgmeWG?=
 =?us-ascii?q?IEzdIEngTKBBAIJAhFrgRAIaIF0QAINZAsOcIFFX0aBcgQCFDQODBYFQiUED?=
 =?us-ascii?q?gMZKx1AAgELdT01BgMLHwZEAh+BbAQvWHcKBkqXBIIKTIIRScMPNAeCK4FWg?=
 =?us-ascii?q?VkMnw0GEy+XCQ4GkiWXeCCoAIFkATiBXDMaJIM2TwMZD44gDA0JFYNuj0g/N?=
 =?us-ascii?q?D0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 YT4qa6oja17pYPM/R5cRkNo
IronPort-HdrOrdr: A9a23:zJc0L6CtWaGnFKDlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:DV0GvW6HCAK5VPSZrNss+XUeMN0ZT0bknFSOPXOWWVhSF+C4VgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AzTzkCgzRHCchT+yz63oYkYealN+aqIOIKG4Hn4w?=
 =?us-ascii?q?Bh86VGCN1HT7FiTaMeIByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,219,1677538800"; 
   d="scan'208";a="104406119"
X-MGA-submission: =?us-ascii?q?MDEOCInsA+ZoYG3T/xycJxkuCdyS70V0Mbia0s?=
 =?us-ascii?q?nkBtG5aozsoa8hXecjnsfFP+M6uENci3cF5NnDoU3UmX50BahqQylprQ?=
 =?us-ascii?q?X3/vLp3bEvIy9MkIdUHo/gnxDRsg2eLj7awqeHq1wwsuiYQuu6ncZGB+?=
 =?us-ascii?q?+ctCmRjE8UIMK3r77aHyNUiA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 09:01:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682233261; i=markus.elfring@web.de;
	bh=Wo19jHgUBTgV+CQ+SZLoBEuQSbj+/sBDfk0oZavfbbI=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=JSUQVMyHxBNptbLubcn9IJdNq1z/7Q1pbEgWhOPDlDEJdwY7pYDFVv4XCgyyD4IpN
	 Dm/DrQx/5Wc2+nfeuLPjoG7MoMBhJn6zO5+J1lzQF2v5MPAsKb/3hrgdp49G6xnq6a
	 xH4rJuL0kyHQ+r7vDJg4P407c5/byOqf3ZshP+6Tax6hcgfOzzmW87VAljMj6RLAJr
	 ojJeHrIwODQR5D/hROZfcXBUfNS53JDc7QmqVat2UuKTY/pqYfk8twZSorbkQltXJv
	 bo5Lp8sr6CRuGl/n7L8uxaMvw6SXcKwKAmbqGT15hAqasOeG7CEEPXgFG0UEbZInIY
	 5m8lXBlYwh10g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MW9ra-1pomdb2V0E-00XypV; Sun, 23
 Apr 2023 09:01:01 +0200
Message-ID: <dfed0b6a-5b20-3b06-9afc-69e808cb0c3b@web.de>
Date: Sun, 23 Apr 2023 09:00:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Julia Lawall <julia.lawall@inria.fr>,
 Thierry Martinez <Thierry.Martinez@inria.fr>, cocci@inria.fr
References: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de>
 <alpine.DEB.2.22.394.2304221031370.2766@hadrien>
 <e170b7fd-c7ff-c3cf-db35-0427833a8215@web.de>
 <alpine.DEB.2.22.394.2304221724070.2766@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2304221724070.2766@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DY53BLVT+aLPEMKnqc+9jLcQj/zAJlS0e7uiluYlOYIMRrE3ytj
 mWXQARso4OhI2yLOZu+zSpzEkGFErJwTHfE85oHwg3//R3M8LsKVA/BtlMK0wiok7dMSxaE
 6hrddUYAEcXnO5aUv/ICMbzcZtWVbA/q6SKjehgpcyaYHhFWzborhRaJBQJcvTM1nCnOoJg
 EORjAX+6bf7BieCkVp6mw==
UI-OutboundReport: notjunk:1;M01:P0:+tgQG/Q2cL0=;JCY5WapQ4zQ/43t4vTsqx+vTDNZ
 x8q62c7eDqS05fdH9hU1Lv2sT8Jg4sVBBodEdQJBlawxZafcY4nK7j7/o9aUBgkEdcFCogP0I
 2xVvbTqSKsUOh07ACrFEm4IDU4VTcnqZpGe3S001NWa0Sg5zb9BPf5ehGdmme5OQtRWkRejuj
 LYKaOmbPZ3qMfyTDVMaRjP0zGpNczWo+KQrU74WVi/cqH8ll3PSaHpe1hr6xTrcB0riI9gWzo
 xFR1cfvLpt0BE3Otnf4WeJP2C+dzsE7Wv6PRxE7Pe3E/wZK6zZ5saYx7CviSDde7k/ZalNwGS
 2i7zC8Kx2YAMzsVgy4jDKFbt2kKVOBfF/wogMjCBNbEiWkb6BR/HKPzO8esykF9q9kLSzUSYR
 OARr44DHgCvssE2xNKTAEm2HHusGh5y196r8Xdov1SqBcuFx5DRMrJtbtM8zYJhc5soYS8s1C
 6+xSmLX25MxpKgqq94cPKlwsugyYI9baksRpBFfjMS9t4EKjqa6FVHUV+6CmaT487sGl2uXA2
 C7W0txMM4qXtBLPOohiQOvdun1pHgnajZFrk6tKCxa8FEJqd9ar/xUwY3aqA2f7TWxD0IWQ2G
 TytDRLdygh6V3b7owpxR6XSFVHChz3WS5rSXq5s+ojzIXepMu/cQW+k2yHo1LOTLQH059wZtk
 CltYjkck8P4bOIpRW5cz3wMsr5uXwYTZYZgJqEGHxXz7dou3GlrnHBDObuvG3kWNNKEyDUHOu
 SwSNORoIbvHakV8sRsHgQz1CPXfEuiqw1MPTR5rpfZEnwvYyxbm2cLwOZVRRHoUBhIa8iMIrW
 rL8b2agWAaNbhvR5SPLgm1x3KNv7PIwB/uW2r2eQCq/k0fcu6y/N9xeyMO1r+Wi9SPSzQZ6n+
 pGNmd9LZWFCgfoQuH+ZDAMdfjN0j0qPjk+KMo4xudeX86uM3uVDbDOHr3ITmzClAfL0yHy7hk
 edp+vw==
Subject: Re: [cocci] Checking selected contents from metavariables by SmPL
 scripting rules
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1124
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/dfed0b6a-5b20-3b06-9afc-69e808cb0c3b%40web.de>

> But a helpful way to show some issue about whitespace around a string
> would be somethng like

Source file example:
void f(void)
{
action(x, "X");
action(y, "++");
}


SmPL script variant:
@find@
constant char[] input_string;
expression input_context;
@@
 action(input_context, input_string);

@script:ocaml special_display1@
text << find.input_string;
@@
Printf.printf "text: =3D>%s<=3D\n" text


Test result:
Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/Probe> =
spatch ../janitor/show_string_data_with_OCaml-20230423.cocci string_litera=
l_usage4.c
=E2=80=A6
text: =3D>"++"<=3D
text: =3D>"X"<=3D



Another SmPL script variant:
@initialize:python@
@@
import sys

@find@
constant char[] input_string;
expression input_context;
@@
 action(input_context, input_string);

@script:python special_display2@
text << find.input_string;
@@
sys.stdout.write('text: =3D>' + text + '<=3D\n')


Another test result:
Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/Probe> =
spatch ../janitor/show_string_data_with_Python-20230423.cocci string_liter=
al_usage4.c
=E2=80=A6
text: =3D>  "++"<=3D
text: =3D>  "X"<=3D


Will such a data presentation trigger further software evolution?

Regards,
Markus
