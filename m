Return-Path: <SRS0=u1YL=GM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56E2C433DB
	for <cocci@archiver.kernel.org>; Sat,  9 Jan 2021 07:31:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0022923372
	for <cocci@archiver.kernel.org>; Sat,  9 Jan 2021 07:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0022923372
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1097V1WZ022285;
	Sat, 9 Jan 2021 08:31:01 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 69D8977A3;
	Sat,  9 Jan 2021 08:31:01 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9A8E43783
 for <cocci@systeme.lip6.fr>; Sat,  9 Jan 2021 00:48:52 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 108Nmpd7024669
 for <cocci@systeme.lip6.fr>; Sat, 9 Jan 2021 00:48:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1610149730;
 bh=avwSDMnPvJUK0AO4g+MnqSk1efd+8vZ8PcLyl8HAAjI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=NiU8Atnnlt6JIELM3/uXK+KO2Wi9vFdXCY2VZzQEo9d6csZYFLFkZfUFQrcbau5vE
 vhPuoNXvIcJkI2M+5UGpJ8Ik4+J4OZ3YigJoqBzv7EuD09dDdJ+Y0OiRkwQzxqYrCl
 PCOXBEJK3QcyIwJLNvuBz2ypc/IhXB+ICkCzIMfc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko.fritz.box ([89.247.255.154]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGAB5-1kmixR144t-00F95x; Sat, 09
 Jan 2021 00:48:50 +0100
Date: Sat, 9 Jan 2021 00:48:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <20210109004841.34cb9174@gecko.fritz.box>
MIME-Version: 1.0
X-Provags-ID: V03:K1:eqR+OTSLtNXnVgiN+3W8W06cHoPN8CBv2cj10/lznUwF/bENSzl
 8vIVmJjl+b2CUXbjzyJmolj1oWkGhITFf5YbN3PcMZOGjIxDcoQMSoal24ZGq3NTTHGbMIT
 O+KdW1qQKW2zkMoAW8EakKZ2c0uRVT6/V2AQu2nKJpbI1c10GCIrotMj3UNJJbEu+16h+w4
 Mb5wQI5tKtmZHkRd7JP4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IOkvr4cDTow=:BL5ZB18OAp5a3/OpugRkhq
 y+f13kZJn92xywuSmmnTWlYbKkmb3oXWTHp4pp3RXfworz8jgkt6RAY0y8lEJDKuA3RfbTXnK
 XCkc+i0UO/boreg+fXzRzm7//wAjlwslzK3sCMw626nekyD8klXvVrDFIVF9Ig+uMn7YjuRjC
 uxwgTRVxs3ftbaVefBFPvITXwSiIe8XQgif3yXN4yMOkk1kIOTbSFNi0N+RnWrNg2OuXgIyq3
 K7FtRx0qrWtfJ5oMqTFZOL7nkj3oA7DEQ6eVdrSDeh1eOVzFR2+xZya7eEN4+OwPqlHVlugdh
 x4bHemGse5Xo3xTZYi6VudQBRUvYzO8WOLT1dqq5oTJaCrqXktyujC6GeMl+kf7mz9IznSYxI
 iK5jxUmWG/jZgfJg1Ns7+tn/Kev60G7rLbePA806pOc6TZhZ3nL41erB3seq2zdMsXd7EiwPJ
 /SFH6JQUbfaWL5ZBBGr1cHQJTiaz1Is4cMVeMsD4uugU1rSFAlmoP7ko6IqpJsoyXojzZ2abm
 Jy67BzoDyND/gCbfScgyZniQc7QbYqC7s6np/G1L+yrGRRpD+WDrsvHzfgL8C9+0udiA3GTqL
 LSYT59sOFDAgvNE93SPspv1uBdH2dlrcPRoq+3RiMM9oKrz5miEYIsx1rb0jyFbhI0dTztUj6
 1aDbNXN55Xn2P7AGVucEF8GCdQLDhaEhUtAaK7NPKdpAfOvKVIX3+mCShGCreZcXgs6tShq8Q
 iNDVgw4gsFMMBzZzNj6l+2/rgBdO/5hB7HX8lDJY+5kDmBQ3kYMauZ6fBG0cQVHMs6zG1Xkqj
 gx/bKms6iZA2Tprc9DRC9Rj5IgYtAy2Qvlm7mz50dhIJwWjw78prf2oo88S+cf+liCP42xRDy
 Z/+8AOAFCy+cmFv+GBtw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 09 Jan 2021 08:31:01 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 09 Jan 2021 00:48:51 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 09 Jan 2021 08:31:00 +0100
Cc: cocci@systeme.lip6.fr
Subject: [Cocci] Matching attributes
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
Content-Type: multipart/mixed; boundary="===============1433142337=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============1433142337==
Content-Type: multipart/signed; boundary="Sig_/A51BkmJwnsrjDaCwM==kYVj";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/A51BkmJwnsrjDaCwM==kYVj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
I am toying with coccinelle to assist in writing c code. My first try is to
automatically free/cleanup local variables when they go out of scope.

This works very well already:

 @@
 type T;
 identifier var;
 attribute name autofree;
 @@
=20
    T var
 -  autofree
    =3D NULL;
    ...
 ++ free(var);
    return ...;

But this fails:

 @@
 type T;
 identifier var;
 attribute name autofree;
 @@
=20
    T var autofree;
    ...
 ++ free(var);
    return ...;

with

 minus: parse error:=20
   File "autofree.cocci", line 7, column 17, charpos =3D 73
   around =3D ';',
   whole content =3D    T var autofree;

What am I doing wrong here?
I tried both with v1.0.8 and latest git.
--=20


--Sig_/A51BkmJwnsrjDaCwM==kYVj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl/471kACgkQNasLKJxd
sli7gA//baW1E+FfCOSdOud6/7kryiKBQSeI/jjI9d/5vApYpzoRLCXl2/omgWcN
OX3bv+ph2RJVM6MnaR9Ih/zNJg2plxQMKKoxs35C6czoIUhlMqbSJ4CHXJTzrE3k
K8UeUoGQbQqAm/N5vtvZtnte3P8GOM9yMQ82t8eMJ/5UiG5Z5Fe3CbTUtiZs6Vv9
zO9PFFWISkg7d4GjI4YBip9tl3h7EFwIVFc3FQkeTmkZTkWSOj8ar2vs3SbUh+mn
AuqPBg4+4Se+bLywojkohcxr5Vfr/nUm3LDD6N+aIoV5puiUQ8XNHWVvMwcwm43E
jEVWywI8/Q+H2PfR1x80R04M+zU41Ddjxi8I31ex8Yi5x298Q52V0lTaCa+Lb0m8
SYsy4p7ABQJErIZLv0O7r3+Y4rbIalwIxi79f9tUtcY6lBOpgsis/+uemGRz3DLB
gmECFQx2DBS+UrYsbed2Sf3pFii9dyn03aazc2kOiBFww+NmiQugpFzMVSIRdgfO
SvS+uSC7tYK0K5UhdOdsacf0iCGpklb/Kj3eZbHWmU3cq3+LlqNHmptICBgZCCIz
pzvgcwU2CihnJgYLdxzwbiVM0Upn4FvFib4rjuaYsTHEowl0DFq3AfKSZoxJ0ZaL
VMGKH7562wYbaEWIj55HOsxlWt/Jp4sIjVVFelY5CIAFHAe+FO0=
=ceQb
-----END PGP SIGNATURE-----

--Sig_/A51BkmJwnsrjDaCwM==kYVj--

--===============1433142337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1433142337==--
