Return-Path: <SRS0=T3A+=XQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B64CC49ED7
	for <cocci@archiver.kernel.org>; Sat, 21 Sep 2019 06:32:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1B8208C0
	for <cocci@archiver.kernel.org>; Sat, 21 Sep 2019 06:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1B8208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8L6VpXk022838;
	Sat, 21 Sep 2019 08:31:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 34D40779F;
	Sat, 21 Sep 2019 08:31:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F18717796
 for <cocci@systeme.lip6.fr>; Sat, 21 Sep 2019 08:31:49 +0200 (CEST)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8L6VnYX008826
 for <cocci@systeme.lip6.fr>; Sat, 21 Sep 2019 08:31:49 +0200 (CEST)
Received: from submission (posteo.de [89.146.220.130]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 6A530160065
 for <cocci@systeme.lip6.fr>; Sat, 21 Sep 2019 08:31:48 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 46b12W2JCBz6tmB;
 Sat, 21 Sep 2019 08:31:47 +0200 (CEST)
Date: Sat, 21 Sep 2019 08:31:50 +0200
From: Michele Martone <michelemartone@users.sourceforge.net>
To: linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org
Message-ID: <20190921063150.GN5628@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org,
 kernelnewbies@kernelnewbies.org, cocci@systeme.lip6.fr,
 Julia Lawall <julia.lawall@lip6.fr>
MIME-Version: 1.0
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 21 Sep 2019 08:31:52 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 21 Sep 2019 08:31:49 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: [Cocci] Munich, Germany,
	Oct. 8th: Intro to Semantic Patching with Coccinelle
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
Content-Type: multipart/mixed; boundary="===============0810352421=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr


--===============0810352421==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ev7mvGV+3JQuI2Eo"
Content-Disposition: inline


--ev7mvGV+3JQuI2Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear Kernel Hackers,

Coccinelle is a tool routinely used to automatically upgrade Linux
kernel drivers, or catch certain bugs in C programs, or to restructure
C programs.

So some of you may be interested in the following event I'm holding=20
near Munich, Germany:

***************************************************************************=
****
  "Introduction to Semantic Patching of C programs with Coccinelle"

Tuesday, October 8, 2019, 10:00 - 17:00
Leibniz Supercomputing Centre (LRZ) of the Bavarian Academy of Sciences and
Humanities, Garching near Munich, Boltzmannstr. 1


The maintenance of a large software project can be very demanding. External
factors like evolving third-party software library APIs, or constantly chan=
ging
hardware platforms might require significant code adaptions for the code to=
 run
efficiently, or to run at all. Failure in coping with this can lead to
obsolescence, loss of performance, incompatibility, vendor lock-in, bugs.

Have you ever wondered how to detect and manipulate specified classes of C =
code
constructs, be it for code analysis, or better, to restructure an arbitrari=
ly
large codebase according to a specified, non-trivial `pattern', without wri=
ting
a C compiler?

In this training we introduce you to a tool to do exactly this: match and
restructure C codebases in a programmatic, formal way. The training will al=
so
show how to analyze code looking for interesting patterns (e.g. bugs),
integrate with your Python scripts to achieve the custom transformations you
need, and leverage Coccinelle's limited C++ support. Special attention will=
 be
on performance-oriented transformations, of other interests of HPC
practitioners.

After this training, you shall be able to write your own code transformatio=
ns,
be it for a refactoring, performance improvement, paving the way to an
experimental fork, or for debugging and further analysis.

Teacher: Dr. Michele Martone (LRZ)

Registration and further information
 https://www.lrz.de/services/compute/courses/2019-10-08_hspc1w19/
***************************************************************************=
****

--ev7mvGV+3JQuI2Eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAl2Fw9YACgkQ4OZpyO8SWLghnwCdGLcErUKXkG79dWWpy28cdFRY
qWcAn1RLl2oJtf+J6R7c81WrTUE3YSsR
=ZVAf
-----END PGP SIGNATURE-----

--ev7mvGV+3JQuI2Eo--

--===============0810352421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0810352421==--
