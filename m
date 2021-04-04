Return-Path: <SRS0=NM3K=JB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DD0C433ED
	for <cocci@archiver.kernel.org>; Sun,  4 Apr 2021 12:19:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF1B600D1
	for <cocci@archiver.kernel.org>; Sun,  4 Apr 2021 12:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF1B600D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 134CJjhX001752;
	Sun, 4 Apr 2021 14:19:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0943D77D0;
	Sun,  4 Apr 2021 14:19:45 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3443D74DE
 for <cocci@systeme.lip6.fr>; Sun,  4 Apr 2021 14:19:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 134CJhAK013382
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 4 Apr 2021 14:19:43 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AJvdZCayO2g8Z+4qC+2DSKrPxM+gkLtp033Aq?=
 =?us-ascii?q?2lEZdDV8acaYl9+jkbAyyHbP+XcscVsr8OrwQ5Woa3Xa6JJz/M0NLa6vNTOW+F?=
 =?us-ascii?q?eAAYl+4eLZslvdMgHk7ehHz+NcdcFFeajNJHdgi8KS2njAL/8Bx529/LmslaPi?=
 =?us-ascii?q?yR5WPHtXQoRh9Ro8Ih2QE01oSGB9dNQEPb+d/NcChjakYB0sH4+GL1wERfWGh9?=
 =?us-ascii?q?CjruOvXTciBwQ7rC+Rij+ygYSKXCSw+xcFTnd3x60+mFK13zDRw6W4rrWA1hTH?=
 =?us-ascii?q?3XTS5Jg+oqqq9vJnBNaQzvQTMCnmkAyyZI9sMofy8QwdhMGKxBIUnMLXoxEmVv?=
 =?us-ascii?q?4DjE/5Wm2uuxPi103B/V8VmgDf4GaCjXHurMD/Tj5SMbs09PVkWyDU4UYho91w?=
 =?us-ascii?q?uZgjtwny2vU4bHOw/1WZlrz1fipnmUaurX0pnfR7tQ0jbaIkZKZVvcgj+ipuYe?=
 =?us-ascii?q?c9NRj3740qC4BVfbfhzcxLelCXZW2xhBgf/PWQWB0Ib2+7a3QZttfQ+zZbm20R?=
 =?us-ascii?q?9Tpl+OUv2lka+II5S4NYjt60cdUrqJh+CuoRa7sVPpZzfeKHTkjMRA/BK26eSG?=
 =?us-ascii?q?6XUdBCB1v976T657g4/4iRCeI15ap3opjYTF9ev2JaQTOdNeS+mKJK6QzWBF+2?=
 =?us-ascii?q?VTPrxsw23fQJ2IHUdf7pdSeDSlQnk87lj/IBDsjcQu++UagmRI6kEULeXYUM1Q?=
 =?us-ascii?q?z9X5FTLD0lWssPtr8AKgv++v7jG8no8ubbcvLaJL+oKystR3/ka0FzB0moGOxw?=
 =?us-ascii?q?qkesHnfiihnQRH+FQD23wa5N?=
X-IronPort-AV: E=Sophos;i="5.81,304,1610406000"; d="scan'208";a="501516073"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Apr 2021 14:19:43 +0200
Date: Sun, 4 Apr 2021 14:19:43 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <addb2edb-98cb-2834-b1b9-7d44cacda965@web.de>
Message-ID: <alpine.DEB.2.22.394.2104041419290.2958@hadrien>
References: <0756b630-a2d7-f300-3b11-59af33b48631@web.de>
 <alpine.DEB.2.22.394.2103281128560.2854@hadrien>
 <1b5f6d22-5b89-097f-37bd-13b3b2ab011a@web.de>
 <alpine.DEB.2.22.394.2103281244200.2854@hadrien>
 <173fa182-4127-aaba-262e-e3953a81a1e2@web.de>
 <alpine.DEB.2.22.394.2103281343310.2854@hadrien>
 <f720b262-708f-a603-3470-b374db625578@web.de>
 <alpine.DEB.2.22.394.2103281644480.2854@hadrien>
 <fa66fce2-e60e-1907-7c8b-fd9ceedb8086@web.de>
 <alpine.DEB.2.22.394.2104041357060.2958@hadrien>
 <addb2edb-98cb-2834-b1b9-7d44cacda965@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1397136529-1617538783=:2958"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 04 Apr 2021 14:19:45 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 04 Apr 2021 14:19:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Excluding quotes from strings of #define directives
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

--8323329-1397136529-1617538783=:2958
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 4 Apr 2021, Markus Elfring wrote:

> >> I hoped that the specified constraint for the metavariable “e” would mean
> >> that expressions which contain a double quotation character should be excluded
> >> for my source code analysis approach.
> >> Would you like to check the observed software functionality once more?
> >
> > There is perhaps a problem, but it is surely not necessary to have all of
> > this python code around it to see the problem.
>
> I chose this test display so that it can be clearly seen which data were processes
> for the metavariable “e”.
>
>
> > Please make a minimal example.  A rule with a match and a * in front of it should be sufficient.
>
> Do you find constraints of the following SmPL script variant easier to clarify?
>
> @display@
> identifier i =~ "^(?:[A-Z]+_){3,3}[A-Z]+";
> expression e !~ "\"";
> @@
> *#define i e
>
> Test result:
> https://gitlab.freedesktop.org/pipewire/pipewire/-/blob/97b01ed9b01bac7cba68ff11c6bf7ceabcae7f52/spa/include/spa/node/type-info.h#L38
>
> elfring@Sonne:~/Projekte/PipeWire/lokal> spatch ~/Projekte/Coccinelle/janitor/show_define_usage4.cocci spa/include/spa/node/type-info.h
> …
> @@ -35,8 +35,6 @@ extern "C" {
>  #include <spa/node/event.h>
>  #include <spa/node/io.h>
>
> -#define SPA_TYPE_INFO_IO                       SPA_TYPE_INFO_ENUM_BASE "IO"
> -#define SPA_TYPE_INFO_IO_BASE          SPA_TYPE_INFO_IO ":"
>
>  static const struct spa_type_info spa_type_io[] = {
>         { SPA_IO_Invalid, SPA_TYPE_Int, SPA_TYPE_INFO_IO_BASE "Invalid", NULL },
> …

Thanks for the simpler examples.

julia
--8323329-1397136529-1617538783=:2958
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1397136529-1617538783=:2958--
