Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BBCC36000
	for <cocci@archiver.kernel.org>; Fri, 21 Mar 2025 13:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NMLKnTjiFM0vxw1RX8+GHtoMkFU271igKPAkEgdr2WY=;
  b=ovxZrs0G3tzqN7+RIxea6ft6YNc6j7Monum+uRGBTsP8V2LbizE6hnH5
   ShsVYyixmZ7rdR8gKNnZSleiNw52JswtcTJCC4NfOghTEdr0SU4M+wDHm
   frk0weglfXaUx1yAhRvV3dRuM/sUotOdpXwSrg0Fq/uaXrAjYEW3Y2N+2
   U=;
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
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214136642"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2025 14:28:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D3391E0D1E; Fri, 21 Mar 2025 14:28:32 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D35F0E007A
	for <cocci@sympa.inria.fr>; Fri, 21 Mar 2025 14:28:30 +0100 (CET)
IronPort-SDR: 67dd6967_oHY7b/9k3UZ/cqZBuozkO1Uv1mNpUguDfd5Epg2KSlInVYt
 n/pQzqPDe2uMX0p2P4b7mItUs+wjoJdd1qBkPlg==
X-IPAS-Result: =?us-ascii?q?A0EKCgDQaN1ng07ASNlaHgEBCxIMQIFVgkJ9WjMEC0gIh?=
 =?us-ascii?q?E6PUYF0hGuPDoh1g1QPAQMBDTsGAQIEAQEDBIUAAosiAh4HAQQ0EwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBOgcOO4V7DUkBEAGCAIEsg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEBAQEBAQEXAg06RAIBAyMdAQERJw8LGgImAgJWBgEUA?=
 =?us-ascii?q?QGCfgGCLwEDMQcNBq47gTKBAYIMAQEGgVhB2EMfLCJXgWUDBoEaLoVtgmMBh?=
 =?us-ascii?q?ieEPCcPgVVEgTyDAz6CYQSFOYJpgjOEQ2eZdpBjUnscA1ksAVUTFwsHBYEpQ?=
 =?us-ascii?q?wMqNDEjgSIFNDQOOCmBY2lJOgINAjWCGyRYgihqBAWBJII2hD6EQIVQghGBX?=
 =?us-ascii?q?AMDFg8Bgx91HINLdT2EYy1QgkUdQAIBC209NwkLGwY9o087hSRXAshfNAeCO?=
 =?us-ascii?q?IFmgWMMiimVNQYTL4NwAZNVDgaSfS6YUCKNY5sugX4jgUQRBzMaJIM2TwMZD?=
 =?us-ascii?q?44hGYQUhGC2LkI1AjoCBwEKAQEDCYVGAQGFJ4UtgUsBAQ?=
