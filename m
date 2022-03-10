Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B086BC433FE
	for <cocci@archiver.kernel.org>; Thu, 10 Mar 2022 09:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dR9sKahbpVQAJ/zVmZdkq11wDS4/db973LZwhCDHxkU=;
  b=MH/rKLIYyMZ6Ttg9QPYfKL5rt4ZrLwltXH86h6o7+IPu21lYEswXqIhR
   NbvbVh/y5miiGfjo26zc81kKSjdFz/dc5Tz3IZqY7HJyru+rBJzwmBZ1e
   vzNP5T0MP3XtoLsK4jXRznP5ouWF6bfGaOThRWLKw4OanNfuOMVe8eQIG
   s=;
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
X-IronPort-AV: E=Sophos;i="5.90,170,1643670000"; 
   d="scan'208";a="25396276"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2022 10:16:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 06FBEE2FB8; Thu, 10 Mar 2022 10:16:55 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F203EE2FB8
	for <cocci@sympa.inria.fr>; Thu, 10 Mar 2022 10:16:50 +0100 (CET)
IronPort-SDR: n0FbJzGzPjP8V5IVF95I3LYC9vdHBQaqa0uYHYBLBu4CAUZC30qxeVStVLdSD/kTqfEkBc5tRc
 D+3nYIxh9Sec9jjloG7DkqH7c2KwqbkgMqGeiDwLtcLGaDd5kO6u3NfstN/VBuQbZbQpC6SNDS
 mM6maDS1+/FOpLQo1gjUBQOWDWTqIlDX81JGEiaYjmUvPFp9/RXgbQTvAd92+nLqlHwHL/1PR5
 vPFVJfe61lu23YUyKtr0mhC/MpIYxF6AIxt5gl2MwRViczPFDeSY3g8tugMZ0GNCGhmBTWfdbI
 NIJ030lXl2AYQZ9GwqCr+g2q
X-IPAS-Result: =?us-ascii?q?A0B6BACEwSlihk7ASNlagQmBXIImaWwrBAtEhFSRG4sjh?=
 =?us-ascii?q?xaMIgsBAwENPgECBAEBhQcChCICHQcBBDUFDQECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgMEARMBAQEMCwkHCAoHDgULBTYGXgZkBIFLBIF0CwcGJw2CN?=
 =?us-ascii?q?SmDZQECAgEjHQEBESYBBAsFBg4MAiYCAlcGJAqCaYJlAQMNJa5LgTGBAYIIA?=
 =?us-ascii?q?QEGhEgfLCJSgVsJgRAthh+HLnonEIFVRIFIgnc+hEWDGoJlmB+CTa1wkjc0B?=
 =?us-ascii?q?4ISgTqBQAueMTMDg02SZgaRZZZVpnmBeYF9MxokgzhOAQIBAg0BAgIDAQIBA?=
 =?us-ascii?q?gkBAQKMC4IrhAyKLEA0OAIGCwEBAwmFRwEBiV4sghwBAQ?=
IronPort-PHdr: A9a23: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
 ZBIRrIJDTTd89sFB04jENFQeP9K
