Return-Path: <SRS0=Ntgp=IM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_05,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EC7C433E0
	for <cocci@archiver.kernel.org>; Sun, 14 Mar 2021 06:40:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2B264E99
	for <cocci@archiver.kernel.org>; Sun, 14 Mar 2021 06:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2B264E99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12E6dZR3002657;
	Sun, 14 Mar 2021 07:39:35 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 52DBA3C3C;
	Sun, 14 Mar 2021 07:39:35 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A02A73BA2
 for <cocci@systeme.lip6.fr>; Sun, 14 Mar 2021 07:10:13 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12E6ACxZ029457
 for <cocci@systeme.lip6.fr>; Sun, 14 Mar 2021 07:10:13 +0100 (CET)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC3F364E84;
 Sun, 14 Mar 2021 06:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615702211;
 bh=wJJQ0Ng4LKjmldzFbogZXRa0YLiczLQHrsfQd+4TiEM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pt1b3kkC/HVv4InnTwDhtY/nEOBW1hqClcOdUrGmHrdo5psgiilhKY+XqVOe0v5mc
 Lw4yoYxyrsx4DPcLWRLu+mjDAPG9f7/YrsPbLPA30Wg+H7aT3rkuQTcS//vlNTgE1m
 V2sG47x8qyOeJAn8y3HdtnUT1HXrFSud8Y6Hhi4F7m6OFV3n5KUmeDaeHpqR30LnnQ
 gR/lZq3kx6//UtgnvB9Ql68fdA9JpGF1tB9jNxOn6wf5S91LZMOqUSRzeEBJZ8avW8
 5TcMNSWqMgGqfNoAeX4RQXpHWsRdKMvgHbbYlZIP2b+UZoDfJGwMeb1MjwzDZJGwLe
 +/2UL8+O2hghA==
Date: Sun, 14 Mar 2021 07:10:01 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Thomas Adam <thomas@xteddy.org>
Message-ID: <20210314061001.GA993@kunai>
References: <CAOhcEPbTH-oTTn1OUkgoYf2GaBKaCYjwpWuhrdNRkNQ0uZ_r4A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOhcEPbTH-oTTn1OUkgoYf2GaBKaCYjwpWuhrdNRkNQ0uZ_r4A@mail.gmail.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 14 Mar 2021 07:39:36 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 14 Mar 2021 07:10:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 14 Mar 2021 07:39:33 +0100
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing a struct member with a function call
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
Content-Type: multipart/mixed; boundary="===============0496704264=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


--===============0496704264==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> @@
> type M;

This?

struct monitor* m;

> @@
> - m->virtual.width;
> + get_monitor_width();

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmBNqLUACgkQFA3kzBSg
Kbbvyw/+I4QEKEArkeaGtf3WxqwGIJv37ydtio4IjN9K35hk4vJ0xa8VrDxF8cLp
JSNvwxMo/D5R3HM17bL3YLnuLaMJU1H9dl6nHlQY8OG7gpqLTsgQL5dN2rXdjl4p
7wtWesEGISBlv7JUIuPhI70ZxTsoywh1mDBIlRZAgtK/bag/hlMUcPB7s5pMXQmB
Kc9kezOD0jUCGWuUGNdoty+RZ/2MkVc7VmaRocyD0u+/srzglaUGz2Uh8rN6fTs4
Z7C/901O5DiNHpeRClWAJK2NyvRoSK+xfwFxUxvAHYcDy9h+vsuQ3hEADNFX3Zxs
loY8ZvjNH87PjEBbITHArHdD0ZHFQKKhN1XCWHxB6XSOeDC8PtPEHcTfnGk8IQbx
1qBnK2f9lCrWcTqbCh9FSWISip8WB0hH9Jg43MZ8rLmNuNkhs74Bwx2hkZ0DBQhp
xFiHGCFAcWSW9CsnjeMXkpelrd1sdfTldJUhRO8jWKkc1LQlB2tQEq0cWr6R3Gzq
Lovz9nXta8zCNXy8Xd6SIpLiMIxqSkgXYHl7WUqJiU+uQoVrCDCImoQzjAaIhwGe
tqP6/iW6roP5/gu/N2uZPystcaSz1WsL08s6hdtmoZKoIJkC6EOjg9EfeRhngzVj
jywCOowkJpXNiuic/qCo8J2XpOmYI8ZauhOGrDYAooIJrifMf64=
=nUjc
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

--===============0496704264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0496704264==--
