Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEE9D3ABDD
	for <cocci@archiver.kernel.org>; Mon, 11 Nov 2024 17:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=cMQwuF9jNz40FDremPlBmzLSVxYGwCW4lVStftIOLcM=;
  b=Xz5Nh6oKda4bLxjydtNMyr0UMtSS7FXuv85oiWBJxHoX3XnOctenZmvp
   WOfm3P3tiK1K1UvRf6JwodDJ6UgfgIxAj7SGQjut1x3vNtpRxPYXYnGIp
   770fva2HsbCPeeO9gplmdbQkV1invhkrY8VPErleePkY+UVuPQZQDkDP1
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="asc'?txt'?scan'208";a="193205562"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2024 18:59:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E29EDE0133; Mon, 11 Nov 2024 18:59:44 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 27CD3E00B7
	for <cocci@sympa.inria.fr>; Mon, 11 Nov 2024 18:59:43 +0100 (CET)
IronPort-SDR: 6732460e_Ejwa0dGmW+XsgbGgnW9Ppx07zF6fmqCg9+vr48A/x33Fnix
 /Dw6+QbyJFmiIgV9yUNDjn+rHCLfCIslTVImcOg==
X-IPAS-Result: =?us-ascii?q?A0EzAADQRDJnhY0kQ7laHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAuFHogdX4gwRRGeBBSBaggHAQMBCAVAAgIEAQGCE4J0A?=
 =?us-ascii?q?oo7Ah4MBSsJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBA?=
 =?us-ascii?q?UBJhgiCYgGEAAEBAQMaCVYQCxgqAgJWBoMUAYJkBwGwZwKBMoEB3jOBXRCBS?=
 =?us-ascii?q?AGBV4QSglcLAYFaiQYnG4FJRIEVgyo+hA4BEgGDfDqCDSIEgkN8hCAliRWYW?=
 =?us-ascii?q?VKBFwNZMgFLChMXCwcFOHEiLAOCUX+BOYFRAYJVSkqDPIFeBTdJgkppTRADA?=
 =?us-ascii?q?wMDAxgCDQI2gg8VXh+CT4UdgQuDZINOgRmBcjEdQAMLbT01FBsGmxsISoEch?=
 =?us-ascii?q?hGBUwGBcMcwhCSBYwyDAIFsgzCXNE0TlzqTAJh3qSOBZzpscDMaLoMtTgMZD?=
 =?us-ascii?q?446yURDcAIHAQoBAQMJhWkTiTuBSwEB?=
IronPort-PHdr: A9a23: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
 XYL
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:AaFEya6VQUR120XlagPXwN/XdLJyesId70hD6qm+c203TiX4ra
 yTdZsgtCMc5Ax6ZJhko7C90de7LE80hKQb3WB5B97LNzUO+lHYSb2KhrGN/9SPIVydygck79
 YFT5RD
X-Talos-CUID: 9a23:8g3cIW1+UfzZ0vXB8f73mbxfF5B9TXf2kE3qAEaCGVxjSOKTGHqC9/Yx
X-Talos-MUID: 9a23:esA/twUO/CWy4BTq/DLcnhI8bcN02f3wOFFdjbgcndepHwUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="asc'?txt'?scan'208";a="193205552"
X-MGA-submission: =?us-ascii?q?MDGi3CdlXEjYrmWLNEFxSMQR1LVifzq2dYSJHD?=
 =?us-ascii?q?81vgchdxpnNQjerMFWAERdOGIWrfod1AuiuQn1CKuV/lr+tvf6Xji8Dc?=
 =?us-ascii?q?oNlxQTBXc8/XSXdzRKxnix/fhgWTvHwP/8+WvREIEuhhQIpUAUQJyiTl?=
 =?us-ascii?q?Zgf7+TRNq9ccHwoTpRfLf8tQ=3D=3D?=
Received: from mout01.posteo.de ([185.67.36.141])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 18:59:42 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 1065A240029
	for <cocci@inria.fr>; Mon, 11 Nov 2024 18:59:41 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4XnHPT2JMDz6txW;
	Mon, 11 Nov 2024 18:59:41 +0100 (CET)
Date: Mon, 11 Nov 2024 17:59:40 +0000
From: Michele Martone <michelemartone@users.sourceforge.net>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Message-ID: <20241111175940.GC32356@localhost>
References: <2406a49d-1609-4af1-9af9-ee3496e48606@web.de>
 <20241111162413.GD10291@localhost>
 <1ecbac88-9afe-42a4-bb46-de3abe59b500@web.de>
 <20241111171232.GE10291@localhost>
 <a03b096b-8815-430e-bceb-9e04248c1831@web.de>
 <20241111173137.GB32356@localhost>
 <3e4d1941-40c5-43f6-aba3-c400b0828ae7@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <3e4d1941-40c5-43f6-aba3-c400b0828ae7@web.de>
Subject: Re: [cocci] EBNF for Coccinelle file formats?
Reply-To: Michele Martone <michelemartone@users.sourceforge.net>
X-Loop: cocci@inria.fr
X-Sequence: 1993
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241111175940.GC32356%40localhost>


