Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C87FC433F5
	for <cocci@archiver.kernel.org>; Sun,  6 Mar 2022 23:54:15 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.90,160,1643670000"; 
   d="scan'208";a="24660425"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2022 00:54:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8A449E00CB; Mon,  7 Mar 2022 00:54:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3E99DE004B
	for <cocci@sympa.inria.fr>; Mon,  7 Mar 2022 00:54:08 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: paFGzeCgODX2Lxhk/sZghtKQAoA2IW49KLTd7MucvZ5d9lJnfjB71J11vNkaA4lLnmwr9s0mTc
 7rWfCNe277QvIOu5oQQwa3K//hCdFdEjUJ8FbObeqhb9D5I4fwvIVolvlhIhsNoAguxoW4//8v
 qTl0x8wAHErkCGLGoJB13JDdWTO/1DOldfLxYWkl0gHnenZSwPbF8I9bDmizAjUAdTJSwnx29/
 SYz51C9feVjLdkqTGxHPiYb0NrTpqbfy60ed0koOFhH7FkQJSPBRKkOxnJwfglWry5tWu5BST3
 SYGX2GpsS8M6iImN/qQeEOPD
X-IPAS-Result: =?us-ascii?q?A0C7BABPSSVi/0Xcza1agQmBWoIoB3dWAQEBKQQLRJNHg?=
 =?us-ascii?q?iUDnHOBaAsBAwENLRQEAQGCEoF1gQAChBsCHQYGMwYOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECAwQBgQgsAWMBZwGBTgGBeQYEMA2CNSkBg2MBAQEBA?=
 =?us-ascii?q?gEnEz8QCxguVwaDFwGCdSGrTXiBATKBAYl7gTyOSCccQIFNgTyCUzA+hBABE?=
 =?us-ascii?q?gELhhUElTNsgRWBTDFgCqJLnhKDU59WBhQulkSRZpZVpnmBPzgmaXAfFBoIJ?=
 =?us-ascii?q?go7gmkJRQECAQIBDAECAgECAQIBAgEIAQECAY5TiE+FayABAQExOAIGCwEBA?=
 =?us-ascii?q?wmPNwEnBIIcAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:jvhBXKy/dnznYfJFMnV6t+crwCrEfRIJ4+MujC+fZmUNrF6WrkVSm
 mFLCmzQaPaKYWWjftgiYIWzp09UsZXSxoQxTVZsqFhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOOU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvW4
 Y2q+aUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPhvy
 sQduMa8Qz4pHfXAn/gUbwdXNHpHaPguFL/veRBTsOSW3wvLbHvhzvFjFgcwMJFwFuRfWD4Vs
 6ZAdXZXNEjF2bPeLLGTEoGAguwoK8LgPasbu2p81nfUEvYrTJTOWePM6MMwMDIY2Z8TRauHO
 aL1bxJ3czn7OQ1LHW0aN5Qsh/qluFiufBxx/Qf9Sa0fuDSNl10ugNABKuH9cduBTsR9hVedv
 muA/mLjAxhcOsb39Nae2ne8wOLQnS72XI8IUru16paGnWF/2EQNCgxGWAG3q8C5qRayXM5WF
 1Ib3XEX+P1aGFOQcvHxWBixoXihtxEaWsZNH+BS1Dxh2pY48C7CWTdZFm8phMgO8Z5pFWZzh
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
IronPort-HdrOrdr: A9a23:wJgFZ6zGFTmBIuojWxtiKrPwKL1zdoMgy1knxilNoH1uA7Wlf6
 LHppsmPHDP5gr5NEtApTnEAtjkfZq+z+8S3WByB8bHYOCOggLBR+wP0WKh+UyGJ8SUzJ8+6U
 4PSchD4QLLZ2RSh8yS2njaL+od
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,160,1643670000"; 
   d="scan'208";a="7750516"
X-MGA-submission: =?us-ascii?q?MDEsr7GpNc/f2+23v9YscAY1yOtJ+/lG7KV/UP?=
 =?us-ascii?q?4iaR/bEWcyweEdWvVBiJZxwcm72ZNk1qarbcxdt/9qDEBr7vDxb29ccz?=
 =?us-ascii?q?WEa8bTl7+G7LKNRe85/0PjMDeLlEYVao5EXzUcMEMwGtsaXDTYZrYzO0?=
 =?us-ascii?q?0CHNJr/NkP3ZuRIMe007KcqQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 00:54:07 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id BA9854A;
	Sun,  6 Mar 2022 15:54:04 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bHq3PxiD3kaq; Sun,  6 Mar 2022 15:54:00 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 5F69439;
	Sun,  6 Mar 2022 15:54:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 5F69439
Date: Sun, 6 Mar 2022 15:53:55 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <48c05723-cfd4-6c4e-b541-56a9cc89563d@web.de>
Message-ID: <684eaf50-7b85-48ec-7f5d-1125aa7c5cf8@ewheeler.net>
References: <15f59e89-64e8-ba91-d71b-322e6905763@ewheeler.net> <48c05723-cfd4-6c4e-b541-56a9cc89563d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] How do you add a function argument when an identifier
 exists in the function?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 172
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/684eaf50-7b85-48ec-7f5d-1125aa7c5cf8%40ewheeler.net>

On Sun, 6 Mar 2022, Markus Elfring wrote: 
> > I'm trying to convert an existing global typedef struct
> 
> Would you become interested in any more source code transformations
> where data from global variables with selected types should be passed
> by additional function arguments?

In our use case there were a bunch of global structs that defined the 
program state.  The first transform was to move all of these global 
structs into a single global struct `nec` which looked like this (thanks 
Julia!):

	@ rule1 @
	global idexpression I = {cm,cmag,crnt,ct1m,ct2m,data,dataj,fpat,ggrid,gnd,gwav,impedance_data,incom,matpar,near_field,netcx,save,segj,smat,calc_data,zload,vsorc};
	identifier j;
	@@
	-I@j
	+nec->j

The `nec` variable is still a global after this transpose, which gives me 
a chance to build the program (www.xnec2c.org) and make sure it still 
works as expected:

	nec_t _nec, *nec = &_nec;

Coccinelle is amazing: This first patch hit ~3300 replacements and the 
code still works.


Since many global values were moved into a single global struct, I don't 
have many other use cases for moving globals into parameters, just `nec`.

Now that `nec` is global and encapsulates each state, the next step is to 
pass it by parameter as noted earlier in this email thread so different 
"struct objects" can be passed down the stack in different threads.  Then 
I can delete the temporary `*nec = &_nec` storage.

There might be other global state stored in static local function 
variables (or static global variables in their own .c file) that I haven't 
discovered yet: see the "How can I find all static variable declarations?" 
thread from a few days ago that is having spatch trouble.

As I find those statics (if any) they will be moved into the `nec` struct 
somewhere so all shared state can be passed down the stack.

> > to be the first function parameter whenever it is used so we can move away
> > from global varaiables and make the code more flexible and thread-safe.
> 
> How much does the parameter position matter for your software adjustments?

To me it matters, but just as a matter of preference.  I've done a lot of 
Perl programming where the first variable in the input list to a function 
is the class object.  Here is a Perl example where $self is akin to "this" 
in C++:

	sub foo
	{
		my ($self, $arg1, $arg2, @other_args_list) = @_;

		return $self->bar($arg1+$arg2, @other_args_list);
	}

	$obj->foo(1, 2, 'a', 'b');


So I put `nec` as the first parameter since the NEC2 code is still written 
in C but is becoming "struct (object) oriented".  


--
Eric Wheeler


