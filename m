Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E39FC433EF
	for <cocci@archiver.kernel.org>; Sat,  5 Mar 2022 21:35:54 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,158,1643670000"; 
   d="scan'208";a="24580127"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Mar 2022 22:35:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4F68CE00CB; Sat,  5 Mar 2022 22:35:52 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4A157E004B
	for <cocci@sympa.inria.fr>; Sat,  5 Mar 2022 22:35:49 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: BgMHTCZ5NhVwk9hfVb6sDKdEPZENfQtquXEgE0eQubfmBYJK9IuItTbBHsPbJsINsxUrwIVxes
 eGZpWf+gVYtNXC1CnsUeIXYIMAYw815p3HC1sTszhz6+7Pt2kdgN/taMMeHKiT9TDu2VcmBtUc
 X2+iikd0K7A1w2f34doUM3BzN2snMlIKFdH7E8PXHUQdrD1zK3rDXvnU9w48ZAsPynZPlkbNTp
 Ww+fHDV6ORHeoN+zveR1xMKngs7yXUMpdVBDA7FygVcJi7HKsdM/FFG2OtZO+nNLCjGqwqdoen
 gJCooR4hgBV2gAyT+svhU7iz
X-IPAS-Result: =?us-ascii?q?A0CFCABD1iNi/0Xcza1aHgE8DAILFYNULgd3VgEBASkEC?=
 =?us-ascii?q?0STR4VOmzULAQMBDS0UBAEBiSQCHQYGNBMBAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?QEBAQIBAQIDBAGBCCwBYwFnAYFOAYF5BgQwDYI1IoQZE4UUAYMWrEKBATKBA?=
 =?us-ascii?q?Yl7gTyGFBRCh14nHECBTYE8gRWBPoI+AYNBhTIEljUCgRiCHpMQj3mLJ5E9g?=
 =?us-ascii?q?S6DUwWJaIEdlEwaLoVBkQORZpZVoUGBVYNjgT85JYFZHxQaCCYKO4JpCUUBA?=
 =?us-ascii?q?gECAQwBAgIBAgECAQIBCAEBAgGOKBaCP4wQIAEBATE4AgYLAQEDCZF/AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:iqty0qB6fl8JuRVW/zPlw5YqxClBgxIJ4kV8jS/XYbTApDMn1D0Bz
 GIWWzzXaPuKNGGjeNFybIvn/B5Uu8fXyddrOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YPhXlvX0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYow+WodNd7
 txhjqOLQjpqD7CQxPs2cjANRkmSPYUekFPGCX2v98GMz0DLd3b2hfNjECnaP6VBpb0xWzkTs
 6ZCcHZTP3hvhMruqF6/YuJrjc8iBM3qJ58E/Hx/zTzUCfs8B5bOX80m4PcHg29u2ZATdRrYT
 8QDeWo1cwyeXy1oZXEcMY4ih+fwvlCqJlW0r3rO+fRssjeDpOBr65DmN9Hee/SRVMBNlwCZo
 HjH9iL3GHkn2Me3zCrD/22si+LLkDm9Xo8OfFGlyhJ0qGeM+G8/LhQ6bmSAqsT6u1PiB810C
 mVBr0LCspMO3ECsS9D8WTixr3iFogMQVrJsLgEq1O2e4vGLvFvBVwDoWhYEOYN27pZnLdA//
 gbRx4uBONB5jFGCpZugGlq8qCP0NDcVIGIGaDVCSwYZizUCnG3RpkmfJjqAOPTp5jEQJd0X6
 2nQxBXSf51J0aY2O1yTpDgqQ1uE//AltDId6ATNRX6C5QhkfoOjbIHAwQGFsagddNvFFgTc5
 iBsdy2iAAYmVsvleMulG7plIV1Uz6zYblUwf3Ywd3Xey9hd0yX/I9sBv2EWyLZBP9kEdDLtb
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
IronPort-HdrOrdr: A9a23:KwGA3a7yUnz+LtwW4APXwNjXdLJyesId70hD6qkRc20wTiT7//
 rAoB1173HJYVoqOU3I+urwXZVoI0msl6KdiLN5VdzOMDUO01HYT72Kg7GD/9Q+IUfDytI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,158,1643670000"; 
   d="scan'208";a="7706785"
X-MGA-submission: =?us-ascii?q?MDHo2eRFPvUSgRZxGIHMG7CZm9lnKS9IzgLn7n?=
 =?us-ascii?q?hWmM/jldfXFWMVyHkYCRP8kQ9aHrAgGZkdy/zo5cwkYFpzR2mGh1I6+Y?=
 =?us-ascii?q?lB+gO08vTnwmqUmzcSD/cSC4crMKs0QRECzFie97M5LvIq3ER/PjzxWc?=
 =?us-ascii?q?eTbM2yiOssG1IMC/XFsKIdmw=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2022 22:35:48 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id B506D41
	for <cocci@inria.fr>; Sat,  5 Mar 2022 13:35:45 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nmQlWM-kgcxc for <cocci@inria.fr>;
	Sat,  5 Mar 2022 13:35:41 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 4E77B40
	for <cocci@inria.fr>; Sat,  5 Mar 2022 13:35:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 4E77B40
Date: Sat, 5 Mar 2022 13:35:39 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <15f59e89-64e8-ba91-d71b-322e6905763@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] How do you add a function argument when an identifier
 exists in the function?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 166
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/15f59e89-64e8-ba91-d71b-322e6905763%40ewheeler.net>

Hello,

I'm trying to convert an existing global typedef struct to be the first 
function parameter whenever it is used so we can move away from global 
varaiables and make the code more flexible and thread-safe.

If I have functions like this:

	void f(int i) {
		nec->x = i;
	}

	int g(int i) {
		return i+1;
	}

Then I want to prepend an argument only if the existing global
`nec_t *nec` is used in the function.  Thus `g` is unmodified and `f` 
would become:

	void f(nec_t *nec, int i) {
		nec->x = i;
	}

This is the patch I'm trying and it doesn't seem to be matching nec->j:
	@ rule1 @
	type T;
	identifier F, j;
	typedef nec_t;
	parameter list PL;
	@@

	T F(
	-PL
	+nec_t *nec, PL
	 )
	{
	...
	nec->j
	...
	}

If I remove `nec->j` from the patch so it is just this:
	T F(
	-PL
	+nec_t *nec, PL
	 )
	{
	...
	}

then the parameter list is correctly modified (in all functions), but how 
do I properly check and only add the parameter when `nec` is used in the 
function?

A couple notes:
    *  `nec` is currently global, it is already used in the function.  
       I'm trying to change it to a parameter so I can drop the globals.

    * The acutal use of `nec` can be quite complex.  For example:
        curd= CCJ * v/(( log(2.0 * nec->dataj.s/ nec->data.bi[is])-1.0)) ...
      so we want to match if `nec` is used in any form. 

Thanks for your help!


--
Eric Wheeler
