Return-Path: <SRS0=GrYw=ZW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752DBC432C0
	for <cocci@archiver.kernel.org>; Sat, 30 Nov 2019 06:36:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F95C20665
	for <cocci@archiver.kernel.org>; Sat, 30 Nov 2019 06:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F95C20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAU6ZgGq018360;
	Sat, 30 Nov 2019 07:35:42 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 01C5277D3;
	Sat, 30 Nov 2019 07:35:42 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8AD8477CC
 for <cocci@systeme.lip6.fr>; Sat, 30 Nov 2019 07:35:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAU6ZdgC004761
 for <cocci@systeme.lip6.fr>; Sat, 30 Nov 2019 07:35:39 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.69,260,1571695200"; d="scan'208";a="414228164"
Received: from abo-228-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.228])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Nov 2019 07:35:39 +0100
Date: Sat, 30 Nov 2019 07:35:39 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Strace Labs <stracelabs@gmail.com>
In-Reply-To: <CABvP5W3hmmovw09n6gJQ5m=Cps2YAYJFFfOPmKY6Zu_SJOU=NQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911300733180.2588@hadrien>
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <a64ca4bf-4d00-6d8f-19cf-0667d9b1ca83@web.de>
 <CY4PR1801MB200527E64CB2C5ECF218EFF4A3460@CY4PR1801MB2005.namprd18.prod.outlook.com>
 <509ffde0-ec26-a58c-d424-6910bc8e7473@web.de>
 <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
 <02fa7455-e76e-7d7d-0d64-41b2803a8025@web.de>
 <CABvP5W0kVE+yBYa7gWLfsegb75fMyMcLSDbsnFUGRnnVoRLtDQ@mail.gmail.com>
 <alpine.DEB.2.21.1911292154450.3140@hadrien>
 <CABvP5W3hmmovw09n6gJQ5m=Cps2YAYJFFfOPmKY6Zu_SJOU=NQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-548002346-1575095739=:2588"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 30 Nov 2019 07:35:42 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 30 Nov 2019 07:35:39 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Replacing printf() parameters according to used data
 types
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

--8323329-548002346-1575095739=:2588
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



--- Please note the new email address ---


On Sat, 30 Nov 2019, Strace Labs wrote:

> Hi Julia,
>
> Thanks for the suggestion. But, It is working partially... I am not sure if
> Coccinelle is able to filter the %fmt e.g: %s only called with a parameter
> of specific data-type. In my case, {struct mydata }.name and { struct mydata
> *}->name.
>
> #####  Cocci
> @r1@
> format list d;
> identifier fn;
> @@
>
> fn("%@d@", ...)

There is no need to put ... here if you want to specify something else.

julia

> @script:ocaml s1@
> d << r1.d;
> res;
> @@
> res := make_expr ("\""^(String.concat "%m"
> (Str.split_delim(Str.regexp_string "%s") d))^"\"")
>
> @main depends on s1 && r1@
> format list r1.d;
> expression s1.res;
> identifier r1.fn;
> struct mydata SMD;
> struct mydata* SMDP;
> @@
>
>  fn(
> -"%@d@"
> +res
> ,
> (
> + &
>   SMD
> - .name
> |
>   SMDP
> - ->name
> )
>  );
>  
> #####  .c Code sample
> int foo() {
> int id;
> struct mydata h1, *h2, s1, *s2;
> char *city;
>
> // works fine
> my_printf("%s", s2->name);
>
> // works without any criterions about the data type of %fmt
> my_printf("sss %s gggg", h1.name);
> my_printf("33131231313 %d %s %d %s hhhhh", id, s1.name, (*h2)->name,
> h2->name);
> my_printf("aaaa %s hhhhh", h2->name);
> my_printf("%s", s2->name);
>
> // should do nothing
> my_printf("%s");
> my_printf("%s", city);
>
> // don't match.
> my_printf("a %s %d", h2->name, id);
> my_printf("ddddd %s %s %s", h2->name, city, h2->name);
> my_printf("%d it would work but dunno mydata=%m\n", id, h2);
> my_printf("%d here also, tt=%s | %s and %m\n", id, h2->name, h2->name, s2);
> }
>
> #### Result
> HANDLING: /Volumes/Users/test/Coccinella/sample.c
> diff =
> --- /Volumes/Users/test/Coccinella/sample.c
> +++ /tmp/cocci-output-99329-3a9829-sample.c
> @@ -5,13 +5,13 @@ int foo() {
>   char *city;
>
>   // works fine
> - my_printf("%s", s2->name);
> + my_printf("%m", s2);
>
>   // works without any criterious about the data type of %fmt
> - my_printf("sss %s gggg", h1.name);
> + my_printf("sss %m gggg", &h1);
>   my_printf("33131231313 %d %s %d %s hhhhh", id, s1.name, (*h2)->name,
> h2->name);
> - my_printf("aaaa %s hhhhh", h2->name);
> - my_printf("%s", s2->name);
> + my_printf("aaaa %m hhhhh", h2);
> + my_printf("%m", s2);
>
>   // should do nothing
>   my_printf("%s");
>
>
> Basically, I intend to replace alls "%s" called with "mydata->name" by "%m"
> with "mydata" or "&mydata"
>
>
>
>
>
> On Fri, Nov 29, 2019 at 6:55 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>       Maybe this will help you:
>
>       @r@
>       format list d;
>       @@
>
>       "%@d@"
>
>       @script:ocaml s@
>       d << r.d;
>       res;
>       @@
>       res := make_expr ("\""^(String.concat "%s" (Str.split_delim
>       (Str.regexp_string "%d") d))^"\"")
>
>
>       @@
>       format list r.d;
>       expression s.res;
>       @@
>
>       -"%@d@"
>       +res
>
>       ---------------
>
>       Example:
>
>       int main() {
>         printf("some %d more\n", 12);
>       }
>
>       int main() {
>         printf("%d more\n", 12);
>       }
>
>       int main() {
>         printf("more %d\n", 12);
>       }
>
>       int main() {
>         printf("%d more %d\n", 12);
>       }
>
>       julia
>
>
>
--8323329-548002346-1575095739=:2588
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-548002346-1575095739=:2588--
