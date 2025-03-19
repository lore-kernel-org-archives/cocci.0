Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DE5C35FFF
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 10:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lY04QL921rH0X9PWQlziFgKPd9PtyMsNeRCAL+M2htY=;
  b=kHUCl6DZLYM7BN/6cBpPv3zRGDmliLbyVZAmxq2Y0mHb1GNF9ct1Ad+5
   SfMNCnc5CctqZVpn8+O1Wos5Dw+tVkg7TKrOIAENT7gh37/01UqPn2ERw
   B4L4WEKCOmhFUPZG1SHwzZm2+zoHMkQvShmCtZBD22wvhcG2PWKdgdP2M
   M=;
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
   d="scan'208";a="213680284"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 11:57:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0107BE0D1D; Wed, 19 Mar 2025 11:57:15 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E344DE007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 11:57:10 +0100 (CET)
IronPort-SDR: 67daa306_AD8xIsuVbck9vycWW9Ms2v0xLuacrxMPSuXWYxNh/7U5NBa
 IgNtIWw6eDrlnqi/Sw78qSYfrotlMx8iNwNCyEg==
X-IPAS-Result: =?us-ascii?q?A0H5BQCjotpngAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRIFXMwQLSIRWj1CBdDCEO4c7h1OIdYNUDwEDAQ1BAQIEAQEDBIIMgnQCi?=
 =?us-ascii?q?yACHgcBBDQTAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHD?=
 =?us-ascii?q?goxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLCxoCJ?=
 =?us-ascii?q?gICVgYBFAEBgn6CMAEDDiMHrj+BMoEBggwBAQbaXB8sIleBZQmBGi6FbYJjA?=
 =?us-ascii?q?YYngx2BHycPgVVEgRUnC4J4PoRDg1uCaYIzhEFniU6IVIdWkEdSexwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSlDAyo0MSOBIgU0PzgpgWNpSToCDQI1ghskWIIoagQFgSSCNoQ+h?=
 =?us-ascii?q?ECFUIIRgV0DAyIBgjBvdxyDFjV2P4RhLVCCFh1AAgELbT03CQsbBj2jbIVSG?=
 =?us-ascii?q?4JYkxgIsnc0B4I4gWaBYwyfXgYTL5dGDgaRWIElLphQIqkRgX4jgVwzGiSDN?=
 =?us-ascii?q?k8DGQ+OIYQttQJCNTwCBwEKAQEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:39gVx6GMLSEl8qYOpLqENseALOsnbusQ8zAXPjNKOHlom6uj5r
 mTdZUgpHnJYVMqM03I9uruBEDtewK5yXcx2/h3AV7AZmfbUQmTQL2KhLGKq1Dd8m/Fh4xgPM
 xbE5SWZueAbmRSsea/xhWkGNA9x9S9/Lmvnvq29QYWcegnUcBdBxwSMHfiLqSafng8OXKzea
 D32vZ6
X-Talos-CUID: 9a23:0JUUTmwCA9Sm+r32Rx7qBgUNJdogI3Hx407uGAyhDGxZSqHMTXGprfY=
X-Talos-MUID: 9a23:8L/fXQQARbD6BqXNRXTNuHZIKPpPx52FGWEtm54sntmmFXFZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="112016055"
X-MGA-submission: =?us-ascii?q?MDFzyPO5M/FB+YexAIPzuAKddpVLtP5JccaV3W?=
 =?us-ascii?q?2SbKMmu4c3QI0yNg1RbEXlKqwZBh38yUvzeBc32LM16fS/A2Ei/PC9/E?=
 =?us-ascii?q?qUqfJETv64jhqecKN1bdTFJImPYyk14+QdoK9bnj4ieiBfQnOlx5/wC2?=
 =?us-ascii?q?lJclbv77pjkvtEcrYY7Vvx2w=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 11:57:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742381824; x=1742986624; i=markus.elfring@web.de;
	bh=lY04QL921rH0X9PWQlziFgKPd9PtyMsNeRCAL+M2htY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p/Q9r2C9IXYbDll9+3DTMpNqm9U7NgLkX/0VNQIyJA/yAGRt/lsJb4ziy3j1rcUq
	 sBi5txXuK2bxeL1iCGhoeuvCX1mj7C51G/L7dsN/cOD4KCuQrsnsYkQ6iy1y0CXWS
	 z5SUzdTIMAL4iEGBt43agVQJ1mO+sNeOfhTqrRlpFqW4B2YKrlwvMgG6kLuetsTm9
	 fyq9tfVwtq3oESLXUQmqPNMjKYI89iEBx7hIkqvbWlJi3uFucs63MjyBxKLTitPEf
	 mDw6mlDTnayHcg7o43w6TVDxk+W1OpGduMTarPjL7BN234R7hDxkbeUM2axRlER1Z
	 HxipaAfhH0Opwt9HYA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.16]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuSe-1tIF6a2TsS-00heXb; Wed, 19
 Mar 2025 11:57:04 +0100
Message-ID: <7a975f4e-e35f-48c9-9554-cbfbc44c81e1@web.de>
Date: Wed, 19 Mar 2025 11:57:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kees Cook <kees@kernel.org>, cocci@inria.fr
References: <202503180924.2135CF8FD@keescook>
 <F7BB5789-F9F2-4D17-986A-AD7BC976F18B@inria.fr>
 <202503182023.D7C4D91@keescook>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <202503182023.D7C4D91@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:syE5mGVaDg60O0ufvkCSNwshSunnZ4pypy+aE87yLQ/tzoah++v
 fzIroBoklIinxQg/U/CNw7y0pYXMty3gdtSV0KPrYg/AmgfbhIgjugQe7Zz2mSHdSkp7Aew
 BETCDl8QVzSDt2DbYCqyqNCKSPbuPR9evQgJC+3mOWa7L2xDjC/o/ls6pWG1+b8nySCBfj0
 qc0rCr+741JF1lLioBmtw==
