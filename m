Return-Path: <SRS0=ztE1=4C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D184C2BA83
	for <cocci@archiver.kernel.org>; Fri, 14 Feb 2020 08:48:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66A72187F
	for <cocci@archiver.kernel.org>; Fri, 14 Feb 2020 08:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66A72187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01E8lvsU000066;
	Fri, 14 Feb 2020 09:47:57 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CD0227802;
	Fri, 14 Feb 2020 09:47:57 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4138377F4
 for <cocci@systeme.lip6.fr>; Fri, 14 Feb 2020 09:47:56 +0100 (CET)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01E8ltbl014384
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <cocci@systeme.lip6.fr>; Fri, 14 Feb 2020 09:47:55 +0100 (CET)
Received: from submission (posteo.de [89.146.220.130]) 
 by mout02.posteo.de (Postfix) with ESMTPS id B6AA4240108
 for <cocci@systeme.lip6.fr>; Fri, 14 Feb 2020 09:40:37 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 48Jmzn1YDrz9rxL;
 Fri, 14 Feb 2020 09:40:37 +0100 (CET)
Date: Fri, 14 Feb 2020 09:40:35 +0100
From: Michele Martone <michelemartone@users.sourceforge.net>
To: cocci@systeme.lip6.fr
Message-ID: <20200214084035.GA4691@localhost>
Mail-Followup-To: cocci@systeme.lip6.fr
MIME-Version: 1.0
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 14 Feb 2020 09:47:58 +0100 (CET)
X-Greylist: Delayed for 00:07:17 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Fri, 14 Feb 2020 09:47:55 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Thank you for Coccinelle!
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
Content-Type: multipart/mixed; boundary="===============1880869551=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


--===============1880869551==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear Coccinelle Developers,

today being "I Love Free Software" / https://ilovefs.org=20
I thank you for developing such a fantastic software like=20
Coccinelle!

I work in scientific / HPC computing and Coccinelle helped
my work in achieving what was previously unachievable, or
slow or extremely error-prone.

And because Coccinelle is free software, I could inspect=20
Coccinelle and even adapt a few minimal things to my needs!


 And you, fellow mailing list subscribers, how did
 Coccinelle improve your work ?


 And, dear Coccinelle devels, what we users can do to ensure
 good health to the Coccinelle project ?


Long life to Coccinelle and its developers!
Michele

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAl5GXQMACgkQ4OZpyO8SWLhzwwCeLgmbDSaNIHDpa/sd7Fm2Q50+
gJcAni6Q8zxdchm7pIM8jp7uyiaOBH2Z
=O8e5
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--

--===============1880869551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1880869551==--
