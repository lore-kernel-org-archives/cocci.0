Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7A6C433EF
	for <cocci@archiver.kernel.org>; Mon,  7 Mar 2022 20:29:16 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="24871428"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2022 21:29:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3E6A9E00BB; Mon,  7 Mar 2022 21:29:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DA528E004B
	for <cocci@sympa.inria.fr>; Mon,  7 Mar 2022 21:29:13 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: 7/RWq9OAP6qO2U7I0eOFFC5gQHAwCm7A4L7Lnc3MuwmQV0/L+hndH0onMC40zOALM2WNoWe8x6
 1DZHKHq7LTXZudoV4pjjm0uCeKtkh8FSLMJptZmWLEYpidL2FY70KE/jsNN8r5GTumi9R8tnFC
 U13jzHXN85ucIqW1Ub9NW7fp5giFsQMBGS7aKWT+OmcUjM0oCDInq+Dj0scjNAAXuOjX3QeIE8
 t+eYaIf8HjHxZdF7zO0kAazG6Zc82Jbgx1UAMbQMWSIVsPsBdZm867G3jFg4wKgrKUCtU2OXa+
 A4fWMOB9ErbWDjkmXRyEDbUS
X-IPAS-Result: =?us-ascii?q?A0CvBABSaiZi/0Xcza1agQmBWoIoB4FNAQEBKQQLRJNHg?=
 =?us-ascii?q?iieWwsBAwENQQQBAYUHAoQeAh0GBjMGDgECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBAgMEAYEILAFjAWcBgU4BgXkGBD2CNSkBg2QGJxM/EB8BMVcGE4MEg?=
 =?us-ascii?q?xeuAYEBMoEBiXuBPI5IJxxAgU2BSIEJjHAEmieiSZ4Sg1OfbQMulkSRZpZVp?=
 =?us-ascii?q?nmBPzgmgVkfFBoIJgo7gmlOAQIBAgEMAQICAQIBAgECAQgBAQIBjigWjk8gA?=
 =?us-ascii?q?QEBMTgCBgsBAQMJkW8BAQ?=
IronPort-PHdr: A9a23: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
 A==
IronPort-Data: A9a23:mWMpc6DoaegrsxVW/x7lw5YqxClBgxIJ4kV8jS/XYbTApGl23zIOz
 2UeXGGBOa6JZWH9KN1xaYrlpksHsZbTm9NlOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPhXFvW0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYoxmsgo9s+
 Oh9iYC1e1soDvzspOMWcSANRkmSPYUekFPGCX2v98GMz0DLd3b2hfNjECnaP6VBpb0xWzkTs
 6ZCcHZTP3hvhMruqF6/YuJrjc8iBM3qJ58E/Hx/zTzUCfs8B5bOX80m4PcCgGdv35wUQ54yY
 eIUdBFTSD/mfSZPBW5OI8p528D213LgJmgwRFW9/vZpuDmMnGSdyoPFO93ecd2iXtRQhk/ep
 2Tc/m2/DAtyHNiW1jOB9lq+h+rFhyq9WYQIFbT++OQCvbGI7mkDThAJVVa2pfSjzEizR7qzN
 nD45AICiLVt6XyWfuXhWi/koU7VniIbUPhpRrhSBB629oLY5AOQB24hRzFHacA7uMJeeQHGx
 mNljPuyWmMy6Oz9pWa1s+bL/WnraED5OEdbPXdcJTbp9eUPt23as/4iZtNzVqOqjtD4HTzqh
 TaHsEDSZon/b+ZQhs1XHnid31pAQ6QlqSZsvG3qspqNtF8RWWJcT9XABJiyxa8owHylZleAp
 mMYvMOV8foDC5qA/ATUHrlTQeDyvK7VYW2D6bKKI3XG32/yk0NPgKgKvW8WyLlBba7ohgMFk
 GeI5V0KtcADVJdbRaJoY4+8D8kwzK7rUIy8Ps04nfIVCqWctWavoklTWKJn9zu1wRh0zPpmY
 s/znATFJS9yNJmLBQGeH481uYLHDAhnrY8KbZyknRmhz5SEY3uZFeUMPFeUN7Br6KKfvB6T/
 slfOsaOxg8ZVuDiO3GF/YkWJFEMDH46GZGv8ZAMLLbee1Y/FTFzEeLVzJMgZ5dhwfZfmNDIy
 W7hCEVW/1zy2C/cIgKQZ3E+Nr62BcRjrWg2NDAHNEqz3yRxep6m6aoSLsNlfbQu+OF54+RzS
 v0JJ5eJDvhVE2SV/zUGcYK7oZNieRmviBjIOSe5OWBtc5llTg3P29nlYgq2rnVVVHLq7Jdnr
 uT5hA3BQJcFSwBzN+rsaaqinwGroHwQuONuRE+WcNNdT0Xb79Q4ISLGiPJqcdoHLg/Ox2bE2
 l/OUwsYv+TEv6Q87MLN2fKft46sHuZzQhhaEm3c4erkPCXW5DP+k4pQFuuXfT3QUG7uvqOve
 bwNnf37NfQGmndMspZ9Suw3lvhmuoKz/rIKnB55GHjrbkiwDu0yKHex3f5Q6v9HyIhftFbkQ
 UmI4NRbZOuEYZu3DF4LKQM5Re2fzvVIyCLK5PE4LRmo/iNx57bbA0xeMwPV1X5YPP14L4Moz
 OMsoogQ5hDm0kgmNdOPjyZ18WWQLyVaD/597sxDXNbm2lgx11VPQZ3AESuospuBXNV7LRV4K
 DGjgqef1a9XwVDPcidtGCGVj/Zdn5kHpDtD0EQGewaSgtPAi/I6tPGLHe/bkuiBItR7P+NP1
 qxDMl0zKLqO8jpsidIFWW2wc+2E6Nt15WSpo2blVkWAJ6VraoAJBGk8IvqWuk0G829RejVBu
 reV1A4JlNoskN7ZhkMPtI0MlxAnZdhw7RHZ3s24H8mIG5QgJzzonsdCoIbORwTPWasMuaEMm
 QWmECucp0E22e78bpDX07Wn6Ik=
