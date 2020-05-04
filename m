Return-Path: <SRS0=MbUO=6S=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C762C3A5A9
	for <cocci@archiver.kernel.org>; Mon,  4 May 2020 13:19:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A7B2073B
	for <cocci@archiver.kernel.org>; Mon,  4 May 2020 13:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A7B2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 044DIrXK024737;
	Mon, 4 May 2020 15:18:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C02AC775A;
	Mon,  4 May 2020 15:18:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F0BCD3E68
 for <cocci@systeme.lip6.fr>; Mon,  4 May 2020 15:18:51 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 044DIpbC015800
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 4 May 2020 15:18:51 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,352,1583190000"; d="scan'208";a="448095192"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 May 2020 15:18:40 +0200
Date: Mon, 4 May 2020 15:18:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
In-Reply-To: <946de1fd2c3faacd4794c8cda8717847f95834bd.camel@gmail.com>
Message-ID: <alpine.DEB.2.21.2005041517560.2425@hadrien>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
 <20200428170228.7002-2-jaskaransingh7654321@gmail.com>
 <alpine.DEB.2.21.2005032122220.2533@hadrien>
 <6073995d205524bfbb64745c3e39e677601ce06e.camel@gmail.com>
 <alpine.DEB.2.21.2005041116360.2425@hadrien>
 <946de1fd2c3faacd4794c8cda8717847f95834bd.camel@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 04 May 2020 15:18:54 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 04 May 2020 15:18:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
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



On Mon, 4 May 2020, Jaskaran Singh wrote:

> On Mon, 2020-05-04 at 11:17 +0200, Julia Lawall wrote:
> >
> > On Mon, 4 May 2020, Jaskaran Singh wrote:
> >
> > > On Sun, 2020-05-03 at 21:23 +0200, Julia Lawall wrote:
> > > > On Tue, 28 Apr 2020, Jaskaran Singh wrote:
> > > >
> > > > > To add Cast attributes to the C AST, pass attributes from the
> > > > > type_name
> > > > > rule of the C parser.
> > > >
> > > > I'm not sure what you mean by "pass".  Normally, one passes
> > > > something
> > > > to
> > > > something else, but it's not clear what the something else is.
> > > >
> > >
> > > The something else would be the cast_expr rule (and basically any
> > > other
> > > rule that uses the type_name rule).
> > >
> > > I guess a better way to say it would be "return the attributes from
> > > the
> > > type_name rule as well"
> >
> > This seems fine, thanks!
> >
> > In this patch there are a lot of places where the information is just
> > discarded.  Will it be used in the future?
> >
>
> We could add support for those attributes as well (ex. typeof, sizeof,
> etc.). This patch only adds support for cast attributes though.

OK.  I'm not sure that attributes make sense for sizeof.  Perhaps give a
warning rather than just dropping it.

julia

