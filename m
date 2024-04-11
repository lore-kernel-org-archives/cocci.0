Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB498C4345F
	for <cocci@archiver.kernel.org>; Thu, 11 Apr 2024 21:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5RkSbqwJaioGknCFErCn4yQr7kV38lJGxi0Rldxh9fs=;
  b=lKNaq8sl4ToyVv506V8V29SysGIxYLnXye1cHT9XTywGrW+fkUfsfqb+
   5AIliPhARFWlFbinDKLHY9iZcC0ybBaOseiDUm339IqaNtQpBBY3pemHO
   duRj4EXr1jzTIAlPD47/WBLSSGmJD1jNySeC3SpcKBt/uDLTAXGvP7QY1
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.07,194,1708383600"; 
   d="asc'?scan'208";a="161152538"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2024 22:59:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0700FE0AF6; Thu, 11 Apr 2024 22:59:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AAC33E0131
	for <cocci@sympa.inria.fr>; Thu, 11 Apr 2024 22:58:10 +0200 (CEST)
IronPort-SDR: 66184ee1_4TDVCtlk9se+lULLpBVQwUX94ZmWpST2u1hMAbRtEm1myIc
 oGsobJdfoyW5Gzp4tD+wKNcfn/NHBTjua+VI6RQ==
X-IPAS-Result: =?us-ascii?q?A0EQAAB4TRhmkNlUsotaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDgVIyBAtIjHNfiE8ghXqFdoZxiyeBfggHAQMBCAVEBAEBAwSEf?=
 =?us-ascii?q?wKIFwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QEBAQEgHhAOJ4VtDYJnAYEegSYBAQEBAQEBAQEBAQEdAg18AQEBAgFAAQE3A?=
 =?us-ascii?q?QQLC0YQRgaDEwGCPCMDsjGBNIEBggoBAQbcHYFaBwmBSAGBVoZKCwGBU4dqe?=
 =?us-ascii?q?icbgUlEhD8+iwaWZopsVIEZA1kyAUsKNAk6DwwaAi8NJCMCLEoKEAIWAx0YM?=
 =?us-ascii?q?hEJCyYDKgY2AhIMBgYGWyAWCQQjAwgEA1ADIHARAwQaBAsHOD2BRjiBPQQTR?=
 =?us-ascii?q?AOBQooXDIMzKYFQKYQ/QnGEIHcDRB1AA3g9NRQbBiIBnFAQiGSwN5UDhB2iD?=
 =?us-ascii?q?YNfAZNFknyYYqkFgWQ6gVwzGggoCIMiTwMZD44gGYh1mVpBNTsCBwsBAQMJi?=
 =?us-ascii?q?SKBSAEB?=
IronPort-PHdr: A9a23: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
 NedzMrO
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:hkTXmqwcay090yzK2ZQ2KrPwI71zdoMgy1knxilNoNJuE/Bws/
 re+8jztCWE7Ar5PUtMpTnuAsW9qB/nmqKdpLNhW4tKPzOW3VdATrsSjrcKqgeIc0aVygce79
 YDT0EUMr3N5DZB4/rH3A==
X-Talos-CUID: 9a23:0FvlUmCHMyVgfqH6Eys21X81GuN6SCbY5SfPOUqiMkNneKLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A0cly/g63z76day/7cyLEsZhxxoxZzLn1JmkQiq8?=
 =?us-ascii?q?Bou7HKHMpBSa/0zeeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,194,1708383600"; 
   d="asc'?scan'208";a="84521465"
