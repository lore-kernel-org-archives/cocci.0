Return-Path: <SRS0=Utcs=WY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3303DC3A5A1
	for <cocci@archiver.kernel.org>; Wed, 28 Aug 2019 12:06:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA64A2173E
	for <cocci@archiver.kernel.org>; Wed, 28 Aug 2019 12:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA64A2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7SC6Cfk021883;
	Wed, 28 Aug 2019 14:06:12 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DBA55778B;
	Wed, 28 Aug 2019 14:06:11 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DD7F974B3
 for <cocci@systeme.lip6.fr>; Wed, 28 Aug 2019 14:06:09 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0232.hostedemail.com
 [216.40.44.232])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7SC68Vr017377
 for <cocci@systeme.lip6.fr>; Wed, 28 Aug 2019 14:06:09 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave06.hostedemail.com (Postfix) with ESMTP id EB40B80231DC
 for <cocci@systeme.lip6.fr>; Wed, 28 Aug 2019 11:59:34 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay08.hostedemail.com (Postfix) with ESMTP id D6B92182CF66A;
 Wed, 28 Aug 2019 11:59:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bells05_52ff9a104e953
X-Filterd-Recvd-Size: 2554
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
 (Authenticated sender: joe@perches.com)
 by omf09.hostedemail.com (Postfix) with ESMTPA;
 Wed, 28 Aug 2019 11:59:30 +0000 (UTC)
Message-ID: <84c7410d1d3ef56370c698c4e603e5422e337abc.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Julia Lawall
 <julia.lawall@lip6.fr>,
        Denis Efremov <efremov@linux.com>
Date: Wed, 28 Aug 2019 04:59:29 -0700
In-Reply-To: <95c32d19-eb4d-a214-6332-038610ec3dbd@rasmusvillemoes.dk>
References: <20190825130536.14683-1-efremov@linux.com>
 <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
 <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com>
 <4E9DDF9E-C883-44F0-A3F4-CD49284DB60D@lip6.fr>
 <95c32d19-eb4d-a214-6332-038610ec3dbd@rasmusvillemoes.dk>
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 28 Aug 2019 14:06:12 +0200 (CEST)
X-Greylist: Delayed for 67:10:02 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Wed, 28 Aug 2019 14:06:09 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] scripts: coccinelle: check for !(un)?likely
	usage
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

On Wed, 2019-08-28 at 13:33 +0200, Rasmus Villemoes wrote:
> On 25/08/2019 21.19, Julia Lawall wrote:
> > > On 26 Aug 2019, at 02:59, Denis Efremov <efremov@linux.com> wrote:
> > > > On 25.08.2019 19:37, Joe Perches wrote:
> > > > > On Sun, 2019-08-25 at 16:05 +0300, Denis Efremov wrote:
> > > > > This patch adds coccinelle script for detecting !likely and !unlikely
> > > > > usage. It's better to use unlikely instead of !likely and vice versa.
> > > > Please explain _why_ is it better in the changelog.
> > > In my naive understanding the negation (!) before the likely/unlikely
> > > could confuse the compiler
> > As a human I am confused. Is !likely(x) equivalent to x or !x?
> 
> #undef likely
> #undef unlikely
> #define likely(x) (x)
> #define unlikely(x) (x)
> 
> should be a semantic no-op. So changing !likely(x) to unlikely(x) is
> completely wrong. If anything, !likely(x) can be transformed to
> unlikely(!x).

likely and unlikely use __builtin_expect

https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005fexpect
https://stackoverflow.com/questions/7346929/what-is-the-advantage-of-gccs-builtin-expect-in-if-else-statements

It's probable that of the more than 20K uses of
likely and unlikely in the kernel, most have no
real performance effect.


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
