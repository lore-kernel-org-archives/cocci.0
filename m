Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007BAC30658
	for <cocci@archiver.kernel.org>; Fri,  5 Jul 2024 08:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Y/zABmy9OxJ1w2wSGsst7G78ZoOsgi2YskDX+o9I9Ho=;
  b=NOuQkZKFS1jZ/KYIfmgrw3+rNob33e12jSYXSlVA1AwIuqT2RSu8sC6A
   avB6894lja+sfHenmL/hu7fhxezJMbQpLNIN6X3pGxJ5B6nQsSElLEtBu
   QqQNCro5mAdIPfFP0d540exw6zf9+meO6F5pcj1tO5CN/E2MfwTuBUKSN
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; 
   d="scan'208";a="174089442"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Jul 2024 10:53:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3D8EFE0CCE; Fri,  5 Jul 2024 10:53:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 937D8E004E
	for <cocci@sympa.inria.fr>; Fri,  5 Jul 2024 10:53:28 +0200 (CEST)
IronPort-SDR: 6687b488_ciDZ5pM1BqhUJkvpI497sIIoG9hSLOk+QuD98AH7Imlpue3
 OjtMULF3QJnp0djg8OWfleRiXQalq8I9zBlhjGQ==
X-IPAS-Result: =?us-ascii?q?A0G4EADis4dme07ASNlagQmBT4JEYhoGVDMEC0gEBCWEK?=
 =?us-ascii?q?Y9IgXWEa48KiHOBVoFAPg8BAwENOwYBAgQBAQMBA4FJQoJ0bYgnAh4HAQQxC?=
 =?us-ascii?q?A4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBJBgGDhAnhXQNg?=
 =?us-ascii?q?mcBEHcbdDACAQEBAQEBAQEBAQEBAQEBAQEBFwINOkYnHQEBESYBNAImAnECA?=
 =?us-ascii?q?QGCfAGCLwEDMQcNBq1/gTKBAYIMAQEGgmfPXh8sIleBYwMGgRouiBcaAQVni?=
 =?us-ascii?q?DElgSEPgVVEgTwLgkeDORcEgSWBBoMOgmmICgGRTYwOJguNGIFPHANZIRMBV?=
 =?us-ascii?q?RMXCz4dAhYDGxQEMA8JCyYpBjkCEgwGBgZZNAkEIwMIBANCAyBxEQMEGgQLB?=
 =?us-ascii?q?3eDJQQTRAOBN4lvgzkpgXCEGQhDgQGDb4FrDGGJdYE+gWKDTUqEcR1AAgELb?=
 =?us-ascii?q?T01CQsbBj2qCYUELJVQFbIkNAeCNoFhBYFdDIh9gSSVJwYTL5c6DgaSbJhpi?=
 =?us-ascii?q?3+Bd5VChVOBaQE3PIEgMxokgzYfMAMZD5IbM4RhxkdBNQIBAQE2AgcBCgEBA?=
 =?us-ascii?q?wmFRgEBgyY0gUoBAQ?=
IronPort-PHdr: A9a23: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
 9KJmK+hcV9/
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Zjp1gqPeY7e5fcBcThmjsMiBIKoaSvp037Dk7TESdfUnSL36qy
 nIpoV86faUskd3ZJhEo7u90ca7Lk80maQFhLX5Xo3NYOCFggeVxehZhOOO/9SKIVybygcy78
 ddWpRfTPvtEFN9kcH22wWgFc08qeP3i5xAyd2+8593JzsaEp2IAj0JcjpymSBNLjV7OQ==
X-Talos-CUID: 9a23:AGlxtGz61aAMZkpwOng3BgUUE+Q/c17m503hCE6ZGGkyTOXJd1KprfY=
X-Talos-MUID: =?us-ascii?q?9a23=3Av115UAy1vZTewWLKCmUreVv5mh6aqK+jOk9Wuog?=
 =?us-ascii?q?WgfG7ZSJSZBGHnjf0RKZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; 
   d="scan'208";a="174089424"
X-MGA-submission: =?us-ascii?q?MDHWwIaGLj9k8GXVqMUVeBdBc/eLvChnHOnl6c?=
 =?us-ascii?q?cM5p85Qin00ZVATgGF3NNbqM/8h5QSG/S1Gy3hKmYP+ocEQpk7B8lrQ6?=
 =?us-ascii?q?12V3aMF0O8Z0H/fWNUalt33R/aM+a+Rvw7QpLOeigjFZvUVm7NRTByzQ?=
 =?us-ascii?q?OxyM09BClFA7pBPDWL2vFIkw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 10:53:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720169606; x=1720774406; i=markus.elfring@web.de;
	bh=Y/zABmy9OxJ1w2wSGsst7G78ZoOsgi2YskDX+o9I9Ho=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oGgsHAsm7jOVosCaomMvNmytTpaEj4lwUq4hdkxgegfwte0rXo1ci/lghlBludFG
	 gLoXEdIjtIa5I8ibYa4uMortYNBeA7IRsboUcDv9ZIdByp8ajafEl8FnGRGTBXjZD
	 Zi2eLKdk2+/3mfftqxuREvBxgCAViG1cIZi7fi3BIXOrcc/pTf5rWolgOgTof+aPr
	 Wj+Fcl438pnHGG/b54QOJfUYKVFZTH547zTaPOYV2aPjcmgJy2sz4zdHFzfTkmd0I
	 k//Aud5Kourf7ZOaGKqcBuODTsn2hMCFEHkOc1DGOcDKwHqRuUAvMnxiH12s3f34A
	 xhm85SMxK9VMgpz12A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW2R-1skKNX3IsH-00YMyW; Fri, 05
 Jul 2024 10:53:26 +0200
