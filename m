Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8D2C4345F
	for <cocci@archiver.kernel.org>; Thu,  2 May 2024 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=TxzkWRj5I1SwpnXVZR7dtcEzOYhUWvyRbz0A9Ndi8KA=;
  b=aQES2ncKyia4mvd4GSudwLMXUm33JdaVSqNI+8xZvBjw8njRcugYrxYj
   ekx7Pu8k0vkzFJ8HoQFnGQZCOdPBzipiHf1Du4FSdGXwBXNMulgLP4bDC
   b6sBNIYa85fYMy8j6q3Cd3eEbHaQSEf+9IuyWi+HUV8rbsvvA26ZHi/MR
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@sang-engineering.com
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="asc'?scan'208";a="164279574"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 May 2024 19:40:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 23528E0CD0; Thu,  2 May 2024 19:40:33 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A15DDE0133
	for <cocci@sympa.inria.fr>; Thu,  2 May 2024 19:40:32 +0200 (CEST)
IronPort-SDR: 6633cffd_y8V1reSFHddZI5HsxHIqE7StR7ON5auOmdX+Up7lmBaUsDe
 XbudOtvUJK5z8DM+ZTzgNvIhJDWWhg3v/aa9P9g==
X-IPAS-Result: =?us-ascii?q?A0HIAQDczzNmkCH+dcJaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYJDgVIxAwcISI1SiG+SR4Voh1kIBwEDAQgFRAQBAQMBA4R2CQKIL?=
 =?us-ascii?q?yAGAQQzBg4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBAQEBA?=
 =?us-ascii?q?SAeEAoEJ4VwDYJnAYEFgQ0BAQEBAQEBAQEBAQEBASIrAoEJAQEBAgFAAQE3A?=
 =?us-ascii?q?QQLC0ZWBoMTAYJBIwe3J4E0gQGCDAEBBtwdgVsHCYFIAYFWhkwLAYFTh296g?=
 =?us-ascii?q?k+EPz6LB6Z2VIEZA1khEwFLChMXCz4JFgIWAxsUBDAPCQsmAyoGNgISDAYGB?=
 =?us-ascii?q?lkgFgkEIwMIBAMQNAMgbxEDBBoECwc4PYF8gTUEE0QDgTiJfQyBfYE0KYFOK?=
 =?us-ascii?q?YQhS2yEC4F4DmKDYYI0HUADC209NRQbBiIBnncwiHTFcoQdoSxNE4NfAZNTk?=
 =?us-ascii?q?m4uh1iQXKJ6hg2BeySBXDMaI4M3TwMZD44gGYNhnHREMjsCBwsBAQMJiSKBS?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Qo=
IronPort-HdrOrdr: A9a23:pxb55qo/dThJ+ZmtxZEUGhoaV5odeYIsimQD101hICG9vPb5qy
 mLpoV86faUskd3ZJhEo7u90ca7Lk80maQa3WBVB8baYOCEghrNEGgB1/qB/9SIIUSXnINgPO
 VbAs1D4bbLfDtHZKjBgTWQIpId7Z289L2wwd3T1W1sSwYCUc1d0zs=
X-Talos-CUID: 9a23:0k548WM8J3NmX+5DQAg99mMrXZ8ZImTn/i3hM3eSEHQqR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AyNwQ7A0s+CSAjwZZLSYktv6a5TUj2IP+GEUny4s?=
 =?us-ascii?q?95Oq+aXV/ERWgjDWZTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="asc'?scan'208";a="164279535"
X-MGA-submission: =?us-ascii?q?MDFxGtuCMrZ/GQa22ua8A2UAnLv00J+KhbDot1?=
 =?us-ascii?q?y23sAmBsNUE1DIe9f3i0TfGZcwmVXmZbvs05ezK3PaU5g80w+nG0btsv?=
 =?us-ascii?q?iOeFLugCR/+H8B594oXeBSdaNQ7lb791uOPMfjx5YsYa8a1TQKi08wnG?=
 =?us-ascii?q?+VMfATnDJZUZzdV4Tp6xuA6A=3D=3D?=
