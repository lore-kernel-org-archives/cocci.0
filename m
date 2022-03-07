Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C57C433EF
	for <cocci@archiver.kernel.org>; Mon,  7 Mar 2022 01:00:03 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,160,1643670000"; 
   d="scan'208";a="24662627"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2022 02:00:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9ADD1E00BB; Mon,  7 Mar 2022 02:00:00 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 56F17E004B
	for <cocci@sympa.inria.fr>; Mon,  7 Mar 2022 01:59:57 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: NwZOsYSnzOhxNWPXsdzt7SXIQBifP0l5hWAnYRdaUb+qhtdv1tT81CIb+i7mIwWW5StrDVOyTS
 aSUQxYXpW5GsCG12kMRb3DWvnIbGQhcT3mZdFT9S5FTPOajOzsN9iB8PLigtqSJ2ZTiJo9wly0
 21tRbb5P7ZZ5fPFhVwG0t6wVI84rrERU3UjPNXuKnb1l1nMLN96JBoNr5JX6N4IKkUdnohcA9M
 J4FfbpjaAicxIaODcjT5SuIsacGV8vtllm7MjKVtFqyrY0RU+J38gf1gwXXZV2hf/n+XXmSOwp
 JzejE6lq+RToR2B2w0gklqCJ
X-IPAS-Result: =?us-ascii?q?A0CIBgCAWCVi/0Xcza1agQmEAgeBTQEBASkEC0STR4VOm?=
 =?us-ascii?q?zULAQMBDUEEAQGJJAIdBgY0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gMEAYEILAFjAWcBgU4BgXkGBD2CNSKEGRNuAYEhgwSDF6xFgQEygQGJe4E8j?=
 =?us-ascii?q?m8cQIFNgTyBFYc+hTIEmh2iSZ4Sg1OfVhoulkSRZQGWVaZ5gT85JYFZHxQaC?=
 =?us-ascii?q?CYKO4JpTgECAQIBDAECAgECAQIBAgEIAQECAY4oFo5PIAEBATE4AgYLAQEDC?=
 =?us-ascii?q?ZF/AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:bKjXYKAoVmez1xVW/zXlw5YqxClBgxIJ4kV8jS/XYbTApGwj3jQFy
 zEWCG3SP/3YZzT1eI11b9zl90wPuZbWyoNrOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPhXVvX0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYo22Gh/ZUx
 pYSj8C5UQ4SO6zwpqcUXBYNRkmSPYUekFPGCX2v98GMz0DLd3b2hfNjECnaP6VBpb0xWzkTs
 6ZCcHZTP3hvhMruqF6/YuJrjc8iBM3qJ58E/Hx/zTzUCfs8B5bOX80m4PcHg2pp2pEQdRrYT
 5EzbxhwZiX7WhlKAAxLNrNhubeztmaqJlW0r3rO+fRssjeDpOBr65DmN9Hee/SRVMBNlwCZo
 HjH9iL3GHkn2Me3zCrD/22si+LLkDm9Xo8OfFGlyhJ0qAWc3ko2Bl5JbweyufCCj0+CZZFWJ
 ENBr0LCspMO3ECsS9D8WTixr3iFogMQVrJsLgEq1O2e4vGLvFvBVwDoWhYEOYN27pZnLdA//
 gbRx4uBONB5jFGCpZugGlq8qCP0NDcVIGIGaDVCSwYZizUCnG3RpkmeJjqAOPTp5jEQJd0X6
 2nQxBXSf51J0aY2O1yTpDgqQ1uE//AltDId6ATNRX6C5QhkfoOjbIHAwQGFsagdfd3CFgnQ7
 Cdsdy2iAAcmVs7lqcBwaL9QQtlFGd7aWNEjvbKfN8J9qW/8pC7LkXF47S5+KUptP9wFfzSsO
 Ba7hO+izMQ7AZZrBIcpC7+M5zMClvCxRYy4DamPNrKjoPFZLWe6wc2nXmbIt0iFraTmufhX1
 U6zfZn+AHAEJ75gyTbqFe4R3aVylnI6xHjPXtb20BSq3L6TfjiTRKtcaAmCaeUw7aWlpgTJ8
 o8Fa5DQk0gGDLTzMnvN7IoeDVEWNnxlV5r4nMxgabLRKARRHmx8WeTaxqksetE7kv0NxPvI5
 Hy0RmRR1EH72S/cMQyPZ306MOHvUJ9zoGgVJyspOVr0iXEvbZz2vPUbdoArZv8q6+xuwPp5V
 b8DdtnZWqZDTTHO+jI8a5jhrdU4KE/x3V/XY3OoOWFtcYRhSgrF/s7fUjHurCReXDCqscYeo
 qG70l2JS5Q0RzN9UJTcZsWpwg7jpnMagu9zAhXFe4EBZEX2/YF2ACXtlftrcdoUIBDOyzbGh
 QabBRAU+bvEr4MvqYSbgLDCopipHuZ6E1AcGWTHtO7kOS7f92ul4IlBTOfRJ2yGDjupofn7a
 LUH1ez4Pd0GgE1O7dh2HYFr+r1itdHhkLlXk1Z/F3LRYlX2VL45eiua3dNCv7Fmz6NCvVfkQ
 VqG/9RXZeeTNMX+HAJDLQYpdL3eh/QE3DTN7fk4JEjgoil64OPfA0lVOhCNjg1bLad0adl5m
 r155ZdKsgHv2AA3NtumjzxP8zreJHI3U5I46sMQDrjth1d50VpFe5HdV3H7ucndd9VWP0A2C
 TaIn66e1a9Ez0/Pfndb+aIhBgaBaUDieSymzWPu43yMipzImf860Rlc63IxQxg9ItCrFQ5sE
 jADCqG3DfzmE/RUaAxrW2G3BxoHCQKZ90H1xkFPkmDFJ6VtuqohM0VlUdtgPyklH6Z0ejlA4
 KrexXnlXDvucdu32CYuMaKgRzoPUvQpnjD/dAub8whp0nX0jfcJQkNjWIbQlybaPA==