IronPort-PHdr: A9a23:w9CgeRwdgAo/TDrXCzKowFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xaZva0m1QKQB9+TwskHotSVmpijY1BI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDebRtEiCChbb9uI
 xm6sAXcutQIjYd8N6081gbHrnxUdutZwm9lOUidkxHg6Mmu4ZVt6T5Qu/Uv985BVaX1YaE1R
 qFGATolLm44+tTluQHMQgWT6HQcVH4WkgdTDAje8B76RJbxvTDkued7xSKXINf5TbEwWTSl8
 qdrVBrlgzoJOjIl7G3ajNF7gaRGqxyjuhN/2ZbZboKbOvVxcKzTYM0URWRBUMlTSyNPDZixb
 5cWD+cbIepUs5fxqlkIoBCjBQesHuTvyjpQi3Hxx6I6yechERzd3Ac9ENwOtHrUrM/0NKcUX
 uC+0a7FwzLZYPNM2jf99ZPIfgour/GIU7Jwa8vRyU8gFw7egFSft5fqMymI2esTqmWW6fdrW
 u2zhWA9sQ5xviSvydk2ionPno8bxV/K+Dt2zYs3JtC2RkF1b9G5HJZSqyyWKZd7TMwmTm12u
 Ss217wLt5G5cSYFyJoqxgDTZviHfYWU/B7uSumfLDFlj3xrf7K/ggy98UmmyuDkTsm10EpKr
 ipCktnKrHwN0AbT6seBR/Bg/UmhwS6C2x7O5uxGO0w5l7TXJ4Q8zrM0iJYfq0bOEyzulEjyg
 6KabEsp9vWy5+njbLjqvJGROo5yhwrjLKkuntG/Af8kMgcQRWiV5OW81bz98kDhXLlHiOA9n
 LPDv5DAP8sbo7a0Aw9L3YYn7BayFzKm0NMFnXkbNl5EdgyIgJPzN17TPv/0Ffa/g1Kynzd33
 /3KIKDtD5fXInXBjrvtZ6tx5kpCxAYpz91S5IpYCrQbL/LyXk/xusbYDhg8MwGsxOjoEs991
 oADWWKUGKOXP6fSsVGS5uIuJemMa5QYuTjjJPc+/fLhkGE2lUcbfaayxZQXcmy3Hux6I0WFZ
 nrhmsoNHX8QvgUiVOzqlEGCUTlLanmuWKIz+i00CIO9AIfYRoGthaSB0z2hEp1XYGBGEFGMH
 m3ye4WKQfdfIB6Vd+/skTsCHZwxVYMo0Vn6tAv91bZuKsLb/yQZsdTo090jo6XYkho59BR1C
 d6c2ieDVTJahGQNEho/xqNiugRQzlmZ0K53y6h9HMZQ+ugPfwM0L5/awMRlBtq0Vg+XLYTBc
 0qvXtjzWWJ5ddk22dJbOy6Vev2nhxHHhG+xBqMN0qeMHNoy+77d2H74I4B8zWzH3e8vlQpuW
 dNBYEuhgKM37A3PH8jRiUzMsq+wdrkHmgPJ+n2Cy2Wmo0xSFgJ9Au3eRX5KXkLNtpzi41/aC
 bqnCLApKAxEnOuLMKhXcZvEiVtcRfHsEMvTaSS9ljT4Hg6Gk5WLaoeiYGABxGPdBUwDxhgU5
 mqDPBMiCz2JpmXDEHpxGFipb06EHfBWjnS9Qwd0ygiLaxYkzL+p4lsOguTaTfoP37UCsSNnq
 jNuHV/70ciEQ9yH7xFseqlRe7ZfqB9OyH7ZugphP5ehM7Eqh1gQdB5ytl/v0BM/A5tJkMwjp
 ncnhARoLqfQ3FREfjKelZf+X9+fYkz75hOycOj73l/E0dCZ0rgC4rI0phSrvQ2kEFYj72Qyy
 8NcgDOX4pTHChZXUIqkCB9osUcg4eiLOG9it9CxtzUkK6S/vz7c1sh8AeIkzk3lZNJDKOafE
 xe0FcQGBs+oIehsml6zbxtCMvoBkcx8d86gafaC37ameeh6mzfzx0FO+oNgyQSh8yRmS+jH9
 4kIybeU00HUMlW0xEfkqc3xlY1eMHs3F3C81DOiKYpffKx0cq4UBG3oL8D9lbAcz9b9HnVf8
 lCkHVYP3sSkLAGTY1LK1gpVzU0LoHajlENU1hRMmioy5uqa1S3KmKH5cQYff3VMXC9khEvtJ
 o69i5YbWlKpZk4njknt6UH/zqld7KNxSgubCWJBZSvrNCdPVqWqt7yNS9FC4tUkvG1bXf+9b
 laTVrPm60FDjGW8RS0HlWp9KGHis46xhxFgjWOBMHt/yRiRMdp9wxvS/p2URPJc2CYHWDgtj
 DDWAlamONz6td6QlprFrqW/Tzf7D8IVLnOtlNLa8nTrtggISVWlkvu+m8PqC10/2C7/jJxxU
 DnQ6Q37es/t3ri7NuRueg9pAkX94ox0ANIb8MN4iZcO1HwdnpjQ82AAlDK5FNxB2r/lKlcJS
 yQKxdH9/wXvnkFuZCHspcqxRjCGz81tasPvKEYfwCEg9IZnDKmO7bpLtTR4qBy0oEiCBJo11
 idYwvwo5nkAhugPswd41SSRDIcZGkxANDDtnRCFvJiu6b9ab2G1ff2sxVJzyJq/WaqarFgWC
 xObMt8yWDV95cJlPBfQ3W3vv8v6LcLIY4tbv0+RlArcyfdYItQ9m7ID1y9gJH64rXMi0fEyl
 xAowpyw+oSKTgcltKvrBxlFKnj/YN4V8TyrkqtU2Mqbl4n9G5J8BnAAR5H1SfHuSTsUua2hP
 AGLdV904n7JHL3CAUqU80xhtWqJSpmtOyjRL34chcNrQB3XTKBGqCYTWjhy3pswFwTxgdfkb
 F88/TcJoFjxthpLzOtscRj5SGbW4gmyOH8yT9CEIRxa4xsnhQ+dONGC7u91AyBT/4Gw5A2LJ
 GuBYg1UDGYPEkWaDlHnN7Oq6JHO6e+dTua5KvLPZ/2Jp4k8H7+Qwomz14J94zuWHsCII2UkE
 PAxnEZOHDh4F8nfhzQTWnkXmibKPKv57F+3/ix6qNz68ey+Aluwo9TVTeIDa5Mwq0PT4+/LL
 eObiSdnJCwN05oNwSSN070DxBsJjDkocTCxELMGvCqLTaTKm6YRAQRIDkE7fMZO8a842RFAf
 MDBjdagnJtxlP0oEBFoUVL7m8emTdMHKSexORmUYSTDfKTDPjDNz8ztNOmkTqZMiexPqxCqk
 TOcDlOlITmJ0TXkHUPKU6kEnGSQOxpQv5u4exBmBD34Td7oXRa8Ncd+kTw8xbBcbpziKmMWd
 zRxIRolRly46CRFnrNgFmYH4nc3dYFsfg6G4uOeJptE6ZNW
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:fVCt7aA6gT2r+7flHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:fp+p22NfwFPpPO5DWRl80nU0S8AZbXTQlFfAHECfOz5ucejA
X-Talos-MUID: =?us-ascii?q?9a23=3AeDh7VAwALDRzkJfV1fHRSn/PnreaqLmAGksJtYg?=
 =?us-ascii?q?Uh8iFa30tJm+2ghb0QIByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="112257826"
