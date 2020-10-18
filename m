Return-Path: <SRS0=mWdE=DZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B345C433DF
	for <cocci@archiver.kernel.org>; Sun, 18 Oct 2020 16:20:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB6020773
	for <cocci@archiver.kernel.org>; Sun, 18 Oct 2020 16:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB6020773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09IGK8TD020551;
	Sun, 18 Oct 2020 18:20:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5440C7797;
	Sun, 18 Oct 2020 18:20:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6607E74CE
 for <cocci@systeme.lip6.fr>; Sun, 18 Oct 2020 18:20:06 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09IGK4SY021009
 for <cocci@systeme.lip6.fr>; Sun, 18 Oct 2020 18:20:04 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.77,391,1596492000"; d="scan'208";a="473171051"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Oct 2020 18:20:04 +0200
Date: Sun, 18 Oct 2020 18:20:04 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2774601.u91sIFNy1E@sonne>
Message-ID: <alpine.DEB.2.22.394.2010181819210.2759@hadrien>
References: <3528117.7ODa3CK5J5@sonne> <2774601.u91sIFNy1E@sonne>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1982622638-1603038004=:2759"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 18 Oct 2020 18:20:08 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 18 Oct 2020 18:20:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>,
        Alexander Popov <alex.popov@linux.com>
Subject: Re: [Cocci] Determination of an usage statistic for
 memory	allocation calls
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

--8323329-1982622638-1603038004=:2759
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 18 Oct 2020, Markus Elfring wrote:

> > …
> > > +    E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|
> > > +          kmalloc_node\|kzalloc_node\|kmalloc_array\|
> > > +          kmalloc_array_node\|kcalloc_node\)(...)@kok
> > …
> >
> > How do you think about the possibility for any adjustments according to the order
> > of the mentioned function names in proposed disjunctions for the semantic patch language?
>
>
> I would like to share another source code analysis approach.
> I hope that this contribution can trigger further helpful software development ideas.
>
>
> @initialize:python@
> @@
> import sys
>
> def write_identifier(source, call):
>     names = []
>     for x in source:
>        names.append(call)
>
>     sys.stdout.write("\n".join(names) + "\n")
>
> @find1@
> expression e;
> identifier call, x;
> position pos;
> type rt;
> @@
>  rt x(...)
>  {
>  <+...
>  e =@pos
> (kzalloc@call
> |kmalloc@call
> |kcalloc@call
> |kmalloc_array@call
> |kmemdup@call
> |kstrdup@call
> |vmalloc@call
> |vzalloc@call
> |kzalloc_node@call
> |kvmalloc@call
> |krealloc@call
> |kmalloc_node@call
> |kcalloc_node@call
> |__vmalloc@call
> |vmalloc_user@call
> |vzalloc_node@call
> |vmalloc_32@call
> |__vmalloc_node_range@call
> |vmalloc_node@call
> |kmalloc_array_node@call
> |__vmalloc_node@call
> |vmalloc_32_user@call
> |vmalloc_exec@call
> )(...)
>  ...+>
>  }
>
> @script:python collection1@
> call << find1.call;
> place << find1.pos;
> @@
> write_identifier(place, call)
>
> @find2@
> identifier call, var, x;
> position pos;
> type rt, vt;
> @@
>  rt x(...)
>  {
>  <+...
>  vt var =@pos
> (kzalloc@call
> |kmalloc@call
> |kcalloc@call
> |kmalloc_array@call
> |kmemdup@call
> |kstrdup@call
> |vmalloc@call
> |vzalloc@call
> |kzalloc_node@call
> |kvmalloc@call
> |krealloc@call
> |kmalloc_node@call
> |kcalloc_node@call
> |__vmalloc@call
> |vmalloc_user@call
> |vzalloc_node@call
> |vmalloc_32@call
> |__vmalloc_node_range@call
> |vmalloc_node@call
> |kmalloc_array_node@call
> |__vmalloc_node@call
> |vmalloc_32_user@call
> |vmalloc_exec@call
> )(...);
>  ...+>
>  }
>
> @script:python collection2@
> call << find2.call;
> place << find2.pos;
> @@
> write_identifier(place, call)
>
>
> Test result:
> elfring@Sonne:~/Projekte/Linux/next-patched> git checkout next-20201016 && XX=$(date) && time spatch --timeout 23 --python python3 --jobs 4 --chunksize 1 --include-headers --no-includes --dir . ~/Projekte/Coccinelle/janitor/report_memory_allocation_calls4.cocci 2> ~/Projekte/Bau/Linux/scripts/Coccinelle/call_checks/20201016/report_memory_allocation_calls4-errors.txt | echo "$(echo 'call' && cat)" | csvsql --query 'select call, count(*) from stdin group by call order by count(*) desc'; YY=$(date) && echo "$XX | $YY"
> …
> call,count(*)
> kzalloc,12652
> kmalloc,4902
> kcalloc,2564
> kmalloc_array,859
> kmemdup,797
> kstrdup,469
> vmalloc,405
> vzalloc,359
> kzalloc_node,177
> kvmalloc,154
> krealloc,151
> kmalloc_node,49
> kcalloc_node,44
> __vmalloc,34
> vmalloc_user,28
> vzalloc_node,21
> vmalloc_32,9
> __vmalloc_node_range,8
> vmalloc_node,7
> kmalloc_array_node,5
> __vmalloc_node,4
> vmalloc_32_user,1
>
> real	22m25,049s
> user	84m11,257s
> sys	0m12,168s
> So 18. Okt 16:55:08 CEST 2020 | So 18. Okt 17:17:33 CEST 2020
>
>
> The log file contains the information “9211 files match”.
> Can such facts influence the specification of efficient SmPL disjunctions another bit?

On my machine, putting the three functions that you have foudn to be the
most frequent at the end of each disjunction has no impact on the
performance.  So what do you suggest?

julia
--8323329-1982622638-1603038004=:2759
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1982622638-1603038004=:2759--
