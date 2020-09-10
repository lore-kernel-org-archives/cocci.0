Return-Path: <SRS0=PX7z=CT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6E1C43461
	for <cocci@archiver.kernel.org>; Thu, 10 Sep 2020 05:18:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F1092075A
	for <cocci@archiver.kernel.org>; Thu, 10 Sep 2020 05:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1092075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08A5Hdao016427;
	Thu, 10 Sep 2020 07:17:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 75A4C778C;
	Thu, 10 Sep 2020 07:17:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 66E217595
 for <cocci@systeme.lip6.fr>; Thu, 10 Sep 2020 07:17:37 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08A5HZJ3015441
 for <cocci@systeme.lip6.fr>; Thu, 10 Sep 2020 07:17:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 1D47429B360
Message-ID: <1068dd442109a366730c102ac4bfca6b583fbe87.camel@collabora.com>
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Thu, 10 Sep 2020 10:47:30 +0530
In-Reply-To: <alpine.DEB.2.22.394.2009092140100.2651@hadrien>
References: <20200909181302.1187-1-jaskaran.singh@collabora.com>
 <20200909181302.1187-3-jaskaran.singh@collabora.com>
 <alpine.DEB.2.22.394.2009092140100.2651@hadrien>
Organization: Collabora
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 10 Sep 2020 07:17:39 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 10 Sep 2020 07:17:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [RFC PATCH 2/3] parsing_c: parse_c: Build name cache
 and includes dependency graph
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

On Wed, 2020-09-09 at 21:41 +0200, Julia Lawall wrote:
> 
> On Wed, 9 Sep 2020, Jaskaran Singh wrote:
> 
> > Build the includes dependency graph and name cache while parsing
> > header
> > files. Every header file is parsed only once for name caching and,
> > while
> > parsing these files, an includes dependency graph is built to
> > determine
> > reachability of one header file from another file.
> 
> So you really parse the whole file here?  

Yes.

> Could you avoid that? 

Well, we need the AST for name caching. I guess we could lazily parse
these on demand and do the name caching in the type annoter. But I'm
not sure how much of a difference that would make, it'd probably end up
parsing about 80% of those branches anyway.

>  Is it
> that you need to parse something to find the end of it?
> 

We need everything from it, i.e. struct fields, enumeration constants,
function prototypes, etc. as well as the #includes in it.

Cheers,
Jaskaran.

> julia
> 
> > Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
> > ---
> >  parsing_c/parse_c.ml | 27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> > 
> > diff --git a/parsing_c/parse_c.ml b/parsing_c/parse_c.ml
> > index 5574cb11b..3b250720f 100644
> > --- a/parsing_c/parse_c.ml
> > +++ b/parsing_c/parse_c.ml
> > @@ -17,6 +17,7 @@ open Common
> > 
> >  module TH = Token_helpers
> >  module LP = Lexer_parser
> > +module IC = Includes_cache
> > 
> >  module Stat = Parsing_stat
> > 
> > @@ -995,15 +996,29 @@ let rec _parse_print_error_heuristic2
> > saved_typedefs saved_macros
> >  and handle_include file wrapped_incl k =
> >      let incl = Ast_c.unwrap wrapped_incl.Ast_c.i_include in
> >      let parsing_style = Includes.get_parsing_style () in
> > +    let f = Includes.resolve file parsing_style incl in
> >      if Includes.should_parse parsing_style file incl
> >      then
> > -      match Includes.resolve file parsing_style incl with
> > +      match f with
> >        | Some header_filename when Common.lfile_exists
> > header_filename ->
> > -	  (if !Flag_parsing_c.verbose_includes
> > -	  then pr2 ("including "^header_filename));
> > -	  let nonlocal =
> > -	    match incl with Ast_c.NonLocal _ -> true | _ -> false in
> > -          ignore (k nonlocal header_filename)
> > +          if not (IC.has_been_parsed header_filename)
> > +          then begin
> > +            IC.add_to_parsed_files header_filename;
> > +	    (if !Flag_parsing_c.verbose_includes
> > +	    then pr2 ("including "^header_filename));
> > +	    let nonlocal =
> > +	      match incl with Ast_c.NonLocal _ -> true | _ -> false in
> > +            let res = k nonlocal header_filename in
> > +            match res with
> > +              None -> ()
> > +            | Some x ->
> > +                let pt = x.parse_trees in
> > +                let (p, _, _) = pt in
> > +                with_program2_unit
> > +                  (IC.extract_names header_filename)
> > +                  p
> > +          end;
> > +          IC.add_to_dependency_graph file header_filename;
> >        | _ -> ()
> > 
> >  and _parse_print_error_heuristic2bis saved_typedefs saved_macros
> > --
> > 2.21.3
> > 
> > 

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
