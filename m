Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBEEC433EF
	for <cocci@archiver.kernel.org>; Wed,  9 Mar 2022 20:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=2T3SlS7AnW1syzpk6Ir/aaV8jraszw2WWgzLRc046EM=;
  b=PWi3rfwKeSolkNVT7R2NMCg9N8jSLyZ8rbLHkdBijKMEUhaTzXq5rlgz
   v9uazTZe7d6GeSXgdDEtoCuutFdgR8Yyj4NvShreN3cMvc206BCbzpslN
   CsLs8MhYiBDMjBnGpzsvqvpRAMI6pKtOCx/AcN0cjkZDEINnO0e7V3WjI
   o=;
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
X-IronPort-AV: E=Sophos;i="5.90,168,1643670000"; 
   d="scan'208";a="25326165"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2022 21:56:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CA3C1E0362; Wed,  9 Mar 2022 21:56:08 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3F457E004D
	for <cocci@sympa.inria.fr>; Wed,  9 Mar 2022 21:56:04 +0100 (CET)
IronPort-SDR: I87FnrlXffO7Ry3Q6BARBlqcTDYAl8/D4d2sMJopLXqRGYHoFpVQjh0CMoz32h5JS6Fi/O6aDG
 Dkhpc5YZENT9NS1cor90JeZBR+HiR0jzdngJYUkTzADZ7ehJj7GBlr+4q4mr9OTFAG2IbXs5mE
 pxkj5bbTROvODFmgeAe+dKqGrJWHjq04aqV4tbe2sXuy0HIK0brjulom+3xkO/MZIh81UVm/mM
 uKaPXU474WdLFBervTkhfpu+MvLYJ772QapiWzwrbGaYuXRvlGl0Rb7j1AuLpTI/gomDwMnERu
 sQN5D166q0fZJWADP1hQ1WuD
X-IPAS-Result: =?us-ascii?q?A0DJMgBuEylihk7ASNlagQmBXAGBOQIBaWkVVysEC0SEV?=
 =?us-ascii?q?IgohkuBd4EGkWSKJ4F7CwEDAQ0SAQEhCQECBAEBghKHGQIdBwEEOAINAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECAwQBEwEBAQwLCQcICgcOBQsFNgZeB?=
 =?us-ascii?q?mQEgUsEgXQLNA1AFgGBXiKEFR0BAREnNAImAmwIAQGDAAGCZAEDMguuPoExg?=
 =?us-ascii?q?QGCCAEBBoJcgWwfLCJSgVsDBoEQKgMBAYYRFEKCT4U2EIFVRIE8DIhHgk2CZ?=
 =?us-ascii?q?ZgqgQCBPZJQrVc0B4ISgToFgTsLiCKBHZRMBhEDLoNhAZJXDgaRZZZVjROUL?=
 =?us-ascii?q?oU4gg+BZzMaJIMEAQEBMU4BAgECDQECAgMBAgECCQEBAo42hAyBC4khQDQ4A?=
 =?us-ascii?q?gYBCgEBAwmFRwEBiSGDBQEB?=
IronPort-PHdr: A9a23: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
 TUuKyulQZWP4CkejvgtQgSpC1J6IOPClyvLt4Hl
