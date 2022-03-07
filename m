Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6957DC433EF
	for <cocci@archiver.kernel.org>; Mon,  7 Mar 2022 01:56:05 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,160,1643670000"; 
   d="scan'208";a="24664405"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2022 02:56:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 81A5FE00CB; Mon,  7 Mar 2022 02:56:03 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9F477E004B
	for <cocci@sympa.inria.fr>; Mon,  7 Mar 2022 02:55:58 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: F8ob3FWSnvKmcElFTuUgI4+02FEBTJANmHQ3rkkKk0OVZqRUTYskKpB+bBDJEg7MgCgnVb5i1L
 C1dInBthlRpXWTkNfzKPs4p1ZSjndvCF5Qz+MKfxgLspALtysEvo8cNCKA9ZN6m+TLcjdoEHg8
 OZdkGCpEIO0FCpRJ8IVRlECC2Zk5OHvCuczOjZAkVdKefmghEzekEM1FhqKI5Ti3pis3gTt8L5
 lrJISzSUqW6bH6tMD/0VpQVEAoQkS2XNu8LBhXcXieh3MikA/IuG7wVSOFaalqD+9ggSyAznS/
 jykAoeN0JTn7syRcQYpzy3dX
X-IPAS-Result: =?us-ascii?q?A0DbBQAiZSVi/0Xcza1agQmBWoIoB4FNAQEBKQQLlAuFT?=
 =?us-ascii?q?ps1CwEDAQ1BBAEBiSQCHQYGMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECAwQBgQgsAWMBZwGBTgGBeQYEPYI1IoQZE4UUgxesRYEBMoEBiXuBPI5vH?=
 =?us-ascii?q?ECBTYFIgkeGAIUyBJYGNoEDgxiiD54Sg1OfVhoug3OSUTeRL5ZVpnmBPzgmg?=
 =?us-ascii?q?VkfFBoIJgo7gmpNAQIBAgEMAQICAQIBAgECAQgBAQIBjXQBMxaOTyABAQFpA?=
 =?us-ascii?q?gYLAQEDCZF/AQE?=
IronPort-PHdr: A9a23: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
 aVTMq9rWXFiB9+flioPRiETmjiLacOH9k/Uxw==
IronPort-Data: A9a23:us8urK1wbyL9MD3WhvbD5cx3kn2cJEfYwER7XKvMYLTBsI5bpzEFy
 jNLUWvQOveMZWagKIskOd6z8UsFvJ/cy4NmSAI53Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1jV5
 4uoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt9ZBl
 vcOrsSpdQkSMpTsvf0/VAAJSAgraMWq+JefSZS+mcmDiUDZc3bhx/h0Skc7IeX0+M4uXjoIr
 6RFbmpXNlbd1opaw5rjIgVors8kJ8LqFIceoW17izzGDfsrRZ3ZBaPH+be02R9q2p4QQaqGO
 6L1bxJMMwvFZxsSIm0JBcw1pv+yuGLyIwdH/Qf9Sa0fuDSNl10ugNABKuH9cduBTsR9hVedv
 muA/mLjAxhcOsb39Nae2ne8wOLQnS72XI8IUru16paGnWF/2EQVOEM0FkDjuMW3sUKHe/dGC
 UsNq3EH+P1aGFOQcvHxWBixoXihtxEaWsZNH+BS1Dxh2pY48C7CWTdZFm8phMgO8Z5pFWZzh
 zdlivuwXWQ32IB5X05x4Vt9kN9fES0Fa2IdZSIJSQYfpd/uvOnfby4jrP44QcZZbfWvRVkcJ
 gxmSwBn3d0uYTYjjfnTwLw+q2vES1igZlddCv/rdmyk9BhlQ4Wuepal71PWhd4ZctrHEwja5
 yBUypjBhAzrMX1qvHfSKNjh4Znzuqjt3MP03jaD4KXNBxz2pyD4LN8AiN2PDEp2MssJfTLzY
 UnY/FsIjKK/z1PxBZKaouuZVawX8EQXPY+9B6CMM4EXOcAZmc3u1HgGWHN8FlvFyCAE+ZzT8
 7/CGSp1JXpFW6lh0hSsQOIRje0iyiwknDOBQZHg0w/h3KWeaXORRK1DNlaSN7hr4KSBqQTT0
 tBeK8rTkUkECrWjO3WO/N5BN00OIFg6GYvy9Z5deNmDFRU6SmsvPPncnOE6cIt/kqUIyOqRp
 iOhWlVVwUbUjGHcLVnYcWhqbb7iBM4trX8yMSE2E0yv3nwvPdSm4KsFLstlebg86PclwOF0Q
 vQBdt/GBPlTE2yV9zMYZJj7jYpjaBXy317VZXL4OWRmcsc5FQLT+9Licg/+zwU0D3K65Zkkv
 rmt9gLHWp5dFQ5sO8bhd679xV2Gu3VAyvl5WFHFI4QNdRy0opRqMSH4ktQ+P9oIdUfY3jKf2
 gubXUUYqO3Kr9Nn+dXFn/nZ/YK5VeZhHkdXG2TBq7C7KXCCrGakxIZBVseOfCzcDTmoo//6O
 LwJlvysYucamFtqspZnF+g5x6wJ5+zw++1QwDNiESiZdF+sEL5hfyeLhJEdqq1Xy7ZFkgKqQ
 UbTqMJCMLCENZ+3ClIXPwZ5PO2P2etNx2vX/bI4P0X36St65vyBXFkLZ0uAjylULb1UNoI5w
 L575JVMs1Hm1kMnYoSckyRZ12WQNXheAa8pgZEtH9O5gAQczFwfM4fXDTX74czRZowUYFUqO
 DKdmIHLm69YmhjZa3M2GHXAtQaHaU/iZPyeIJ4+y1W1dh7tg+9x0QJR/DkzQx4TyBhbuw621
 q6HKGUtTZhiPR8x7CSAY4xoMwVAHwGCvEHuy1YEkGDDCU+lSgQh6YH71fmlpCgkHqE1QtSf1
 LWZ03r+Fzv1fMz82iYoH0hot5QPiDC3GhLqwKiaIihOI3X2jfcJTENjiarkZiYL2f8MuXA=