X-MGA-submission: =?us-ascii?q?MDHTaW/9HZC0twPmk2Hd6sTuNJVFxEQb/uKCBo?=
 =?us-ascii?q?S7KS7GCR2ZH7d7d3jU1AYiaVxDVzB9dqGP7EvplHk3Re4MZijHNwU5fo?=
 =?us-ascii?q?MdgStL9+VEgCfWrhRHnfucuuaxfmaqH2YUkN8oVJoLup7R0TlrhfZAdz?=
 =?us-ascii?q?IK6pUkX0qKONetbVEkiNkUYg=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 22:58:09 +0200
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5DA4A6216F;
	Thu, 11 Apr 2024 20:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794A4C072AA;
	Thu, 11 Apr 2024 20:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712869087;
	bh=D19SfiKPoR/SYXhn4k16YX0Gi/iUKPHlNtdAuNqY2Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZKLSrmBIfGJa+lIHREGku86zEKXU+/dsfPD9FQSzCYHn528f3swBcmY49bncNtA18
	 UNZSihPRnCOf+tk0nV+US8fo+VEZAmfE/uewPWgoGJbSz89j/q01Z1Muzll8BF+yc+
	 1n87Gj/8amVLyN/rRdczlg6nhfJYNoDstsD3QevC5ZK+3+KOaO8QUg9QKcuBcb3Euy
	 oH5jG5qcklkwVDwtw60yrO8EJGrAqTM6a2F3Oea+lU9XV3a6SNuTIOrAV+YuvZycDY
	 jI/C85jMt4uRGMqoo4i3eOknGEhIZMQ3+conaFs+bXuQfTcGrCPhoPp5SlxOJX0WII
	 7xeVYSzZW3K6g==
Date: Thu, 11 Apr 2024 22:58:03 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <ZhhO29XtBmBkyuQo@shikoro>
References: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="10QjLvqprcIriVfo"
Content-Disposition: inline
In-Reply-To: <8056b6c5-9147-6e89-ce97-e1d17e675515@inria.fr>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] new version 1.2
Reply-To: Wolfram Sang <wsa@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1639
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/ZhhO29XtBmBkyuQo%40shikoro>


--10QjLvqprcIriVfo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Julia,

> There is a new version, 1.2.

I compiled it but the "--in-place" option does not work for me. Can you
reproduce that? "-in_place" worked fine with the 1.1.1 version from
Debian.

Thanks for all your work!

   Wolfram


--10QjLvqprcIriVfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYYTtYACgkQFA3kzBSg
KbbGtA/+NHgljZV5hVavIqx3z3gy9Wl98He8oyYlI3ftmMeEm5Q2UImhtwlDtaS9
v/EYjQP/GcM+lPLkMNaBscekmbdSDMzOYy+GBRUzWzBrckzgHLttAqoDGMq3+Enf
4CsUMmkBwF2UTmWZ8cQlsVAMxo74HVF4oiTwZ6hZGg0k615qNMQt0FbJ4/jNQ2xq
uYMJX7l4siycxfzpMKrKnrndDl1TO1XxHoG2waGbB8tHEUMxOZHqY6KlxjNWM7mU
CdSEb5jDr9cdRLhKuq66bUY2aa2bUh1Ohe1ruqumTwGj8QO8Ez5p+jVq60QWuRvq
wj0PGVT/wSnM0KTIgKZY8fzy90F9peYoXjg0SFLnTMHlRCxsLCcgP9yVK9OHKNcM
ThCC/vpE/vw9qQ0CWZxcSuudD9SK12z1tBb4juHfWkn773Ql7QgkCSYnf59mGONX
hWPJUsdeAxhJGk6nPQ5e5VY/u/IeGqXI81WW99Pk1krzQ4mFsVRSF/ZYyenH1OTM
SaZqyyA+A0tvVPAqzKuSNbuOWTewA2vpDtvsVkjlWQ0L/+mUIN9B3Pppu7Q9jYMc
LobKP7pYBV0s/xPJ8WySY5lLBjRc3PWYpSm257KOtKiIybX0vNKjAptiOprHBl2Z
9ZCDRvAHICtBAQW2bgTRnvaXVDG5UUPFLJd9kUiKcNl0ECqGENw=
=HEhu
-----END PGP SIGNATURE-----

--10QjLvqprcIriVfo--