IronPort-Data: A9a23:f06t4qJGwEj2Lpw6FE+RjpMlxSXFcZb7ZxGr2PjKsXjdYENShTxUm
 GBKUT+DO/mDYWr1fNx/bojk8BkFusODyN8wT1Qd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefRLlbFILas1hpZHGeIcw98z0M78wIFqtQw24LhWFvc4
 YiaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhzsAp5
 cpLk7mLWyASb/aWvKdabAF3HHQrVUFG0OevzXmXtMuO0wvZfnGqz/gG4EMeZ9RHvLktRzgfr
 7pHeFjhbTjb7w6y6JeyUOpxnYIOKMfxPYUQkm5tx3fVAJ7KRLiZHv6Qu4YGgF/cgOhTPqqHe
 s0EUABdUwubT0V2NlgHIsMhybLAan7XKmAE9gvM+8Lb+VP7xwt627nFK8vQYtXMRMNPn0/eq
 HiuwojiKhQdKcDZ1jePtH6h7gPSoc/lcNMCTJCn8NhPu0+0/T1IUjlVEmSjjvbs3yZSROljA
 0AT/yMvq407+0qqUsTxUnWEnZKUgvIPc4cJSbxrs2lh3oKFv1fAXgDoWxYbMIROiSMgedA9/
 nOk9+4F6BRqt6CJD22Q/PGYoFte2BT5z0dSOEforiNfu7EPRb3faDqSH76P94br1LXI9cnYm
 WzikcTHr+x7YTQ3/6u650vbpDmnu4LESAU4ji2OAD77vl4hOtb9PN3zgbQ+0RqmBNnJJrVml
 CdV8/VyEMhVUvlhaQTQHLRWQ+/BCwitamGG2wMH82YdG8SFoiP/I9kJvlmS1W8wfJ9MeDn1b
 VXVtB8Z7ZA7AZdZRf8fXm5FMOxzlfKIPY29CJj8N4MSCrAsKlPv1HwxPSa4gjG1+GBxwPpXE
 crKIa6EUyxHYYw5l2Heb7lGjtcWKtUWnj+7qWbTlEn/jdJzpRe9Fd84Dbd5Rrtgvf3e/1mNr
 Yo32gnj40w3bdASqxL/qeY7RW3m51BibXwvg8AIJOOFPCR8H2QtV63Yzb87Jd56kq4TmuqRp
 iOxXUpRyVzeg3zbKFzWOy45N+61Bc5y/SAhICghHVe0wHx9M4yh26coccdld7cQ8uE+n+V/S
 OMIepnbD/kWEmbH9j0RYIPTtotncBj31wuCMzD7MicyddhsSlWRqNPjewLu8ggIDza27Jdv/
 ef/i1mDGZdaHlZsFsfbbv6r3midh3lFlbIgRVbML/lSZF7ortpgJRvxuflrccsCHhPOm2mB3
 AGMDBZE/uTArtNn8NTNgqzY/Y6lH/EnRxhfGHTHq6m7P2/W8zP7k4NHVe+JexHbVX/1ofnzO
 78KkqukaPBXzkxXt4dcEqpwyfxs7dXYp4hcklZuEkLNYgn5EbhnOHSHgZJCu/Ef3LNfogfqC
 EuD9sMDYOeMP975VkEcLkwpY73bh/0TnzDT69UzIVn7vXMmouDYDB8KZxTc2jZAKLZVMZ8+x
 blzssAh6zu51kggPOGAg30G7G+LNHEBD/4qu5xy7FUHUeb3JoyuoKAwCxMaJLmKbMhQdFYnK
 HmYicIuQliaKlXqKxIO+brlhIKxRqjifDhVwVVEK1nhdh/tmKosxBMImdgoZl098/iEut6f/
 kB0OkczKajmE/KEQiRcdzjEJjytzyF1NqA8J5XlWYEZo4SVurTxEVAA
IronPort-HdrOrdr: A9a23:KWk5CqmliSet+ZYHB4U3v2g5nT3pDfIe3DAbv31ZSRFFG/Fw5P
 re/8jzsiWE7wr5OUtQ/exoXZPqfZqyz/FICOUqTNWftWrd1ldATrsP0WKK+VSJdhEWndQtsJ
 uIHZIfNDS9NzlHZd2R2njfLz/M+qj/zEiQ792ut0uExmxRAZ1d0w==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,168,1643670000"; 
   d="scan'208";a="25326164"
X-MGA-submission: =?us-ascii?q?MDHfUriSStxdckoPWB+b6kQ6Te9fDbGoGRNLRT?=
 =?us-ascii?q?X3Sj5niQaM1iePHWRK6p6A+g+LG1uhCwmKEcNAxDlRlTx7gywQVx7BGP?=
 =?us-ascii?q?7bodR2eP2n8OOe2De9XeA/ALhMOyaD2rMEMC5FqMRpuBjiiUDOUd61VP?=
 =?us-ascii?q?A5QT/dd69BhLYK2hqZ2tvyvA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 21:56:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1646859363;
	bh=2T3SlS7AnW1syzpk6Ir/aaV8jraszw2WWgzLRc046EM=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=Qr3JKQK2xEJ7G3re6Ehaa2U5/CMHuvqDRItstX6w/ZCN28np8TfmKE9TyL+1nHdW9
	 TVKrm8MOFJN4UsDQwWn3IICZAHGYI35qYRKl4E1o596IJx6EFiDADe1p+/W1AOngPP
	 KqeUZJPR5VwsXqioLDkkWfZxDlmeOq8WHX6uo2Cs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.114.231]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MALiL-1nHNIf3Mzb-00C3U0 for
 <cocci@inria.fr>; Wed, 09 Mar 2022 21:56:02 +0100
