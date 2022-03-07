Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3B9C433EF
	for <cocci@archiver.kernel.org>; Mon,  7 Mar 2022 01:57:30 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,160,1643670000"; 
   d="scan'208";a="24664459"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2022 02:57:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EF841E00D9; Mon,  7 Mar 2022 02:57:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 87981E004B
	for <cocci@sympa.inria.fr>; Mon,  7 Mar 2022 02:57:27 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: zvaOBPgE6NkW2uCHXo+QlR6OV5p9r4M4KktVCLXk4f9LT2xtRsH/47oMVInS9xzCJYChwVEOtp
 d1Hxmx7E2Xrarb7/qww+pqj2Y1OMzfdOXdz+nKjqXQW3AY7R+CJ6bb+HvhhnQWklb8NFYUz63l
 00XtqASEHkJ0QMBy0nwSYpfQS0r6wjOGF9zcfX9lYrKwcwLyu/xrpC6kCaytLNVNrIOHrZqJvP
 IgBsQESYl69zwmmxOIWHYD7Zr+5d0rG7yKZNLlUkkOc0Je/NGbY+EOHokeEraF8GGZd+Kyruca
 e2A/1QT8WC0r3l3ancA8eeNR
X-IPAS-Result: =?us-ascii?q?A0CRBgAiZSVi/0Xcza1agQmEAgeBTQEBASkEC0STR4Ion?=
 =?us-ascii?q?lsLAQMBDUEEAQGFBwKEGwIdBgY0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgMEAYEILAFjAWcBgU4BgXkGBD2CNSKDbAYnE08fATFXGYMEgxesRYEBM?=
 =?us-ascii?q?oEBiXuBPI5IJxxAgU2CUYc+hTIElyGCfKJJnhKDU59wLpZEkWaWVaZ5gT85J?=
 =?us-ascii?q?YFZHxQaCCYKO4JpTgECAQIBDAECAgECAQIBAgEIAQECAY4oFo5PIAEBATE4A?=
 =?us-ascii?q?gYLAQEDCZF/AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:kuDtEq9F7wo9LDXfBb+CDrUDn3iTJUtcMsCJ2f8bNWPcYEJGY0x3y
 jEbDz3Sbq3cYWv9c9Anbo/k8RkE7cXUxoBiSFE4qilEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvylYAL9EngZqTVMEU/Nsjo+3b9h6mJUqYLhWVnV4
 ous+5e31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Zy
 MQXhYWxCiwSfe7sgrgHQSNzLSJRBPgTkFPHCSDXXc27yl2AfmTszvhqAVtwO4AEkgp1KTgRr
 rpCcG1LNErbwbznqF64YrEEasALJ87gN4I3vnB70SqfAOkmTJ3HTr+M49JEtNs1rpoSQ6iCO
 5dGAdZpRBr+XEJzZglGMYs/nsr13njmIxdSpF3A8MLb5ECIkFIqgee9WDbPQfSBQs5en26Dt
 2fe9iL4BAsbPZqR01K4HmmEg/+JkDz7VY8WGaf+8PN26LGO+oANIB0HD2uioLqSsQ39e8gDM
 V4u0RQtgpFnoSRHUeLBdxG/pXeFuDsVVNxRD/A25Wmx90bE3+qKLjNbEWMZObTKoOdzFGN6j
 AbY9z/8LWU36OX9dJ6LyluDQdqP1cU9KH9EaDAEQAYB7sOlpowv5v4ucjqBOPXk5jEWMWusq
 9xvkMTZr+xJ5fPnL43hoTj6b8uE//Akjmcdv207pF6N4AJjf5KCbIe181Xd5vsoBN/HEgfc7
 SNfw5jPvL9m4XSxeMulG7plIV1Uz6zYblUwf3Ywd3Xey9hd0yX/I9sBv2EWyLZBP9kEdDLtb
 VXSvwgUvMY7AZdZRfQfXm9wYux0pZXd+SPNDaiFPoITOcEqLGdqPkhGPCat4owkq2B0+YlXB
 HtRWZ/E4a8yBfs1wTyoaf0a1LN3lCkyyXmKFcL/zg+7yvyTe36YRLMIKh2IY/xgtPGIpwDc8
 tB+McqWykwFDLakOnSOrdcefQIQMHw2JZHqsMgJJOSNFQpRBz1zAfHmx758KZdumL5Yl7qW8
 yjlCFNY0lf2mVbONR6ONiJ4cLrqUJsm9SA7MCUgMEyGwX8mZYrzvq4Te4FuLesj9fd/1rh5U
 PkIdsGNGLJJRyieo2YRapz0rYpDchW3hFvUY3H/OGVmI8dtHlWb9MXlcw3j8Dg1IhC27cZu8
 ae90g77QIYYQ1owBsjhaMWwkwG7s08blb8gREDPONRSJRvhqdA4Nyzrg/YrCMgQMhGflCCC3
 gObDBpE9+nAp4g5rIvAiaye9tr7Fvs4E1VaEmTf4KzwMyTGpzLxzYhFWeeOXDbcSGKtovn5P
 70Ilq2lPa1VhktOvqp9D61vk/A06ezvkKAGnA5qK3PGMgawAbR6L3jbg8QW7v9RxqVUsBedU
 16U/oUIIq2APc7oTAwLKAw+YrjR3P0YgGCPv/ElZkjl5CJ6+LedF0NfI0DU2iBaKbJ0NqIjw
 Psg4ZRKsFbn10N2a9vW3DpJ82msL2AbV/t1vJ8tALj01lghxGZEbMGOESTx+pyONotBaxF4P
 j+OiaPerL1A3U6eIWErHH3A0Oc1aU7iY/yWIIvu5mhlm+YpQtcyzFtc7jQ6QwBY1FNB3v4b1
 q2H8aFqDf3mwtuqrJErs6OQ98VpAByC5le3xkQJmWDdQlPuUGHRRIH41SBh42hBm1+xvVFnE
 HWwzGf+TS2scd7x0yY2VFQjrfH/JTC0Gssuh+j/d/m481IGjfYJT0Ngiafka/cqPC/puHD6m
 A==
