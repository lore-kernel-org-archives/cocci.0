Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B19C6FD19
	for <cocci@archiver.kernel.org>; Thu,  9 Mar 2023 08:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UBVNOyh2ACAOiyyKpbMGTlBgFQvlXTfGOo/jd7oOKE4=;
  b=dSZcKIs//V8SaruyG9q2ZDnNwFQcfuK96QaCWhjUvbLVdEyi1Y5RYErK
   I3IyNdGqe8FB4j2XqG7YbIVx1VLpwnRQ10OAR6xSG+PJn3t+1TEZs/CfI
   Z+DCt0RGZbecsUjYRRZY1jxEaLE1Fn1jJ+5KSFAfsQCZOc2HIwQOIGeH3
   4=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.98,245,1673910000"; 
   d="txt'?scan'208";a="96219753"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2023 09:31:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E0908E01A9; Thu,  9 Mar 2023 09:31:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E2BB3E00BE
	for <cocci@sympa.inria.fr>; Thu,  9 Mar 2023 09:28:58 +0100 (CET)
IronPort-SDR: 640998c8_Oe5Zkg5q0Qg9J0ab9Txtjkp3AxXugsh2RdPG3HzSmneSn/I
 fyWrgxC7/EjPnLHhqVWqDRQXjWMWzPufJdXFzBg==
