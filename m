Return-Path: <SRS0=tHwe=7W=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C83C433E1
	for <cocci@archiver.kernel.org>; Tue,  9 Jun 2020 16:22:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62BF920774
	for <cocci@archiver.kernel.org>; Tue,  9 Jun 2020 16:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BF920774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 059GMA2Q025341;
	Tue, 9 Jun 2020 18:22:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5EF017783;
	Tue,  9 Jun 2020 18:22:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9B84A3F9A
 for <cocci@systeme.lip6.fr>; Tue,  9 Jun 2020 18:22:09 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 059GM8fK015602
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 9 Jun 2020 18:22:09 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,492,1583190000"; d="scan'208";a="351117269"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jun 2020 18:22:05 +0200
Date: Tue, 9 Jun 2020 18:22:05 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20200608150038.223747-5-efremov@linux.com>
Message-ID: <alpine.DEB.2.21.2006091821010.2516@hadrien>
References: <20200608150038.223747-1-efremov@linux.com>
 <20200608150038.223747-5-efremov@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 09 Jun 2020 18:22:10 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 09 Jun 2020 18:22:09 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v2 4/4] coccinelle: api: add selfcheck for
 memdup_user rule
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



On Mon, 8 Jun 2020, Denis Efremov wrote:

> Check that the rule matches vmemdup_user implementation.
> memdup_user is out of scope because we are not matching
> kmalloc_track_caller() function.

Is this a bit over-enginered?  More precisely, even if it is nice to check
that the API definition has the expected behavior, does it make sense to
do it in one case but not the other?

julia

>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/coccinelle/api/memdup_user.cocci | 46 ++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
> index 8621bd98be1e..78fded83b197 100644
> --- a/scripts/coccinelle/api/memdup_user.cocci
> +++ b/scripts/coccinelle/api/memdup_user.cocci
> @@ -14,13 +14,24 @@ virtual patch
>  virtual context
>  virtual org
>  virtual report
> +virtual selfcheck
>
>  @initialize:python@
>  @@
> -filter = frozenset(['memdup_user', 'vmemdup_user'])
> +
> +definitions = {
> +    'memdup_user': 'mm/util.c',
> +    'vmemdup_user': 'mm/util.c',
> +}
> +
> +filter = frozenset(definitions.keys())
> +coccinelle.filtered = set()
> +coccinelle.checked_files = set()
>
>  def relevant(p):
> -    return not (filter & {el.current_element for el in p})
> +    found = filter & {el.current_element for el in p}
> +    coccinelle.filtered |= found
> +    return not found
>
>  @depends on patch@
>  expression from,to,size;
> @@ -117,3 +128,34 @@ p << rv.p;
>  @@
>
>  coccilib.report.print_report(p[0], "WARNING opportunity for vmemdup_user")
> +
> +@script:python depends on selfcheck@
> +@@
> +coccinelle.checked_files |= set(definitions.values()) & set(cocci.files())
> +
> +@finalize:python depends on selfcheck@
> +filtered << merge.filtered;
> +checked_files << merge.checked_files;
> +@@
> +
> +# Don't check memdup_user because the pattern is not capturing
> +# kmalloc_track_caller() calls
> +del definitions['memdup_user']
> +
> +# mapping between checked files and filtered definitions
> +found_defns = {}
> +for files, funcs in zip(checked_files, filtered):
> +   for file in files:
> +      found_defns[file] = funcs
> +
> +# reverse mapping of definitions
> +expected_defns = {v : set() for v in definitions.values()}
> +for k, v in definitions.items():
> +    expected_defns[v] |= {k}
> +
> +for efile, efuncs in expected_defns.items():
> +    if efile in found_defns:
> +        not_found = efuncs - found_defns[efile]
> +        if not_found:
> +            print('SELF-CHECK: the pattern no longer matches ' \
> +		  'definitions {} in file {}'.format(not_found, efile))
> --
> 2.26.2
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