Message-ID: <bcd3e669-9158-45a4-a539-14bfeca06deb@web.de>
Date: Fri, 5 Jul 2024 10:53:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
Cc: Dan Carpenter <dan.carpenter@linaro.org>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bD1UHVLyoW/Vxl9z/XiPeR7ItUirSOOx2LGU+UO7baDNrePZsB+
 TZO05jSZKewq5EqJwOKPeoYMDZsba+IjnrFMTH7lMqgXlmwJlGHsFTlNJrh369X7aIKG1eB
 t3H2lGa4Zpv/HAq1ZWf+XUGYhXY+EQeuiW8gLLCR9fP4nw9S1+1ZQYf0yqoDpNZ6Psfjg+I
 mO9nnJNOHOkQskyrsIKNA==
UI-OutboundReport: notjunk:1;M01:P0:ir2G1E56h3o=;UymVdS6kxN7FOFuki1d2NzhJHxo
 BURaunK6TJ9s/EmOqyBvaIii7BRYD03LIg1hY9Mcm9EGCrzpRjFHPekFfoAz7SWk8hE1VGgNa
 ewwREMwfd994QUQoUZT+JjD5knfqEtUfo1kGY/FU+bQTtsBaIr/B74fmIbAWDPbCzuBprKd2k
 fNAAYebxs/9Z0q/PKYw3QT25Uf6ny4MhrAuYcYv3qu7jb4gEQBr4EckQEak5Cu66Mbo55jwRy
 lKK9nOlnlcAB3b8obWzTuYaAhPqGGqaETuH0RMWv6P+45YooJmqnctoIs9i0pjj5v547T0LzB
 WqNkuXEUO37Q0lJ7LwxIu4xX2YvT6KW4FQs38Q/Hl/CsQPQxqDexYyFWo3j04DQ+KOFcbbuWP
 kBaot0o6O4DMfRlbBWF5Ny9vXbACGgnTnAejUykGQOdLCHq6ZhwQSo36GCmBkz7/R6b6V7xji
 8T0Tr9L5V4GlQUjYNv7W8njZAPuvrBCy+Yn1pLo9zrHjpfJRGqLp/ZoxSAm4T4cFbKiGVeGeo
 XnicALrXGqfpxw+8/Vg1Ij1Zfdm1NJKpt7ubdfUgCQLlWN5nLe6VctM6jHVyz4DPfWTx4aozX
 KZgk3UtLIsW2TWiXZUcm/qzQ3ru3gmWKPlVsXzMM7wBCQMV1U0FpxN9nkBE9jI8+ZoT1O1zWX
 3MYZexv6g/MJcKTETro7w5/11+jN4Ab4UaJynxH5vXoXyCuAtVi+8+YqffghNsDPBj3aQ3pnm
 /j0BQwtLqLt5K4Mbp+yCbj5/9l0FCnc1jn4p8SOk/tDJpLkouzUhX5LR3YuPF8cW2azhtGEnF
 6ZAVcuh6NemseLpC7n+fXD5VntDzjaN/5QTtQMnGuXGaI=
Subject: [cocci] Improving handling of nested if statements (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1799
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/bcd3e669-9158-45a4-a539-14bfeca06deb%40web.de>

Hello,

I constructed another small script variant for the semantic patch language=
.


// See also:
// [PATCH] crypto: lib/mpi: delete unnecessary condition
// https://lore.kernel.org/linux-kernel/6686bed3.4a0a0220.6aa45.6c34@mx.go=
ogle.com/
// https://lkml.org/lkml/2024/7/4/933

// https://elixir.bootlin.com/linux/v6.10-rc6/source/lib/crypto/mpi/mpi-bi=
t.c#L178

@deletion2@
expression e;
identifier i;
@@
 if (...)
 {
    ...
 }
 else
    if (i)
    {
 <+... when !=3D \( i =3D e \| e(..., &i, ...) \)
-      if (i)
-      {
          ...
-      }
 ...+>
    }
    else
    {
       ...
    }


A known patch variant can be generated then.

Unfortunately, this does not happen for the affected source file together =
with
the following smaller SmPL script variant (by using the software
combination =E2=80=9CCoccinelle 1.2-00021-gac9af0e8=E2=80=9D).


@deletion@
expression e;
identifier i;
@@
 if (i)
 {
 <+... when !=3D \( i =3D e \| e(..., &i, ...) \)
-   if (i)
-   {
       ...
-   }
 ...+>
 }


Thus I would appreciate to clarify the handling of else branches a bit mor=
e
for related source code search and transformation approaches.

Regards,
Markus