UI-OutboundReport: notjunk:1;M01:P0:Hh63Jn3CieM=;zjN69MqRgkoWxeKdhl5WpqNWP/J
 p8uzcf/fniTrX4GaISZiPTPVs+ViwXfZG1WOhKtLzsGx7V4tY81aOUJwZHmYnFIGnQuhMVFvd
 VdTeaTs4KBYrGuymj1Y6vP4HG8390YsaY5EHNXnj6Yeys0V6jJmA4+gbccthBEF3m3/6S+1GH
 PNqHSxWP4NwTEF1EW/Qsc2ZrvP8GiLqfDAJLDQw2fanW2w/AI90TOEwRvZDauVY18L11r91qt
 ipDTrxubDvcTrx+x+NbdgkYMIoFiHx2ryCivj0OtXk1E8dM1j7qJqAODvERjN2zY+oWHKBh2X
 Wjsn9DVMq89Si1jeKJEqufTdyBgwAEHiAxfObWVHPagi5OD+1QwhqbqtgM+urEUaHQ0m1qGNL
 ODSoJhfVx4dtU7+PnaXnK+0CMWNCsgoQHj9JMBKTK4Fyb+NVpmbAXzbbLgCR4Tiw7nOmzhtXw
 Z3fqxWDlpVPOk2pGGb6S0o2oDUW+9j9ra5TJ5GkjKviiguHXn/HzjSCAjyhd9VLl+vKEQFQWL
 5owQKaPehStwxMkrX+qr6K9McjI3rpLi5GvEW7Oa0XT8QItthG2q2wEkX5EgYpWVvsoJMtYCS
 05nc3jPhiVU4RzxhkmSitaq/s1MSIfs4zC30u88eMK7SeUidqXxDEShRjMFNOTSL9r+9N0+LX
 rY3lLnJcaU+os7724vIESVSqChURVHnz3ZapSkh04W+D8dj2jXEcgxMxUgv3vw+WGQrL1Y9y9
 sG4eK5YTVislVr64n1OGmko064oDhXwuuGgauPwEFu0EFEYiOIJuWCIIYURoXvbsQG4mQRIZt
 hRolU+kB6YCyejTBmduxpx21C+MKqzuPQqVLMZa3dlt56Ozg8motvczPVJsfFSO0XmS9f65dz
 ESIeRZieEu3pJdNp7Lb5GMBlWyJcQjqpNSQ1iD3zYbgy4jg73RSwF3rYXVWsffgI97DUytH9v
 kukQr8D0MQd4SMzKWP9pUN4mPs+rNGICvPxJmPmwe+qWcbc8H/E9uiWp1g9FU4LcnAs4mEu+Q
 OgfuvRjFyAc+a2aHEZXJUEqOTmQd1m/NvwphtWfpliU8ZRUchlqsOmbD0Qs2Tx1sP43tkjoaL
 4ZHEYvjT7EJYFmbQAN9mLb/4L1D6UtOMO2rr9odhe+na4+Y6TgU85L937xSnzy3EcMRrtgYJv
 m2D6X6OBXb4xi7fRaSZ0GAcRxrA2M8DlCEzSqmPxto9r2jKjz655yuZihZ3a3QjHoU6hNAA5H
 08NmWVEH4Bqlx+l2r5FAKgXGVqIiwB3B1h5QhqpF63hIiZFVi1Dgyl1ew09+GkK5S97l5rxxK
 KI04r5N6lqVDfexz5XpC060QBFNPKZX5gfqsyYHVKVRU3RURPE9PknApyiQO3R9ZhDQlxf0uz
 bAOxs4mw4yb9amYEY/YgD8WyMHxCv5axj+lbVW2kx/uaj8fWa6C2pnhz/6h4JQ13MSzJzBx36
 3kZKhUEzMBhNHK1aOMbsik7f4gBAixGDQ+a1oyPXHHNKyF45s
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2645
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/7a975f4e-e35f-48c9-9554-cbfbc44c81e1%40web.de>

> This parses, but don't match (from crypto/asymmetric_keys/x509_cert_pars=
er.c):

Will further information (like the following) trigger any software adjustm=
ents?

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time spatch -=
-parse-c crypto/asymmetric_keys/x509_cert_parser.c
=E2=80=A6
(ONCE) CPP-MACRO: found string-macro fmt
including crypto/asymmetric_keys/x509_parser.h
(ONCE) CPP-MACRO: found toplevel macro noptvirg: DEFINE_FREE
(ONCE) CPP-MACRO: found higher order macro : DEFINE_FREE
TYPEDEF:_handle_typedef=3Dfalse. Not normal if don't come from exn
(ONCE) CPP-TYPEDEF: promoting:(4) x509_free_certificate on line 63
(ONCE) CPP-TYPEDEF: promoting:(4) kfree on line 64
TYPEDEF CONFLICT:kfree
TODO:typedef now used as an identifier
TYPEDEF CONFLICT:x509_free_certificate
transforming some ident into a typedef
crypto/asymmetric_keys/x509_cert_parser.c:63: passed:cert
crypto/asymmetric_keys/x509_cert_parser.c:64: passed:ctx
=2D----------------------------------------------------------------------
NB total files =3D 1; perfect =3D 1; pbs =3D 0; timeout =3D 0; =3D=3D=3D=
=3D=3D=3D=3D=3D=3D> 100%
nb good =3D 809,  nb passed =3D 2 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 0.25% passe=
d
nb good =3D 809,  nb bad =3D 0 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 100.00% good o=
r passed

real    0m0,071s
user    0m0,054s
sys     0m0,014s


Regards,
Markus