X-IPAS-Result: =?us-ascii?q?A0HsAgB4lwlkfzTQVdFaHQEBAQEJARIBBQUBgXwHAQsBg?=
 =?us-ascii?q?i11Vi8EUYRTg0+FL4YBMycBAQEGgUKNboQpizqBQD4IBwEDAQsBATkJAgQBA?=
 =?us-ascii?q?QMBAzcBBoRAhTQCHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQEAQECEAEBGQkZBw4OBSSFaA2CNyJ9TQMDNAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBBAINUh85AQEgFhEEGQEbHQEDEkcCJREBB?=
 =?us-ascii?q?QE1IoJdgicBAzEDBAwGpX6BBEKLMn8WBQIWgQGCCQaBB5sEChkoDWuBVAcCB?=
 =?us-ascii?q?wkBCBWBGQGENyOCaIhzeieBAxWBEIEVg2iCYgOBPQEBg3iCZwSBBYEhjF0lh?=
 =?us-ascii?q?24BAwICAwICAwYEAgICBQQCAQMEAg4EDgMBAQICAQECBAgCAgMDAggPEwMHA?=
 =?us-ascii?q?gEGBQEDAQIGBAIEAQsCBQIKAQIEAQICAgEFCQEDAQMBCwICBwIDBQYEAgMNA?=
 =?us-ascii?q?gEBAwICAg0DAgMCBAEFBQEBEAIGBAcBBgMLAgQBBAMBAgUHAwcDAgICAggEE?=
 =?us-ascii?q?gIDAgIEBQICAgECBAUCBwYCAQICAgQCAQMCBAICBAICBAMbAgMFAw4CAgICA?=
 =?us-ascii?q?QkLAgMHBAIDAwEHAgIMAQMYAwICAgICAgEDBwoECQQCBQECAQQLAQUBDQQCA?=
 =?us-ascii?q?gICAgMCAQEDBggGAwoCBQQDAwYJDw8IBQMBBAMCAwIBCAsCAwICBAgCAwECA?=
 =?us-ascii?q?gEGAgMBAgIBAgIBCwEBAgMFAgIRAQICAgICAQECAwIDAQcBAgIYBgQFAwMFA?=
 =?us-ascii?q?gIBBAECAgQEBQsCBAMBAQECAgICAwILAwUDAQYDAwoHBAEIAgYDBAIFBAMEB?=
 =?us-ascii?q?AYCAgICAgEEAQYLAwIEBAMDBgMJAgIMAhQCEgYBBAsLBAECAgIOAwQGAgMDA?=
 =?us-ascii?q?gIFCgQCAgICAgMGAgkEAgIDAwICAwMHAwECAgIFAQQFBgMCBAIBAwIEAgIEA?=
 =?us-ascii?q?wQBBwICAgICAwECAgMDAQIBBgMCAgIFAgIBCAIDAgICAgMDDwEBAQIKAgMBA?=
 =?us-ascii?q?QEFBAICCAIGAQICAgQEAQICAgICAgIMAwICAgMCAgYDAgIDOAMDAiADRB0CC?=
 =?us-ascii?q?QMjBQoDCwkIExcoBgwHNAQ0ARQHAQ0HBwYqDgYCBgMEAQoLBQQFCAECAQEGA?=
 =?us-ascii?q?gQCBwkMAgEGAQUCAgMCAQUCAQYDAQICAgIFBgUDBAUDEwMBAQQDAgECAQIDA?=
 =?us-ascii?q?gMHAwIEAgMBAgMEBgYBCQQGBQ0DBAICAQIBAQMEBAQCAgECAgMBBAICAQEDA?=
 =?us-ascii?q?wMCAgIDBAIDAwsECgcDAwIBBQsEAgMCAQEDBwkEAgIGAQIEAgICAgICAwEBA?=
 =?us-ascii?q?wkEAgEDAgIEAwYCAQIBCQUCAQkDAQIBAwQBAwkBAgIECQIDBwUKAgICAggCA?=
 =?us-ascii?q?g4DAwIBAQQCAgQFCQECBwIFAQEDBQcCAgECAgEEAwEJBAECAwIBAQMSAwMBB?=
 =?us-ascii?q?AIFAwMNCQYCAgEDAgENAwECAQIDAQUFFwMIBxQDBQICBAQBBwICAwMDAgECC?=
 =?us-ascii?q?QYBAwEFAg4DAgIEBgECAQECAw8FAQEBARcBAwQCAwEEAwEBAgECAw8EAQQFC?=
 =?us-ascii?q?wMcAgQBCAgCAgMDAQIDBQECAwQCAQgKAgICAgkCCgMCAwEDBQEDAgkDAQUBA?=
 =?us-ascii?q?gcCBgEBAQICCAIIAgMLAQMFBgIBAgIBBQIBAgIFAwUCAgICBA0CBQICAgUBA?=
 =?us-ascii?q?gcEAgICAwECAgYFAQIHBwIFAgICAwMKBAQHBAECAgEBBQECAQMDAQIEAQIBA?=
 =?us-ascii?q?gUDBgICAgIBAgIBAQEIAgICAgICAwQCCJhqgWcdCD5EPhMIDBYCWCMKFoEEl?=
 =?us-ascii?q?iaNAg6gPAeDfYQBgjWFMZR7TBOWdJI1AZdii2OYSINDAgoHBhAjEoEvAjaBX?=
 =?us-ascii?q?DMaI4M3CUYDGQ+OIINAMo96QDQCAQE3AgcBCgEBAwmFQyYTCwGFOwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:SXHIN6xS+I+uJWM9m4CTKrPwF71zdoMgy1knxilNoNJuA6ilfq
 GV7YwmPHrP4gr5N0tQ+uxoVJPwI080lqQFmLX5X43SOjUO0VHAROoD0WKL+Vzd8kbFh4lgPM
 lbAs1D4R7LYWSST/yW3OB1KbkdKRC8npyVuQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,245,1673910000"; 
   d="txt'?scan'208";a="96218812"
X-MGA-submission: =?us-ascii?q?MDEjyF3A45HWZjSZLckOyCcq7bSDSfjhy5sJIn?=
 =?us-ascii?q?2T9lvNoRipP9ua88rjhzgFZDlnsDzEc3ipYAcXFA+GgRnV7XZgEgc45w?=
 =?us-ascii?q?e2CbSuUwZIe80DuNrhmXWIx+zKcwh4sYctASN3nj3iowHXXqOXfGxUuB?=
 =?us-ascii?q?IKN54A3+JVNp4GIp9KutiKTg=3D=3D?=
