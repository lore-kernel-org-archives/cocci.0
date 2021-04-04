Return-Path: <SRS0=NM3K=JB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6011C433B4
	for <cocci@archiver.kernel.org>; Sun,  4 Apr 2021 11:58:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B368161365
	for <cocci@archiver.kernel.org>; Sun,  4 Apr 2021 11:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B368161365
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 134BwTSc002373;
	Sun, 4 Apr 2021 13:58:29 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 102A377D0;
	Sun,  4 Apr 2021 13:58:29 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D5BDE74DE
 for <cocci@systeme.lip6.fr>; Sun,  4 Apr 2021 13:58:26 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 134BwPUB021283
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 4 Apr 2021 13:58:25 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AsAU8+64XNe5o6f5nkQPXwCnXdLJzesId70hD?=
 =?us-ascii?q?6mlaTxtJfsuE0/2/hfhz726RtB89UGwt8OrqBICuWnXZnKQe3aAwOvOYUBDiqC?=
 =?us-ascii?q?+UKuhZjLfK5x3FN2nA+vVG1aFmGpIObeHYKVRhl8717E2ZPr8boOWvy6yjiefA?=
 =?us-ascii?q?w3oFd2gDV4ha4wh0EQqdGEFtLTM2ZqYRLoaW5cZMulObF0g/U8LTPBU4dtTYq8?=
 =?us-ascii?q?aOvJzrZgNuPW9E1CC+yQLt0rL8HhSCty1ybxpEy94ZnlT4rw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,304,1610406000"; d="scan'208";a="501515410"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Apr 2021 13:58:25 +0200
Date: Sun, 4 Apr 2021 13:58:25 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <fa66fce2-e60e-1907-7c8b-fd9ceedb8086@web.de>
Message-ID: <alpine.DEB.2.22.394.2104041357060.2958@hadrien>
References: <0756b630-a2d7-f300-3b11-59af33b48631@web.de>
 <alpine.DEB.2.22.394.2103281128560.2854@hadrien>
 <1b5f6d22-5b89-097f-37bd-13b3b2ab011a@web.de>
 <alpine.DEB.2.22.394.2103281244200.2854@hadrien>
 <173fa182-4127-aaba-262e-e3953a81a1e2@web.de>
 <alpine.DEB.2.22.394.2103281343310.2854@hadrien>
 <f720b262-708f-a603-3470-b374db625578@web.de>
 <alpine.DEB.2.22.394.2103281644480.2854@hadrien>
 <fa66fce2-e60e-1907-7c8b-fd9ceedb8086@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-453651040-1617537505=:2958"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 04 Apr 2021 13:58:30 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 04 Apr 2021 13:58:25 +0200 (CEST)
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

--8323329-453651040-1617537505=:2958
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 4 Apr 2021, Markus Elfring wrote:

> > The following looks like what one might want to do to find #defines that
> > are near each other.
>
> I have tried another SmPL script variant out.
>
>
> @initialize:python@
> @@
> import sys
>
> records = {}
>
> class integrity_error:
>    pass
>
> def store_positions(places, name, text):
>     """Add source code positions to an internal table."""
>     for place in places:
>        key = place.file, place.line, int(place.column) + 1
>
>        if key in records:
>           sys.stderr.write("\n".join(["-> duplicate data",
>                                       "file:", key[0],
>                                       "function:", place.current_element,
>                                       "line:", str(place.line)]))
>           sys.stderr.write("\n")
>           raise integrity_error
>        else:
>           records[key] = name, text, place.current_element
>
> @find@
> identifier i =~ "^(?:[A-Z]+_){3,3}[A-Z]+";
> expression e !~ "\"";
> position p;
> @@
>  #define i@p e
>
> @script:python collection@
> i << find.i;
> e << find.e;
> places << find.p;
> @@
> store_positions(places, i, e)
>
> @finalize:python@
> @@
> if len(records) > 0:
>    delimiter = "|"
>    sys.stdout.write(delimiter.join(['name',
>                                     'text',
>                                     'function',
>                                     '"source file"',
>                                     'line',
>                                     'column'
>                                     ]))
>    sys.stdout.write("\r\n")
>
>    for key, value in records.items():
>       sys.stdout.write(delimiter.join([value[0],
>                                        value[1],
>                                        value[2],
>                                        key[0],
>                                        key[1],
>                                        str(key[2])
>                                       ]))
>       sys.stdout.write("\r\n")
> else:
>    sys.stderr.write("No result for this analysis!\n")
>
>
> I wonder about the following test result then.
>
> elfring@Sonne:~/Projekte/PipeWire/lokal> spatch ~/Projekte/Coccinelle/janitor/check_define_usage.cocci spa/include/spa/node/type-info.h
> …
> name|text|function|"source file"|line|column
> SPA_TYPE_INFO_NodeCommand|SPA_TYPE_INFO_COMMAND_BASE "Node"|something_else|spa/include/spa/node/type-info.h|70|1
> SPA_TYPE_INFO_IO_BASE|SPA_TYPE_INFO_IO ":"|something_else|spa/include/spa/node/type-info.h|39|1
> SPA_TYPE_INFO_NODE_EVENT_BASE|SPA_TYPE_INFO_NodeEvent ":"|something_else|spa/include/spa/node/type-info.h|56|1
> SPA_TYPE_INFO_NodeEvent|SPA_TYPE_INFO_EVENT_BASE "Node"|something_else|spa/include/spa/node/type-info.h|55|1
> SPA_TYPE_INFO_IO|SPA_TYPE_INFO_ENUM_BASE "IO"|something_else|spa/include/spa/node/type-info.h|38|1
> SPA_TYPE_INFO_NODE_COMMAND_BASE|SPA_TYPE_INFO_NodeCommand ":"|something_else|spa/include/spa/node/type-info.h|71|1
>
>
> I hoped that the specified constraint for the metavariable “e” would mean
> that expressions which contain a double quotation character should be excluded
> for my source code analysis approach.
> Would you like to check the observed software functionality once more?

There is perhaps a problem, but it is surely not necessary to have all of
this python code around it to see the problem.  Please make a minimal
example.  A rule with a match and a * in front of it should be
sufficient.

julia
--8323329-453651040-1617537505=:2958
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-453651040-1617537505=:2958--