Received: from www.zeus03.de (HELO mail.zeus03.de) ([194.117.254.33])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 19:40:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Txzk
	WRj5I1SwpnXVZR7dtcEzOYhUWvyRbz0A9Ndi8KA=; b=E0J6q6zy92ZoVwZvDtk/
	TJYXkmzVYrBW9wiikb+UnNIz+PWAdBMPEtyXLNZRahApL71azSDGp/zG/dvFDyyo
	3PNLdEwKsyyQUow7oDG7tqpTjW2MYNvnUY9xPjO4O+OLKQ7XHI4nVzgOw9drg3qT
	qAgHD82zfPJOR7V+kp3tljqTaBoTqJdYyb1hsgi0NmZuazZ2eO2BK5bSoN5ceNCf
	6vRZkXIT1+08JEe5XBNXBoFec66RhOXpfozR6Pkexm5G2jDcgxJlqfLuzeCUfnLA
	K3HOlR+i9ur2KAoRsm/92DfrgJWDLiYaU/IqUQJRat0Xxmqv98jNl9KDojrBzYhL
	qQ==
Received: (qmail 3323666 invoked from network); 2 May 2024 19:40:12 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 May 2024 19:40:12 +0200
X-UD-Smtp-Session: l3s3148p1@ZOBcGHwXUI1ehhrT
Date: Thu, 2 May 2024 19:40:11 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: cocci@inria.fr
Message-ID: <20240502174011.rzlhhttpctw4vzlv@ninjato>
References: <20240502085433.GA30267@redhat.com>
 <4vbt6ijjdgqd23lyqgkydqvzvhqeq37a3uqmxvif3amur3ei7z@lokx6uszecfy>
 <20240502161625.GB30267@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2uh6uqpdwxecmsvp"
Content-Disposition: inline
In-Reply-To: <20240502161625.GB30267@redhat.com>
Subject: Re: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Loop: cocci@inria.fr
X-Sequence: 1687
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/20240502174011.rzlhhttpctw4vzlv%40ninjato>


--2uh6uqpdwxecmsvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I think there is some significant difference between OCaml 4.x and
> OCaml 5.1.1.  Can you see if updating to OCaml 5.1.1 makes it slower?

Sorry, there is no OCaml 5 for Debian yet and compiling the toolchain
itself is beyond my bandwidth currently.


--2uh6uqpdwxecmsvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYzz/MACgkQFA3kzBSg
KbYjTBAAhNli4uJvWEVHFkVm5+Wj9KvU/9pl2WhZCP9IHoJvksWaWmj9SL/2KSVC
QGeBV9wyb343dPwyMv29phUi8eyFx5Mj+DHXf1ZIGxV2EnW8vTnFvsC5iQHJ1qrB
4FtHvQ04MNjJ1DL0cetT5BETDSsB54W/SMjKBlifae8IzB/cEDumvWzDvAhmzlcL
T6qr1XdFXFNgmmMNg0mCrBRT33sl0Gbi9Q8BuwwYJeSM5+NikBfhR31JY/mwpk3y
lg47dsGaMWvjyDovAAuKDZ43fPfSGRq7Cmk/nctbGX9bfIwDaCxGItLWDVZRxL6d
z85u3r6urPKkD3HKRaW6p4/jHwxFVcMRPtVlA8yOYgHx+Jwvqi7Kw4qsdw3oopCD
rxIGN1icUk6+Cq7MG+Wu+wqcsw2hNmhpiYkdSlpumIZGtpU7YQeWfHDaO5hQrFC7
a+q17TX0ZSUqA89anxl8ONwP2SpN1EP+is1tC5vcmjhBfxbH6xasZ4wdcoe72P3Y
d+/gD06pbpnplwYELVSTWosW/hSMSAKvPISWQ7dy36MqMIEaWSheEm3p5LVIu/rC
dbkfatMHjvMgURasO3b4ldONGDNuWCt0afOsPAGcgpRAB7Sd51nTiAYWwGBoIr2f
LXqBgNMu6oo18zr3Zy9UWwJYtg2DwQNmirqu9isT/cFpRlLqTwA=
=msOH
-----END PGP SIGNATURE-----

--2uh6uqpdwxecmsvp--
