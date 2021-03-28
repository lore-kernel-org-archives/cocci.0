Return-Path: <SRS0=v4mC=I2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA8EC433DB
	for <cocci@archiver.kernel.org>; Sun, 28 Mar 2021 14:45:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE196194A
	for <cocci@archiver.kernel.org>; Sun, 28 Mar 2021 14:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE196194A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12SEjija027215;
	Sun, 28 Mar 2021 16:45:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0654F77C4;
	Sun, 28 Mar 2021 16:45:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 156A33E8A
 for <cocci@systeme.lip6.fr>; Sun, 28 Mar 2021 16:45:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12SEjgGh025966
 for <cocci@systeme.lip6.fr>; Sun, 28 Mar 2021 16:45:42 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AjXcWpqzT45TNIyjPx02eKrPwzb1zdoIgy1kn?=
 =?us-ascii?q?xilNYDZSddGVkN3roeQD2XbP+VIscVwphNzoAsK9aFzG85od2+MsFJekGDLroW?=
 =?us-ascii?q?65aLxlhLGC/xTFOwnTstFQzr1hda8WMqyUMXFfgdzh6Ae1V/YMqePmzImSie3T?=
 =?us-ascii?q?z2hgQGhRAsldxjx0BQqBHkp9SBMuP+tbKLOn+sFFqzC8EE54Uu2HABA+M9Trm8?=
 =?us-ascii?q?fGj9bPbxIAGnccmWuzpALt2frBHx+U0gx2aV5y6L0pmFKrrzDE?=
X-IronPort-AV: E=Sophos;i="5.81,285,1610406000"; d="scan'208";a="377087051"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Mar 2021 16:45:42 +0200
Date: Sun, 28 Mar 2021 16:45:41 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <f720b262-708f-a603-3470-b374db625578@web.de>
Message-ID: <alpine.DEB.2.22.394.2103281644480.2854@hadrien>
References: <0756b630-a2d7-f300-3b11-59af33b48631@web.de>
 <alpine.DEB.2.22.394.2103281128560.2854@hadrien>
 <1b5f6d22-5b89-097f-37bd-13b3b2ab011a@web.de>
 <alpine.DEB.2.22.394.2103281244200.2854@hadrien>
 <173fa182-4127-aaba-262e-e3953a81a1e2@web.de>
 <alpine.DEB.2.22.394.2103281343310.2854@hadrien>
 <f720b262-708f-a603-3470-b374db625578@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-390427568-1616942742=:2854"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 28 Mar 2021 16:45:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 28 Mar 2021 16:45:42 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing #define directives with the help of SmPL
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

--8323329-390427568-1616942742=:2854
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 28 Mar 2021, Markus Elfring wrote:

> > And what is the problem here?
>
> Would you like to discuss further software development ideas
> according to another SmPL script example like the following?

The following looks like what one might want to do to find #defines that
are near each other.

julia

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
> expression e;
> identifier i;
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
> elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch list_macros.cocci /usr/include/pipewire-0.3/pipewire/client.h
> …
> name|text|function|"source file"|line|column
> …
> PW_CLIENT_METHOD_GET_PERMISSIONS|3|something_else|/usr/include/pipewire-0.3/pipewire/client.h|98|1
> PW_CLIENT_METHOD_UPDATE_PROPERTIES|2|something_else|/usr/include/pipewire-0.3/pipewire/client.h|97|1
> …
>
>
> Regards,
> Markus
>
--8323329-390427568-1616942742=:2854
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-390427568-1616942742=:2854--