IronPort-HdrOrdr: A9a23:DnGY+a7DNnTjP1Y37APXwMTXdLJyesId70hD6qkRc20yTiT7//
 rAoB1173HJYVoqOU3I3OrwWpVoIkmskqKdg7NhWItKNTOO0ADEQL2Kr7GSpwEIcBeOldK1u5
 0BT0GgMrfNMWQ=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,160,1643670000"; 
   d="scan'208";a="24664457"
X-MGA-submission: =?us-ascii?q?MDEPlzIJaq9LWOyjAtgTkOj7c1P2vN2jsO6XOT?=
 =?us-ascii?q?TwZtqqDvRyzUTYypRE6h1n60QJiTsLyPAHY/EdwCvBCGBl96YFSi7wTT?=
 =?us-ascii?q?Tnsg0fYdElI3ZgUGHnZCmDV43GR/3BXMfT8+JftGkpGJnL3NaDcWz/GZ?=
 =?us-ascii?q?x7w19cmXhYnfqhKW7Gws9KLA=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 02:57:26 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 5A0FA4A
	for <cocci@inria.fr>; Sun,  6 Mar 2022 17:57:24 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3fT7XFWqhluC for <cocci@inria.fr>;
	Sun,  6 Mar 2022 17:57:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 08BA839
	for <cocci@inria.fr>; Sun,  6 Mar 2022 17:57:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 08BA839
Date: Sun, 6 Mar 2022 17:57:18 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
In-Reply-To: <df8a810-dcb1-4bf2-178d-178943e6e458@ewheeler.net>
Message-ID: <caa0adde-7dd-e571-fa2-ee2a650b328@ewheeler.net>
References: <df8a810-dcb1-4bf2-178d-178943e6e458@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] [PATCH v2] Fix support for "complex double" in parameter
 lists
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 176
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/caa0adde-7dd-e571-fa2-ee2a650b328%40ewheeler.net>

From: Eric Wheeler <cocci@linux.ewheeler.net>
Author: Eric Wheeler <cocci@linux.ewheeler.net>
Date:   Sun Mar 6 16:55:32 2022 -0800

    Fix support for complex double in parameter lists
    
    It seems that `parameter list` does _not_ support `complex double`,
    but it _does_ support `double complex`.  Coccinelle already supports
    `double complex` and `float complex` so this commit adds grammar support
    for the reverse of `complex double` and `complex float`.
    
    With this SmPL:
    
            @ rule1 @
            type T;
            identifier F, j;
            typedef nec_t;
            parameter list PL;
            @@
    
            T F(
            +nec_t *nec,
            PL
             )
            {
            ... when exists
                    when any
            nec->j
            ... when exists
                    when any
            }
    
    This works:
    
            void qdsrc( int is, double complex v, double complex *e )
            {
              is--;
              i= nec->data.icon1[is];
            }
    
    but this did not:
    
            void qdsrc( int is, complex double v, complex double *e )
            {
              is--;
              i= nec->data.icon1[is];
            }
    
    Patch v2: Fixed error: "strange type2, maybe because of weird order: complex double"
      when patching this example function:
    	static void Near_Field_Total( complex double ex, complex double ey, complex double ez, int nfeh, int idx )
    	{
    		nec->x++;
    		return;
    	}

diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 019ee3b..8c1fe8e 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -408,7 +408,9 @@ let split_signb_baseb_ii (baseb, ii) =
   | B.FloatType (B.CFloat),["float",i1] -> None, [i1]
   | B.FloatType (B.CDouble),["double",i1] -> None, [i1]
   | B.FloatType (B.CFloatComplex),["float",i1;"complex",i2] -> None, [i1;i2]
+  | B.FloatType (B.CFloatComplex),["complex",i1;"float",i2] -> None, [i1;i2]
   | B.FloatType (B.CDoubleComplex),["double",i1;"complex",i2] -> None, [i1;i2]
+  | B.FloatType (B.CDoubleComplex),["complex",i1;"double",i2] -> None, [i1;i2]
   | B.FloatType (B.CLongDouble),["long",i1;"double",i2] -> None,[i1;i2]
   | B.FloatType (B.CLongDoubleComplex),["long",i1;"double",i2;"complex",i3] ->
       None,[i1;i2;i3]
diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index 949c0bf..22fe5e7 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -1270,7 +1270,9 @@ type_spec2:
  | Tfloat               { Right3 (BaseType (FloatType CFloat)),  [$1]}
  | Tdouble              { Right3 (BaseType (FloatType CDouble)), [$1] }
  | Tfloat Tcomplex      { Right3 (BaseType (FloatType CFloatComplex)),  [$1;$2]}
+ | Tcomplex Tfloat      { Right3 (BaseType (FloatType CFloatComplex)),  [$1;$2]}
  | Tdouble Tcomplex     { Right3 (BaseType (FloatType CDoubleComplex)), [$1;$2] }
+ | Tcomplex Tdouble     { Right3 (BaseType (FloatType CDoubleComplex)), [$1;$2] }
  | Tsize_t              { Right3 (BaseType SizeType),            [$1] }
  | Tssize_t             { Right3 (BaseType SSizeType),           [$1] }
  | Tptrdiff_t           { Right3 (BaseType PtrDiffType),         [$1] }