IronPort-HdrOrdr: A9a23:iuv5/KGo+ed5IzoWpLqE1seALOsnbusQ8zAXPiFKKCC9F/by/f
 xG885rtiMc5Ax9ZJhYo6HnBEDiex3hHPxOjbX5VI3KNDUP0gOTXfhfBODZrAEIdRefygZQvZ
 0QEZSXBbXLfD9HZcyT2njcLz4uqOP3lJyVuQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,163,1643670000"; 
   d="scan'208";a="24871426"
X-MGA-submission: =?us-ascii?q?MDEjbiOJ2vRhVs+8N/MsvUyAGW2yO9o+JcqnXN?=
 =?us-ascii?q?BtNz581SJbAA0rZnaWhejMnPa7mnzR3/NAXltEaz8eCz2gVhcPUvfP+W?=
 =?us-ascii?q?Ns/tf5S5PT9lcOl/UjHDHWOZEtPnaMUkycnZz3QRCr81vIBTCyUmkQjI?=
 =?us-ascii?q?zsSEAFCuiX2ucdQEm2xQuJsg=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 21:29:12 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id A27BE81;
	Mon,  7 Mar 2022 12:29:10 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PTU-N4TgSWxf; Mon,  7 Mar 2022 12:29:06 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 3258539;
	Mon,  7 Mar 2022 12:29:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 3258539
Date: Mon, 7 Mar 2022 12:29:03 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2203070900200.3091@hadrien>
Message-ID: <2018915-898b-778-b5e-c8683697ed40@ewheeler.net>
References: <df8a810-dcb1-4bf2-178d-178943e6e458@ewheeler.net> <caa0adde-7dd-e571-fa2-ee2a650b328@ewheeler.net> <alpine.DEB.2.22.394.2203070900200.3091@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] [PATCH v3] Fix support for "complex double" in parameter
 lists
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 179
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/2018915-898b-778-b5e-c8683697ed40%40ewheeler.net>

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
    
    Patch v2: Fixed: strange type2, maybe because of weird order: complex double
    when patching this example function:
    	static void Near_Field_Total( complex double ex, complex double ey, complex double ez, int nfeh, int idx )
    	{
    		nec->x++;
    		return;
    	}
    
    Patch v3: Added signed-off-by.
    
    Signed-off-by: Eric Wheeler <cocci@linux.ewheeler.net>

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