Received: from mail-ed1-f52.google.com ([209.85.208.52])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 09:28:57 +0100
Received: by mail-ed1-f52.google.com with SMTP id cw28so3834400edb.5
        for <cocci@inria.fr>; Thu, 09 Mar 2023 00:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678350537;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UBVNOyh2ACAOiyyKpbMGTlBgFQvlXTfGOo/jd7oOKE4=;
        b=YeXCO5UluX/l1BE0jMLq6iW1nnrdPYFPGJXkdJfPtZGzuDnOj8CNGNjVJrvXSXygHO
         g39DAhiUIk6RqcnDt7coWvsOyC1JnsjvFf3kHOvdTGSnZUWCkqocGkGIKA2A+9Ho2LP0
         ViYb7x+q5BjP+UrtiGbXsUSMjPdAyCsSGR1Rc1dvVL8qu2x+dJ/ElAQDUiL5hgFFpw9T
         8n8VEqBEV/z5tTWaLary9+9mxhK0cX2FGEa7gKh5zmLqoa3DMe5kAqC0yv395/CG+tm5
         PDc+oCorEfeX5XjRDvFGc30bzeChtibeH89FiuZgLYRoqsigWMLIVIvdIqW1K63v5PJA
         z63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678350537;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBVNOyh2ACAOiyyKpbMGTlBgFQvlXTfGOo/jd7oOKE4=;
        b=Y0DSS/gjd05+cQll+qIt8nMOLaqEoZAZM8sDKjXfnNTd+RsfEiXI0UyrrJwJQIrZD8
         W0w4bRdwdmjNakK66IHDZF/IJ/dLmhzc0Dimdtp9MQEVtBohe/EE0cimdkNKaWvEFGzj
         TyaDaj2DJ95MARuvWWyYhwvJQ3gDMLdDjjijcGqzM9h1/QkwpskcZ9KXPi6LIluUNpyC
         zdwg4z69k9jtWZ8jVtIbt6NJl4GqKA/JoKzGj2Rrq+Q0mTYg4qxPXLSMrC62V7mmrHvu
         1UkkDqJR1V5qNn8SAuZ5I54wpBZjgPrB3F/6q0i1aChI/y28FZlNeVUP2x7bMXOyJBxg
         TFWg==
X-Gm-Message-State: AO0yUKU3/lZoHbuwC7cuCmcI7IwzH1jk/BcNA7a6rttcJVRPBHr9wyoz
	mKcU2+0oDpHy6VFQSe69i0U=
X-Google-Smtp-Source: AK7set/BVOO+WCGL9Q4X4mhu531HaNHp3/+KfnYpA8v51XhrEjjLwiYYZ5y94PSkHL8RXYKiDafc1A==
X-Received: by 2002:a05:6402:1608:b0:4c6:9132:65 with SMTP id f8-20020a056402160800b004c691320065mr18888148edv.20.1678350537294;
        Thu, 09 Mar 2023 00:28:57 -0800 (PST)
Received: from nbbrfq (80-110-214-113.static.upcbusiness.at. [80.110.214.113])
        by smtp.gmail.com with ESMTPSA id k2-20020a50ce42000000b004bc59951d6fsm9259204edj.57.2023.03.09.00.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:28:57 -0800 (PST)
Date: Thu, 9 Mar 2023 09:28:12 +0100
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: cocci@inria.fr
Cc: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Message-ID: <20230309092812.71b25d5c@nbbrfq>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/sUXn.Qn_nLkY0jdL1HdrSwT"
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] HELP: multiple inserts at one position
Reply-To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 880
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/20230309092812.71b25d5c%40nbbrfq>

--MP_/sUXn.Qn_nLkY0jdL1HdrSwT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!

I'm trying to follow Julias advise in
https://www.mail-archive.com/cocci@systeme.lip6.fr/msg06465.html
---8<---
> >   Unfortunately, I stumble on the error message =E2=80=9Creplacement: a=
lready=20
> > tagged token:
> >   C code context=E2=80=9D then.