Message-ID: <30416823-3677-1e5d-2bab-160edfa56d8d@web.de>
Date: Wed, 9 Mar 2022 21:56:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QfqY2UGrqb6tP1pHhlnU/X+jZHV38hHF8PFX6aYk6qrfHKmkuhq
 likfXnWT4W2wU0ItvynF4doouNWbyapmbyflUKQ4v/owsMMXgTjyg/aT0hezskfHoudgo7s
 TaovfWAStJqurFx8wjkF1Wsb4HrJtJAZUZ5tBoQwbfBcCWJ6uPNoqu8KfYO/bqUnUKzegtc
 re2I13zUq/ifGGJCYx4xQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PzTkcY4JDAI=:pNXgaSqPFrO9CDnRIcigGJ
 OypA9eAnTwN6fBG8Z3/B74cEPmk1SboK+wQ/AumW0t1uBzsf8wsy5fzMkTw2Res3Kxz/CYsuF
 OzZFWQ7pxMPYvLoyosKwhcsXaI1DiWnt6nSY1YOsiGmzPlsrxOz9sVLcNVlFdhHdjagw/XKer
 Pr9uxcDU3sS9vDt2QnXBn7mLvOOtGOBaooe+z73yzCwuQst5CwGiY/bcfnHmF6i8dY27mHvbR
 sI7D1Vy6uFIon9vZzaWhSLswOrEQPBvFF9p+xUi/C3N0TtzucB06dk6l6ZJ60VaHtDa4enwFM
 E70fmowuE/yT9o2B3JvMMmilP6shrmHxqnCtdJnMfRXmncJYZVhiJQ2ewXbIhCAP2hlHeepOG
 BklFFuN2KzS0HZM4cj2lpRknBqYVkvhC+zj5sI3VVoY2/drulOPu5Q7ArmdqnVjOEFpou+Zc6
 ddh10CeBJKhlW5+gApg8bQjLOIZcPFUXIOFjJglVKiA7SRr65BO02E7QjoHbtnr4CBAsBrOaA
 EQ42FLiVx7jWRSR7h05senFCBLkaKEus9GbUT1KPhsI2uh02J+blzi4oNhXnqFIYOJ/O2w4t+
 Xqj8u083pOwF+LZpfnU/GMmJSjvtcufT5+WGWhNbOqRESnviUoJ4HeoU4LQlVFWBwGGBLcw5a
 8DP8BoRSZtbrYNxLhOMKHWUzKT6QZu4cFwdDsR4Z+CaECUaxdDpE6cLXOQWJkpQAy/Qhffsgr
 kElWjovyPRtH4YJWI0G9MH29J41zMtUZLEmhnqQVhUL9wwhvt9MuuaC0K4FXJwB8J55FeXtUY
 r4ZaR2kO/SRlEplFOi5Zfcf/JMXHJ8GbRKe1GkWHRP75cSpJtbwWiBJG1QPp8qWDiS0+5sw5y
 CAP2RutsZiAXi0BAqj5rbtm+RSsUjpjXu1e3VvBq9XnaDkXbocIzrjeoHzgONy7JJRInd1dzX
 ikCPdrPAwsia3EOAuOkIVcDTforwJ20ae/Ba0gkOEXVrkuwJXMHlQVIcxukM987MTtHwTyCeZ
 2J8hf86EzwP5EVPPx99ts13TjpeHR9CyZeeDHeCuyYX1YI6lE/ex2bBTF7fZUG4b/Vl8aULIn
 3n8Pfkp1A7t0iM=
Subject: [cocci] Evolution for parsing of C++ with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 195
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/30416823-3677-1e5d-2bab-160edfa56d8d%40web.de>

Hello,

I noticed some commits which indicate software development for more suppor=
t
according to the parsing of the programming language =E2=80=9CC++=E2=80=9D=
 together with
the semantic patch language (Coccinelle software).
https://gitlab.inria.fr/coccinelle/coccinelle/-/commits/master/

Are you aware that C++ belongs to the category of context-dependent progra=
mming languages?

How do you think about to clarify corresponding design challenges any furt=
her?

Regards,
Markus