IronPort-Data: A9a23:AnSIRKuTE1hRfbpUUQbTFhTOTOfnVChYMUV32f8akzHdYApBsoF/q
 tZmKT2DbqqLYzb9c4glb9i1/RwA7cCGm4diSVdk/HxhHn9BgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCY0idfCc8IMsboUsLd9UR38g52bBVPyvX4
 Ymo+5aGYAf8s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCnaDsb0QRIYzcovRHdzJjHzBeJJZPp6CSdBBTseTLp6HHW37r3ukoE0w8e4EVkgp1KTsXq
 rpHcnZUP0rF2LLeLLGTEoGAguwGJdPoIZhZl3Vu1zDfAt45TJqFT6iiCdpwhmpr154UQK62i
 8wxdzExQiTAXhZzNg0rEKsOu9f3unfFSmgNwL6SjfNqvzaKlVIZPKLWGN7cZdWOQe1Hn0OSv
 GuA/mLjAxhcOsb34TGC+XmtrvTemDvyHoMUDryxsPBw6GB/3UQWDwAKE0S2q7+1hyZSRu6zN
 WQopgxtlbcT5Ha7FP3WZBGpgGe/t0EDDo84//IB1CmBza/d4gC8D2cCTyJcZNFOiPLaVQDGx
 XfUxom4VGcHXKm9GC7Mr+/8QSaaY3BNRVLucxPoWiMpzrHeTGwbixXSUpB8HaTzgtCd9dDML
 9Ki/HVWa1Y715ZjO0CHEbbv3mPESn/hEFRd2+kvdjj5hj6VnrKNaY2y8kT85v1dNoufRVTpl
 CFax5bOsbhQVcnWxXflrAAx8FeBuKbt3Nr03g8HInXd32/yk5JeVd0MsWohei+FzO5eJWWzP
 Sc/Rj+9FLcKYSf0NPYpC25AI51klODhE8joTPbZcpJHbfBMmPyvrElTibqr9zm1yiAEyPlhU
 b/CKJrEJStEVcxPkWXuL89AgOdD7n1vngv7GMGrpzz5i+f2TCDOEt8tbgDRBt3VGYvf/G396
 chEDcKWxn13CaumCsUh2dVOdQxiwLlSLcyelvG7gcbYe1s4Qj59U6GNqV7jEqQ895loei7z1
 inVcidlJJDX3BUr8C2GNSJubq3BR5F6oS5pNCAgJwj6xHUpJ4qitf9Ne5wydLgh1epi0f8tE
 6hbIZrdWKwXR2SV4SkZYLn8sJdmKkahizWOCCz5MjIxSJhtGl7S8dj+cwqzryQDV3LltcY3r
 7C6+BncRJ4PG1ZrAMrMNqCwwln3sXVEwLB+WE7BI99yfkTw8dE2enKr0aJte5kBcEyRyCGb2
 gCaBQYjidPM+4JlosPUga2krpuyF7UsFERtH17dseS8Ox7c8zfx2oRHSuuJIWvQWW6oqqWvY
 eJZk6P1PPEdxQ8Yto1hD/B0wKh469a2/+1WyQFtHXPqaVW3C+o8cyfcgpQV7vVAlu1DpA+7e
 kOT4d0Ea7+HD8PSFgJDLgQSaOneh+ofnSPf7KhuLUimtjV7+qGLDRdbMxWW0XUPKbxoLMU6z
 O1ntMNPs16zjR8jM9CniCFI9j3QfyJaDPh97skXUN3xlw4m6lBeepiCWCX415G4bYkeOEcdJ
 DLJ1rHJgK5RxxaZfnc+fZQXMTGxWXjTVNF2IF4+y5Chn93Ymrko0RcX/TlfosG5CPlY+7obB
 4SpHxQdyWayE/NAm8VJGWyhc+2ELAPM4VT/kjPli0WAJ3RFlQXxwKkVJuuHukwUm46Zkv634
 5nAoFvYvf3WkA0dE8f8tYOJaxAucDCpyjD/pQ==
IronPort-HdrOrdr: A9a23:n9aRVKAy8uXhv3jlHelu55DYdb4zR+YMi2TDGXoQdfUzSL3mqy
 nOpoV46faQsl0ssR4b6LW90cW7L0801KQFhbX5eI3SOjUO21HFEGgB1+TfKlTbckWSygce79
 YYT0C6Y+eAamSS5vyKgzVQfexA/DD9ytHSuQ/EpU0dNz2ChpsQkjtRO0KmMglTSBNdDZQ0UK
 eN/8YvnUvZRZwvBP7LekXs1IX4zeH2qA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,170,1643670000"; 
   d="scan'208";a="25396250"
X-MGA-submission: =?us-ascii?q?MDHbvWpatNLSPRV3g7psM9fbL03QZQWieepo7G?=
 =?us-ascii?q?BUKXD/8Qd8jD7Ya5IWYrF8ni+W/Dq1/Jtv4zzeJv2bTawU+JCsPotj/g?=
 =?us-ascii?q?0lLFdzQKLNakaO4XVsIiIQ1SFoCjmdMiqj0bV2sxw1GoYgVU4DpKGGeQ?=
 =?us-ascii?q?eAlL1HIA/PhaCiy09JDaqW+A=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 10:16:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1646903810;
	bh=dR9sKahbpVQAJ/zVmZdkq11wDS4/db973LZwhCDHxkU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LcLiIxrp4x+I/qKCBj5W5p9Zb45IoY1Yd82IGtxf4ocLZW0YGICZCXnN3P2HSnYmw
	 mrMVOBl06ZAT/9hjtgL5dOppocjFHx9XUMtECPiBYhsbYpgC8LMhNwpJtaygo3uCCQ
	 l6IfUYB95g2AdJAxsvXoZR+5P6Ru/nIdZZV6EHYc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [212.144.252.253] ([212.144.252.253]) by web-mail.web.de
 (3c-app-webde-bap20.server.lan [172.19.172.20]) (via HTTP); Thu, 10 Mar
 2022 10:16:50 +0100