This is what I would expect.  You could use one rule with an exists to put
a position variable in the place where you want to put a kfree, and then
use another rule to put a kfree at that position.
---8<---

I'm attaching my sample inp.c and my attempt at the script and would be
glad if you could give some guidance how to properly phrase the
replacement rule.

In effect, i want to insert *multiple* hunks, each hunk before the
respective single return statement.

TIA for your help or any pointers and cheers,

PS:
In case it matters, i'm using the debian package which is
  spatch version 1.1.1 compiled with OCaml version 4.13.1

The two attached scripts are identical, just
  sed -i -e s/mpz/mpfr/g
If i patch the mpfr part of inp.c, then all works like i would
envision, since there is just a single replacement to be done:

$ spatch --sp-file ~/mpfr_free.0.cocci /tmp/inp.cc;echo EOF
init_defs_builtins: /usr/lib/coccinelle/standard.h
HANDLING: /tmp/inp.cc
diff =3D=20
--- /tmp/inp.cc
+++ /tmp/cocci-output-1395250-146bec-inp.cc
@@ -34,9 +34,11 @@ CompileExpr::compile_float_literal (cons
       rust_error_at (expr.get_locus (),
 		     "decimal overflows the respective type %<%s%>",
 		     tyty->get_name ().c_str ());
+      mpfr_clear(fval);
       return error_mark_node;
     }
=20
+  mpfr_clear(fval);
   return real_value;
 }
=20
EOF

But when attempting to insert multiple "free()" for a handful of
identifiers in the mpz case, then:
$ spatch --sp-file ~/mpz_free.0.cocci /tmp/inp.cc ; echo EOF
init_defs_builtins: /usr/lib/coccinelle/standard.h
HANDLING: /tmp/inp.cc
    =20
previous modification:

  <<< mpz_clear(i);
CONTEXT

According to environment 4:
   mpz_0_find.i -> id ival

   mpz_0_find.ret_pos -> poss[(/tmp/inp.cc,CompileExpr::compile_integer_lit=
eral,((44,0),(80,1)),(71,6),(71,12))]

   mpz_0_find.i -> id ival

   mpz_0_find.ret_pos -> poss[(/tmp/inp.cc,CompileExpr::compile_integer_lit=
eral,((44,0),(80,1)),(71,6),(71,12))]


current modification:

  <<< mpz_clear(i);
CONTEXT

According to environment 4:
   mpz_0_find.i -> id type_max

   mpz_0_find.ret_pos -> poss[(/tmp/inp.cc,CompileExpr::compile_integer_lit=
eral,((44,0),(80,1)),(71,6),(71,12))]

   mpz_0_find.i -> id type_max

   mpz_0_find.ret_pos -> poss[(/tmp/inp.cc,CompileExpr::compile_integer_lit=
eral,((44,0),(80,1)),(71,6),(71,12))]


mpz_0_replace: already tagged token:
C code context
File "/tmp/inp.cc", line 71, column 6, charpos =3D 1993
  around =3D 'return',
  whole content =3D       return error_mark_node;
EOF

Isn't this OK nevertheless?

--MP_/sUXn.Qn_nLkY0jdL1HdrSwT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=inp.cc.txt

