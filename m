Return-Path: <SRS0=Qlnj=ST=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8258C282DD
	for <cocci@archiver.kernel.org>; Wed, 17 Apr 2019 14:15:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0936D20872
	for <cocci@archiver.kernel.org>; Wed, 17 Apr 2019 14:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0936D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3HEEoVV005124
          ; Wed, 17 Apr 2019 16:14:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D95087735;
	Wed, 17 Apr 2019 16:14:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 26EE17725
 for <cocci@systeme.lip6.fr>; Wed, 17 Apr 2019 16:14:49 +0200 (CEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3HEEao2000540
 for <cocci@systeme.lip6.fr>; Wed, 17 Apr 2019 16:14:37 +0200 (CEST)
X-pt: isis.lip6.fr
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B594F74A7;
 Wed, 17 Apr 2019 14:14:33 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 135901001E7C;
 Wed, 17 Apr 2019 14:14:31 +0000 (UTC)
Date: Wed, 17 Apr 2019 10:14:30 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <20190417141429.GA3229@redhat.com>
References: <20190416221106.GA22465@redhat.com>
 <alpine.DEB.2.21.1904170712320.2612@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904170712320.2612@hadrien>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Apr 2019 16:14:51 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Apr 2019 16:14:37 +0200 (CEST)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 17 Apr 2019 14:14:36 +0000 (UTC)
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Add code after local variable declarations ?
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

On Wed, Apr 17, 2019 at 07:14:29AM +0200, Julia Lawall wrote:
> =

> =

> On Tue, 16 Apr 2019, Jerome Glisse wrote:
> =

> > I would like to add code after local variable declaration but there
> > is nothing particular to match there for me. Roughly i want to do:
> >
> >     void FooFun(..., struct fooicareabout *identifier, ...)
> >     {
> >         // bunch of local variable
> >
> >         // I want to add code here after all local variables
> >     }
> =

> @@
> statement S,S1;
> @@
> =

> foo(...) {
>   ... when !=3D S
> + added code
>   S1
>   ...
> }
> =

> A declaration doesn't match S.

Oh cool did not think of that thanks. What happens if some of the
declaration also have initializer that are statement ie for instance:

foobar(int a, int b, int c, struct fooicareabout *id)
{
    int toto =3D funbar(a, b);
    int k, l, m;

    ...
}


> =

> >
> > The thing i match on is one of the function argument. So is that do-
> > able ? If so any pointer on how to do this would be much appreciated.
> =

> I'm not sure what you are trying to do here.  You can certainly make a
> pattern for your parameters like you have shown in the example.  Do you
> mean that you want to go find the argument value at the call site?

No i want to add some code to _all_ function that have a specific
structure as one of their argument. Thus i match on the function
parameter list for the struct i am interested in and then after
all the declaration i add a code snippet.

Cheers,
J=E9r=F4me
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