MIME-Version: 1.0
Message-ID: <trinity-819ef152-a230-487d-a730-fa70e5275ce3-1646903810019@3c-app-webde-bap20>
From: Markus Elfring <Markus.Elfring@web.de>
To: Eric Wheeler <cocci@lists.ewheeler.net>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Mar 2022 10:16:50 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <ce6ae8a0-9976-4177-bce7-446d54bdc4f1@ewheeler.net>
References: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net>
 <alpine.DEB.2.22.394.2203090654100.4094@hadrien>
 <a32a6aea-bc17-2e56-947a-99325ab91265@ewheeler.net>
 <alpine.DEB.2.22.394.2203092218430.35182@hadrien>
 <ce6ae8a0-9976-4177-bce7-446d54bdc4f1@ewheeler.net>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:TeyscSNY8WyLoeR4TwMMbiwnOs/bBxAFezuxVT7N/aEK6HJYQv45JJXykgYc6ESUeZQ4G
 Ma8n40yQMymGF/w0YUdjMol4sqRR7qnsbDL26aImDyi53XKjsPzTalWpk7yOZwCdGLTCL7R0E/gq
 ioGwLNcaxF8HZ1D87JJkg0uKThUL5sTJ9hejIAx3YEm0ap0U7jf6SHLUgZSaMZVu3SbaqEEGARq9
 hEmORmEQEBGzrFeOIokJ9KmViSABQesfAGqZJVPXRvQbIcCRl4kvH3mCR2T8i2tKHfoEaWM85V3n
 xE=
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nt/6kBkWc6o=:6OHA5imxITAHjZ9KlEb+Zi
 ShMnBh+ZWTngND02l2ysTN2/1WSL/r+krHiUrVGtu292fWyxR+PLGwoaBSIQBIN3Ifq4qbubf
 ThcoyxJ0ffHpqobR2i+K3QUz/QJnRErxNPwoZ4CrCC49WDGpYCKgQ3aoG39hYx94X5Ipq/CbS
 LCtlQcw5s73YodiJ4+TcRo97QiWUeDoooeCcfeXrsjJ/NFbf5dr4N0iWqUnzGhnrQrSS9u83u
 gyg3jPeHEobrLiYEUbqlci8fD0v9C5OLJz0WJFr2t+IiDwFSNiIYM9Zh4iXgHX6ZD2LnK5Xic
 WcOMSUkxZ4No2IjjM0GVr8Hz1waR0AAvakmyNF4fij4UklbXTaPcRN2i1hlwvdPHYh1Wkn7mA
 TcLqdfBY+0wDE7/h9z3drmb9kDZUVMkDX3eK9hV+Yto/+1lBdQHo5u1qyCczeMrvGTIz7X/SW
 CoboBLn/TEPXVu3YJ9Svbg/M8eEDHKCtIr6LQBjQ1cDdTDdy7Wqp0tP8jQzIp7s3sSZMUhIbT
 AIp/3/l+60jJ15/EdEB59kjFb/0QY2WbOLPsB0dtgAuVJW5wYHfxdef13bj5rnMChJPMCBkuk
 qmgSKqlA3S7REIUqGdvShw9K/ATx6q0aUPdUz3FVX7E5nHLUMU3PgFdG+1nJdzLPg6arvPRDJ
 iwgcKdIpFOaeneg0UJn9CtdBeqwh1iUwZ6P3TTrvz7Hsc7LNd/UoEB4/tgBjrxvh4+Ng3TUTS
 uvGUEIiRFUFz+e5Yg+msJDxoHVkYDd3tn3CFxp4eRD9YKPODXJStPypTtp95gki3FAdVDBhsJ
 bnNW5qD
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Does SmPL support regex groups?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 202
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/trinity-819ef152-a230-487d-a730-fa70e5275ce3-1646903810019%403c-app-webde-bap20>

> Anyway, my needs for this are already met with a combination of SmPL
> cleverness and a bit of manual intervention,

Would you like to share a bit more information about a (temporary) solutio=
n
which you find good enough at the moment?


> so no need to rush about trying to implement this on my behalf

Thanks for your nice feedback.


> unless it would benefit others.

I guess that further demonstrations for the application of (advanced)
regular expressions in combination with the semantic patch language can he=
lp
to clarify corresponding use cases.

Regards,
Markus
