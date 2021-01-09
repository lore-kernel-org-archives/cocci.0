Return-Path: <SRS0=u1YL=GM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277D4C433DB
	for <cocci@archiver.kernel.org>; Sat,  9 Jan 2021 09:10:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6A223A3A
	for <cocci@archiver.kernel.org>; Sat,  9 Jan 2021 09:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6A223A3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1099ALMA001589;
	Sat, 9 Jan 2021 10:10:21 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 765CE77A3;
	Sat,  9 Jan 2021 10:10:21 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A6DD9454B
 for <cocci@systeme.lip6.fr>; Sat,  9 Jan 2021 10:10:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1099AI4W026831
 for <cocci@systeme.lip6.fr>; Sat, 9 Jan 2021 10:10:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610183418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=knQafjxd+bKwdSM4pmnsIxjF+ty++e9tJTrqnBNkuAE=;
 b=Up4KA/Sb+wexbs/J2f29N7JzI2p2J5oZuG9Bb7H6i2XbQnR5u26bOlEhMgEO6VCautcWDO
 BoLPGJRz6JjVRKaHHbDzcGAfJWgbAJqAoIGxmz9eVcw+2JCBb5RZrjUTJ4WAejtRI3esiW
 ps7yeiDqLeYWEXq9fs70MRZ6IjWEyqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-84PBNUESP8ucsqRiWmKTDQ-1; Sat, 09 Jan 2021 04:10:13 -0500
X-MC-Unique: 84PBNUESP8ucsqRiWmKTDQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6EF3800D55;
 Sat,  9 Jan 2021 09:10:11 +0000 (UTC)
Received: from localhost (ovpn-114-98.ams2.redhat.com [10.36.114.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3D3F10013BD;
 Sat,  9 Jan 2021 09:10:10 +0000 (UTC)
Date: Sat, 9 Jan 2021 09:10:09 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Thierry Martinez <Thierry.Martinez@inria.fr>
Message-ID: <20210109091009.GK30079@redhat.com>
References: <20210105190008.GB27779@redhat.com>
 <alpine.DEB.2.22.394.2101082341230.2796@hadrien>
 <ow4mtxjyqhx.fsf@inria.fr>
MIME-Version: 1.0
In-Reply-To: <ow4mtxjyqhx.fsf@inria.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 09 Jan 2021 10:10:21 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 09 Jan 2021 10:10:19 +0100 (CET)
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Python 3.10 again: _Py_fopen deprecated
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

On Sat, Jan 09, 2021 at 12:10:18AM +0100, Thierry Martinez wrote:
> Hi, Richard.
> =

> Thank you very much for your two successive reports about
> incompatibilities between pyml and Python 3.10. They should have been
> fixed now.
> =

> Richard:
> >> What I don't understand from the pyxml code is why we use these
> >> internal Python functions at all, instead of calling regular C
> >> functions like fopen etc.  In fact it seems like for Python 2 we did
> >> call fopen ...
> =

> Indeed, for Python 2, there is a fallback to fopen since Py_fopen is not
> available.  When Py_fopen or Py_wfopen are available, we prefer to use
> them because they handle the Windows special case.

Oh I see, that makes sense.

Rich.

> Best regards.
> -- =

> Thierry.
> =

> Julia Lawall=C2=A0:
> > On Tue, 5 Jan 2021, Richard W.M. Jones wrote:
> >
> >> Firstly a gentle reminder that there's a patch waiting to be applied:
> >> https://systeme.lip6.fr/pipermail/cocci/2020-November/thread.html#8398
> >>
> >> Different from that patch, but still related to Python 3.10, we've got
> >> another bug report here:
> >> https://bugzilla.redhat.com/show_bug.cgi?id=3D1912931
> >>
> >> This time _Py_fopen has been deprecated, replaced by _Py_wfopen or
> >> _Py_fopen_obj.  It's unclear which is better.  The two functions are
> >> documented here:
> >> https://github.com/python/cpython/blob/master/Python/fileutils.c#L1418
> >>
> >> What I don't understand from the pyxml code is why we use these
> >> internal Python functions at all, instead of calling regular C
> >> functions like fopen etc.  In fact it seems like for Python 2 we did
> >> call fopen ...
> >
> > Everything should be up to date now on github.  Thanks for your help.
> > Thierry will contact you directly about the choice of fopen.
> >
> > julia
> >
> >>
> >> Rich.
> >>
> >> --
> >> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/=
~rjones
> >> Read my programming and virtualization blog: http://rwmj.wordpress.com
> >> Fedora Windows cross-compiler. Compile Windows programs, test, and
> >> build Windows installers. Over 100 libraries supported.
> >> http://fedoraproject.org/wiki/MinGW
> >>
> >> _______________________________________________
> >> Cocci mailing list
> >> Cocci@systeme.lip6.fr
> >> https://systeme.lip6.fr/mailman/listinfo/cocci
> >>
> > _______________________________________________
> > Cocci mailing list
> > Cocci@systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci

-- =

Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
