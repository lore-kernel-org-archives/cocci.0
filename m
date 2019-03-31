Return-Path: <SRS0=9ZHZ=SC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCE7C43381
	for <cocci@archiver.kernel.org>; Sun, 31 Mar 2019 07:59:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 886DB2146F
	for <cocci@archiver.kernel.org>; Sun, 31 Mar 2019 07:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886DB2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2V7wgtW028716
          ; Sun, 31 Mar 2019 09:58:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 472457663;
	Sun, 31 Mar 2019 09:58:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 606557631
 for <cocci@systeme.lip6.fr>; Sun, 31 Mar 2019 09:58:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2V7wdh1015301
 for <cocci@systeme.lip6.fr>; Sun, 31 Mar 2019 09:58:39 +0200 (CEST)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,291,1549926000"; d="scan'208";a="301281910"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Mar 2019 09:58:15 +0200
Date: Sun, 31 Mar 2019 09:58:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20190330222410.GA27158@roeck-us.net>
Message-ID: <alpine.DEB.2.21.1903310950160.2578@hadrien>
References: <20190330222410.GA27158@roeck-us.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 Mar 2019 09:58:42 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sun, 31 Mar 2019 09:58:39 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] A complex set of rules: can it be done ?
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



On Sat, 30 Mar 2019, Guenter Roeck wrote:

> Hi Coccinelle experts,
>
> is it possible to define a set of rules to automate the conversion done
> in the attached patch ? I tried doing it myself, but did'nt get anywhere.

@r@
initializer list elements;
identifier i;
@@

-static const u32 i[] = {
-  elements,
-  0
-};

@s@
identifier r.i,j,ty;
@@

-static const struct hwmon_channel_info j = {
-       .type = ty,
-       .config = i,
-};

@script:ocaml t@
ty << s.ty;
elements << r.elements;
shorter;
elems;
@@

shorter :=
   make_ident (List.hd(List.rev (Str.split (Str.regexp "_") ty)));
elems :=
   make_ident
    (String.concat ","
     (List.map (fun x -> Printf.sprintf "\n\t\t\t   %s" x)
       (Str.split (Str.regexp " , ") elements)))

@@
identifier s.j,t.shorter;
identifier t.elems;
@@

- &j
+ HWMON_CHANNEL_INFO(shorter,elems)

--------------------------------------

Theer is some ugliness here.  The elements of the array are considered to
be an initializer list, while the arguments to the macro have to be an
expression list.  The script code related to elems and elements is to deal
with that.

There is also script code to constuct the first argument of
HWMON_CHANNEL_INFO from gthe name of the hwmon_channel_info structure.

You should be able to drop the static const stuff on the structures, if it
is not appropriate in general.  It should still be removed when the whole
structure is removed.

If you want to write some other script code that makes metavariables in
this way and prefer to use python, there are examples in

demos/pythontococci.cocci (only for making identifiers)
tests/python_mdecl.cocci  (for making identifiers and others)

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
