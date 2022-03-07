Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7099CC433EF
	for <cocci@archiver.kernel.org>; Mon,  7 Mar 2022 20:45:55 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="24872345"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2022 21:45:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ABDA4E00D3; Mon,  7 Mar 2022 21:45:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B4006E004B
	for <cocci@sympa.inria.fr>; Mon,  7 Mar 2022 21:45:49 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="7863582"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 21:45:50 +0100
Date: Mon, 7 Mar 2022 21:45:49 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <2018915-898b-778-b5e-c8683697ed40@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203072145310.3091@hadrien>
References: <df8a810-dcb1-4bf2-178d-178943e6e458@ewheeler.net> <caa0adde-7dd-e571-fa2-ee2a650b328@ewheeler.net> <alpine.DEB.2.22.394.2203070900200.3091@hadrien> <2018915-898b-778-b5e-c8683697ed40@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v3] Fix support for "complex double" in
 parameter lists
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 180
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203072145310.3091%40hadrien>



On Mon, 7 Mar 2022, Eric Wheeler wrote:

> From: Eric Wheeler <cocci@linux.ewheeler.net>
> Author: Eric Wheeler <cocci@linux.ewheeler.net>
> Date:   Sun Mar 6 16:55:32 2022 -0800
>
>     Fix support for complex double in parameter lists

Applied, thanks.

julia

>
>     It seems that `parameter list` does _not_ support `complex double`,
>     but it _does_ support `double complex`.  Coccinelle already supports
>     `double complex` and `float complex` so this commit adds grammar support
>     for the reverse of `complex double` and `complex float`.
>
>     With this SmPL:
>
>             @ rule1 @
>             type T;
>             identifier F, j;
>             typedef nec_t;
>             parameter list PL;
>             @@
>
>             T F(
>             +nec_t *nec,
>             PL
>              )
>             {
>             ... when exists
>                     when any
>             nec->j
>             ... when exists
>                     when any
>             }
>
>     This works:
>
>             void qdsrc( int is, double complex v, double complex *e )
>             {
>               is--;
>               i= nec->data.icon1[is];
>             }
>
>     but this did not:
>
>             void qdsrc( int is, complex double v, complex double *e )
>             {
>               is--;
>               i= nec->data.icon1[is];
>             }
>
>     Patch v2: Fixed: strange type2, maybe because of weird order: complex double
>     when patching this example function:
>     	static void Near_Field_Total( complex double ex, complex double ey, complex double ez, int nfeh, int idx )
>     	{
>     		nec->x++;
>     		return;
>     	}
>
>     Patch v3: Added signed-off-by.
>
>     Signed-off-by: Eric Wheeler <cocci@linux.ewheeler.net>
>
> diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
> index 019ee3b..8c1fe8e 100644
> --- a/engine/cocci_vs_c.ml
> +++ b/engine/cocci_vs_c.ml
> @@ -408,7 +408,9 @@ let split_signb_baseb_ii (baseb, ii) =
>    | B.FloatType (B.CFloat),["float",i1] -> None, [i1]
>    | B.FloatType (B.CDouble),["double",i1] -> None, [i1]
>    | B.FloatType (B.CFloatComplex),["float",i1;"complex",i2] -> None, [i1;i2]
> +  | B.FloatType (B.CFloatComplex),["complex",i1;"float",i2] -> None, [i1;i2]
>    | B.FloatType (B.CDoubleComplex),["double",i1;"complex",i2] -> None, [i1;i2]
> +  | B.FloatType (B.CDoubleComplex),["complex",i1;"double",i2] -> None, [i1;i2]
>    | B.FloatType (B.CLongDouble),["long",i1;"double",i2] -> None,[i1;i2]
>    | B.FloatType (B.CLongDoubleComplex),["long",i1;"double",i2;"complex",i3] ->
>        None,[i1;i2;i3]
> diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
> index 949c0bf..22fe5e7 100644
> --- a/parsing_c/parser_c.mly
> +++ b/parsing_c/parser_c.mly
> @@ -1270,7 +1270,9 @@ type_spec2:
>   | Tfloat               { Right3 (BaseType (FloatType CFloat)),  [$1]}
>   | Tdouble              { Right3 (BaseType (FloatType CDouble)), [$1] }
>   | Tfloat Tcomplex      { Right3 (BaseType (FloatType CFloatComplex)),  [$1;$2]}
> + | Tcomplex Tfloat      { Right3 (BaseType (FloatType CFloatComplex)),  [$1;$2]}
>   | Tdouble Tcomplex     { Right3 (BaseType (FloatType CDoubleComplex)), [$1;$2] }
> + | Tcomplex Tdouble     { Right3 (BaseType (FloatType CDoubleComplex)), [$1;$2] }
>   | Tsize_t              { Right3 (BaseType SizeType),            [$1] }
>   | Tssize_t             { Right3 (BaseType SSizeType),           [$1] }
>   | Tptrdiff_t           { Right3 (BaseType PtrDiffType),         [$1] }
>
>