IronPort-HdrOrdr: A9a23:LFIkraPkkxdnAcBcTtGjsMiBIKoaSvp037BL7TEUdfQ2Gvb2qy
 nAppomPHPP6Qr5O0tQ/OxoWpPwI080nKQdieJ9UYtKNzOW21dAQrsD0WI8+VfdJxE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,160,1643670000"; 
   d="scan'208";a="24664404"
X-MGA-submission: =?us-ascii?q?MDFK1/7IbRX2ArKPErwRxXrJCTXeOn6YEGP9pa?=
 =?us-ascii?q?ZKWfA4tzExnv5j49ewMfH2YgLETklFBUy/8TpUBeOAsBL8tfbR1Wd5gY?=
 =?us-ascii?q?pfFImMWXYX+OKSZqVPf2pT41E/fv45XrF9VosXBwXTnIXdtMq3BE8LKc?=
 =?us-ascii?q?GqHFqsRzjT/IYpg8W3V1b/8Q=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 02:55:57 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id DEA5B4A
	for <cocci@inria.fr>; Sun,  6 Mar 2022 17:55:54 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1iWaCh68IjPp for <cocci@inria.fr>;
	Sun,  6 Mar 2022 17:55:54 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 151B639
	for <cocci@inria.fr>; Sun,  6 Mar 2022 17:55:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 151B639
Date: Sun, 6 Mar 2022 17:55:51 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <ed1d7d30-461-8822-7fd2-e1701534c29b@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] Does SmPL for functions with prototype disjunctions need to
 be complete?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 175
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/ed1d7d30-461-8822-7fd2-e1701534c29b%40ewheeler.net>

This seems to work when the body of the funciton is defined in each disjunction:

	@ prefix_nec_arg @
	type T;
	identifier F, j;
	typedef nec_t;
	parameter list PL;
	@@
	( 
	T F(
	-void
	+nec_t *nec
	 )
	{
	... when exists
	    when any
	nec->j
	... when exists
	    when any
	}
	| 
	T F(
	+nec_t *nec
	 )
	{
	... when exists
	    when any
	nec->j
	... when exists
	    when any
	} 
	| 
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
	)

But placing the function body after the disjunction block did not, even 
though it is easier to read and does not duplicate content:

	@ prefix_nec_arg @
	type T;
	identifier F, j;
	typedef nec_t;
	parameter list PL;
	@@
	( 
	T F(
	-void
	+nec_t *nec
	 )
	| 
	T F(
	+nec_t *nec
	 )
	| 
	T F(
	+nec_t *nec,
	PL
	 )
	)
	{
	... when exists
	    when any
	nec->j
	... when exists
	    when any
	}

Is that expected?  

It means there must be a longer SmPL, which is ok, but for my own 
curiosity: is there a shorter form?


--
Eric Wheeler