>
> Cheers,
> Jaskaran.
>
> > julia
> >
> > > (or if there is a specific term for it in
> > > parser-terminology, then that).
> > >
> > > Cheers,
> > > Jaskaran.
> > >
> > > > > Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> > > > > ---
> > > > >  ocaml/coccilib.mli     |  3 ++-
> > > > >  parsing_c/parse_c.ml   |  4 +++-
> > > > >  parsing_c/parser_c.mly | 16 ++++++++--------
> > > > >  3 files changed, 13 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
> > > > > index 0e807c9a..a305d616 100644
> > > > > --- a/ocaml/coccilib.mli
> > > > > +++ b/ocaml/coccilib.mli
> > > > > @@ -791,7 +791,8 @@ module Parser_c :
> > > > >        (Lexing.lexbuf -> token) -> Lexing.lexbuf ->
> > > > > Ast_c.statement
> > > > >      val expr : (Lexing.lexbuf -> token) -> Lexing.lexbuf ->
> > > > > Ast_c.expression
> > > > >      val type_name :
> > > > > -      (Lexing.lexbuf -> token) -> Lexing.lexbuf ->
> > > > > Ast_c.fullType
> > > > > +      (Lexing.lexbuf -> token) -> Lexing.lexbuf ->
> > > > > +      Ast_c.attribute list * Ast_c.fullType
> > > > >    end
> > > > >  module Lexer_c :
> > > > >    sig
> > > > > diff --git a/parsing_c/parse_c.ml b/parsing_c/parse_c.ml
> > > > > index 0d3a189a..5f8d5e2d 100644
> > > > > --- a/parsing_c/parse_c.ml
> > > > > +++ b/parsing_c/parse_c.ml
> > > > > @@ -370,7 +370,9 @@ let parse_gen ~cpp ~tos parsefunc s =
> > > > >    result
> > > > >
> > > > >  (* Please DO NOT remove this code, even though most of it is
> > > > > not
> > > > > used *)
> > > > > -let type_of_string       = parse_gen ~cpp:false ~tos:true
> > > > > Parser_c.type_name
> > > > > +let type_of_string s     =
> > > > > +  let typname = parse_gen ~cpp:false ~tos:true
> > > > > Parser_c.type_name
> > > > > s in
> > > > > +  Common.snd typname
> > > > >  let statement_of_string  = parse_gen ~cpp:false ~tos:false
> > > > > Parser_c.statement
> > > > >  let expression_of_string = parse_gen ~cpp:false ~tos:false
> > > > > Parser_c.expr
> > > > >  let cpp_expression_of_string = parse_gen ~cpp:true ~tos:false
> > > > > Parser_c.expr
> > > > > diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
> > > > > index aedde179..0abcc9b0 100644
> > > > > --- a/parsing_c/parser_c.mly
> > > > > +++ b/parsing_c/parser_c.mly
> > > > > @@ -665,7 +665,7 @@ let postfakeInfo pii  =
> > > > >
> > > > >  %type <Ast_c.statement> statement
> > > > >  %type <Ast_c.expression> expr
> > > > > -%type <Ast_c.fullType> type_name
> > > > > +%type <Ast_c.attribute list * Ast_c.fullType> type_name
> > > > >
> > > > >  %%
> > > > >  /*(***********************************************************
> > > > > ****
> > > > > **********)*/
> > > > > @@ -818,7 +818,7 @@ arith_expr:
> > > > >
> > > > >  cast_expr:
> > > > >   | unary_expr                        { $1 }
> > > > > - | topar2 type_name tcpar2 cast_expr { mk_e(Cast ($2, $4))
> > > > > [$1;$3]
> > > > > }
> > > > > + | topar2 type_name tcpar2 cast_expr { mk_e(Cast (snd $2, $4))
> > > > > [$1;$3] }
> > > > >  /*
> > > > >  It could be useful to have the following, but there is no
> > > > > place
> > > > > for the
> > > > >  attribute in the AST.
> > > > > @@ -831,7 +831,7 @@ unary_expr:
> > > > >   | TDec unary_expr                 { mk_e(Infix ($2,
> > > > > Dec))    [$1]
> > > > > }
> > > > >   | unary_op cast_expr              { mk_e(Unary ($2, fst $1))
> > > > > [snd
> > > > > $1] }
> > > > >   | Tsizeof unary_expr              { mk_e(SizeOfExpr
> > > > > ($2))    [$1]
> > > > > }
> > > > > - | Tsizeof topar2 type_name tcpar2 { mk_e(SizeOfType
> > > > > ($3))    [$1;$2;$4] }
> > > > > + | Tsizeof topar2 type_name tcpar2 { mk_e(SizeOfType (snd
> > > > > $3))    [$1;$2;$4] }
> > > >
> > > > There could be less white space in front of the [
> > > >
> > > > julia
> > > >
> > > > >   | Tnew new_argument               { mk_e(New (None,
> > > > > $2))     [$1]
> > > > > }
> > > > >   | Tnew TOPar argument_list_ne TCPar new_argument { mk_e(New
> > > > > (Some
> > > > > $3, $5))             [$1; $2; $4] }
> > > > >   | Tdelete cast_expr               { mk_e(Delete(false,
> > > > > $2))  [$1]
> > > > > }
> > > > > @@ -897,9 +897,9 @@ postfix_expr:
> > > > >
> > > > >   /*(* gccext: also called compound literals *)*/
> > > > >   | topar2 type_name tcpar2 TOBrace TCBrace
> > > > > -     { mk_e(Constructor ($2, (InitList [], [$4;$5]))) [$1;$3]
> > > > > }
> > > > > +     { mk_e(Constructor (snd $2, (InitList [], [$4;$5])))
> > > > > [$1;$3]
> > > > > }
> > > > >   | topar2 type_name tcpar2 TOBrace initialize_list
> > > > > gcc_comma_opt_struct TCBrace
> > > > > -     { mk_e(Constructor ($2, (InitList (List.rev $5),[$4;$7] @
> > > > > $6))) [$1;$3] }
> > > > > +     { mk_e(Constructor (snd $2, (InitList (List.rev
> > > > > $5),[$4;$7] @
> > > > > $6))) [$1;$3] }
> > > > >
> > > > >
> > > > >  primary_expr:
> > > > > @@ -1298,7 +1298,7 @@ type_spec2:
> > > > >         Right3 (TypeName (name, Ast_c.noTypedefDef())),[] }
> > > > >
> > > > >   | Ttypeof TOPar assign_expr TCPar { Right3 (TypeOfExpr ($3)),
> > > > > [$1;$2;$4] }
> > > > > - | Ttypeof TOPar type_name   TCPar { Right3 (TypeOfType ($3)),
> > > > > [$1;$2;$4] }
> > > > > + | Ttypeof TOPar type_name   TCPar { Right3 (TypeOfType (snd
> > > > > $3)),
> > > > > [$1;$2;$4] }
> > > > >
> > > > >  /*(*----------------------------*)*/
> > > > >  /*(* workarounds *)*/
> > > > > @@ -1531,12 +1531,12 @@ type_qualif_list:
> > > > >  type_name:
> > > > >   | spec_qualif_list
> > > > >       { let (attrs, ds) = $1 in
> > > > > -       let (returnType, _) = fixDeclSpecForDecl ds in
> > > > > returnType }
> > > > > +       let (returnType, _) = fixDeclSpecForDecl ds in (attrs,
> > > > > returnType) }
> > > > >   | spec_qualif_list abstract_declaratort
> > > > >       { let (attrs1, ds) = $1 in
> > > > >         let (attrs2, fn) = $2 in
> > > > >         let (returnType, _) = fixDeclSpecForDecl ds in
> > > > > -       fn returnType }
> > > > > +       (attrs1@attrs2, fn returnType) }
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > 2.21.1
> > > > >
> > > > >
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