X-MGA-submission: =?us-ascii?q?MDEhaUnB/lKq8NXUBVBlQIkRVIRre55Uj9iEpn?=
 =?us-ascii?q?BmILyyyFI5rOb3rT6srUnipN7sPHBpQHTEPr7XCfa4StE4Cs3dadS72/?=
 =?us-ascii?q?bw8I35UTRKm3sR9PiwA/vOQWquVre4QeCHS8RVgB4HPgHBGRC9reubEQ?=
 =?us-ascii?q?Ykad2S2sAK4ykLI/gx94AKIA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 14:28:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742563687; x=1743168487; i=markus.elfring@web.de;
	bh=NMLKnTjiFM0vxw1RX8+GHtoMkFU271igKPAkEgdr2WY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BMUs6ZNGyr14aguBkA9ialzyW6Q+8ltLB5IaT+M487RVAL6z5d3//krBQfamE1N7
	 Fje2aNhsHPfrVpe+pGyikf58nHFJo0cFJVu9Y6Xb6LmuhYxpd+vlg3DlcICnazU7D
	 CVN0KEVKI/0m0RBRrhGI7skF3xezUtrKPPcixxb3Ui/dpBd7bi+lyf9M07AZd0M+y
	 K9VkRr63FeufNUcfgJc04VoBNaF3A5Ap4CPhlC3OXXo7DvhmwP19ai3O9KWuneMSu
	 zWuMRDBYQqH9VT/lly7rvZhfQ1W0cL2h0BZElnA1087lLBIfAayoH8uIAJUVKNVS5
	 jUKRKLF2BT0iA1yUog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.36]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mtgyj-1t1rZI0mjf-014g4r; Fri, 21
 Mar 2025 14:28:07 +0100
Message-ID: <634d9530-6d94-49ae-8abc-7b93d6c4fa7e@web.de>
Date: Fri, 21 Mar 2025 14:28:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?SMOla29uIEzDuHZkYWw=?= <hlovdal@gmail.com>, cocci@inria.fr
References: <99c55fe9-b23f-a6c2-575-9a856a8a358c@inria.fr>
 <CAACXqO9vVrOFyrcZhKZxvO=H9C7Kp-x2jM9O_mCTd=RA0mQ5XA@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAACXqO9vVrOFyrcZhKZxvO=H9C7Kp-x2jM9O_mCTd=RA0mQ5XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xoJpR4k78vV8NLqoUhvOGN8xgaIZGul/UpjGWvxoM1I6Ncbu309
 yfjffX/OrvLSbl1ARZBJjDBDDoMMks1x1EwoTRo+/5zlBCTgTIQjgxl1W0lXrvUzS/Bni68
 buBHIUfhAcbH6rhY2uAmB4Xkd9Eb0OtwRrqK7Jm5mjRbbSPmY70WNdG7mIECbuJgV0R7aKd
 CEoITg/PJOcti1JueA4GQ==
