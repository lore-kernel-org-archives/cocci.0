Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A240AC433DF
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 02:38:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FBD220738
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 02:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9R5YlYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBD220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04O2cbdB000518;
	Sun, 24 May 2020 04:38:37 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 511463DC8;
	Sun, 24 May 2020 04:38:37 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EB9033D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 04:38:34 +0200 (CEST)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04O2cVKO022507
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA256 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 04:38:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590287911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ls1I2b7V1sw20DK+NEy7TK6xyBeg+iJQPXjXgPqTQVc=;
 b=G9R5YlYFBB3rxG6ncZ3vgxm522+0/WaGgkZZSO69GUO1KvGrkpCAsjGo6IB8Vj2gcva/2t
 3yd/D4hG2XIsUST/cKxn/78mukqyE3BWT3ND0A8jrY44mxB0ojkkHP+YrzoPe3d4LhiPCa
 X830eelwQvIKYoag6cnqttU471k4/3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-D0bh5_K6OCSzUMVqRMneOA-1; Sat, 23 May 2020 22:38:28 -0400
X-MC-Unique: D0bh5_K6OCSzUMVqRMneOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A2B11855A00;
 Sun, 24 May 2020 02:38:27 +0000 (UTC)
Received: from redhat.com (ovpn-112-33.rdu2.redhat.com [10.10.112.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C76D600E5;
 Sun, 24 May 2020 02:38:26 +0000 (UTC)
Date: Sat, 23 May 2020 22:38:24 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: cocci@systeme.lip6.fr, Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <20200524023824.GA2598074@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 04:38:38 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 04:38:33 +0200 (CEST)
Subject: [Cocci] Matching an expression which use an identifier
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Hi,

I am trying to move local variable initialization of some variable to
first statement. For instance in example below i want to move any local
initialization that use local variable "a" to before the printf.

From:
void foo()
{
    int k =3D 8/2;
    int a =3D 45*4;
    int c =3D 16*2;
    int b =3D a*4+2;
    int d;

    printf("%d %d %d", a, c, b);
}

To:
void foo()
{
    int a =3D 45*4;
    int c =3D 16*2;
    int b;
    int d;

    b =3D a*4+2;
    printf("%d %d %d", a, c, b);
}

Here is a rule that will move "c =3D 16*2"

@@
identifier V1=3D{a};
identifier V2;
expression E;
statement S1;
statement S;
type T1, T2;
@@  =

{ ... T1 V1; ...

-T2 V2 =3D E;
+T2 V2;

// Insert it before first statement that is not a declaration.
... when !=3D S
+V2=3DE;
S1}


This match the first declaration after "a" declaration. I have try using
V1@E or E@V1 but it does not seem to match b declaration.

Note that i do not know the form of the expression in which "a" appears,
nor do i know the type of "b". My objective is to move the initialization
of some local variable of some type to first statement (role played by "a"
in above example) and then move all dependent initialization after it
(in above example "b" is dependent on "a").

I am not sure what kind of filter on E i can use to make it float to
only expression containing "a" ...

Hope this is something that can be done, i would hate having to do it
in python :)

Thank you in advance for any pointers.

Cheers,
J=C3=A9r=C3=B4me

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
