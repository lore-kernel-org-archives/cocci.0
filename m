Return-Path: <SRS0=x4mb=CF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AB5C433E3
	for <cocci@archiver.kernel.org>; Thu, 27 Aug 2020 21:18:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1867520825
	for <cocci@archiver.kernel.org>; Thu, 27 Aug 2020 21:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1867520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07RLI13p022338;
	Thu, 27 Aug 2020 23:18:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9AEBF4316;
	Thu, 27 Aug 2020 23:18:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 786503C97
 for <cocci@systeme.lip6.fr>; Thu, 27 Aug 2020 23:18:00 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0244.hostedemail.com
 [216.40.44.244])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07RLHwrb015270
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 27 Aug 2020 23:17:59 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 6E22118030C6B
 for <cocci@systeme.lip6.fr>; Thu, 27 Aug 2020 21:01:03 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id 411CB18224504;
 Thu, 27 Aug 2020 21:01:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stew80_430513e27070
X-Filterd-Recvd-Size: 7057
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf17.hostedemail.com (Postfix) with ESMTPA;
 Thu, 27 Aug 2020 21:00:58 +0000 (UTC)
Message-ID: <f1b510509b10d6f1e7af89296c3dbe68d056d1e5.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Thu, 27 Aug 2020 14:00:57 -0700
In-Reply-To: <cf9b1ea3716305447be43bffc8f90b7ef7292f5b.camel@perches.com>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
 <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
 <20200827071537.GA168593@kroah.com>
 <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
 <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
 <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
 <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
 <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
 <cf9b1ea3716305447be43bffc8f90b7ef7292f5b.camel@perches.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 Aug 2020 23:18:01 +0200 (CEST)
X-Greylist: Delayed for 04:02:03 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Thu, 27 Aug 2020 23:17:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: "Gustavo A. R.
 Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cocci <cocci@systeme.lip6.fr>,
        Alex Dewar <alex.dewar90@gmail.com>
Subject: Re: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
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

On Thu, 2020-08-27 at 13:29 -0700, Joe Perches wrote:
> On Thu, 2020-08-27 at 21:42 +0200, Julia Lawall wrote:
> > On Thu, 27 Aug 2020, Joe Perches wrote:
> > 
> > > On Thu, 2020-08-27 at 15:48 +0100, Alex Dewar wrote:
> > > > On Thu, Aug 27, 2020 at 03:41:06PM +0200, Rasmus Villemoes wrote:
> > > > > On 27/08/2020 15.18, Alex Dewar wrote:
> > > > > > On Thu, Aug 27, 2020 at 09:15:37AM +0200, Greg Kroah-Hartman wrote:
> > > > > > > On Thu, Aug 27, 2020 at 08:42:06AM +0200, Rasmus Villemoes wrote:
> > > > > > > > On 25/08/2020 00.23, Alex Dewar wrote:
> > > > > > > > > kernel/cpu.c: don't use snprintf() for sysfs attrs
> > > > > > > > > 
> > > > > > > > > As per the documentation (Documentation/filesystems/sysfs.rst),
> > > > > > > > > snprintf() should not be used for formatting values returned by sysfs.
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Can we have a sysfs_sprintf() (could just be a macro that does sprintf)
> > > > > > > > to make it clear to the next reader that we know we're in a sysfs show
> > > > > > > > method? It would make auditing uses of sprintf() much easier.
> > > > > > > 
> > > > > > > Code churn to keep code checkers quiet for pointless reasons?  What
> > > > > > > could go wrong with that...
> > > > > 
> > > > > I did not (mean to) suggest replacing existing sprintf() calls in sysfs
> > > > > show methods. But when changes _are_ being made, such as when replacing
> > > > > snprintf() calls for whatever reasons, can we please not make it harder
> > > > > for people doing manual audits (those are "code checkers" as well, I
> > > > > suppose, but they do tend to only make noise when finding something).
> > > > > 
> > > > > > > It should be pretty obvious to any reader that you are in a sysfs show
> > > > > > > method, as almost all of them are trivially tiny and obvious.
> > > > > 
> > > > > git grep doesn't immediately show that, not even with a suitable -C
> > > > > argument, as you can't really know the potential callers unless you open
> > > > > the file and see that the function is only assigned as a .show method.
> > > > > And even that can be a pain because it's all hidden behind five levels
> > > > > of magic macros that build identifiers with ##.
> > > > > 
> > > > > > Perhaps I should have mentioned this in the commit message, but the problem
> > > > > > is that snprintf() doesn't return the number of bytes written to the
> > > > > > destination buffer,
> > > > > 
> > > > > I'm perfectly well aware of that, TYVM (you may want to 'git log
> > > > > --author Villemoes lib/vsprintf.c').
> > > > > 
> > > > >  but the number of bytes that *would have been written if
> > > > > > they fitted*, which may be more than the bounds specified [1]. So "return
> > > > > > snprintf(...)" for sysfs attributes is an antipattern. If you need bounded
> > > > > > string ops, scnprintf() is the way to go. Using snprintf() can give a
> > > > > > false sense of security, because it isn't necessarily safe.
> > > > > 
> > > > > Huh? This all seems utterly irrelevant WRT a change that replaces
> > > > > PAGE_SIZE by INT_MAX (because that's what sprintf() is going to pretend
> > > > > you passed). You get the same return value.
> > > > > 
> > > > > But I'm not at all concerned about whether one passes the proper buffer
> > > > > size or not in sysfs show methods; with my embedded hat on, I'm all for
> > > > > saving a few bytes of .text here and there. The problem, as far as I'm
> > > > > concerned, is merely that adding sprintf() callers makes it harder to
> > > > > find the problematic sprintf() instances.
> > > > > 
> > > > 
> > > > Apologies, I think I might have expressed myself poorly, being a kernel noob
> > > > ;-). I know that this is a stylistic change rather than a functional
> > > > one -- I meant that I was hoping that it would be helpful to get rid of bad
> > > > uses of snprintf().
> > > > 
> > > > I really like your idea of helper methods though :-). If in show()
> > > > methods we could have something like:
> > > > 	return sysfs_itoa(buf, i);
> > > > in place of:
> > > > 	return sprintf(buf, "%d\n", i);
> > > > 
> > > > ... then we wouldn't be introducing any new calls to sprintf() as you
> > > > say, but we'd still be removing a call to snprintf() (which also may be
> > > > problematic). Plus we'd have type checking on the argument.
> > > > 
> > > > For returning strings, we could have a bounded and unbounded variant of
> > > > the function. As it seems like only single values should be returned via
> > > > sysfs, if we did things this way then it would only be these
> > > > string-returning functions which could cause buffer overflow problems
> > > > and kernel devs could focus their attention accordingly...
> > > > 
> > > > What do people think? I'm happy to have a crack, provided this is
> > > > actually a sensible thing to do! I'm looking for a newbie-level project
> > > > to get started with.
> > > 
> > > Not a bad idea.
> > > 
> > > Coccinelle should be able to transform the various .show
> > > methods to something sysfs_ prefixed in a fairly automated
> > > way.
> > 
> > Something like
> > 
> > identifier f;
> > fresh identifier = "sysfs" ## f;
> > 
> > may be useful.  Let me know if further help is needed.

cocci syntax eludes me, but I imagine something like:

@@
identifier f_show =~ "^.*_show$";
@@
ssize_t f_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
{
-	sprintf
+	kobj_sprintf
	(...);


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
