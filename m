Return-Path: <SRS0=SdPp=VE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25493C48BDB
	for <cocci@archiver.kernel.org>; Sun,  7 Jul 2019 18:20:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF882082E
	for <cocci@archiver.kernel.org>; Sun,  7 Jul 2019 18:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="eOkYYoEn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="bO66F2uY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF882082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nexedi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x67IKDUA013748;
	Sun, 7 Jul 2019 20:20:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0EC3076B5;
	Sun,  7 Jul 2019 20:20:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 35CEB76B2
 for <cocci@systeme.lip6.fr>; Sun,  7 Jul 2019 20:20:10 +0200 (CEST)
Received: from mail180-22.suw31.mandrillapp.com
 (mail180-22.suw31.mandrillapp.com [198.2.180.22])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x67IK7jt010154
 for <cocci@systeme.lip6.fr>; Sun, 7 Jul 2019 20:20:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
 i=kirr@nexedi.com; 
 bh=IEkfr4YRUhLQp/HsBY74d4iNJyE2lakZV4Jo08VmuaA=;
 b=eOkYYoEnGUWqIB0dbm6nCcKDIIjoxM4d+HhRgGETEvjlGfW7UgggueEiV4ZKgBm8ASPzz58BSXeN
 IlmkkOBadR4II4eSBitdArJdpwPS/iD390IQP8SzJQQpZSq5HN0pZhZLS1Ya/MLN88HkPISXXNaV
 qKalsjTLIFxcUuHIVbU=
Received: from pmta03.mandrill.prod.suw01.rsglab.com (127.0.0.1) by
 mail180-22.suw31.mandrillapp.com id h48rte22sc05 for <cocci@systeme.lip6.fr>;
 Sun, 7 Jul 2019 18:20:06 +0000 (envelope-from
 <bounce-md_31050260.5d2237d6.v1-78b079d6b41646bcbb6601139bb316a7@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1562523606; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=IEkfr4YRUhLQp/HsBY74d4iNJyE2lakZV4Jo08VmuaA=; 
 b=bO66F2uYOXuv1h/WHJ+zyPIP0BmHtwh52THKQzlyoBeVJYgYEiyH2vKJe1xixzJMj+HUSH
 i1ANXEJCPJgzylWHcGjxBZfFSG+5eR/vzKlLngs/6dGthQ8yIbvjM62NW4MqG15eTGOZSmTY
 fBbQP5AV4cCTWK4SH/rwXwZu/9V9Q=
From: Kirill Smelkov <kirr@nexedi.com>
Received: from [87.98.221.171] by mandrillapp.com id
 78b079d6b41646bcbb6601139bb316a7; Sun, 07 Jul 2019 18:20:06 +0000
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Message-Id: <20190707182002.GB25031@deco.navytux.spb.ru>
References: <20190623072838.31234-1-kirr@nexedi.com>
 <CAK7LNAT2tt+pCX54=L9qN9pzZ+rCOQ5-9p-o1jMLa3GD9jhG8A@mail.gmail.com>
In-Reply-To: <CAK7LNAT2tt+pCX54=L9qN9pzZ+rCOQ5-9p-o1jMLa3GD9jhG8A@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here:
 http://mandrillapp.com/contact/abuse?id=31050260.78b079d6b41646bcbb6601139bb316a7
X-Mandrill-User: md_31050260
Date: Sun, 07 Jul 2019 18:20:06 +0000
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 07 Jul 2019 20:20:13 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 07 Jul 2019 20:20:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Logan Gunthorpe <logang@deltatee.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Cocci] [PATCH 1/2] coccinelle: api/stream_open: treat all
	wait_.*() calls as blocking
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On Sat, Jul 06, 2019 at 10:17:18PM +0900, Masahiro Yamada wrote:
> On Sun, Jun 23, 2019 at 4:29 PM Kirill Smelkov <kirr@nexedi.com> wrote:
> >
> > Previously steam_open.cocci was treating only wait_event_.* - e.g.
> > wait_event_interruptible - as a blocking operation. However e.g.
> > wait_for_completion_interruptible is also blocking, and so from this
> > point of view it would be more logical to treat all wait_.* as a
> > blocking point.
> >
> > The logic of this change actually came up for real when
> > drivers/pci/switch/switchtec.c changed from using
> > wait_event_interruptible to wait_for_completion_interruptible:
> >
> >         https://lore.kernel.org/linux-pci/20190413170056.GA11293@deco.navytux.spb.ru/
> >         https://lore.kernel.org/linux-pci/20190415145456.GA15280@deco.navytux.spb.ru/
> >         https://lore.kernel.org/linux-pci/20190415154102.GB17661@deco.navytux.spb.ru/
> >
> > For a driver that uses nonseekable_open with read/write having stream
> > semantic and read also calling e.g. wait_for_completion_interruptible,
> > running stream_open.cocci before this patch would produce:
> >
> >         WARNING: <driver>_fops: .read() and .write() have stream semantic; safe to change nonseekable_open -> stream_open.
> >
> > while after this patch it will report:
> >
> >         ERROR: <driver>_fops: .read() can deadlock .write(); change nonseekable_open -> stream_open to fix.
> >
> > Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> > Cc: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
> > ---
> 
> Applied to linux-kbuild. Thanks.

Thanks.


> >  scripts/coccinelle/api/stream_open.cocci | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle/api/stream_open.cocci
> > index 350145da7669..12ce18fa6b74 100644
> > --- a/scripts/coccinelle/api/stream_open.cocci
> > +++ b/scripts/coccinelle/api/stream_open.cocci
> > @@ -35,11 +35,11 @@ type loff_t;
> >  // a function that blocks
> >  @ blocks @
> >  identifier block_f;
> > -identifier wait_event =~ "^wait_event_.*";
> > +identifier wait =~ "^wait_.*";
> >  @@
> >    block_f(...) {
> >      ... when exists
> > -    wait_event(...)
> > +    wait(...)
> >      ... when exists
> >    }
> >
> > @@ -49,12 +49,12 @@ identifier wait_event =~ "^wait_event_.*";
> >  // XXX currently reader_blocks supports only direct and 1-level indirect cases.
> >  @ reader_blocks_direct @
> >  identifier stream_reader.readstream;
> > -identifier wait_event =~ "^wait_event_.*";
> > +identifier wait =~ "^wait_.*";
> >  @@
> >    readstream(...)
> >    {
> >      ... when exists
> > -    wait_event(...)
> > +    wait(...)
> >      ... when exists
> >    }
> >
> > --
> > 2.20.1
> > _______________________________________________
> > Cocci mailing list
> > Cocci@systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
