Return-Path: <SRS0=b71c=UW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D65C43613
	for <cocci@archiver.kernel.org>; Sun, 23 Jun 2019 08:18:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E43420663
	for <cocci@archiver.kernel.org>; Sun, 23 Jun 2019 08:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="le5yfpgO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="j9NpUT6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E43420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nexedi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5N8I74g004220;
	Sun, 23 Jun 2019 10:18:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 28266776C;
	Sun, 23 Jun 2019 10:18:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0BF757761
 for <cocci@systeme.lip6.fr>; Sun, 23 Jun 2019 10:18:06 +0200 (CEST)
Received: from mail10.wdc04.mandrillapp.com (mail10.wdc04.mandrillapp.com
 [205.201.139.10])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5N8I5ME024114
 for <cocci@systeme.lip6.fr>; Sun, 23 Jun 2019 10:18:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
 i=kirr@nexedi.com; 
 bh=43Z5tU8a6uZY8167nIjWOY/Bo/wPuHg/vyCerkiRXnY=;
 b=le5yfpgOtyiKom34YiICaF5wvbgMTaxRyMeNN1ux2bg20C6onlB0GZF7OQntIwmUUs09T23cYcHd
 Y9aNVCzCEuNzZHj7g5schBgetFiUzec0cOQ92qiLSrrAtYICagO3A7Tzd/Bp84t9EhXltfGfXARX
 8NKVk+1aHFY/oAxKwlY=
Received: from pmta08.mandrill.prod.suw01.rsglab.com (127.0.0.1) by
 mail10.wdc04.mandrillapp.com id h1sqrq1jvmgs for <cocci@systeme.lip6.fr>;
 Sun, 23 Jun 2019 08:18:05 +0000 (envelope-from
 <bounce-md_31050260.5d0f35bd.v1-a39600c445304bbc91e4e619daca5646@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1561277885; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : Date : MIME-Version : 
 Content-Type : Content-Transfer-Encoding : From : Subject : Date : 
 X-Mandrill-User : List-Unsubscribe; 
 bh=43Z5tU8a6uZY8167nIjWOY/Bo/wPuHg/vyCerkiRXnY=; 
 b=j9NpUT6OucEMfBjQgQbrAvAzwOUFe2A8N8P00ZHmd71K9OQ3gIy5ol02dyQHLug/MRpSEt
 a/kT7KNeCd8XlrGltYMWJ17s63ZHmn0vHLUbmoLLiK25P3t79baNoo5oRAiZNYzGduL5hrMq
 hPFT5P6jilhhdJaJy3Oxrq2+V1/+w=
From: Kirill Smelkov <kirr@nexedi.com>
Received: from [87.98.221.171] by mandrillapp.com id
 a39600c445304bbc91e4e619daca5646; Sun, 23 Jun 2019 08:18:05 +0000
To: Julia Lawall <julia.lawall@lip6.fr>
Message-Id: <20190623081800.GA1889@deco.navytux.spb.ru>
In-Reply-To: <alpine.DEB.2.21.1906231001360.4961@hadrien>
 <alpine.DEB.2.21.1906231002020.4961@hadrien>
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here:
 http://mandrillapp.com/contact/abuse?id=31050260.a39600c445304bbc91e4e619daca5646
X-Mandrill-User: md_31050260
Date: Sun, 23 Jun 2019 08:18:05 +0000
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 23 Jun 2019 10:18:07 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 23 Jun 2019 10:18:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Bjorn Helgaas <helgaas@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Logan Gunthorpe <logang@deltatee.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
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

On Sun, Jun 23, 2019 at 10:02:17AM +0200, Julia Lawall wrote:
> On Sun, 23 Jun 2019, Kirill Smelkov wrote:
> > On Sun, Jun 23, 2019 at 09:35:17AM +0200, Julia Lawall wrote:
> > > On Sun, 23 Jun 2019, Kirill Smelkov wrote:
> > >
> > > > Previously steam_open.cocci was treating only wait_event_.* - e.g.
> > > > wait_event_interruptible - as a blocking operation. However e.g.
> > > > wait_for_completion_interruptible is also blocking, and so from this
> > > > point of view it would be more logical to treat all wait_.* as a
> > > > blocking point.
> > > >
> > > > The logic of this change actually came up for real when
> > > > drivers/pci/switch/switchtec.c changed from using
> > > > wait_event_interruptible to wait_for_completion_interruptible:
> > > >
> > > > 	https://lore.kernel.org/linux-pci/20190413170056.GA11293@deco.navytux.spb.ru/
> > > > 	https://lore.kernel.org/linux-pci/20190415145456.GA15280@deco.navytux.spb.ru/
> > > > 	https://lore.kernel.org/linux-pci/20190415154102.GB17661@deco.navytux.spb.ru/
> > > >
> > > > For a driver that uses nonseekable_open with read/write having stream
> > > > semantic and read also calling e.g. wait_for_completion_interruptible,
> > > > running stream_open.cocci before this patch would produce:
> > > >
> > > > 	WARNING: <driver>_fops: .read() and .write() have stream semantic; safe to change nonseekable_open -> stream_open.
> > > >
> > > > while after this patch it will report:
> > > >
> > > > 	ERROR: <driver>_fops: .read() can deadlock .write(); change nonseekable_open -> stream_open to fix.
> > >
> > > Are you really sure that every word that starts with wait_ in the Linux
> > > kernel has the property you want?  How many of them are there?  Would it
> > > be reasonable to put the names in the semantic patch explicitly?
> >
> > We are talking about function calls or macros here only. I think that
> > by default every "wait.*()" has blocking semantic, and if there are
> > something that does not block, it should be instead white-listed with
> > the default still being treated as "all wait.*() blocks".
> >
> > Here are the list of wait functions & macros (if I read tags format
> > correctly). They were generated with `grep -w d tags |grep '^wait'` and
> > `grep -w f tags |grep '^wait'`. Offhand they all seem to be of blocking
> > kind to me.
> 
> OK, thanks for the list.
> 
> julia

On Sun, Jun 23, 2019 at 10:01:52AM +0200, Julia Lawall wrote:
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Julia, you are welcome. Thanks for ACK.

Kirill
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