--gr/z0/N6AeWAPJVB
Content-Type: multipart/mixed; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20241111@18:36, Markus Elfring wrote:
> >>> If you
> >>>  grep '^[a-z_]*:'
> >>> through the *.mly files you get a few hundred non-terminals,
> >>> each with a handful of production rules.
> >>>
> >>> In a few words: LOTS of rules.
> >>
> >> Is such a software situation influenced because of the usage
> >> of the tools =E2=80=9Cocamlyacc=E2=80=9D?
> > No -- you'd have the same problem with any tool I'd say.
>=20
> Has EBNF the potential for more succinct grammar descriptions
> in comparison to ocamlyacc?
I think no.

How do you find the grammar description attached to this email?

--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="parser_c.txt"

   0  $accept : %entry% $end

   1  main : translation_unit EOF

   2  translation_unit :
   3                   | translation_unit external_declaration
   4                   | translation_unit Tnamespace TIdent TOBrace translation_unit TCBrace
   5                   | translation_unit Tnamespace TOBrace translation_unit TCBrace

   6  ident : TIdent
   7        | TypedefIdent

   8  identifier : TIdent

   9  identifier_cpp : TIdent
  10                 | ident_extra_cpp

  11  ident_cpp : TIdent
  12            | TypedefIdent
  13            | ident_extra_cpp

  14  ident_extra_cpp : TIdent TCppConcatOp identifier_cpp_list
  15                  | TCppConcatOp TIdent
  16                  | TMacroIdentBuilder TOPar param_define_list TCPar
  17                  | TQualId qual_id

  18  identifier_cpp_list : ident_or_kwd
  19                      | identifier_cpp_list TCppConcatOp ident_or_kwd

  20  qual_id : ident
  21          | TColonColon ident
  22          | qual_id TColonColon ident

  23  ident_or_kwd : TIdent
  24               | Talignas
  25               | Tasm
  26               | Tattribute
  27               | TattributeNoarg
  28               | Tauto
  29               | TautoType
  30               | Tbreak
  31               | Tcase
  32               | Tchar
  33               | Tclass
  34               | Tcomplex
  35               | Tconst
  36               | Tcontinue
  37               | Tcpp_struct
  38               | Tcpp_union
  39               | Tdecimal
  40               | Tdefault
  41               | Tdelete
  42               | Tdo
  43               | Ttry
  44               | Tdouble
  45               | Telse
  46               | Tenum
  47               | Texec
  48               | Textern
  49               | Tfinal
  50               | Tvirtual
  51               | Tfloat
  52               | Tfor
  53               | Tgoto
  54               | Tif
  55               | Tinline
  56               | Tint
  57               | Tlong
  58               | TMacroAttr
  59               | Tnamespace
  60               | Tnew
  61               | Toperator
  62               | Tprivate
  63               | Tprotected
  64               | Tptrdiff_t
  65               | Tpublic
  66               | Tregister
  67               | Trestrict
  68               | Treturn
  69               | Tshort
  70               | Tsigned
  71               | Tsizeof
  72               | Tsize_t
  73               | Tssize_t
  74               | Tstatic
  75               | Tstruct
  76               | Tswitch
  77               | Ttemplate
  78               | Ttypedef
  79               | Ttypename
  80               | Ttypeof
  81               | Tunion
  82               | Tunsigned
  83               | Tusing
  84               | Tvoid
  85               | Tvolatile
  86               | Twhile

  87  expr : assign_expr
  88       | expr TComma assign_expr

  89  assign_expr : cond_expr
  90              | unary_expr TAssign assign_expr
  91              | unary_expr TEq assign_expr
  92              | unary_expr TAssign tuple_expr
  93              | unary_expr TEq tuple_expr

  94  cond_expr : arith_expr
  95            | arith_expr TWhy gcc_opt_expr TDotDot cond_expr
  96            | Tnew cpp_type cpp_initialiser_opt
  97            | Tnew placement_params cpp_type cpp_initialiser_opt

  98  placement_params : TOPar argument_list_ne_without_paramdecl TCPar

  99  cpp_initialiser_opt : TOPar argument_list TCPar
 100                      | TOBrace argument_list TCBrace
 101                      |

 102  cpp_type : TOPar simple_type TCPar
 103           | cpp_type_noparen

 104  cpp_type_noparen : simple_type
 105                   | identifier_cpp

 106  arith_expr : cast_expr
 107             | arith_expr TMul arith_expr
 108             | arith_expr TDiv arith_expr
 109             | arith_expr TMin arith_expr
 110             | arith_expr TMax arith_expr
 111             | arith_expr TMod arith_expr
 112             | arith_expr TPlus arith_expr
 113             | arith_expr TMinus arith_expr
 114             | arith_expr TShl arith_expr
 115             | arith_expr TShr arith_expr
 116             | arith_expr TInf arith_expr
 117             | arith_expr TSup arith_expr
 118             | arith_expr TInfEq arith_expr
 119             | arith_expr TSupEq arith_expr
 120             | arith_expr TEqEq arith_expr
 121             | arith_expr TNotEq arith_expr
 122             | arith_expr TAnd arith_expr
 123             | arith_expr TOr arith_expr
 124             | arith_expr TXor arith_expr
 125             | arith_expr TAndLog arith_expr
 126             | arith_expr TOrLog arith_expr

 127  arith_expr_nosup : cast_expr
 128                   | arith_expr_nosup TMul arith_expr_nosup
 129                   | arith_expr_nosup TDiv arith_expr_nosup
 130                   | arith_expr_nosup TMin arith_expr_nosup
 131                   | arith_expr_nosup TMax arith_expr_nosup
 132                   | arith_expr_nosup TMod arith_expr_nosup
 133                   | arith_expr_nosup TPlus arith_expr_nosup
 134                   | arith_expr_nosup TMinus arith_expr_nosup
 135                   | arith_expr_nosup TShl arith_expr_nosup
 136                   | arith_expr_nosup TShr arith_expr_nosup
 137                   | arith_expr_nosup TInf arith_expr_nosup
 138                   | arith_expr_nosup TInfEq arith_expr_nosup
 139                   | arith_expr_nosup TSupEq arith_expr_nosup
 140                   | arith_expr_nosup TEqEq arith_expr_nosup
 141                   | arith_expr_nosup TNotEq arith_expr_nosup
 142                   | arith_expr_nosup TAnd arith_expr_nosup
 143                   | arith_expr_nosup TOr arith_expr_nosup
 144                   | arith_expr_nosup TXor arith_expr_nosup
 145                   | arith_expr_nosup TAndLog arith_expr_nosup
 146                   | arith_expr_nosup TOrLog arith_expr_nosup

 147  cast_expr : unary_expr
 148            | topar2 type_name tcpar2 cast_expr

 149  unary_expr : postfix_expr
 150             | TInc unary_expr
 151             | TDec unary_expr
 152             | unary_op cast_expr
 153             | Tsizeof unary_expr
 154             | Tsizeof topar2 type_name tcpar2
 155             | Tdelete cast_expr
 156             | Tdelete TOCro TCCro cast_expr
 157             | Tdefined identifier_cpp
 158             | Tdefined TOPar identifier_cpp TCPar

 159  unary_op : TAnd
 160           | TMul
 161           | TPlus
 162           | TMinus
 163           | TTilde
 164           | TBang
 165           | TAndLog

 166  postfix_expr : primary_expr
 167               | TQualExp qual_type
 168               | postfix_expr TOCro argument_list_ne TCCro
 169               | postfix_expr TOPar argument_list TCPar
 170               | postfix_expr TInf3 argument_list TSup3
 171               | postfix_expr TDot ident_cpp
 172               | postfix_expr TPtrOp ident_cpp
 173               | postfix_expr TInc
 174               | postfix_expr TDec
 175               | topar2 type_name tcpar2 TOBrace outer_initialize_list TCBrace

 176  primary_expr_without_ident : TInt
 177                             | TFloat
 178                             | TString
 179                             | TQuote string_fragments TQuote
 180                             | TChar
 181                             | TDecimal
 182                             | TOPar expr TCPar
 183                             | TMacroString
 184                             | string_elem string_list
 185                             | TOPar compound TCPar

 186  primary_expr : identifier_cpp
 187               | primary_expr_without_ident

 188  string_fragments :
 189                   | string_fragment string_fragments

 190  string_fragment : TPct string_format
 191                  | TSubString

 192  string_format : TFormat

 193  argument_ne : assign_expr
 194              | tuple_expr
 195              | parameter_decl_arg
 196              | action_higherordermacro_ne

 197  argument_ne_without_paramdecl : primary_expr_without_ident
 198                                | action_higherordermacro_ne

 199  argument : assign_expr
 200           | tuple_expr
 201           | parameter_decl_arg
 202           | action_higherordermacro

 203  action_higherordermacro_ne : taction_list_ne

 204  action_higherordermacro : taction_list

 205  const_expr : cond_expr

 206  topar2 : TOPar

 207  tcpar2 : TCPar

 208  statement : statement2

 209  statement2 : labeled
 210             | compound
 211             | expr_statement
 212             | selection
 213             | iteration
 214             | jump TPtVirg
 215             | Tasm TOPar asmbody TCPar TPtVirg
 216             | Tasm Tvolatile TOPar asmbody TCPar TPtVirg
 217             | TMacroStmt TOPar macro_argument_list TCPar
 218             | TMacroIdStmt
 219             | Texec identifier exec_list TPtVirg

 220  labeled : ident_cpp TDotDot sw_stat_or_decl
 221          | Tcase const_expr TDotDot sw_stat_or_decl
 222          | Tcase const_expr TEllipsis const_expr TDotDot sw_stat_or_decl
 223          | Tdefault TDotDot sw_stat_or_decl

 224  sw_stat_or_decl : decl
 225                  | statement

 226  end_labeled : ident_cpp TDotDot
 227              | Tcase const_expr TDotDot
 228              | Tdefault TDotDot

 229  compound : tobrace compound2 tcbrace

 230  compound2 :
 231            | stat_or_decl_list

 232  stat_or_decl_list : stat_or_decl
 233                    | end_labeled
 234                    | stat_or_decl stat_or_decl_list

 235  stat_or_decl : decl
 236               | statement
 237               | function_definition
 238               | cpp_directive
 239               | cpp_ifdef_directive

 240  expr_statement : TPtVirg
 241                 | expr TPtVirg

 242  handler : Tcatch TOPar parameter_decl TCPar compound

 243  handler_sequence : handler
 244                   | handler_sequence handler

 245  selection : Tif TOPar expr TCPar cpp_ifdef_statement
 246            | Tif TOPar expr TCPar cpp_ifdef_statement Telse cpp_ifdef_statement
 247            | Tswitch TOPar expr TCPar statement
 248            | TUifdef Tif TOPar expr TCPar statement Telse TUendif statement
 249            | TUifdef Tif TOPar expr TCPar statement Telse TUelseif statement TUendif statement
 250            | Ttry compound handler_sequence

 251  iteration : Twhile TOPar expr TCPar cpp_ifdef_statement
 252            | Twhile TOPar decl_spec init_declarator_list TCPar cpp_ifdef_statement
 253            | Tdo statement Twhile TOPar expr TCPar TPtVirg
 254            | Tfor TOPar expr_statement expr_statement TCPar cpp_ifdef_statement
 255            | Tfor TOPar expr_statement expr_statement expr TCPar cpp_ifdef_statement
 256            | Tfor TOPar decl expr_statement TCPar cpp_ifdef_statement
 257            | Tfor TOPar decl expr_statement expr TCPar cpp_ifdef_statement
 258            | Tfor TOPar decl_spec declaratorifn TDotDot initialize TCPar cpp_ifdef_statement
 259            | TMacroIterator TOPar argument_list TCPar cpp_ifdef_statement

 260  jump : Tgoto ident_cpp
 261       | Tcontinue
 262       | Tbreak
 263       | Treturn
 264       | Treturn expr
 265       | Treturn tuple_expr
 266       | Tgoto TMul expr

 267  tuple_expr : TOBrace outer_initialize_list TCBrace

 268  string_elem : TQuote string_fragments TQuote
 269              | TString
 270              | TMacroString

 271  asmbody : string_list colon_asm_list
 272          | string_list

 273  colon_asm : TDotDot colon_option_list

 274  colon_option : TString
 275               | TString TOPar asm_expr TCPar
 276               | TOCro identifier TCCro TString TOPar asm_expr TCPar
 277               | identifier
 278               |

 279  exec_list :
 280            | TDotDot identifier_cpp exec_ident exec_list
 281            | TIdent exec_ident2 exec_list
 282            | token exec_list

 283  exec_ident :
 284             | TDot TIdent exec_ident
 285             | TPtrOp TIdent exec_ident
 286             | TOCro argument_list_ne TCCro exec_ident

 287  exec_ident2 :
 288              | TDot TIdent exec_ident2

 289  asm_expr : assign_expr

 290  token : TPlus
 291        | TMinus
 292        | TMul
 293        | TDiv
 294        | TMod
 295        | TMin
 296        | TMax
 297        | TInc
 298        | TDec
 299        | TEq
 300        | TAssign
 301        | TEqEq
 302        | TNotEq
 303        | TSupEq
 304        | TInfEq
 305        | TSup
 306        | TInf
 307        | TAndLog
 308        | TOrLog
 309        | TShr
 310        | TShl
 311        | TAnd
 312        | TOr
 313        | TXor
 314        | TOBrace
 315        | TCBrace
 316        | TOPar
 317        | TCPar
 318        | TWhy
 319        | TBang
 320        | TComma
 321        | TypedefIdent
 322        | Tif
 323        | Telse
 324        | TInt
 325        | TFloat
 326        | TString
 327        | TChar

 328  simple_type : Tvoid
 329              | Tchar
 330              | Tint
 331              | Tfloat
 332              | Tdouble
 333              | Tcomplex
 334              | Tsize_t
 335              | Tssize_t
 336              | Tptrdiff_t
 337              | Tshort
 338              | Tlong
 339              | Tsigned
 340              | Tunsigned
 341              | Tdecimal TOPar const_expr TComma const_expr TCPar
 342              | Tdecimal TOPar const_expr TCPar
 343              | TautoType
 344              | Ttypeof TOPar assign_expr TCPar
 345              | Ttypeof TOPar type_name TCPar
 346              | TypedefIdent
 347              | TQualType qual_type

 348  qual_type : ident
 349            | qual_type TColonColon ident
 350            | TColonColon ident
 351            | qual_type TTemplateStart argument_list TTemplateEnd

 352  type_spec2_without_braces : simple_type
 353                            | enum_ident_independant

 354  type_spec2_with_braces : struct_or_union_spec
 355                         | enum_spec

 356  type_spec : type_spec2_without_braces
 357            | type_spec2_with_braces

 358  type_qualif : Tconst
 359              | Tvolatile
 360              | Trestrict

 361  attribute : attribute_gcc
 362            | attr_arg

 363  attr_arg : TMacroAttr
 364           | TMacroAttrArgs TOPar argument_list TCPar
 365           | TMacroAttrArgs TOPar argument_list TCParEOL

 366  attribute_gcc : Tattribute tdouble_opar_gcc_attr argument_list tdouble_cpar_gcc_attr
 367                | tdouble_ocro_cxx_attr argument_list tdouble_ccro_cxx_attr
 368                | tdouble_ocro_cxx_attr Tusing ident_cpp TDotDot argument_list tdouble_ccro_cxx_attr

 369  declarator : pointer direct_d
 370             | direct_d

 371  declarator_fn : pointer direct_d_fn
 372                | direct_d_fn

 373  pointer : tmul type_qualif_list
 374          | tmul type_qualif_list pointer

 375  tmul : TMul
 376       | TAnd
 377       | TAndLog

 378  direct_d : identifier_cpp
 379           | operator_c_plus_plus
 380           | TOPar declarator TCPar
 381           | direct_d tocro tccro
 382           | direct_d tocro const_expr tccro

 383  direct_d_fn : direct_d topar parameter_type_list tcpar

 384  operator_c_plus_plus : Toperator unary_op
 385                       | Toperator TInc
 386                       | Toperator TDec
 387                       | Toperator Tdelete
 388                       | Toperator Tnew
 389                       | Toperator TDiv
 390                       | Toperator TMin
 391                       | Toperator TMax
 392                       | Toperator TMod
 393                       | Toperator TShl
 394                       | Toperator TShr
 395                       | Toperator TInf
 396                       | Toperator TSup
 397                       | Toperator TInfEq
 398                       | Toperator TSupEq
 399                       | Toperator TEqEq
 400                       | Toperator TNotEq
 401                       | Toperator TOr
 402                       | Toperator TXor
 403                       | Toperator TOrLog
 404                       | Toperator TOCro TCCro
 405                       | Toperator TOPar TCPar
 406                       | Toperator TAssign
 407                       | Toperator TEq

 408  tocro : TOCro

 409  tccro : TCCro

 410  abstract_declarator : pointer
 411                      | direct_abstract_declarator
 412                      | pointer direct_abstract_declarator

 413  direct_abstract_declarator : TOPar abstract_declarator TCPar
 414                             | TOCro TCCro
 415                             | TOCro const_expr TCCro
 416                             | direct_abstract_declarator TOCro TCCro
 417                             | direct_abstract_declarator TOCro const_expr TCCro
 418                             | topar parameter_type_list tcpar
 419                             | direct_abstract_declarator topar parameter_type_list tcpar

 420  parameter_type_list :
 421                      | parameter_list
 422                      | parameter_list TComma TEllipsis

 423  parameter_decl2 : TKRParam
 424                  | decl_spec declaratorp
 425                  | decl_spec abstract_declaratorp
 426                  | decl_spec

 427  parameter_decl_arg : TKRParam
 428                     | decl_spec declaratorp
 429                     | decl_spec abstract_declaratorp
 430                     | decl_spec

 431  template_parameter_decl2 : Ttypename ident
 432                           | Ttypename ident TEq type_spec
 433                           | Tclass ident
 434                           | Tclass ident TEq type_spec
 435                           | type_spec2_without_braces declaratorp
 436                           | type_spec2_without_braces declaratorp TEq initialize_arg
 437                           | Tconst type_spec2_without_braces declaratorp
 438                           | Tconst type_spec2_without_braces declaratorp TEq initialize_arg
 439                           | Ttemplate TTemplateStart template_parameter_list_ne TTemplateEnd template_parameter_decl2

 440  parameter_decl : parameter_decl2

 441  template_parameter_decl : template_parameter_decl2

 442  declaratorp : declarator attributes_opt
 443              | declarator_fn attributes_opt

 444  abstract_declaratorp : abstract_declarator

 445  spec_qualif_list2 : type_spec
 446                    | type_qualif
 447                    | attribute
 448                    | type_spec spec_qualif_list
 449                    | type_qualif spec_qualif_list
 450                    | attribute spec_qualif_list

 451  spec_qualif_list : spec_qualif_list2

 452  type_qualif_list :
 453                   | type_qualif_list type_qualif
 454                   | type_qualif_list attribute

 455  type_name : spec_qualif_list
 456            | spec_qualif_list abstract_declaratort

 457  abstract_declaratort : abstract_declarator

 458  decl2 : decl_spec TPtVirg
 459        | decl_spec init_declarator_list TPtVirg
 460        | TMacroDecl TOPar macro_argument_list TCPar attributes_opt TPtVirg
 461        | TMacroDecl TOPar macro_argument_list TCPar attributes_opt teq initialize TPtVirg
 462        | decl_spec TMacroDecl TOPar macro_argument_list TCPar attributes_opt TPtVirg
 463        | decl_spec TMacroDecl TOPar macro_argument_list TCPar attributes_opt teq initialize TPtVirg

 464  decl_spec2 : storage_class_spec
 465             | type_spec
 466             | type_qualif
 467             | Tinline
 468             | align_class_prod
 469             | attribute
 470             | storage_class_spec decl_spec2
 471             | type_qualif decl_spec2
 472             | align_class_prod decl_spec2
 473             | Tinline decl_spec2
 474             | attribute decl_spec2
 475             | type_spec decl_spec2

 476  align_class_prod : Talignas TOPar argument TCPar

 477  storage_class_spec_nt : Tstatic
 478                        | Textern
 479                        | Tauto
 480                        | Tregister

 481  storage_class_spec : storage_class_spec_nt
 482                     | Ttypedef

 483  decl : decl2

 484  decl_spec : decl_spec2

 485  init_declarator2 : declaratorifn
 486                   | declaratorifn teq initialize
 487                   | declaratori topar_ini_cxx valinit tcpar_ini
 488                   | declaratori tobrace_ini valinit tcbrace_ini

 489  init_declarator_attrs2 : declaratorifn
 490                         | attributes declaratorifn
 491                         | declaratorifn teq initialize
 492                         | attributes declaratorifn teq initialize
 493                         | declaratori topar_ini_cxx valinit tcpar_ini
 494                         | attributes declaratori topar_ini_cxx valinit tcpar_ini
 495                         | declaratori tobrace_ini valinit tcbrace_ini
 496                         | attributes declaratori tobrace_ini valinit tcbrace_ini

 497  teq : TEq

 498  init_declarator : init_declarator2

 499  init_declarator_attrs : init_declarator_attrs2

 500  declaratori : declarator attributes_opt
 501              | declarator gcc_asm_decl

 502  declaratorifn : declarator attributes_opt
 503                | declarator gcc_asm_decl
 504                | declarator_fn attributes_opt
 505                | declarator_fn gcc_asm_decl

 506  gcc_asm_decl : Tasm TOPar asmbody TCPar
 507               | Tasm Tvolatile TOPar asmbody TCPar

 508  initialize : assign_expr
 509             | tobrace_ini outer_initialize_list tcbrace_ini

 510  initialize_arg : arith_expr_nosup
 511                 | tobrace_ini outer_initialize_list tcbrace_ini

 512  initialize_list : initialize2
 513                  | initialize_list TComma initialize2
 514                  | initialize_list TNoComma initialize2

 515  outer_initialize_list :
 516                        | initialize_list gcc_comma_opt_struct

 517  valinit : outer_initialize_list

 518  initialize2 : cond_expr
 519              | tobrace_ini outer_initialize_list tcbrace_ini
 520              | designator_list TEq initialize2
 521              | ident TDotDot initialize2

 522  designator : TDot ident
 523             | TOCro const_expr TCCro
 524             | TOCro const_expr TEllipsis const_expr TCCro

 525  gcc_comma_opt_struct : TComma
 526                       | TNoComma
 527                       |

 528  s_or_u_spec2 : cpp_struct_or_union ident optfinal TDotDot base_classes tobrace_struct cpp_struct_decl_list_gcc tcbrace_struct
 529               | cpp_struct_or_union ident optfinal tobrace_struct cpp_struct_decl_list_gcc tcbrace_struct
 530               | struct_or_union ident tobrace_struct struct_decl_list_gcc tcbrace_struct
 531               | cpp_struct_or_union TDotDot base_classes tobrace_struct cpp_struct_decl_list_gcc tcbrace_struct
 532               | cpp_struct_or_union tobrace_struct cpp_struct_decl_list_gcc tcbrace_struct
 533               | struct_or_union tobrace_struct struct_decl_list_gcc tcbrace_struct
 534               | struct_or_union ident
 535               | cpp_struct_or_union ident

 536  struct_or_union2 : Tstruct
 537                   | Tunion
 538                   | Tstruct attributes
 539                   | Tunion attributes

 540  cpp_struct_or_union2 : Tcpp_struct
 541                       | Tcpp_union
 542                       | Tclass
 543                       | Tcpp_struct attributes
 544                       | Tcpp_union attributes
 545                       | Tclass attributes

 546  struct_decl2 : field_declaration
 547               | TPtVirg
 548               | identifier TOPar macro_argument_list TCPar attributes_opt TPtVirg
 549               | TMacroDecl TOPar macro_argument_list TCPar attributes_opt TPtVirg
 550               | cpp_directive
 551               | cpp_ifdef_directive

 552  cpp_struct_decl2 : function_definition
 553                   | decl
 554                   | TPtVirg
 555                   | c_plus_plus_constructor_decl
 556                   | cpp_directive
 557                   | cpp_ifdef_directive
 558                   | Tpublic TDotDot
 559                   | Tprotected TDotDot
 560                   | Tprivate TDotDot

 561  c_plus_plus_constructor_decl : pre_member_function identifier TOPar parameter_type_list TCPar constr_inits post_constructor TPtVirg
 562                               | pre_member_function TTilde identifier TOPar parameter_type_list TCPar post_constructor TPtVirg
 563                               | pre_member_function identifier TOPar parameter_type_list TCPar constr_inits post_constructor compound
 564                               | pre_member_function TTilde identifier TOPar parameter_type_list TCPar post_constructor compound

 565  constr_inits : TDotDot constructor_init_list
 566               |

 567  constructor_init_list : constructor_init
 568                        | constructor_init_list TComma constructor_init

 569  constructor_init : ident_cpp TOPar argument_list TCPar
 570                   | ident_cpp TOBrace argument_list TCBrace

 571  pre_member_function : Tvirtual
 572                      |

 573  post_constructor : Tfinal
 574                   |

 575  optfinal : Tfinal
 576           |

 577  field_declaration : decl_spec struct_declarator_list TPtVirg
 578                    | decl_spec TPtVirg
 579                    | simple_type dotdot const_expr2 TPtVirg

 580  struct_declarator : declarator attributes_opt
 581                    | declarator dotdot const_expr2
 582                    | declarator_fn attributes_opt
 583                    | declarator_fn dotdot const_expr2

 584  struct_or_union_spec : s_or_u_spec2

 585  struct_or_union : struct_or_union2

 586  cpp_struct_or_union : cpp_struct_or_union2

 587  struct_decl : struct_decl2

 588  cpp_struct_decl : cpp_struct_decl2

 589  dotdot : TDotDot

 590  const_expr2 : const_expr

 591  struct_decl_list_gcc : struct_decl_list
 592                       |

 593  cpp_struct_decl_list_gcc : cpp_struct_decl_list
 594                           |

 595  enum_spec : enum_ident enum_base tobrace_enum enumerator_list gcc_comma_opt_struct tcbrace_enum

 596  enum_ident_independant : Tenum enum_key ident
 597                         | Tenum ident

 598  enum_ident_dependant : Tenum enum_key
 599                       | Tenum

 600  enum_ident : enum_ident_independant
 601             | enum_ident_dependant

 602  enum_base : TDotDot simple_type
 603            |

 604  enum_key : Tcpp_struct
 605           | Tclass

 606  enumerator : idente
 607             | idente TEq const_expr

 608  idente : ident_cpp

 609  function_definition : function_def

 610  cpp_directive_list : cpp_directive
 611                     | cpp_directive_list cpp_directive

 612  function_def : start_fun compound
 613               | start_fun cpp_directive_list compound

 614  start_fun : start_fun2

 615  start_fun2 : decl_spec declaratorfd
 616             | ctor_dtor

 617  ctor_dtor : Tconstructorname topar parameter_type_list tcpar
 618            | Tconstructorname topar parameter_type_list tcpar TDotDot constr_extra_list

 619  constr_extra : TIdent TOPar argument_list TCPar
 620               | TypedefIdent TOPar argument_list TCPar

 621  declaratorfd : declarator_fn attributes_opt

 622  cpp_directive : TIncludeStart TIncludeFilename
 623                | TDefine TIdentDefine define_val TDefEOL
 624                | TDefine TIdentDefine TOParDefine call_param_define_list TCPar define_val TDefEOL
 625                | TUndef TIdentDefine TDefEOL
 626                | TPragma TIdent pragma_strings TDefEOL
 627                | TCppDirectiveOther
 628                | Tusing TIdent TEq Ttypename cpp_type_noparen TPtVirg
 629                | Tusing TIdent TEq cpp_type_noparen TPtVirg
 630                | Tusing TypedefIdent TEq Ttypename cpp_type_noparen TPtVirg
 631                | Tusing TypedefIdent TEq cpp_type_noparen TPtVirg
 632                | Tusing identifier_cpp TPtVirg
 633                | Tusing Tnamespace identifier_cpp TPtVirg

 634  pragma_strings : TPragmaString

 635  define_val : expr
 636             | statement
 637             | decl
 638             | decl_spec
 639             | decl_spec abstract_declarator
 640             | stat_or_decl stat_or_decl_list
 641             | function_definition
 642             | TOBraceDefineInit outer_initialize_list TCBrace comma_opt
 643             | Tdo statement Twhile TOPar expr TCPar
 644             | Tasm TOPar asmbody TCPar
 645             | Tasm Tvolatile TOPar asmbody TCPar
 646             | designator_list TEq initialize2 gcc_comma_opt_struct
 647             | designator_list TEq initialize2 TComma initialize_list gcc_comma_opt_struct
 648             |

 649  param_define : TIdent
 650               | TypedefIdent
 651               | TEllipsis
 652               | TIdent TEllipsis
 653               | TypedefIdent TEllipsis
 654               | Tregister

 655  cpp_ifdef_statement : ifdef cpp_ifdef_statement cpp_ifdef_statement_tail
 656                      | statement

 657  cpp_ifdef_statement_tail : ifdefelse cpp_ifdef_statement endif
 658                           | ifdefelif cpp_ifdef_statement cpp_ifdef_statement_tail

 659  ifdef : TIfdef

 660  ifdefelse : TIfdefelse

 661  ifdefelif : TIfdefelif

 662  endif : TEndif

 663  cpp_ifdef_directive : ifdef
 664                      | ifdefelse
 665                      | ifdefelif
 666                      | endif
 667                      | TIfdefBool
 668                      | TIfdefMisc
 669                      | TIfdefVersion

 670  cpp_other : identifier TOPar macro_argument_list TCPar attributes_opt TPtVirg
 671            | identifier TOPar macro_argument_list TCPar compound
 672            | identifier TOPar macro_argument_list TCParEOL
 673            | identifier TPtVirg

 674  external_declaration : Ttemplate TTemplateStart template_parameter_list_ne TTemplateEnd external_declaration
 675                       | function_definition
 676                       | decl

 677  celem : Tnamespace ident TOBrace translation_unit TCBrace
 678        | Tnamespace TOBrace translation_unit TCBrace
 679        | external_declaration
 680        | cpp_directive
 681        | cpp_other
 682        | cpp_ifdef_directive
 683        | Tasm TOPar asmbody TCPar TPtVirg
 684        | TPtVirg
 685        | EOF

 686  base_class : base_class_name
 687             | Tpublic base_class_name
 688             | Tprotected base_class_name
 689             | Tprivate base_class_name

 690  base_class_name : ident_cpp

 691  base_classes : base_class
 692               | base_classes TComma base_class

 693  tobrace : TOBrace

 694  tcbrace : TCBrace

 695  tobrace_enum : TOBrace

 696  tcbrace_enum : TCBrace

 697  tobrace_ini : TOBrace

 698  tcbrace_ini : TCBrace

 699  topar_ini_cxx : TOParCplusplusInit

 700  tcpar_ini : TCPar

 701  tobrace_struct : TOBrace

 702  tcbrace_struct : TCBrace

 703  call_param_define_list : param_define_list

 704  topar : TOPar

 705  tcpar : TCPar

 706  tdouble_opar_gcc_attr : TOPar TOPar

 707  tdouble_cpar_gcc_attr : TCPar TCPar

 708  tdouble_ocro_cxx_attr : TOCroCro

 709  tdouble_ccro_cxx_attr : TCCro TCCro

 710  string_list : string_elem
 711              | string_list string_elem

 712  colon_asm_list : colon_asm
 713                 | colon_asm_list colon_asm

 714  colon_option_list : colon_option
 715                    | colon_option_list TComma colon_option

 716  constr_extra_list : constr_extra
 717                    | constr_extra_list TComma constr_extra

 718  argument_list :
 719                | argument_list_ne

 720  argument_list_ne : argument_ne
 721                   | argument_list_ne TComma argument

 722  argument_list_ne_without_paramdecl : argument_ne_without_paramdecl
 723                                     | argument_list_ne TComma argument_ne_without_paramdecl

 724  macro_argument_list : argument
 725                      | macro_argument_list TComma argument

 726  struct_decl_list : struct_decl
 727                   | struct_decl_list struct_decl

 728  cpp_struct_decl_list : cpp_struct_decl
 729                       | cpp_struct_decl_list cpp_struct_decl

 730  struct_declarator_list : struct_declarator
 731                         | struct_declarator_list TComma cpp_directive_list struct_declarator
 732                         | struct_declarator_list TComma struct_declarator

 733  enumerator_list : enumerator
 734                  | enumerator_list TComma cpp_directive_list enumerator
 735                  | enumerator_list TComma enumerator
 736                  |

 737  init_declarator_list : init_declarator
 738                       | init_declarator_list TComma cpp_directive_list init_declarator_attrs
 739                       | init_declarator_list TComma init_declarator_attrs

 740  parameter_list : parameter_decl
 741                 | parameter_list TComma parameter_decl

 742  template_parameter_list_ne : template_parameter_decl
 743                             | template_parameter_list_ne TComma template_parameter_decl

 744  taction_list_ne : TAction
 745                  | TAction taction_list_ne

 746  taction_list :
 747               | TAction taction_list

 748  param_define_list :
 749                    | param_define
 750                    | param_define_list TComma param_define

 751  designator_list : designator
 752                  | designator_list designator

 753  attribute_list : attribute
 754                 | attribute_list attribute

 755  attributes : attribute_list

 756  attributes_opt : attribute_list
 757                 |

 758  comma_opt : TComma
 759            |

 760  gcc_opt_expr : expr
 761               |

 762  %entry% : '\001' main
 763          | '\002' celem
 764          | '\003' statement
 765          | '\004' expr
 766          | '\005' type_name
 767          | '\006' cpp_directive
 768          | '\007' iteration



--IrhDeMKUP4DT/M7F--

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQdu1Va6jWbiq8Ma4jg5mnI7xJYuAUCZzJGCAAKCRDg5mnI7xJY
uMFyAJ9CXpKS8eorLqP8LXX4auBABF838ACfXRSJM3GamGC22h7pPLtLqTVn75s=
=MtKw
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