tree
CompileExpr::compile_float_literal (const HIR::LiteralExpr &expr,
				    const TyTy::BaseType *tyty)
{
  rust_assert (expr.get_lit_type () == HIR::Literal::FLOAT);
  const auto literal_value = expr.get_literal ();

  mpfr_t fval;
  if (mpfr_init_set_str (fval, literal_value.as_string ().c_str (), 10,
			 MPFR_RNDN)
      != 0)
    {
      rust_error_at (expr.get_locus (), "bad number in literal");
      mpfr_clears(expr, fval, NULL);
      mpfr_clear(fval);
      return error_mark_node;
    }

  tree type = TyTyResolveCompile::compile (ctx, tyty);

  // taken from:
  // see go/gofrontend/expressions.cc:check_float_type
  mpfr_exp_t exp = mpfr_get_exp (fval);
  bool real_value_overflow = exp > TYPE_PRECISION (type);

  REAL_VALUE_TYPE r1;
  real_from_mpfr (&r1, fval, type, GMP_RNDN);
  REAL_VALUE_TYPE r2;
  real_convert (&r2, TYPE_MODE (type), &r1);

  tree real_value = build_real (type, r2);
  if (TREE_OVERFLOW (real_value) || real_value_overflow)
    {
      rust_error_at (expr.get_locus (),
		     "decimal overflows the respective type %<%s%>",
		     tyty->get_name ().c_str ());
      return error_mark_node;
    }

  return real_value;
}


tree
CompileExpr::compile_integer_literal (const HIR::LiteralExpr &expr,
				      const TyTy::BaseType *tyty)
{
  rust_assert (expr.get_lit_type () == HIR::Literal::INT);
  const auto literal_value = expr.get_literal ();

  tree type = TyTyResolveCompile::compile (ctx, tyty);

  mpz_t ival;
  if (mpz_init_set_str (ival, literal_value.as_string ().c_str (), 10) != 0)
    {
      rust_error_at (expr.get_locus (), "bad number in literal");
      return error_mark_node;
    }

  mpz_t type_min;
  mpz_t type_max;
  mpz_init (type_min);
  mpz_init (type_max);
  get_type_static_bounds (type, type_min, type_max);

  if (mpz_cmp (ival, type_min) < 0 || mpz_cmp (ival, type_max) > 0)
    {
      rust_error_at (expr.get_locus (),
		     "integer overflows the respective type %<%s%>",
		     tyty->get_name ().c_str ());
      return error_mark_node;
    }

  tree result = wide_int_to_tree (type, wi::from_mpz (type, ival, true));

  mpz_clear (type_min);
  mpz_clear (type_max);

  return result;
}

--MP_/sUXn.Qn_nLkY0jdL1HdrSwT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=mpfr_free.0.cocci.txt

/// mpfr ///////////////////////////////////////////////////////////////

@ mpfr_0_find exists@
identifier i;
type mpfr_t;
position ret_pos;
@@
mpfr_t i;
...
(
mpfr_init_set_str (i, ...)
|
mpfr_init (i)
|
mpfr_init2 (i, ...)
|
mpfr_init3 (i, ...)
)
... when != mpfr_clear (i)
    when != mpfr_clears (...,i,...)
(
  return \(<+...i...+>\);
|
//Ideally i would prefer to just have this single rule and just do:
//+ mpfr_clear (i);
return@ret_pos ...;
)

@ mpfr_0_replace @
identifier mpfr_0_find.i;
//expression E;
position mpfr_0_find.ret_pos;
@@
+ mpfr_clear (i);
? return@ret_pos ...;

--MP_/sUXn.Qn_nLkY0jdL1HdrSwT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=mpz_free.0.cocci.txt

/// mpz ///////////////////////////////////////////////////////////////

@ mpz_0_find exists@
identifier i;
type mpz_t;
position ret_pos;
@@
mpz_t i;
...
(
mpz_init_set_str (i, ...)
|
mpz_init (i)
|
mpz_init2 (i, ...)
|
mpz_init3 (i, ...)
)
... when != mpz_clear (i)
    when != mpz_clears (...,i,...)
(
  return \(<+...i...+>\);
|
//Ideally i would prefer to just have this single rule and just do:
//+ mpz_clear (i);
return@ret_pos ...;
)

@ mpz_0_replace @
identifier mpz_0_find.i;
//expression E;
position mpz_0_find.ret_pos;
@@
+ mpz_clear (i);
? return@ret_pos ...;

--MP_/sUXn.Qn_nLkY0jdL1HdrSwT--
