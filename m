Return-Path: <SRS0=v8PH=77=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863E5C433DF
	for <cocci@archiver.kernel.org>; Thu, 18 Jun 2020 20:01:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B80E20890
	for <cocci@archiver.kernel.org>; Thu, 18 Jun 2020 20:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B80E20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=univ-grenoble-alpes.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05IK1JPl003927;
	Thu, 18 Jun 2020 22:01:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4CBA27577;
	Thu, 18 Jun 2020 22:01:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7EEBC402B
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 22:01:17 +0200 (CEST)
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05IK1FYZ023830
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 22:01:15 +0200 (CEST)
Received: from zm-mta-out.u-ga.fr (zm-mta-out.u-ga.fr [152.77.200.53])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 5B4234127B
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 22:01:15 +0200 (CEST)
Received: from zm-mbx05.u-ga.fr (zm-mbx05.u-ga.fr [152.77.200.19])
 by zm-mta-out.u-ga.fr (Postfix) with ESMTP id 53F7180848
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 22:01:15 +0200 (CEST)
Date: Thu, 18 Jun 2020 22:01:15 +0200 (CEST)
From: NICOLAS PALIX <nicolas.palix@univ-grenoble-alpes.fr>
To: Coccinelle <cocci@systeme.lip6.fr>
Message-ID: <1173488313.3947218.1592510475320.JavaMail.zimbra@univ-grenoble-alpes.fr>
In-Reply-To: <159250651644.6245.11738703319415468670.launchpad@haetae.canonical.com>
References: <159250651644.6245.11738703319415468670.launchpad@haetae.canonical.com>
MIME-Version: 1.0
X-Originating-IP: [2.7.103.30]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: coccinelle 1.0.8~20.04npalix1 (Accepted)
Thread-Index: raTsCD9FV52RkcPgtEp6nzekj/Igqg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 18 Jun 2020 22:01:19 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 18 Jun 2020 22:01:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Fwd: [~npalix/ubuntu/coccinelle/focal] coccinelle
 1.0.8~20.04npalix1 (Accepted)
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
Content-Type: multipart/mixed; boundary="===============0472117315=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0472117315==
Content-Type: multipart/alternative; 
	boundary="=_eed25aba-0fbc-4c4a-8870-3b7dc3d729fd"

--=_eed25aba-0fbc-4c4a-8870-3b7dc3d729fd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=20

I released the 1.0.8 version ported to 20.04 focal=20
on the coccinelle PPA.=20

Regards,=20


De: "Launchpad PPA" <no_reply@launchpad.net>=20
=C3=80: "Nicolas Palix" <nicolas.palix@imag.fr>=20
Envoy=C3=A9: Jeudi 18 Juin 2020 20:55:16=20
Objet: [~npalix/ubuntu/coccinelle/focal] coccinelle 1.0.8~20.04npalix1 (Acc=
epted)=20

Accepted:=20
OK: coccinelle_1.0.8~20.04npalix1.tar.xz=20
OK: coccinelle_1.0.8~20.04npalix1.dsc=20
-> Component: main Section: devel=20

coccinelle (1.0.8~20.04npalix1) focal; urgency=3Dmedium=20

* New release 1.0.8=20

--=20
https://launchpad.net/~npalix/+archive/ubuntu/coccinelle=20
You are receiving this email because you made this upload.=20

--=_eed25aba-0fbc-4c4a-8870-3b7dc3d729fd
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi,<br></div><div><br data-mce-bogus=3D"1">=
</div><div>I released the 1.0.8 version ported to 20.04 focal<br data-mce-b=
ogus=3D"1"></div><div>on the coccinelle PPA.<br data-mce-bogus=3D"1"></div>=
<div><br data-mce-bogus=3D"1"></div><div>Regards,<br data-mce-bogus=3D"1"><=
/div><div><br></div><hr id=3D"zwchr" data-marker=3D"__DIVIDER__"><div data-=
marker=3D"__HEADERS__"><b>De: </b>"Launchpad PPA" &lt;no_reply@launchpad.ne=
t&gt;<br><b>=C3=80: </b>"Nicolas Palix" &lt;nicolas.palix@imag.fr&gt;<br><b=
>Envoy=C3=A9: </b>Jeudi 18 Juin 2020 20:55:16<br><b>Objet: </b>[~npalix/ubu=
ntu/coccinelle/focal] coccinelle 1.0.8~20.04npalix1 (Accepted)<br></div><di=
v><br></div><div data-marker=3D"__QUOTED_TEXT__">Accepted:<br>&nbsp;OK: coc=
cinelle_1.0.8~20.04npalix1.tar.xz<br>&nbsp;OK: coccinelle_1.0.8~20.04npalix=
1.dsc<br>&nbsp;&nbsp; &nbsp; -&gt; Component: main Section: devel<br><br>co=
ccinelle (1.0.8~20.04npalix1) focal; urgency=3Dmedium<br><br>&nbsp;&nbsp;* =
New release 1.0.8<br><br>-- <br>https://launchpad.net/~npalix/+archive/ubun=
tu/coccinelle<br>You are receiving this email because you made this upload.=
<br></div></div></body></html>
--=_eed25aba-0fbc-4c4a-8870-3b7dc3d729fd--

--===============0472117315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0472117315==--
