Return-Path: <SRS0=q87m=CY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BEBC433E2
	for <cocci@archiver.kernel.org>; Tue, 15 Sep 2020 19:24:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D9020770
	for <cocci@archiver.kernel.org>; Tue, 15 Sep 2020 19:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D9020770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08FJNaak020470;
	Tue, 15 Sep 2020 21:23:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 60311778A;
	Tue, 15 Sep 2020 21:23:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B2E7A4266
 for <cocci@systeme.lip6.fr>; Tue, 15 Sep 2020 21:23:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08FJNYVr024481
 for <cocci@systeme.lip6.fr>; Tue, 15 Sep 2020 21:23:34 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="359084275"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 21:23:33 +0200
Date: Tue, 15 Sep 2020 21:23:33 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jaskaran Singh <jaskaran.singh@collabora.com>
In-Reply-To: <20200910061703.2397-1-jaskaran.singh@collabora.com>
Message-ID: <alpine.DEB.2.22.394.2009152123150.6185@hadrien>
References: <20200910061703.2397-1-jaskaran.singh@collabora.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 15 Sep 2020 21:23:36 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 15 Sep 2020 21:23:34 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v2 0/3] parsing_c: Optimize recursive header
 file parsing
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



On Thu, 10 Sep 2020, Jaskaran Singh wrote:

> This patch series aims to optimize performance for recursively parsing
> header files in Coccinelle.
>
> Coccinelle's C parsing subsystem has an option called --recursive-includes
> to recursively parse header files. This is used for type
> inference/annotation.
>
> Previously, using --recursive-includes on the entire Linux kernel source
> code would take far too long. On my computer with the following specs,
> 	- Processor: AMD Ryzen 5 3550H
> 	- RAM: 8 GB
> it would take close to 7 hours to complete.  The optimization that this
> patch series implements reduces that time to 1 hour.
>
> The following is a high-level description of what has been implemented:
> - As header files are recursively parsed, they are scanned for the
>   following:
> 	- fields of structs/unions/enums
> 	- typedefs
> 	- function prototypes
> 	- global variables
>   The names of the above are stored in a "name cache", i.e. a hashtable to
>   map the name to the files it is declared in.
> - A dependency graph is built to determine dependencies between all the
>   files in the codebase.
> - In the type annotation phase of the C subsystem, if a function call,
>   struct/union field or identifier is encountered, the type of which is
>   not known to the annoter, the name cache is checked for the name.
> - The name cache gives a list of files that the name is declared/defined
>   in.  These files are cross checked with the dependency graph to
>   determine if any of these are reachable by the file that the annoter is
>   working on.
> - If a reachable header file is found, that file is parsed and the type
>   associated to the name is returned.
>
> Different approaches that were attempted to alleviate this issue, and the
> problems with each are as follows:
> - Caching the most recently used files: A LRU cache to store ASTs of the
>   most recently encountered header files. The problem with this approach
>   is the amount of memory it takes to cache the header file ASTs.
> - Caching the most troublesome files: A pseudo-LFU cache to store files
>   that cumulatively take the longest to parse, and thus bloat the time
>   taken. The problem with this approach is the amount of memory it takes
>   to cache the header file ASTs.
> - Skipping unparsable locations in header files: Skipping top-level items
>   in a header file that cannot be parsed. This approach does not produce
>   even close to the amount of optimization needed.
>
> The next step from here would be:
> - Maintain a small but persistent cache of header files in groups of
>   directories. Leverage multiprocessing for parsing these header files.
> - Leverage multiprocessing to parse header files initially for name
>   extraction.
> - Performing some initial matching with the semantic patch to determine if
>   a C file matches. If matches are found, call the annoter and recursively
>   parse header files for type annotation.
> - Recursively parse all header files only once and build a large type
>   environment. Use the dependency graph to determine reachability. This
>   has potential memory usage issues though.

Applied.


>
>
> Changes in v2:
> --------------
> - Change occurences of 'begin' and 'match' on the same line with something else
>   to the next line for better readability.
>
>
>  Makefile                     |    2
>  parsing_c/includes_cache.ml  |  286 +++++++++++++++++++++++++++++++++++++++++++
>  parsing_c/includes_cache.mli |   47 +++++++
>  parsing_c/parse_c.ml         |   27 +++-
>  parsing_c/type_annoter_c.ml  |  130 ++++++++++++++++---
>  5 files changed, 466 insertions(+), 26 deletions(-)
>
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
