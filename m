Return-Path: <SRS0=MbUO=6S=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EB1C3A5A9
	for <cocci@archiver.kernel.org>; Mon,  4 May 2020 09:07:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FCD52054F
	for <cocci@archiver.kernel.org>; Mon,  4 May 2020 09:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D31a+0Vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCD52054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04496pTx007791;
	Mon, 4 May 2020 11:06:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A7B3F775A;
	Mon,  4 May 2020 11:06:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 28D373E68
 for <cocci@systeme.lip6.fr>; Mon,  4 May 2020 11:06:50 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04496mBG019792
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 4 May 2020 11:06:49 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id y6so3523027pjc.4
 for <cocci@systeme.lip6.fr>; Mon, 04 May 2020 02:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=gC80UsR+vRMCz+UVaXF2Eroj3n/m1FwH2bmpPRK1VLk=;
 b=D31a+0Vj2rvtMbj5oASSgUGar+aU3kPw4PRtqI52o8+ZTgUU37MjLCKRlFt/6Ux5w9
 5SWlblfmVIPM4ZlDnm8dw8Ho8CcMey2z+pbrenlXQ6Bx8NQL4QJjP18NUupkwz9yMiGk
 FZmjCpjIGID1lkFr5nxPZzkawL04TvKepo7XDWfFw91ZfQDoefMln0e7Da+5HN5mcMq0
 2DcXKM1llfWLo1UR/YyJ3C0ucuFHZSExJ8YnCkOb/a6xPG/lPmwB2CMMt/x7nF6KMYRW
 5uWzMICNHQRZWSb7rtpkjp6JgwHnMdT2TB6CcM8Ovfnl2swXiVoAO8IcA7S0R6UTeRZo
 B7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=gC80UsR+vRMCz+UVaXF2Eroj3n/m1FwH2bmpPRK1VLk=;
 b=VsXjmeNUxvFcRiubrG6bY7mASKM4AZohrxll6t1Cv9/F89ErT2g/HFyz6wKTc9YHeE
 rp+59GhgiKuXkGfKKDEl+umqRWZnrbh8RYIli+jMB29pKRvF8maZfanUTtmPfxFousfR
 pWWbc9Fys7HQJ9Aw9fltSNVIV5vVaQvSNTCtfarUjDhVDqhyLiQidK0jTEf/aeWq+K+V
 YrH5mFP3QBziJgMNGH7LMEZOb2azNTNo2WVdFbkLQTABeKICh77taz3gavKmicTcu3rc
 p1S1usjV4R0Iypk5J3wYXq+/rEh+5K9tjkdcfcnU0dtjSSl6xRYTeP1QGwynn344/DRJ
 FDgw==
X-Gm-Message-State: AGi0PuZK0sWbBLpHATDm6SwfQ6PQfYHUnyLt76ZhVVscKU0HtaCqQblw
 op0Ri7cTxS6mhwTi7dHJuww=
X-Google-Smtp-Source: APiQypKqjlfhE1gl+HLg8SKEkYhpFgym36rTBY28xbycR5kyYPOKNc8DVh8OQHwi31TJhfVzdsNutw==
X-Received: by 2002:a17:90a:6e0f:: with SMTP id
 b15mr16936247pjk.129.1588583207365; 
 Mon, 04 May 2020 02:06:47 -0700 (PDT)
Received: from localhost.localdomain ([2409:4040:e98:c794:8efa:58db:a8f7:9926])
 by smtp.gmail.com with ESMTPSA id q7sm7306591pgs.13.2020.05.04.02.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 02:06:46 -0700 (PDT)
Message-ID: <6073995d205524bfbb64745c3e39e677601ce06e.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Mon, 04 May 2020 14:36:43 +0530
In-Reply-To: <alpine.DEB.2.21.2005032122220.2533@hadrien>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
 <20200428170228.7002-2-jaskaransingh7654321@gmail.com>
 <alpine.DEB.2.21.2005032122220.2533@hadrien>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 04 May 2020 11:06:52 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 04 May 2020 11:06:49 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 01/32] parsing_c: parser: Pass attribute list
 from type_name
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

On Sun, 2020-05-03 at 21:23 +0200, Julia Lawall wrote:
> 
> On Tue, 28 Apr 2020, Jaskaran Singh wrote:
> 
> > To add Cast attributes to the C AST, pass attributes from the
> > type_name
> > rule of the C parser.
> 
> I'm not sure what you mean by "pass".  Normally, one passes something
> to
> something else, but it's not clear what the something else is.
> 

The something else would be the cast_expr rule (and basically any other
rule that uses the type_name rule).

I guess a better way to say it would be "return the attributes from the
type_name rule as well" (or if there is a specific term for it in
parser-terminology, then that).

Cheers,
Jaskaran.

> > Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> > ---
> >  ocaml/coccilib.mli     |  3 ++-
> >  parsing_c/parse_c.ml   |  4 +++-
> >  parsing_c/parser_c.mly | 16 ++++++++--------
> >  3 files changed, 13 insertions(+), 10 deletions(-)
> > 
> > diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
> > index 0e807c9a..a305d616 100644
> > --- a/ocaml/coccilib.mli
> > +++ b/ocaml/coccilib.mli
> > @@ -791,7 +791,8 @@ module Parser_c :
> >        (Lexing.lexbuf -> token) -> Lexing.lexbuf -> Ast_c.statement
> >      val expr : (Lexing.lexbuf -> token) -> Lexing.lexbuf ->
> > Ast_c.expression
> >      val type_name :
> > -      (Lexing.lexbuf -> token) -> Lexing.lexbuf -> Ast_c.fullType
> > +      (Lexing.lexbuf -> token) -> Lexing.lexbuf ->
> > +      Ast_c.attribute list * Ast_c.fullType
> >    end
> >  module Lexer_c :
> >    sig
> > diff --git a/parsing_c/parse_c.ml b/parsing_c/parse_c.ml
> > index 0d3a189a..5f8d5e2d 100644
> > --- a/parsing_c/parse_c.ml
> > +++ b/parsing_c/parse_c.ml
> > @@ -370,7 +370,9 @@ let parse_gen ~cpp ~tos parsefunc s =
> >    result
> > 
> >  (* Please DO NOT remove this code, even though most of it is not
> > used *)
> > -let type_of_string       = parse_gen ~cpp:false ~tos:true
> > Parser_c.type_name
> > +let type_of_string s     =
> > +  let typname = parse_gen ~cpp:false ~tos:true Parser_c.type_name
> > s in
> > +  Common.snd typname
> >  let statement_of_string  = parse_gen ~cpp:false ~tos:false
> > Parser_c.statement
> >  let expression_of_string = parse_gen ~cpp:false ~tos:false
> > Parser_c.expr
> >  let cpp_expression_of_string = parse_gen ~cpp:true ~tos:false
> > Parser_c.expr
> > diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
> > index aedde179..0abcc9b0 100644
> > --- a/parsing_c/parser_c.mly
> > +++ b/parsing_c/parser_c.mly
> > @@ -665,7 +665,7 @@ let postfakeInfo pii  =
> > 
> >  %type <Ast_c.statement> statement
> >  %type <Ast_c.expression> expr
> > -%type <Ast_c.fullType> type_name
> > +%type <Ast_c.attribute list * Ast_c.fullType> type_name
> > 
> >  %%
> >  /*(***************************************************************
> > **********)*/
> > @@ -818,7 +818,7 @@ arith_expr:
> > 
> >  cast_expr:
> >   | unary_expr                        { $1 }
> > - | topar2 type_name tcpar2 cast_expr { mk_e(Cast ($2, $4)) [$1;$3]
> > }
> > + | topar2 type_name tcpar2 cast_expr { mk_e(Cast (snd $2, $4))
> > [$1;$3] }
> >  /*
> >  It could be useful to have the following, but there is no place
> > for the
> >  attribute in the AST.
> > @@ -831,7 +831,7 @@ unary_expr:
> >   | TDec unary_expr                 { mk_e(Infix ($2, Dec))    [$1]
> > }
> >   | unary_op cast_expr              { mk_e(Unary ($2, fst $1)) [snd
> > $1] }
> >   | Tsizeof unary_expr              { mk_e(SizeOfExpr ($2))    [$1]
> > }
> > - | Tsizeof topar2 type_name tcpar2 { mk_e(SizeOfType
> > ($3))    [$1;$2;$4] }
> > + | Tsizeof topar2 type_name tcpar2 { mk_e(SizeOfType (snd
> > $3))    [$1;$2;$4] }
> 
> There could be less white space in front of the [
> 
> julia
> 
> >   | Tnew new_argument               { mk_e(New (None, $2))     [$1]
> > }
> >   | Tnew TOPar argument_list_ne TCPar new_argument { mk_e(New (Some
> > $3, $5))             [$1; $2; $4] }
> >   | Tdelete cast_expr               { mk_e(Delete(false, $2))  [$1]
> > }
> > @@ -897,9 +897,9 @@ postfix_expr:
> > 
> >   /*(* gccext: also called compound literals *)*/
> >   | topar2 type_name tcpar2 TOBrace TCBrace
> > -     { mk_e(Constructor ($2, (InitList [], [$4;$5]))) [$1;$3] }
> > +     { mk_e(Constructor (snd $2, (InitList [], [$4;$5]))) [$1;$3]
> > }
> >   | topar2 type_name tcpar2 TOBrace initialize_list
> > gcc_comma_opt_struct TCBrace
> > -     { mk_e(Constructor ($2, (InitList (List.rev $5),[$4;$7] @
> > $6))) [$1;$3] }
> > +     { mk_e(Constructor (snd $2, (InitList (List.rev $5),[$4;$7] @
> > $6))) [$1;$3] }
> > 
> > 
> >  primary_expr:
> > @@ -1298,7 +1298,7 @@ type_spec2:
> >         Right3 (TypeName (name, Ast_c.noTypedefDef())),[] }
> > 
> >   | Ttypeof TOPar assign_expr TCPar { Right3 (TypeOfExpr ($3)),
> > [$1;$2;$4] }
> > - | Ttypeof TOPar type_name   TCPar { Right3 (TypeOfType ($3)),
> > [$1;$2;$4] }
> > + | Ttypeof TOPar type_name   TCPar { Right3 (TypeOfType (snd $3)),
> > [$1;$2;$4] }
> > 
> >  /*(*----------------------------*)*/
> >  /*(* workarounds *)*/
> > @@ -1531,12 +1531,12 @@ type_qualif_list:
> >  type_name:
> >   | spec_qualif_list
> >       { let (attrs, ds) = $1 in
> > -       let (returnType, _) = fixDeclSpecForDecl ds in returnType }
> > +       let (returnType, _) = fixDeclSpecForDecl ds in (attrs,
> > returnType) }
> >   | spec_qualif_list abstract_declaratort
> >       { let (attrs1, ds) = $1 in
> >         let (attrs2, fn) = $2 in
> >         let (returnType, _) = fixDeclSpecForDecl ds in
> > -       fn returnType }
> > +       (attrs1@attrs2, fn returnType) }
> > 
> > 
> > 
> > --
> > 2.21.1
> > 
> > 

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
