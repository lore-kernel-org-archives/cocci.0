Return-Path: <SRS0=ks6G=UB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED046C282DC
	for <cocci@archiver.kernel.org>; Sun,  2 Jun 2019 08:39:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BF527888
	for <cocci@archiver.kernel.org>; Sun,  2 Jun 2019 08:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BF527888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x528clIG007344;
	Sun, 2 Jun 2019 10:38:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E749C657D;
	Sun,  2 Jun 2019 10:38:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id ABB815852
 for <cocci@systeme.lip6.fr>; Sun,  2 Jun 2019 10:38:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x528ciLM001208
 for <cocci@systeme.lip6.fr>; Sun, 2 Jun 2019 10:38:44 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.60,542,1549926000"; d="scan'208";a="385584924"
Received: from abo-20-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.20])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jun 2019 10:38:44 +0200
Date: Sun, 2 Jun 2019 10:38:43 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Wen Yang <yellowriver2010@hotmail.com>
In-Reply-To: <MAXPR01MB39833362F9B533717A9DE485B21B0@MAXPR01MB3983.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <alpine.DEB.2.21.1906021038020.10641@hadrien>
References: <MAXPR01MB39833362F9B533717A9DE485B21B0@MAXPR01MB3983.INDPRD01.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 02 Jun 2019 10:38:47 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sun, 02 Jun 2019 10:38:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] Python scripts also support comments metavar
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

Applied, thanks.

julia

On Sun, 2 Jun 2019, Wen Yang wrote:

> Extending the comment support to python
>
> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> ---
>  demos/comments.cocci     | 28 +++++++++++++++++++++++++++-
>  python/coccilib/elems.py |  6 ++++++
>  python/yes_pycocci.ml    | 22 +++++++++++++++++++++-
>  3 files changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/demos/comments.cocci b/demos/comments.cocci
> index cdca955b..abfcc6b8 100644
> --- a/demos/comments.cocci
> +++ b/demos/comments.cocci
> @@ -33,4 +33,30 @@ Printf.printf "c3a: %s\n\n" (String.concat " " c3a);
>  Printf.printf "c4b: %s\n" (String.concat " " c4b);
>  Printf.printf "c4m: %s\n" (String.concat " " c4m);
>  Printf.printf "c4a: %s\n\n" (String.concat " " c4a);
> -Printf.printf "-------------------\n"
> \ No newline at end of file
> +Printf.printf "-------------------\n"
> +
> +@script:python@
> +c1 << r.c1;
> +c2 << r.c2;
> +c3 << r.c3;
> +c4 << r.c4;
> +@@
> +
> +print("python test begin ...")
> +print("c1b: ", c1[0].before)
> +print("c1m: ", c1[0].middle)
> +print("c1a: ", c1[0].after)
> +
> +print("c2b: ", c2[0].before)
> +print("c2m: ", c2[0].middle)
> +print("c2a: ", c2[0].after)
> +
> +print("c3b: ", c3[0].before)
> +print("c3m: ", c3[0].middle)
> +print("c3a: ", c3[0].after)
> +
> +print("c4b: ", c4[0].before)
> +print("c4m: ", c4[0].middle)
> +print("c4a: ", c4[0].after)
> +
> +print("python test end \n")
> diff --git a/python/coccilib/elems.py b/python/coccilib/elems.py
> index ddb508b0..4d11a79a 100644
> --- a/python/coccilib/elems.py
> +++ b/python/coccilib/elems.py
> @@ -11,6 +11,12 @@ class Location:
>                  self.line_end = line_end
>                  self.column_end = column_end
>
> +class Comment:
> + def __init__(self, comment_before, comment_middle, comment_after):
> +                self.before = comment_before
> +                self.middle = comment_middle
> +                self.after = comment_after
> +
>  class ElemBase:
>          def __init__(self):
>                  pass
> diff --git a/python/yes_pycocci.ml b/python/yes_pycocci.ml
> index 0e0e654c..038ad2a9 100644
> --- a/python/yes_pycocci.ml
> +++ b/python/yes_pycocci.ml
> @@ -366,7 +366,27 @@ let construct_variables mv e =
>         let pylocs = Py.Tuple.of_list locs in
>         let _ = build_variable py pylocs in
>         ()
> -    | Some (_, Ast_c.MetaComValList l) -> failwith "comments not yet supported"
> +    | Some (_, Ast_c.MetaComValList l) ->
> +       let coms =
> +	 List.map
> +	   (function (bef, mid, aft) ->
> +            let com_strings l =
> +              List.rev
> +                (List.fold_left
> +                   (fun prev cur ->
> +                     match cur with
> +                       (Token_c.TComment,_) -> (Token_c.str_of_token cur) :: prev
> +                     | (Token_c.TCommentCpp _,_) -> (Token_c.str_of_token cur) :: prev
> +                     | _ -> prev)
> +                   [] l) in
> +	     pycocci_instantiate_class "coccilib.elems.Comment"
> +	       (Py.Tuple.of_list_map Py.String.of_string
> +		  [String.concat "\n" (com_strings bef);
> +		   String.concat "\n" (com_strings mid);
> +		   String.concat "\n" (com_strings aft)])) l in
> +       let pycoms = Py.Tuple.of_list coms in
> +       let _ = build_variable py pycoms in
> +       ()
>      | Some (_,binding) ->
>         let _ =
>  	 build_variable py
> --
> 2.21.0
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