UI-OutboundReport: notjunk:1;M01:P0:mKkuJerP1Ac=;00KAqAYMedWsomg7s4OIvfepdXr
 Bt8M5hHy86o7anQwgMQziu4CYvYYXwrYQc6aFvwvbAQOJS1cY/2/SwS6Q3Q7PYdb3hWCtdL4z
 8VFXEKb3d+qdFFmJ8v5GxjnY1AUqO0WDVVpgM8r0aFTF85UZl/n0sYGOestMNKC1PtODBEexz
 22CZmkk67+gOdNa755a6uA0poBmnKXz9ZVJQN4Qtzy8CXsAsHA4vrub4dBzldh9UBEG8T0GmU
 4EABdzJCX9B+6ZtTKccXk1hq1Y+IOOFCDPnrtg7ZxcRo+gnbkHfeIEhRSLvW3n56JcNjX8WgX
 rbMGOrMrZn5gwwsmIWwBSPcRIsukUK0gjA3JH2mqWKHqwwM3N/njbhxx8gRM9fDoRNfBKNins
 Pmf6Kv36Rgaq7Hs8se+ZKx3iMQ77f5TQJL1j/PLEo3UTnhjUp0qbpbkcSOaxB8S2hihNVPB/v
 8wMtXNGuvLBwCtlWWgJKKBTj5qjmU1Y1KpRoem5AOx2SVxkaq++CirUs0Lmh1dnkvJuQeVnkg
 jId+UpcIzqu3phw1mdlYAZ+TtD1GAIkkGMpT01dl4i6nhZPkfBZPtVO9jGiCFKOcDfHDib4Xx
 FHfa/5lboXwbBnF+qOiAxMU98Rcyf5QCv9Ey8YYoCvcbTm5fM3OSE9IFbuDKcfjbTsVYRp74e
 bDxEdEdfSTY0PiyFF9WNtQc1Ltlu0c/st0Ip4sOqmVZyEMED/eKG6MDsmObMRmmiNO+AFk4jZ
 A28zDjkwrGdAvyzbVrGcnFWQRMYvBEECxgIrd3G1dNVihBxnZeLMV3f4GqCYTk7iq+CPFfyMA
 51TACoGMSvyAWXhzUa8T9IwFxGdnTm4tzG/JHde/omcOo9JuGi32zwyw/GB5olA2ZxCRlvdAp
 ayWvw2qpksY+1qm6AXiMxHp++6NGDilPpcNdq3PLhr1wrdioF8IlpwTWX911cDAg3P2J2fY0+
 2G5/LurwP73CoFCjGwzw09qCEPKsgbnNJFN9ODFkF7c0FJ9Vodgu1Rws5qgPeoZk1HreH13qM
 3buI3jJ0ynU/vdHQ8mdpX8isJms7jWKE9GQQmDhbJg2FxDha+N11FrmoV3duigVVJwhO2Dy+n
 5REvteN9XYKuBVW8+yKBLaWfdvMcWqcfdK6dap/Kh4kqlmzP9SkL1RKG81291GdbGizSKLY1/
 29BaIJnTSgSNLtbjahpg/xGx6ytR4TbW1qK3Hilirf/pqbcMiMWVEaFlrHXRpeG/8AE5iJCSm
 mvYtMtMmk0MvhCOBrk7Ux0Ccmo1KivHeCgZnUXuJA4Fhup+cpjYYG4D5k9OX3S7nkXesJuoXw
 rbNlbkV/uwZHtiOs1NrrdWmp4wETkR6npVfoFwiDL5XsjY9lpHOu1hqrw+1i9p3OqxsQipzX2
 Ji72hpcmCuD2MAZmi/tOjvAtxfrlKOEwPDCAMdsnjqpBh021TLPSMZONoxCvtSUdCYz7DQUv+
 vvGnrWLwsnKfgPZpV9BtjvIcgXcVvxQXNaFoL2EWzInrWsyRHmIx4kfYEyzNGALv6TyH/hw==
Subject: Re: [cocci] scoped_guard
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2666
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/634d9530-6d94-49ae-8abc-7b93d6c4fa7e%40web.de>

=E2=80=A6
> The concept seems similar to the `using` statement in C#,
=E2=80=A6

Would you find any information about a =E2=80=9Cwith statement=E2=80=9D
(according to the Python programming language) related?
https://docs.python.org/3/reference/compound_stmts.html#the-with-statement


Regards,
Markus
