Return-Path: <SRS0=ztE1=4C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA82C2BA83
	for <cocci@archiver.kernel.org>; Fri, 14 Feb 2020 12:56:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ADC1222C2
	for <cocci@archiver.kernel.org>; Fri, 14 Feb 2020 12:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADC1222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01ECufuP025470;
	Fri, 14 Feb 2020 13:56:41 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A23E77802;
	Fri, 14 Feb 2020 13:56:41 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7F04977F4
 for <cocci@systeme.lip6.fr>; Fri, 14 Feb 2020 13:56:39 +0100 (CET)
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01ECucq1008199
 for <cocci@systeme.lip6.fr>; Fri, 14 Feb 2020 13:56:39 +0100 (CET)
Received: from localhost (p5486CB48.dip0.t-ipconnect.de [84.134.203.72])
 by pokefinder.org (Postfix) with ESMTPSA id 9E0AF2C08AB;
 Fri, 14 Feb 2020 13:56:38 +0100 (CET)
Date: Fri, 14 Feb 2020 13:56:38 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20200214125638.GA20771@ninjato>
References: <138939dd-ff5b-2b85-946d-891d028bb3fa@web.de>
 <20200214120535.GC4691@localhost>
 <2050f71a-5da1-f01b-b3ed-8efd675e36c9@web.de>
MIME-Version: 1.0
In-Reply-To: <2050f71a-5da1-f01b-b3ed-8efd675e36c9@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 14 Feb 2020 13:56:42 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 14 Feb 2020 13:56:39 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Supporting Coccinelle software
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0665845757=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


--===============0665845757==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 01:23:16PM +0100, Markus Elfring wrote:
> > I cloned coccinelle's GIT repository, I suggested a patch,
> > and the patch has been accepted.
>=20
> Will the chances increase for further contributions?

Why do you want to know?


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5GmQEACgkQFA3kzBSg
KbY+8BAAsPhzY7TW3wAD/p08YTkSPR0ftsE42oXNMF41nVMxkPsmdo10Wj8i8jwu
5DtUvQG0mhRZUxdpGsq1wtiWtgtYaJSBDakxCp9+QjuRoRf2PZrRhfp/jA2cU6Ds
izv6LKpoAxVqX0dqkDvU72f+1QBj4t2p2sJpLNQ+zvIaG1HNawbcUuq6kUDeDFpb
IFzUqww5pZ7rCgyJGZzmlCcp5GRmg0TF0JRl9QUb5H/gfM7qWe89QoNy2Z30UdhE
glyQpzQUH5l+sr73mmbQ6XyFm4Xg/ECG1axjYz4lCpfD1VxzOi/se9fo1EMH3sxi
BJo2I4Z+KK/640ykXlDbW9f8+cpBJvd1mkXaBOR7gCzMA7TXjdMOowIZBoMw981J
Y/cGTiZL/lcIb234ilW76JpSJUqY3mZqEwLTWPWLCzJmV+QodcSqo69szWyalsyT
F27obt/eX4Un/XFoRcintS/sSOxHM0AxE/aBKYj/PxZ7E2ASWNvZ4wnXKZMDZlqo
YAD1lfOFE59ylXJyntUTif41dQzKQw1QjwY8fyLZ89WiIRp9+P4GQrDAP9mooOB0
tMhqwvKwAvPadl6MIPQ74dJgnfZ9r5ko+umYdY/7y/fLi8n4GKxBvHIjtwkS4YmQ
qmxQS7MX7ecQsRrQ18Jfk/bfCT/8Z1HsCIU1N4pL8K+UOoejOWg=
=mVQt
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

--===============0665845757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0665845757==--
