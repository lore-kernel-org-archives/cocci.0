Return-Path: <SRS0=4B11=3Y=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F9DC3524A
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 08:14:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220D72087E
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 08:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220D72087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0148EOnE027885;
	Tue, 4 Feb 2020 09:14:24 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CB7ED77EC;
	Tue,  4 Feb 2020 09:14:24 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BABCC77E8
 for <cocci@systeme.lip6.fr>; Tue,  4 Feb 2020 09:14:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0148ENrL017142
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 4 Feb 2020 09:14:23 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.70,398,1574118000"; d="scan'208";a="434317361"
Received: from abo-208-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.208])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Feb 2020 09:14:23 +0100
Date: Tue, 4 Feb 2020 09:14:22 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f0ccaf84-1b37-4936-3a7a-d5c11e3ef1c3@web.de>
Message-ID: <alpine.DEB.2.21.2002040913290.3236@hadrien>
References: <72729ef6-f8df-942f-57aa-4b3fac75a20d@web.de>
 <alpine.DEB.2.21.2002032151520.3356@hadrien>
 <b318a372-2f31-f57f-4684-62ac2b82bff3@web.de>
 <alpine.DEB.2.21.2002032226260.3356@hadrien>
 <f0ccaf84-1b37-4936-3a7a-d5c11e3ef1c3@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-879344643-1580804063=:3236"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 09:14:24 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 09:14:23 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Wellington Wallace <wellingtonwallace@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing a std::string check by strcmp() with SmPL
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-879344643-1580804063=:3236
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 4 Feb 2020, Markus Elfring wrote:

> >> Do you distinguish between the storage class specifier
> >> and other uses of such a key word?
> >> https://en.cppreference.com/w/cpp/language/auto
> >
> > Sorry.  I know nothing about C++.
>
> I guess that you know something also for this programming language
> according to the program option “--c++”.
> https://github.com/coccinelle/coccinelle/blob/0cece3639048dc7e81c4b2cc8f2a6f7a57fd546b/docs/spatch.1.in#L434
> https://github.com/coccinelle/coccinelle/issues/1
>
>
> > Auto seems to be supported
>
> I am looking for further evolution around this software area.
>
>
> > - I see it in both the C parser and the SmPL parser.
>
> How would we like to handle corresponding development challenges?
>
> @display@
> expression X;
> identifier I;
> @@
> *auto I = X(...);
>
>
> elfring@Sonne:~/Projekte/Coccinelle/Probe> spatch --parse-cocci show_variable_definition_with_auto1.cocci
> init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
> minus: parse error:
>   File "show_variable_definition_with_auto1.cocci", line 5, column 6, charpos = 47
>   around = 'I',
>   whole content = *auto I = X(...);
>
>
> Can such a source code search approach make sense also according to
> the rules of the C programming language?

I think it expects a type as well.  I don't know if that is a reasonable
assumption in C or in C++.

julia
--8323329-879344643-1580804063=:3236
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-879344643-1580804063=:3236--