IronPort-HdrOrdr: A9a23:mFrTJKvqhT/5KG28Y6oIB/Sp7skDZtV00zEX/kB9WHVpm62j5q
 STdJZy73DJYVkqNk3I9ergBEDiewK4yXcW2/hyAV7KZmCP0wbFEGgI1/qA/9SPIU3DHzFmv5
 tdTw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,160,1643670000"; 
   d="scan'208";a="7751496"
X-MGA-submission: =?us-ascii?q?MDE1B7xRcc3JA/B0jFj5IfhX1NhNBz9zHUZYhc?=
 =?us-ascii?q?IdOpjOiXsVyIHvym2nPmt7NP9+zmQEMBhvlIC8TK3gixi8t5YGSKuTEK?=
 =?us-ascii?q?Zh+H6hD/Q8UhkMNDEouwV0vjwA2J81G66f0iVVYRWn0HkdaWYn55FsWG?=
 =?us-ascii?q?PZCNyZAvQ30ukpmQ5EpdwmEQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:59:56 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id B10414A
	for <cocci@inria.fr>; Sun,  6 Mar 2022 16:59:53 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EH9gdg2NkSca for <cocci@inria.fr>;
	Sun,  6 Mar 2022 16:59:49 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 4D06839
	for <cocci@inria.fr>; Sun,  6 Mar 2022 16:59:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 4D06839
Date: Sun, 6 Mar 2022 16:59:47 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <df8a810-dcb1-4bf2-178d-178943e6e458@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] [PATCH] Fix support for "complex double" in parameter lists
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 174
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/df8a810-dcb1-4bf2-178d-178943e6e458%40ewheeler.net>

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

