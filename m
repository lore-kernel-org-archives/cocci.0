Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60C8C36000
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 15:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=g9AWNQLR4n7Ac0NYeGKu7Pq1IhB8otHSkrFNepYQT3U=;
  b=ds082XZAjnCD9OuReV30XT5QkexsZRFXovevyitzvDvSe02QZtvVStpl
   nWJZxXAH4/jVetRzmRiZgjzrLS4Ib9XtBRvfNducD7mSewJT/yVsRSYg7
   oCC8frg1uU3quwFx9xfJXMXF9+oOtqwpf7szP9Sax8MIhWGPWl/lV5gqv
   g=;
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
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213745955"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 16:42:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5BC97E0D1E; Wed, 19 Mar 2025 16:42:29 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 31B6BE007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 16:42:24 +0100 (CET)
IronPort-SDR: 67dae5df_f380rx2oI5jYNx9sPUU/NMInJ4OOfu96PWD0YUH+3fdgD1W
 8wsBnmg8/WRyhf5U+GH73iuvGE2Z0ZNpuq6weJw==
X-IPAS-Result: =?us-ascii?q?A0FoDQB45NpngAQP49RaHgEBCxIMQIFIC4JEfVozBAtIC?=
 =?us-ascii?q?IROj1CBdDCEO48OiHWBVoF+DwEDAQ09BAECBAEBAwMBhQACiyACHgcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QJHRAEBAQIBIx0BAREnBAsLGgImAgJWBgEUAQGCfgGCLwEDDiMHDQaufoEyg?=
 =?us-ascii?q?QGCDAEBBoFGAtkUHywiV4FlAwaBGi6FbYJjAYYnhDwnD4FVRIE8gwM+gmEBA?=
 =?us-ascii?q?4Feg1uCaYIzhEFnmXiQSFJ7HANZLAFVExcLBwWBKUMDKjQxI4EiBTQ/OCmBY?=
 =?us-ascii?q?2lJOgINAjWCGyRYgihqBAWBJII2hD6EQIVQghGBXQMDIgGCMG93HINLdj+EY?=
 =?us-ascii?q?S1QghgdQAIBC209NwkLGwY9ozI7hX2VOpAzonI0B4I4gWaBYwyKKZU1BhMvg?=
 =?us-ascii?q?3CTVg4Gkn2YfiKNY5sugWc6gVwzGiSDNk8DGQ+OIYQtgQuzWEI1AgkxAgcBC?=
 =?us-ascii?q?gEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
 twCR+0DPLTQPuwXAAJpEY5aSKo=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:fZBn1qOn9fSlTsBcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3AEl9/0WvAnpOJXEeX3JktBk6Y6IsfYnzCjy+IGHW?=
 =?us-ascii?q?qFGJZRJe4c1aM4Y17xp8=3D?=
X-Talos-MUID: 9a23:1phx+ArvgeLXx8Trdcsezx9BGOtDwa+BMl4Arcoso+nZbwhrNSjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="112049123"
X-MGA-submission: =?us-ascii?q?MDGyWPF4MRc7LSgq21lWDSj2zQRqDsFXRIxPsN?=
 =?us-ascii?q?th/KL0mIb3D2j0ETGieFmi6c50hFw26REVMH+llf90vBxvPcKRaCRT1w?=
 =?us-ascii?q?dpQ2Gl0YLdBF9mVVdiT2kQLsWAhKAXihtBnttmUh3f89jYe4zA5QbGOr?=
 =?us-ascii?q?chjYJabxPC9ek6ilb6qfFPHw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 16:42:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742398942; x=1743003742; i=markus.elfring@web.de;
	bh=g9AWNQLR4n7Ac0NYeGKu7Pq1IhB8otHSkrFNepYQT3U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EWg8OULttVMoTOa6TF35JdqT9raS7xuZHZsFigJ2TjANKJSMp8TuZWsjnsi+I612
	 FnS40j+cusvGlxGExSr/3V0bAt2d5ck+3e3SvHxQ+B0oauK6MyDutU4AUrBmf3ksV
	 S62vTCA9PHLHOdNX7ofunHo2+5U0n/nHH6HO44Qt/qBID5OdquwfxwNrnoyW/ZpYE
	 AYtYmK9xWqzLjUbDxdv33mBQr90hWFzusoobtHLotgXQoQMfrC1jrJBUuDvbCt2v7
	 06ohXTOI/TGPD/2cY1+UuqPi0uarIV8PQLmOFK/lWJoVIA1MN2sd/R2PmzdTsCUNo
	 pL2MVsisH1x6c4gqyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.16]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1u6n-1tAltf1S6D-010cYk; Wed, 19
 Mar 2025 16:42:22 +0100
Message-ID: <c71c3327-b377-4d21-8c85-226c5722550e@web.de>
Date: Wed, 19 Mar 2025 16:42:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
References: <8886034f-43ac-4475-9f16-faa2db8de5de@web.de>
 <cbc0e8ca-fca0-4533-9351-859dd98bca25@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cbc0e8ca-fca0-4533-9351-859dd98bca25@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wg6ZrDyXNR0VsyadNh4zycRh5sd/hQSyHdkYC41VgUXi7Xf84Z/
 N+qm8SEft6LIoQWSJjOZnANlFpV0xFJYjc6AMdQtVZRTY4C+6tTnDPZg+IrSdruaM1dxrpN
 kLU18/OzkWBOx5jtSHA79tIhXGZEqQc92RCK5xnIDT0pkAJaQgI+TXc1K1RzPuJmnE5tacd
 qtIr8HGuHlHZTbYzYszrA==
UI-OutboundReport: notjunk:1;M01:P0:EUdE2mike4A=;BGdRm6z85uTqb1BoPH7MmOgFTvT
 PwKYGahdsvw6mn4Ad8jA/mZGY24S1AEWqZcPQNSq+H8KNy3oaT+TWWeH77xiLyv+Ij6YQWVM4
 iLwLXd+OETiQJGAJF9CqW2DLVTMn/RM2/GfY9z8+PN1OHRt2mku4FX7A/0XqsxVfMYe3QBWnU
 15bLrktTbAyOKts1FVcJ/0KdBgD/hncnSv/D2tdW/ccQvet+Q3T0KuY7kgFvQuVZOWLUD1wRt
 CRjcUREJ6Bvufu34b4fKGmpioYbHyJAmJ4mopBJMhBOntOcCZ5uO9bMAVdm0aXX9lrwVnmqcx
 MDN3xU6VhTElvjTngmUyUdw92rnOo2jwtUdtWCdjmrT+F1Lm3AuODK9qbdft9xuQ+E2u13+aD
 h5HS5Gkb2Ba3rnfwWVLeCjbiw4FNIiZERM6fjzitdqQtc48GDbpyA0f8aJzp7SB2ItgNNunTR
 R/wF1epMA7Bn5kHN5tV0/ZqMdGqfaezOiX/5BUtZ2fXH1nu2NRbzUZQ0z5x4f7yG+3GSQXK77
 SFWDXNPfW21CEjCeA+ukUCa72U5UJi84Ph6SZVKgTGnYxG81JC8Klp+Wl+bgJ/eR2CY3KMWRZ
 0mMhpSo2vr0dBsa2xV+mjfrOnQPkYVG7vr2HF7pHskp4SIzELK9+Wj4KjYrx4M3k+jUmtEUq4
 0iwxGYIqNrXkUxEcLSr5LZurKhHVWuUln9lPYu5MriOV9477L8PfzjnjMTtELGMhts5g+Z09O
 9lAs1aLyM34Sp7XrCpHWU4o/WUZdv3nYaph4VJJf3Ni9qLadpRXJhqZDr3HmRZTYw+B8Kljmv
 R4HsfNoVQ4dfxj2WA8siGrIjgN9kAHg8xkjTnKsNASwtnGsqqMhe6Xu5bEseWLh1agw2YG+lt
 KU9egYFXD09X7X1X95GkFXpbqHMigmewcbpAr0vhtUpUpJwNxDpZnHApTp+29zWgtfrEjkFzb
 O4Eij6jPAQO2zMPHZGLyZIf/bYMc4W8pGeUE6DO80zCu+xXThh2yXAccrqKTvElONiyIvZumS
 mNVGqbvkGVLi+E72HRXMzgshnMJyDkreBJkn9XpFP/KHfOPZoK1izwx2DFncZkCDNWWS69Zf6
 xc6mWzV3SvSUgwAGVBl01Tdbh5/QlNTIJRV12IGLJrpyuA83MKnTBsCzbkFok+9tTjX5r86J8
 EqFf2VMmFJxvt5W1tVf0Bh5lS2ky0f4D93gwQ9HDtj2YSUSjjTzfJAHveWbS1EAKx/jYChT6p
 MxEQERofZhGjAtnjkRxy/qwlnVqdpJMlVQLVnUbtjhUGLxY07LPVNYoPhKH1ORuxQYaRbmeal
 XMyW0sNA1bFUDRxA9+XN73p7SWtfQ1v6HooTy+GwotL76ftqmISpFBA61K4zf2RUTpoMXYjSJ
 nm3pTCw2kwTIbSCyMnAhWiCDq0e9vjINLwrmJbwOOxkUcmwSZFIqNOQ1Kz/A5UbKKQOEXyGDe
 GEuWznvjAG2EPGJVwjBrfPIvcxokuvuNLH2PJiQXzKsJoW+9/
Subject: Re: [cocci] Improving find commands?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2659
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/c71c3327-b377-4d21-8c85-226c5722550e%40web.de>

> What would be the point of using single quotes?

Can OCaml source code (like the following) be more appropriate?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/67d1b7c071a65f154f94c=
1193ab2d14f8d1bd3bc/parsing_c/test_parsing_c.ml#L35-45

=E2=80=A6
      then
        "find " ^ path ^ " -type f \\( -name '*.cpp' -o -name '*.cxx' -o -=
name '*.cc' -o -name '*.h' -o -name '*.hpp' -o -name '*.hxx' \\) -not -nam=
e '*.in.*'"
      else
        "find " ^ path ^ " -type f \\( -name '*.cpp' -o -name '*.cxx' -o -=
name '*.cc' \\) -not -name '*.in.*'")
=E2=80=A6

Would you like to avoid any duplicate code a bit more here?

Regards,
Markus
